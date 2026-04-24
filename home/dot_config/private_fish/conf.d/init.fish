# fnm init
if command -v fnm > /dev/null
    fnm env | source
end

# pyenv init
if command -v pyenv > /dev/null
    pyenv init - | source
end
