#!/usr/bin/env bash
set -euo pipefail

ASTGREP="${ASTGREP_BIN:-ast-grep}"

send_response() {
  local response="$1"
  printf '%s\n' "$response"
}

handle_initialize() {
  local id="$1"
  local resp
  resp=$(
    cat <<EOF
{"jsonrpc":"2.0","id":$id,"result":{"protocolVersion":"2024-11-05","capabilities":{"tools":{"listChanged":false},"prompts":{"listChanged":false}},"serverInfo":{"name":"ast-grep","version":"1.0.0"}}}
EOF
  )
  send_response "$resp"
}

handle_tools_list() {
  local id="$1"
  local resp
  resp=$(
    cat <<'EOF'
{"jsonrpc":"2.0","id":__ID__,"result":{"tools":[{"name":"search","description":"Find code by AST pattern. $NAME metavars match any single node, $$$NAME matches multiple nodes.\n\nExamples:\n- pattern: console.log($MSG), lang: javascript — find console.log calls\n- pattern: import $$$IMPORTS from '$MOD', lang: typescript — find ES imports\n- pattern: def $FN(self, $$$ARGS): $$$BODY, lang: python — find methods\n- pattern: .unwrap(), lang: rust — find unwrap calls\n- pattern: if ($COND) { return $VAL; }, lang: javascript — find early returns","inputSchema":{"type":"object","properties":{"pattern":{"type":"string","description":"AST pattern. $NAME = single-node wildcard, $$$NAME = multi-node wildcard."},"language":{"type":"string","description":"Source language (javascript, typescript, python, rust, go, java, c, cpp, etc)."},"paths":{"type":"array","items":{"type":"string"},"description":"Directories/files to search. Default: cwd."},"globs":{"type":"array","items":{"type":"string"},"description":"Glob filters, e.g. ['*.ts', '!test/**']."}},"required":["pattern","language"]}},{"name":"search_and_replace","description":"Find-and-replace by AST pattern. Metavars captured in pattern are available in rewrite.\n\nExamples:\n- pattern: var $X = $Y, rewrite: const $X = $Y, lang: javascript\n- pattern: $A == null, rewrite: $A === null, lang: typescript\n- pattern: print($$$ARGS), rewrite: logger.info($$$ARGS), lang: python\n- pattern: .unwrap(), rewrite: ?, lang: rust","inputSchema":{"type":"object","properties":{"pattern":{"type":"string","description":"AST pattern to match."},"rewrite":{"type":"string","description":"Replacement with $NAME/$$$NAME metavar refs from pattern."},"language":{"type":"string","description":"Source language."},"paths":{"type":"array","items":{"type":"string"},"description":"Directories/files to search."},"globs":{"type":"array","items":{"type":"string"},"description":"Glob filters."}},"required":["pattern","rewrite","language"]}}]}}
EOF
  )
  resp="${resp/__ID__/$id}"
  send_response "$resp"
}

handle_prompts_list() {
  local id="$1"
  local resp
  resp=$(
    cat <<'EOF'
{"jsonrpc":"2.0","id":__ID__,"result":{"prompts":[]}}
EOF
  )
  resp="${resp/__ID__/$id}"
  send_response "$resp"
}

handle_prompts_get() {
  local id="$1"
  local name="$2"
  local arguments="$3"

  if [ "$name" != "refactor" ]; then
    local err_resp
    err_resp=$(jq -n --argjson id "$id" '{jsonrpc:"2.0",id:$id,error:{code:-32602,message:"Unknown prompt"}}')
    send_response "$err_resp"
    return
  fi

  local description language
  description=$(printf '%s' "$arguments" | jq -r '.description // "refactor the code"')
  language=$(printf '%s' "$arguments" | jq -r '.language // "rust"')

  local text="You have access to an ast-grep search_and_replace tool. Use it to: ${description}\n\nThe source language is ${language}. Use ast-grep pattern syntax with \$NAME for single-node wildcards and \$\$\$NAME for multi-node wildcards.\n\nSearch first to verify matches, then apply the replacement."

  local resp
  resp=$(jq -n --argjson id "$id" --arg text "$text" '{jsonrpc:"2.0",id:$id,result:{messages:[{role:"user",content:{type:"text",text:$text}}]}}')
  send_response "$resp"
}

handle_tool_call() {
  local id="$1"
  local method_name="$2"
  local arguments="$3"

  local pattern language rewrite
  pattern=$(printf '%s' "$arguments" | jq -r '.pattern // empty')
  language=$(printf '%s' "$arguments" | jq -r '.language // empty')
  rewrite=$(printf '%s' "$arguments" | jq -r '.rewrite // empty')

  if [ -z "$pattern" ] || [ -z "$language" ]; then
    local err_resp
    err_resp=$(jq -n --argjson id "$id" '{jsonrpc:"2.0",id:$id,result:{content:[{type:"text",text:"Error: pattern and language are required."}],isError:true}}')
    send_response "$err_resp"
    return
  fi

  local cmd=("$ASTGREP" "run" "-p" "$pattern" "-l" "$language" "--json=compact")

  local paths_json globs_json
  paths_json=$(printf '%s' "$arguments" | jq -r '.paths // empty')
  globs_json=$(printf '%s' "$arguments" | jq -r '.globs // empty')

  local is_replace=false
  if [ "$method_name" = "search_and_replace" ]; then
    if [ -z "$rewrite" ]; then
      local err_resp
      err_resp=$(jq -n --argjson id "$id" '{jsonrpc:"2.0",id:$id,result:{content:[{type:"text",text:"Error: rewrite is required for search_and_replace."}],isError:true}}')
      send_response "$err_resp"
      return
    fi
    is_replace=true
    cmd+=("-r" "$rewrite")
  fi

  if [ -n "$globs_json" ] && [ "$globs_json" != "null" ]; then
    while IFS= read -r glob; do
      cmd+=("--globs" "$glob")
    done < <(printf '%s' "$arguments" | jq -r '.globs[]')
  fi

  if [ -n "$paths_json" ] && [ "$paths_json" != "null" ]; then
    while IFS= read -r p; do
      cmd+=("$p")
    done < <(printf '%s' "$arguments" | jq -r '.paths[]')
  fi

  local output exit_code=0
  output=$("${cmd[@]}" 2>&1) || exit_code=$?

  local result_text
  if [ $exit_code -eq 0 ]; then
    local count
    count=$(printf '%s' "$output" | jq 'length' 2>/dev/null || echo "0")
    if [ "$count" = "0" ] || [ -z "$output" ] || [ "$output" = "[]" ]; then
      result_text="No matches found."
    else
      if [ "$is_replace" = true ]; then
        local apply_cmd=("$ASTGREP" "run" "-p" "$pattern" "-l" "$language" "-r" "$rewrite" "--update-all")
        if [ -n "$globs_json" ] && [ "$globs_json" != "null" ]; then
          while IFS= read -r glob; do
            apply_cmd+=("--globs" "$glob")
          done < <(printf '%s' "$arguments" | jq -r '.globs[]')
        fi
        if [ -n "$paths_json" ] && [ "$paths_json" != "null" ]; then
          while IFS= read -r p; do
            apply_cmd+=("$p")
          done < <(printf '%s' "$arguments" | jq -r '.paths[]')
        fi
        "${apply_cmd[@]}" >/dev/null 2>&1 || true
        result_text="Replaced $count matches."$'\n\n'"$(printf '%s' "$output" | jq -r '.[] | "\(.file):\(.range.start.line + 1):\(.range.start.column + 1)\n  matched: \(.text)\n  replacement: \(.replacement // "N/A")\n"')"
      else
        result_text="Found $count matches:"$'\n\n'"$(printf '%s' "$output" | jq -r '.[] | "\(.file):\(.range.start.line + 1):\(.range.start.column + 1)\n  \(.lines | gsub("^\\s+"; "") | gsub("\\n$"; ""))\n"')"
      fi
    fi
  elif [ $exit_code -eq 1 ]; then
    result_text="No matches found."
  else
    result_text="ast-grep error (exit $exit_code): $output"
  fi

  local resp
  resp=$(jq -n --argjson id "$id" --arg text "$result_text" '{jsonrpc:"2.0",id:$id,result:{content:[{type:"text",text:$text}],isError:false}}')
  send_response "$resp"
}

while IFS= read -r line; do
  line="${line%%$'\r'}"
  if [ -z "$line" ]; then
    continue
  fi

  body="$line"

  method=$(printf '%s' "$body" | jq -r '.method // empty')
  id=$(printf '%s' "$body" | jq -r '.id // empty')

  case "$method" in
  "initialize")
    handle_initialize "$id"
    ;;
  "notifications/initialized")
    ;;
  "tools/list")
    handle_tools_list "$id"
    ;;
  "prompts/list")
    handle_prompts_list "$id"
    ;;
  "prompts/get")
    prompt_name=$(printf '%s' "$body" | jq -r '.params.name')
    prompt_args=$(printf '%s' "$body" | jq -c '.params.arguments // {}')
    handle_prompts_get "$id" "$prompt_name" "$prompt_args"
    ;;
  "tools/call")
    tool_name=$(printf '%s' "$body" | jq -r '.params.name')
    tool_args=$(printf '%s' "$body" | jq -c '.params.arguments // {}')
    handle_tool_call "$id" "$tool_name" "$tool_args"
    ;;
  "ping")
    send_response "{\"jsonrpc\":\"2.0\",\"id\":$id,\"result\":{}}"
    ;;
  *)
    if [ -n "$id" ]; then
      err_resp=$(jq -n --argjson id "$id" '{jsonrpc:"2.0",id:$id,error:{code:-32601,message:"Method not found"}}')
      send_response "$err_resp"
    fi
    ;;
  esac
done
