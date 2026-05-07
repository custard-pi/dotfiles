# Replace ls with eza
if command -v eza >/dev/null
    alias l='eza -bF --color=auto --group-directories-first --icons=auto' # preferred listing
    alias la='eza -abF --color=auto --group-directories-first --icons=auto' # All files and dirs
    alias ll='eza -lGbF --git --color=auto --group-directories-first --icons=auto' # Long format
    alias llm='eza -lGbF --git --sort=modified -r' # sort by date Modified
    alias lt='eza -aTb --color=auto --group-directories-first --icons=auto' # Tree listing
    alias l.="eza -ab | grep -e '^\.'" # show only DOTfiles
    alias lx='eza -lbhHigUmuSa --time-style=long-iso --git --color-scale' # show eXtra info
    alias lX='eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale' # show even more eXtra info
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
