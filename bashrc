if [ -f ~/.aliases ]; then
    . ~/.aliases
fi
if [ -f ~/.grep ]; then
    . ~/.grep
fi

export PATH="$HOME/.rbenv/bin:$PATH"
