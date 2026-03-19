# source aliases
[ -f "$HOME/.aliases" ] && . "$HOME/.aliases"

# Env vars & PATH — written in POSIX sh so bash and zsh can both read it
export EDITOR="vim"
export PATH="$HOME/.local/bin:$PATH"

# colors
LS_COLORS='di=38;5;74:ln=38;5;140:so=38;5;110:pi=38;5;178:ex=38;5;71:bd=38;5;167:cd=38;5;178:su=38;5;167:sg=38;5;140:tw=38;5;115:ow=38;5;74;49'
export LS_COLORS

LSCOLORS='exfxcxdxbxegedabagacad'
export LSCOLORS

# pyenv setup
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"


# Load liminal functions
if [ -f "$HOME/.liminal/liminal.sh" ]; then
    . "$HOME/.liminal/liminal.sh"
fi

# pyenv PATH (liminal)
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv >/dev/null 2>&1; then
    eval "$(pyenv init --path)"
fi
# end pyenv PATH (liminal)
