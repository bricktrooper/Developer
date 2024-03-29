export CLICOLOR=1
export LSCOLORS=exgxCxDxcxexexaxaxaxex
export HISTCONTROL=ignoreboth:erasedups

PS1_BLACK="\[\e[0;30m\]"
PS1_RED="\[\e[0;31m\]"
PS1_GREEN="\[\e[0;32m\]"
PS1_YELLOW="\[\e[0;33m\]"
PS1_BLUE="\[\e[0;34m\]"
PS1_MAGENTA="\[\e[0;35m\]"
PS1_CYAN="\[\e[0;36m\]"
PS1_WHITE="\[\e[0;37m\]"
PS1_RESET="\[\e[0m\]"

export ENABLE_PS1_HOSTNAME=$1
export ENABLE_PS1_USER=$2
export ENABLE_PS1_DIRECTORY=$3
export ENABLE_PS1_BRANCH=$4
export ENABLE_PS1_TERMINATOR=1
export ENABLE_PS1_ARCHITECTURE=0

ps1_hostname()
{
	if [[ $ENABLE_PS1_HOSTNAME -eq 1 ]]
	then
		echo "${PS1_RESET}(${PS1_GREEN}\h${PS1_RESET})"
		#echo "${PS1_RESET}(${PS1_GREEN}$(arch)${PS1_RESET})"
	fi
}

ps1_dash()
{
	if [[ $ENABLE_PS1_HOSTNAME -eq 1 ]] && [[ $ENABLE_PS1_USER -eq 1 ]]
	then
		echo "-"
	fi
}

ps1_user()
{
	if [[ $ENABLE_PS1_USER -eq 1 ]]
	then
		echo "${PS1_RESET}[${PS1_YELLOW}\u${PS1_RESET}]"
	fi
}

ps1_colon()
{
	if [[ $ENABLE_PS1_USER -eq 1 ]] || [[ $ENABLE_PS1_HOSTNAME -eq 1 ]]
	then
		echo "${PS1_RED}:${PS1_RESET}"
	fi
}

ps1_directory()
{
	if [[ $ENABLE_PS1_DIRECTORY -eq 1 ]]
	then
		echo "${PS1_BLUE}\w${PS1_RESET}"
	fi
}

git_branch()
{
	if [[ $ENABLE_PS1_BRANCH -eq 1 ]]
	then
		local BRANCH=$(git branch 2> /dev/null | grep "*" | sed 's/* //')

		if [[ -n $BRANCH ]]
		then
			echo "(${BRANCH})"
		fi
	fi
}

ps1_terminator()
{
	if [[ $ENABLE_PS1_TERMINATOR -eq 1 ]]
	then
		if [[ `whoami` == "root" ]]
		then
			echo "# "
		else
			echo "$ "
		fi
	fi
}

export PS1_HOSTNAME=`ps1_hostname`
export PS1_DASH=`ps1_dash`
export PS1_USER=`ps1_user`
export PS1_COLON=`ps1_colon`
export PS1_DIRECTORY=`ps1_directory`
export PS1_BRANCH="\`git_branch\`"
export PS1_TERMINATOR=`ps1_terminator`

export PS1="${PS1_HOSTNAME}${PS1_DASH}${PS1_USER}${PS1_COLON}${PS1_DIRECTORY}${PS1_BRANCH}${PS1_TERMINATOR}"
