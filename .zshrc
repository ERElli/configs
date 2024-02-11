eval "$(fnm env --use-on-cd --version-file-strategy=recursive)"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

export CODE_DIR='~/code'

typeset +x BLN_PATH_TO_OPS='~/code/bln-ops-plan-state'

# Sourcing plugins and themes
source ~/.zsh/git-open/git-open.plugin.zsh
source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme
source ~/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-z/zsh-z.plugin.zsh

# Sourcing alias files
for alias_files in ~/.zsh/aliases/*.zsh; do source $alias_files; done

#source ~/.zsh/scripts/generate_url.sh

export PATH="$HOME/.zsh/scripts:$PATH"

source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh # per the docs, this must be at the end of this file
