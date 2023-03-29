function git_current_branch() {
	local ref
	ref=$(git symbolic-ref --quiet HEAD 2> /dev/null)
	local ret=$?
	if [[ $ret != 0 ]]; then
		[[ $ret == 128 ]] && return  # no git repo.
		#	ref=$(git rev-parse --short HEAD 2> /dev/null) || return
	fi
	echo ${ref#refs/heads/}
}

function grp() {
	cur_dir=$(pwd)
	dest_dir=$(z -e $1)
	echo "Navigating to ${dest_dir}..."	
	z $1
	echo "Fetching latest..."
	git fetch
	hash=$(git rev-parse $2 | tr -d '\n')
	echo "Back to $cur_dir... \n"
	cd $cur_dir
	if [[ $3 = 'cb' ]]; then
		echo $hash | tr -d '\n' | pbcopy
		echo "Copying to clipboard..."
	fi
	echo "commit-hash $2 HEAD: $hash"
}

alias ga='git add'
alias gan='git add -N'
alias gapa='git add --patch'
alias gc='git commit --verbose'
alias gc!='git commit --verbose --amend'
alias gcmsg='git commit --message'
alias gcob='git checkout -b'
alias gco='git checkout'
alias gd='git diff'
alias gdno='git diff --name-only'
alias gds='git diff --staged'
alias gf='git fetch'
alias gl='git log'
alias glo='git log --oneline --decorate'
alias glocb='git log --oneline -n 1 --pretty=format:%s | tr -d "\n" | pbcopy'
alias gls='git log --stat'
alias glsp='git log --stat --patch'
alias gres='git restore --staged'
alias gm='git merge'
alias gto='git-open'
alias gtoom='git-open origin master'
alias gpu='git pull'
alias gpocb='git push origin $(git_current_branch)'
alias gst='git status'
alias gsts='git status -s'
alias gsta='git stash'
alias gstap='git stash push -u -m'
