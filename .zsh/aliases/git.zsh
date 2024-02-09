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
	starting_dir=$(pwd)
	branch_name=${2:-origin/master}
	z $1
	echo "Fetching latest refs from $(z -e $1)..."
	git fetch
	hash=$(git rev-parse $branch_name | tr -d '\n')

	cd $starting_dir

	echo "commit-hash $branch_name HEAD: $hash"
	if [[ $3 = 'cb' ]]; then
		echo $hash | tr -d '\n' | pbcopy
		echo "Commit hash copied to clipboard!"
	fi
}

function zgo() {
	starting_dir="$(pwd)"
	z $1
	git-open $2 $3
	cd $starting_dir
}

alias ga='git add'
alias gan='git add -N'
alias gapa='git add --patch'
alias gbe='git branch | grep "eric/"'
alias gby='git branch | yank'
alias gc='git commit --verbose'
alias gc!='git commit --verbose --amend'
alias gcmsg='git commit --message'
alias gcob='git checkout -b'
alias gco='git checkout'
alias gd='git diff'
alias gdc='git diff --compact-summary'
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

# Github cli aliases
alias ginv="gh search prs \
	--involves @me \
	--state open \
	--order desc \
	--sort created \
	--json url,number,author,repository,title,updatedAt \
	--template '
{{color \"magenta+bu\" \"PULL REQUESTS IM INVOLVED IN\"}}

{{range .}}{{color \"78\" (hyperlink .url (printf \"#%v\" .number))}}{{\"\t\"}}{{truncate 15 .author.login}}{{\"\t\"}}{{color \"blue\" (truncate 30 .repository.name)}}{{\"\t\t\"}}{{truncate 50 .title}}{{\"\n\"}}{{end}}'
"

alias gpr="gh search prs \
	--author @me \
	--state open \
	--order desc \
	--sort updated \
	--json url,number,repository,title,updatedAt \
	--template '
{{color \"magenta+bu\" \"MY PULL REQUESTS\"}}
{{range .}}{{color \"78\" (hyperlink .url (printf \"#%v\" .number))}}{{\"\t\"}}{{color \"blue\" .repository.name}}{{\"\t\t\"}}{{.title}}{{\"\n\"}}{{end}}'
"

alias grr="gh search prs \
	--review-requested @me \
	--state open \
	--order desc \
	--sort created \
	--json url,number,author,repository,title,updatedAt \
	--template '
{{color \"magenta+bu\" \"TODO REVIEW REQUESTS\"}}{{\"\n\"}} \
{{range .}}{{color \"78\" (hyperlink .url (printf \"#%v\" .number))}}{{\"\t\"}}{{truncate 15 .author.login}}{{\"\t\"}}{{color \"blue\" (truncate 30 .repository.name)}}{{\"\t\t\"}}{{truncate 50 .title}}{{\"\n\"}}{{end}}'
"
alias grr1="gh search prs \
	--review-requested @me \
	--state open \
	--order asc \
	--sort created \
	--json url,number,author,repository,title,updatedAt \
	--template '\
	{{- tablerow \"LINK\" \"AUTHOR\" \"REPO\" \"TITLE\" \"UPDATED\" -}}{{tablerender}} \
	{{- range . -}} \
	{{- tablerow \
		(hyperlink .url (printf \"#%v\" .number)) \
		(truncate 20 .author.login)
		(truncate 30 .repository.name) \
		(truncate 30 .title) \
		(timeago .updatedAt) \
	-}}
	{{- end}}' \
"
