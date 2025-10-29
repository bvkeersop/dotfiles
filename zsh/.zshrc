# ===============================
# Zsh Configuration
# ===============================

# --- History ---
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt HIST_SAVE_NO_DUPS       # Don’t save duplicate commands
setopt INC_APPEND_HISTORY       # Append commands immediately
setopt SHARE_HISTORY            # Share history across sessions

# --- Quality of Life ---
setopt autocd                   # Allow "cd"-less directory changes
setopt correct                  # Suggest command corrections
bindkey -v                      # Use Vim keybindings

# --- Autocompletion ---
autoload -U compinit && compinit

# --- Plugins ---
# Syntax highlighting (must be sourced *after* compinit)
if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Autosuggestions (must be sourced *after* compinit)
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Extra completions
if [ -d /usr/share/zsh-completions ]; then
  fpath+=(/usr/share/zsh-completions)
fi

# --- FZF (fuzzy finder) ---
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# --- Starship Prompt ---
eval "$(starship init zsh)"

# --- LSD Aliases ---
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'