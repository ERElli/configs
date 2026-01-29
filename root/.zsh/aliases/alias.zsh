alias ..='cd ..'

# Docker
alias dpf='docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.ID}}\t{{.CreatedAt}}\t{{.Size}}\t{{.Ports}}"'
alias dlf='docker logs -f'
alias drc='docker ps -a --format "{{.ID}}\t{{.Names}}" | fzf -m --preview "docker logs {1}" --preview-window "right:60%" | awk "{print \$1}" | xargs -r docker rm'
alias dri='docker images --format "{{.ID}}\t{{.Repository}}\t{{.Tag}}" | fzf -m --preview "docker image history {1}" --preview-window "right:60%" | awk "{print \$1}" | xargs -r docker rmi'

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

# Navigation
alias ..='cd ..'
alias la='ls -lAhG'
alias ls='ls --color=auto'
