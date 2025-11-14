# ===============================
# Zsh Configuration
# ===============================

# --- History ---
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt HIST_SAVE_NO_DUPS        # Don’t save duplicate commands
setopt INC_APPEND_HISTORY       # Append commands immediately
setopt SHARE_HISTORY            # Share history across sessions

# --- Quality of Life ---
setopt autocd                   # Allow "cd"-less directory changes
setopt correct                  # Suggest command corrections
bindkey -v                      # Use Vim keybindings

# --- Autocompletion ---
autoload -U compinit && compinit

# --- zinit Plugins ---
source ~/.local/share/zinit/zinit.git/zinit.zsh

# Syntax highlighting
zinit light zsh-users/zsh-syntax-highlighting

# Autosuggestions
zinit light zsh-users/zsh-autosuggestions
bindkey '^T' autosuggest-accept # accept

# Extra completions
zinit light zsh-users/zsh-completions

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

# --- Neovim ---
export PATH="$HOME/neovim/bin:$PATH"

# ===============================
# SSH Agent Setup (WSL Compatible)
# ===============================

# This section ensures you have exactly one persistent ssh-agent
# and automatically loads your automation key if not yet added.

export SSH_ENV="$HOME/.ssh/agent_env"

# --- Function: Start a new agent and save its environment ---
function start_agent {
    echo "[SSH] Starting new ssh-agent..."
    eval "$(ssh-agent -s)" > /dev/null
    echo "export SSH_AUTH_SOCK=$SSH_AUTH_SOCK" > "$SSH_ENV"
    echo "export SSH_AGENT_PID=$SSH_AGENT_PID" >> "$SSH_ENV"
    chmod 600 "$SSH_ENV"
}

# --- Reuse existing agent if possible ---
if [ -f "$SSH_ENV" ]; then
    source "$SSH_ENV" > /dev/null
    # Check if the agent process is still running
    if ! kill -0 $SSH_AGENT_PID 2>/dev/null; then
        start_agent
    fi
else
    start_agent
fi

# --- Add SSH key if available and not loaded ---
# Load key name dynamically from your JSON config
configFile="$HOME/dotfiles/config.json"
if [ -f "$configFile" ]; then
    keyname=$(jq -r '.git_ssh_keyname' "$configFile")
    KEY="$HOME/.ssh/$keyname"
    if [ -f "$KEY" ]; then
        # Check if the key is already added
        ssh-add -l | grep -q "$(basename "$KEY")"
        if [ $? -ne 0 ]; then
            echo "[SSH] Adding key: $KEY"
            ssh-add "$KEY" >/dev/null
        fi
    else
        echo "[SSH] Key file not found: $KEY"
    fi
else
    echo "[SSH] Config file not found: $configFile"
fi


# ===============================
# Zinit Bootstrapping (Leave as-is)
# ===============================

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk
