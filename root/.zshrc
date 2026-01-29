if command -v fnm >/dev/null 2>&1; then
    eval "$(fnm env --use-on-cd --version-file-strategy=recursive --log-level=quiet)"
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# keybinds
bindkey -s ^f "tmux-sessionizer\n"

# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

export CODE_DIR='~/code'
export OBSIDIAN_VAULT=~/Library/CloudStorage/ProtonDrive-me@ericelli.com-folder/Obsidian_Vaults/Personal

typeset +x BLN_PATH_TO_OPS='~/code/bln-ops-plan-state'

# Sourcing plugins and themes
source ~/.zsh/plugins/git-open/git-open.plugin.zsh
source ~/.zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme
source ~/.zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/plugins/zsh-z/zsh-z.plugin.zsh


# Only trigger autocomplete after you stop typing for a moment
zstyle ':autocomplete:*' delay 0.3

# Or reduce the number of lines shown
zstyle ':autocomplete:*' list-lines 8

# Sourcing alias files
for alias_files in ~/.zsh/aliases/*.zsh; do source $alias_files; done

#source ~/.zsh/scripts/generate_url.sh
export PATH="$HOME/.zsh/scripts:$PATH"
export PATH="$HOME/Library/pnpm/global/5/node_modules/@bluedrop-learning-networks/skillspass-dev-tools/bin/:$PATH"

if command -v thefuck >/dev/null 2>&1; then
    eval $(thefuck --alias)
fi

source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh # per the docs, this must be at the end of this file

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

if command -v direnv >/dev/null 2>&1; then
    eval "$(direnv hook zsh)"
fi

