# Replace ls with eza
if command -v eza >/dev/null
    alias ls='eza --color=auto --group-directories-first --icons=auto' # preferred listing
    alias la='eza -a --color=auto --group-directories-first --icons=auto' # all files and dirs
    alias ll='eza -l --color=auto --group-directories-first --icons=auto' # long format
    alias lt='eza -aT --color=auto --group-directories-first --icons=auto' # tree listing
    alias l.="eza -a | grep -e '^\.'" # show only dotfiles
end

# Replace cat with bat
if command -v bat >/dev/null
    alias cat='bat --plain --paging=never'
end

# Common usage
alias untar='tar -zxvf '
alias wget='wget -c '
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
