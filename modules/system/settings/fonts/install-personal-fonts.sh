#!/usr/bin/env bash

set -o errexit -o nounset -o pipefail
shopt -s inherit_errexit
IFS=$'\n\t'

is_installed() {
	local -r archive_path=$1 stamp_path=$2

	[[ -f $stamp_path && "$(<"$stamp_path")" == "$archive_path" ]]
}

extract_archive() {
	local -r archive_path=$1 key_file_path=$2 output_directory=$3

	age --decrypt --identity "$key_file_path" "$archive_path" |
		tar --extract --gzip --directory "$output_directory"
}

replace_fonts() {
	local -r source_directory=$1 install_directory=$2

	mkdir -p -- "$install_directory"
	rsync --archive --delete -- "$source_directory/" "$install_directory/"
}

main() {
	local -r archive_path=$1 key_file_path=$2 install_directory=$3
	local -r stamp_path="$install_directory/.source"

	if is_installed "$archive_path" "$stamp_path"; then
		return 0
	fi

	if [[ ! -f $key_file_path ]]; then
		printf 'Skipping the personal fonts until %s exists.\n' "$key_file_path" >&2
		return 0
	fi

	local staging_directory
	staging_directory=$(mktemp -d)

	(
		trap 'rm -rf -- "$staging_directory"' EXIT

		extract_archive "$archive_path" "$key_file_path" "$staging_directory"
		replace_fonts "$staging_directory" "$install_directory"
	)

	printf '%s\n' "$archive_path" >"$stamp_path"
	printf 'Installed the personal fonts into %s.\n' "$install_directory"
}

main "$@"
