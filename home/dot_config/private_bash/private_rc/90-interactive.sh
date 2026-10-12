# Only interactive Bash
[[ $- == *i* ]] || return 0

# Switch to Fish for interactive SSH sessions
if [[ -n ${SSH_TTY:-} && $- == *i* && -z ${__AUTO_FISH_DONE_9DADEA76D94D:-} ]] &&
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

# Starship for interactive Bash
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init bash)"
fi
