local truncate = require("maki.truncate")
local ToolView = require("maki.tool_view")

local DEFAULT_TOP_K = 5

if maki.fn.executable("semble") == 0 then
	return
end

local function semble_view_opts(ctx)
	local tol = ctx:tool_output_lines()
	return { max_lines = (tol and tol.other) or 5, keep = "head" }
end

local function shell_quote(s)
	return "'" .. s:gsub("'", "'\\''") .. "'"
end

local cwd = maki.uv.cwd() or "."

maki.api.register_prompt_hint({
	slot = "tool_usage",
	content = '- Use **semble** for "How does X work?" questions or when you don\'t know the right names. Use **grep** for known symbols.',
})

maki.api.register_prompt_hint({
	slot = "efficient_tools",
	content = "semble",
})

maki.api.register_tool({
	name = "semble",
	description = [[Search code semantically using semble.

- Finds code by meaning, not keywords. Best when you don't know the exact names.
- Returns chunks with file:line and relevance scores.
- Use for: "How does X work?", "Where is X implemented?", cross-cutting concerns.
- Use grep instead for known symbols or exhaustive reference searches.]],

	schema = {
		type = "object",
		properties = {
			query = { type = "string", description = "Natural language or symbol query", required = true },
			path = { type = "string", description = "Directory to search" },
			top_k = { type = "integer", description = "Number of results (default " .. DEFAULT_TOP_K .. ")" },
			content = { type = "string", description = "code (default), docs, config, or all" },
		},
	},
	header = function(input)
		local buf = maki.ui.buf()
		local spans = { { input.query or "", "tool" } }
		if input.path then
			spans[#spans + 1] = { " in ", "dim" }
			spans[#spans + 1] = { input.path, "path" }
		end
		buf:line(spans)
		return buf
	end,

	restore = function(_input, output, _is_error, ctx)
		return ToolView.restore(output, semble_view_opts(ctx))
	end,

	handler = function(input, ctx)
		local query = input.query
		if not query then
			return "error: query is required"
		end

		local config = ctx:config()
		local max_lines = (config and config.max_output_lines) or 2000
		local max_bytes = (config and config.max_output_bytes) or (50 * 1024)

		local top_k = input.top_k or DEFAULT_TOP_K
		local path = input.path or cwd

		local cmd = "semble search " .. shell_quote(query) .. " " .. shell_quote(path) .. " --top-k " .. tostring(top_k)

		if input.content then
			cmd = cmd .. " --content " .. shell_quote(input.content)
		end

		local buf, view
		do
			local b = maki.ui.buf()
			local v = ToolView.new(b, semble_view_opts(ctx))
			v:append({ { "Searching...", "dim" } })
			buf, view = b, v
			b:on("click", function()
				v:toggle()
			end)
		end

		local output_parts = {}

		local function append_line(line)
			if #output_parts > 0 then
				output_parts[#output_parts + 1] = "\n"
			end
			output_parts[#output_parts + 1] = line
		end

		local has_output = false

		maki.fn.jobstart(cmd, {
			on_stdout = function(_, line)
				if not has_output then
					has_output = true
					view:clear()
				end
				append_line(line)
				view:append(line)
			end,
			on_stderr = function(_, line)
				if not has_output then
					has_output = true
					view:clear()
				end
				append_line(line)
				view:append(line)
			end,
			on_exit = function(_, code)
				local output = table.concat(output_parts)
				local is_error = code ~= 0

				if output == "" then
					output = is_error and ("Exit code: " .. code) or "No results found"
					view:clear()
					view:append({ { output, "dim" } })
				end

				local llm_output = truncate(output, max_lines, max_bytes)
				view:finish()

				ctx:finish({ llm_output = llm_output, is_error = is_error, body = buf })
			end,
		})

		return nil
	end,
})
