# History settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt HIST_SAVE_NO_DUPS
setopt INC_APPEND_HISTORY

# Allow changing directories without `cd`
setopt autocd

# Use Vim-style keybindings
bindkey -v

# Autocompletion
autoload -U compinit; compinit

# Starship
eval "$(starship init zsh)"