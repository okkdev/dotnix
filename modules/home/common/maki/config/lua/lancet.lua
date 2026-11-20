-- /lancet toggles it. While on, bash commands that LANCET does not flag run
-- without a permission prompt; everything else prompts as usual.
-- lancet-classify is built in default.nix.

local enabled = false

local function classify(command)
	local id, err = maki.fn.jobstart({
		"lancet-classify",
		maki.json.encode({ command = command, shell = "bash" }),
	})
	if not id then
		return nil, err
	end
	local res, werr = maki.fn.jobwait(id, 20000)
	if not res then
		return nil, werr
	end
	local out = maki.json.decode(res.stdout:match("[^\n]+") or "", { luanil = { object = true } })
	if type(out) ~= "table" then
		return nil, "no answer: " .. res.stderr
	end
	return out
end

maki.api.set_slot("permission.prompt", function(prev, req, ctx)
	if enabled and req.tool == "bash" then
		local v, err = classify(req.input.command)
		if v and v.classification == "not_flagged" then
			return { decision = "allow" }
		end
		maki.ui.flash("lancet: " .. (v and v.classification or tostring(err)))
	end
	return prev(req, ctx)
end)

maki.api.register_command({
	name = "lancet",
	description = "Toggle LANCET auto-approval of bash commands",
	handler = function()
		enabled = not enabled
		maki.ui.flash("lancet " .. (enabled and "on" or "off"))
	end,
})
