if status is-interactive
    # Commands to run in interactive sessions can go here

    # fish config
    # vi keybindings
    fish_vi_key_bindings

    # applications
    # atuin
    if command -v atuin >/dev/null
        atuin init fish --disable-up-arrow | source
    end

    # direnv
    if command -v direnv >/dev/null
        direnv hook fish | source
    end

    # fzf (leave Ctrl+R to Atuin)
    if command -v fzf >/dev/null
        fzf --fish | FZF_CTRL_R_COMMAND= source
    end

    # nvim
    if command -v nvim >/dev/null
        set -gx EDITOR nvim
    end

    # starship
    if command -v starship >/dev/null
        starship init fish | source
    end
end
