#!/usr/bin/env sh
# shellcheck shell=sh disable=SC3043 # `local` is supported by every real /bin/sh.

set -o errexit -o nounset

readonly NIX_INSTALLER_URL='https://install.determinate.systems/nix/tag/v3.24.2'

FLAKE_PATH=$(cd -- "$(dirname -- "$0")" && pwd)
readonly FLAKE_PATH

has_bold_support() {
	[ -t 2 ] || return 1
	case ${TERM:-} in
	xterm* | rxvt* | urxvt* | linux* | vt*) return 0 ;;
	*) return 1 ;;
	esac
}

print_message() {
	local label="$1" message="$2"

	if has_bold_support; then
		printf '\33[1m%s:\33[0m %s\n' "$label" "$message" >&2
	else
		printf '%s: %s\n' "$label" "$message" >&2
	fi
}

log() {
	local message="$1"

	print_message info "$message"
}

warn() {
	local message="$1"

	print_message warn "$message"
}

err() {
	local message="$1"

	print_message error "$message"
}

require_command() {
	local command_name="$1"

	if ! command -v "$command_name" >/dev/null; then
		err "Need $command_name, install it first and run the installation script again."
		exit 1
	fi
}

read_option() {
	local name="$1"
	shift

	while [ "$#" -gt 0 ]; do
		if [ "$1" = "--$name" ] && [ "$#" -gt 1 ] && [ -n "$2" ]; then
			printf '%s' "$2"
			return
		fi
		shift
	done
	return 1
}

parse_dry_run_argument() {
	local dry_run=false argument

	for argument in "$@"; do
		case $argument in
		--dry-run)
			dry_run=true
			;;
		*)
			err "Unknown argument $argument, the only option is --dry-run."
			exit 1
			;;
		esac
	done
	printf '%s' "$dry_run"
}

is_dry_run() {
	[ "$DRY_RUN" = true ]
}

run() {
	if is_dry_run; then
		log "Would run: $*"
		return
	fi
	"$@"
}

is_root() {
	[ "$(id -u)" -eq 0 ]
}

is_interactive() {
	[ -t 0 ]
}

has_systemd() {
	[ -d /run/systemd/system ]
}

detect_platform() {
	case $(uname -s) in
	Darwin)
		printf 'darwin'
		;;
	Linux)
		if [ -e /etc/NIXOS ]; then
			printf 'nixos'
		else
			printf 'linux'
		fi
		;;
	*)
		return 1
		;;
	esac
}

install_nix() {
	local platform plan_arguments confirmation_argument installer_script

	if ! platform=$(read_option platform "$@"); then
		err 'Installing Nix needs --platform with darwin, nixos or linux.'
		exit 1
	fi

	if command -v nix >/dev/null; then
		log 'Nix is already installed.'
		return
	fi

	case $platform in
	darwin)
		plan_arguments='install'
		;;
	linux)
		if has_systemd; then
			plan_arguments='install'
		else
			plan_arguments='install linux --init none'
		fi
		;;
	*)
		err "Can't install Nix on $platform."
		exit 1
		;;
	esac

	if is_interactive; then
		confirmation_argument=''
	else
		confirmation_argument='--no-confirm'
	fi

	require_command curl

	if is_dry_run; then
		log "Would install Nix with: $plan_arguments${confirmation_argument:+ $confirmation_argument}"
		return
	fi

	log 'Installing Nix...'
	installer_script=$(
		curl \
			--retry 3 \
			--fail \
			--silent \
			--show-error \
			--location \
			--proto '=https' \
			--tlsv1.2 \
			-- "$NIX_INSTALLER_URL"
	)
	# shellcheck disable=SC2086 # The arguments are single words, so splitting them is wanted.
	sh -c "$installer_script" nix-installer $plan_arguments $confirmation_argument
}

list_host_names() {
	local configurations_output="$1"

	nix eval \
		--raw \
		--apply 'configurations: builtins.concatStringsSep "\n" (builtins.attrNames configurations)' \
		"$FLAKE_PATH#$configurations_output"
}

print_menu() {
	local item_number=1 menu_item

	for menu_item in "$@"; do
		printf '%s) %s\n' "$item_number" "$menu_item"
		item_number=$((item_number + 1))
	done
}

is_valid_menu_choice() {
	local typed_choice="$1" item_count="$2"

	case $typed_choice in
	'' | *[!0-9]*) return 1 ;;
	esac
	[ "$typed_choice" -ge 1 ] && [ "$typed_choice" -le "$item_count" ]
}

pick_menu_item() {
	local item_number="$1"
	shift

	shift "$((item_number - 1))"
	printf '%s\n' "$1"
}

prompt_for_host_name() {
	local typed_choice

	print_menu "$@" >&2

	while true; do
		printf 'Which host is this machine? ' >&2
		if ! read -r typed_choice; then
			err 'No host chosen.'
			exit 1
		fi
		if is_valid_menu_choice "$typed_choice" "$#"; then
			pick_menu_item "$typed_choice" "$@"
			return
		fi
		log "Enter a number from 1 to $#."
	done
}

select_host_name() {
	local platform configurations_output host_names

	if ! platform=$(read_option platform "$@"); then
		err 'Choosing the host needs --platform with darwin or nixos.'
		exit 1
	fi

	case $platform in
	darwin)
		configurations_output='darwinConfigurations'
		;;
	nixos)
		configurations_output='nixosConfigurations'
		;;
	*)
		err "Can't choose a host on $platform."
		exit 1
		;;
	esac

	if ! is_interactive; then
		err 'Choosing the host needs a terminal, run the installation script in one.'
		exit 1
	fi

	if is_dry_run && ! command -v nix >/dev/null; then
		log 'Would ask which host this machine is once Nix is installed.'
		printf '<host>'
		return
	fi

	host_names=$(list_host_names "$configurations_output")
	if [ -z "$host_names" ]; then
		err "The flake has no $configurations_output."
		exit 1
	fi

	# shellcheck disable=SC2086 # Host names are single words, so splitting them is wanted.
	prompt_for_host_name $host_names
}

is_managed_by_nix_darwin() {
	local etc_file="$1"

	if [ ! -L "$etc_file" ]; then
		return 1
	fi
	case $(readlink -- "$etc_file") in
	/etc/static/*) return 0 ;;
	*) return 1 ;;
	esac
}

move_aside_for_nix_darwin() {
	local etc_file="$1"
	local backup_file="$etc_file.before-nix-darwin"

	if [ ! -e "$etc_file" ] || is_managed_by_nix_darwin "$etc_file"; then
		log "$etc_file doesn't need moving aside."
		return
	fi
	if [ -e "$backup_file" ]; then
		err "$backup_file already exists, move it away and run the installation script again."
		exit 1
	fi

	log "Moving $etc_file to $backup_file."
	run sudo mv -- "$etc_file" "$backup_file"
}

switch_configuration() {
	local platform host_name nh_subcommand

	if ! platform=$(read_option platform "$@"); then
		err 'Switching needs --platform with darwin or nixos.'
		exit 1
	fi

	if ! host_name=$(read_option host "$@"); then
		err 'Switching needs --host with the name of a host.'
		exit 1
	fi

	case $platform in
	darwin)
		move_aside_for_nix_darwin /etc/nix/nix.custom.conf
		nh_subcommand='darwin'
		;;
	nixos)
		nh_subcommand='os'
		;;
	*)
		err "Can't switch a configuration on $platform."
		exit 1
		;;
	esac

	log "Switching to $host_name..."
	run nix develop "$FLAKE_PATH" --command nh "$nh_subcommand" switch "$FLAKE_PATH#$host_name"

	if ! is_dry_run; then
		log "Switched to $host_name. Open a new terminal to load the new environment."
	fi
}

setup_darwin() {
	local host_name

	install_nix --platform darwin

	if ! host_name=$(select_host_name --platform darwin); then
		exit 1
	fi
	switch_configuration --platform darwin --host "$host_name"
}

setup_nixos() {
	local host_name

	install_nix --platform nixos

	if ! host_name=$(select_host_name --platform nixos); then
		exit 1
	fi
	switch_configuration --platform nixos --host "$host_name"
}

setup_linux() {
	install_nix --platform linux

	log 'No further setup is available on Linux yet.'
}

main() {
	local platform

	if is_root; then
		err 'Run the installation script as your normal user, not as root.'
		exit 1
	fi

	if ! platform=$(detect_platform); then
		err "Unsupported platform: $(uname -s)."
		exit 1
	fi

	export PATH="/nix/var/nix/profiles/default/bin:$PATH"
	export NIX_CONFIG='extra-experimental-features = nix-command flakes'

	if is_dry_run; then
		log 'Dry run, no changes will be made.'
	fi
	log "Setting up $platform from $FLAKE_PATH..."
	"setup_$platform"
}

if ! DRY_RUN=$(parse_dry_run_argument "$@"); then
	exit 1
fi
readonly DRY_RUN

main
