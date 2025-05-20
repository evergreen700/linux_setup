### Locale ###
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Functions
function set_prompt () {
	    # Get return code of last command to put at front of prompt
		local LAST_COMMAND=$?

		# Define local variables
		## Colors
		local BOLD_BLUE='\[\e[01;34m\]'
		local BOLD_GREEN='\[\e[01;32m\]'
		local BOLD_PURPLE='\[\e[01;35m\]'
		local BOLD_RED='\[\e[01;31m\]'
		local BOLD_TEAL='\[\e[01;36m\]'
		local BOLD_WHITE='\[\e[01;37m\]'
		local BOLD_YELLOW='\[\e[01;33m\]'
		local BLUE='\[\e[00;34m\]'
		local GREEN='\[\e[00;32m\]'
		local PURPLE='\[\e[00;35m\]'
		local RED='\[\e[00;31m\]'
		local RESET='\[\e[00m\]'
		local TEAL='\[\e[00;36m\]'
		local WHITE='\[\e[00;37m\]'
		local YELLOW='\[\e[00;33m\]'
		## Special symbols
		local CHECKMARK='\342\234\223'
		local FANCY_X='\342\234\227'

		# Set prompt to titlebar
		PS1=$(set_titlebar)
		#set_titlebar PS1

		## If it was successful, print a green check mark.
		## Otherwise, print last commands return code and a red X.
		if [[ ${LAST_COMMAND} == 0 ]]; then
		    PS1+="${GREEN}${CHECKMARK} "
		#else
		#    PS1+="${WHITE}\$? ${RED}${FANCY_X} "
		fi

		# Begin prompt with a square bracket
		PS1+="${WHITE}["

		# If not successful, print last commands return code and a red X.
		if [[ ${LAST_COMMAND} != 0 ]]; then
			PS1+="${WHITE}\$? ${RED}${FANCY_X} "
		fi

		# If root, print the user in red.
		# Otherwise, print the current user in yellow.
		#local USERNAME_COLOR=${YELLOW}
		#if [[ ${EUID} == 0 ]]; then
		#	USERNAME_COLOR="${BOLD_RED}"
		#fi

		#PS1+="${USERNAME_COLOR}\\u${WHITE}@"

		# Print the short hostname
		PS1+="${GREEN}\\h${WHITE}:"

		# Add the git branch you are working on if in a git repo
		BRANCH="$(git branch 2>/dev/null | sed -n 's/* \(.*\)/\1/p')"
		if [[ ! -z "${BRANCH}" ]]; then
			PS1+="${PURPLE}(${BRANCH}) "
		fi

		# Add the python virtual environment you are working on if in a python virtual environment
		if [[ ${VIRTUAL_ENV} ]]; then
			PS1+="${YELLOW}{$(echo ${VIRTUAL_ENV} | sed -n 's/.*\/\(.*\)/\1/p')} "
		fi

                # Add the conda virtual environment you are working on if in a conda virtual environment
                if [[ ${CONDA_DEFAULT_ENV} ]]; then
                        PS1+="${YELLOW}{${CONDA_DEFAULT_ENV}} "
                fi

		# Print the working directory in teal
		PS1+="${TEAL}\\w"

		# End prompt with a square bracket
		PS1+="${WHITE}]"

		# Print the prompt marker in green
		# and reset the text color to the default.
		PS1+="\n${GREEN}\\\$${RESET} "
	}

	function set_titlebar () {
		# Set passed in parameter to local variable
		local p_titlebar=${1}

		# Setup the titlebar and store it
		local TITLEBAR='\[\e]0;\u@\h: \w\a\]'

		# If parameter was passed in set TITLEBAR to it;
		# Otherwise echo out TITLEBAR to stdout
		if [[ "${p_titlebar}" ]]; then
		# Use eval to interpret line twice and set paramter to local value
			eval ${p_titlebar}="'${TITLEBAR}'"
		else
			echo "${TITLEBAR}"
		fi
	}

PROMPT_COMMAND='set_prompt'

## ZACH ALIASES
# gitSSH: turns all https urls into ssh urls and then runs the equivalent git command
gitSSH(){
        array="${@}"
        echo "git ${array}" | sed -r 's/https\:\/\/github.com\/([^\s\/]+)\/([^\s\/]+)/git@github.com\:\1\/\2.git/g' | bash
}

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

## CONFIG PULLED FROM GCLOUD
shopt -s checkwinsize
shopt -s globstar

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

#Add alert alias for long running commmands? Haven't tested it out yet
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
