# User specific environment
personal_bin_root=${PERSONAL_ENV_HOME:-$HOME}
case :$PATH: in
  *:"$personal_bin_root/.local/bin":*) ;;
  *) PATH="$personal_bin_root/.local/bin:$PATH" ;;
esac
case :$PATH: in
  *:"$personal_bin_root/bin":*) ;;
  *) PATH="$personal_bin_root/bin:$PATH" ;;
esac
export PATH
unset personal_bin_root

# Atuin keeps history data and configuration in the XDG directories.
if command -v atuin >/dev/null 2>&1; then
  export ATUIN_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/atuin"
  export ATUIN_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/atuin"
  mkdir -p -m 700 -- "$ATUIN_HOME" "$ATUIN_CONFIG_DIR"
fi
