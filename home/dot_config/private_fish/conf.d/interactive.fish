if status is-interactive
    # Commands to run in interactive sessions can go here

    # fish config
    # vi keybindings
    fish_vi_key_bindings

    # applications
    # fzf (disable Ctrl+R to use mcfly for history search)
    if command -v fzf >/dev/null
        fzf --fish | FZF_CTRL_R_COMMAND= source
    end

    # mcfly
    if command -v mcfly >/dev/null
        mcfly init fish | source
        set -gx MCFLY_INTERFACE_VIEW BOTTOM
        set -gx MCFLY_PROMPT "❯"
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
