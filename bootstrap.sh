#!/usr/bin/env bash
set -euo pipefail

repo=https://github.com/custard-pi/dotfiles.git
shared=
personal_dest=

usage() {
  printf 'Usage: %s [--shared-user true|false] [--personal-dest ABSOLUTE_PATH] [--repo URL]\n' "$0"
}

while (($#)); do
  case $1 in
    --shared-user) shared=${2:?missing value for --shared-user}; shift 2 ;;
    --personal-dest) personal_dest=${2:?missing value for --personal-dest}; shift 2 ;;
    --repo) repo=${2:?missing value for --repo}; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) usage >&2; exit 2 ;;
  esac
done

if [[ -z $shared ]]; then
  read -r -p 'Shared user account? [y/N] ' answer </dev/tty
  case $answer in y|Y|yes|YES) shared=true ;; *) shared=false ;; esac
fi
case $shared in true|false) ;; *) printf 'Invalid --shared-user value: %s\n' "$shared" >&2; exit 2 ;; esac

if [[ $shared == true ]]; then
  if [[ -z $personal_dest ]]; then
    read -r -p 'Absolute personal directory: ' personal_dest </dev/tty
  fi
  [[ $personal_dest == /* && $personal_dest != / ]] || {
    printf 'Personal directory must be an absolute path other than /.\n' >&2
    exit 2
  }
else
  [[ -z $personal_dest ]] || { printf '%s\n' '--personal-dest requires --shared-user true' >&2; exit 2; }
  personal_dest=$HOME
fi

mkdir -p -- "$personal_dest/.local/bin" "$personal_dest/.config/chezmoi"
personal_dest=$(cd -P -- "$personal_dest" && pwd)
source_dir=$personal_dest/.local/share/chezmoi
config_path=$personal_dest/.config/chezmoi/chezmoi.yaml
export PATH="$personal_dest/.local/bin:$PATH"
if [[ $shared == true ]]; then
  export XDG_CONFIG_HOME=$personal_dest/.config
  export XDG_DATA_HOME=$personal_dest/.local/share
  export XDG_STATE_HOME=$personal_dest/.local/state
  export XDG_CACHE_HOME=$personal_dest/.cache
fi

if [[ ! -x $personal_dest/.local/bin/chezmoi ]]; then
  curl -fsLS https://get.chezmoi.io | sh -s -- -b "$personal_dest/.local/bin"
fi
chezmoi_bin=$personal_dest/.local/bin/chezmoi

init_args=(--source "$source_dir" --destination "$personal_dest" init
  --config-path "$config_path" --apply --guess-repo-url=false
  --promptBool "User shared with others=$shared")
if [[ $shared == true ]]; then
  init_args+=(--promptString "Absolute directory to apply your config=$personal_dest")
fi
"$chezmoi_bin" "${init_args[@]}" "$repo"
# Make mise-managed tools visible when the init template checks lookPath again.
if [[ -x $personal_dest/.local/bin/mise ]]; then
  if [[ $shared == true ]]; then
    export MISE_CONFIG_DIR=$XDG_CONFIG_HOME/mise
    export MISE_GLOBAL_CONFIG_ROOT=$personal_dest
    export MISE_CEILING_PATHS=$(dirname -- "$personal_dest")
  fi
  eval "$("$personal_dest/.local/bin/mise" activate bash)"
fi
# The first target state was calculated before package-installing before scripts.
"$chezmoi_bin" --source "$source_dir" --destination "$personal_dest" \
  --config "$config_path" apply --init
