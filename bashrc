function wasError() {
    if [ $? -ne 0 ]; then
        echo -e "\n\033[31m[ERROR]\n";
    fi
}

PS1='`wasError`\[\033]0;$MSYSTEM:${PWD//[^[:ascii:]]/?}\007\]\n\[\033[32m\]\u@\h \[\033[33m\]\w\[\033[36m\]`__git_ps1`\[\033[0m\]\n$'

SSH_ENV=$HOME/.ssh/environment

# start the ssh-agent
function start_agent {
    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add
}

if [ -f "${SSH_ENV}" ]; then
     . "${SSH_ENV}" > /dev/null
	 ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
	    start_agent;
	}
else
    start_agent;
fi

export HISTCONTROL=ignoredups

alias grep='grep --color=always'
alias egrep='egrep --color=always'
alias pgrep='pgrep --color=always'

alias ls='ls --color=always'
alias la='ls -A'
alias ll='ls -la'
