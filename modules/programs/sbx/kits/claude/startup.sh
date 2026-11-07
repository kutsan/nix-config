#!/usr/bin/env sh

set -eu

readonly CLAUDE_DIR=/home/agent/.claude
readonly SETTINGS_FILE=$CLAUDE_DIR/settings.json
readonly INSTRUCTIONS_FILE=$CLAUDE_DIR/CLAUDE.md

read_settings_or_empty() {
	local file=$1

	if [ -f "$file" ]; then
		cat -- "$file"
	else
		printf '{}'
	fi
}

merge_host_settings() {
	local sandbox_settings=$1 host_settings=$2

	printf '%s' "$sandbox_settings" |
		jq \
			--argjson host_settings "$host_settings" \
			'
			def drop_agent_sandbox: del(.sandbox);
			def disable_synced_skills_plugin: .enabledPlugins["kutsan-skills@synced"] = false;

			. * $host_settings | drop_agent_sandbox | disable_synced_skills_plugin
			'
}

main() {
	local host_settings=$1 agent_instructions=$2
	local settings

	settings=$(merge_host_settings "$(read_settings_or_empty "$SETTINGS_FILE")" "$host_settings")

	mkdir -p -- "$CLAUDE_DIR"
	printf '%s\n' "$settings" >"$SETTINGS_FILE"
	printf '%s' "$agent_instructions" >"$INSTRUCTIONS_FILE"
}

main "$@"
