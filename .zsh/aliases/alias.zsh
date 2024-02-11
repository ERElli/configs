alias ..='cd ..'

# Docker
alias dpf='docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.ID}}\t{{.CreatedAt}}\t{{.Size}}\t{{.Ports}}"'
alias dlf='docker logs -f'

alias la='ls -lAhG'
alias ls='ls --color=auto'

# General
alias reload='exec zsh'

function zc() {
  # Todo: add --dry-run flag
  cur_dir=$(pwd)
  z $1
  echo "opening $(pwd)..."
  code .
  cd $cur_dir
}
