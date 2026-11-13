# Only interactive Bash
[[ $- == *i* ]] || return 0

# Switch to Fish for interactive SSH sessions if bash is login shell
if [[ -z ${PERSONAL_ENV_HOME:-} && -n ${SSH_TTY:-} && ${SHELL##*/} == bash && -z ${__AUTO_FISH_DONE_9DADEA76D94D:-} ]] &&
  command -v fish &>/dev/null; then
  __AUTO_FISH_DONE_9DADEA76D94D=1 exec fish
fi

# Vi editing
set -o vi

# History
HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/bash/history"
HISTCONTROL=ignoreboth:erasedups
HISTSIZE=10000
HISTFILESIZE=20000
HISTTIMEFORMAT='%F %T '

shopt -s histappend
shopt -s cmdhist lithist
shopt -s histverify

# Interactive conveniences
shopt -s autocd
shopt -s globstar
shopt -s dirspell

# applications
# Starship initializes before Atuin so its prompt still works with older
# Atuin versions that do not provide a Bash preexec backend.
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init bash)"
fi

# atuin
if command -v atuin >/dev/null 2>&1; then
  eval "$(atuin init bash --disable-up-arrow)"
fi

# direnv
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook bash)"
fi

# fzf (leave Ctrl+R to Atuin)
if command -v fzf >/dev/null 2>&1; then
  FZF_CTRL_R_COMMAND= eval "$(fzf --bash)"
fi

# nvim
if command -v nvim >/dev/null 2>&1; then
  export EDITOR=nvim
fi
