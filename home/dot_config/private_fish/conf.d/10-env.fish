# Atuin keeps history data and configuration in the XDG directories.
if command -v atuin >/dev/null
    set -l atuin_data_home $HOME/.local/share
    set -l atuin_config_home $HOME/.config
    if set -q XDG_DATA_HOME; and test -n "$XDG_DATA_HOME"
        set atuin_data_home $XDG_DATA_HOME
    end
    if set -q XDG_CONFIG_HOME; and test -n "$XDG_CONFIG_HOME"
        set atuin_config_home $XDG_CONFIG_HOME
    end
    set -gx ATUIN_HOME "$atuin_data_home/atuin"
    set -gx ATUIN_CONFIG_DIR "$atuin_config_home/atuin"
    mkdir -p -m 700 -- "$ATUIN_HOME" "$ATUIN_CONFIG_DIR"
end

# fnm init
if command -v fnm > /dev/null
    fnm env | source
end

# pyenv init
if command -v pyenv > /dev/null
    pyenv init - | source
end
