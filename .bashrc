# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes
git_highlight=yes

get_git_status() 
{
    GIT_BRANCH=`git symbolic-ref HEAD 2> /dev/null | cut -b 12- 2> /dev/null`
    GIT_DIRTY=`git status --short 2> /dev/null | wc -l 2> /dev/null`

    if [ "$GIT_BRANCH" != "" ]; then
        echo -n "(git:$GIT_BRANCH"

        if [ "$GIT_DIRTY" != 0 ]; then
            echo -n "*)"
        else
            echo -n ")"
        fi
    fi
}

#get_hg_status()
# {
#     HG_COMMIT=`hg parents --template="{node}\n" 2> /dev/null`
#
#     if [ "$HG_COMMIT" != "" ]; then
#        HG_BRANCH=`cat .hg/branch 2> /dev/null`
#        echo -n "(hg:$HG_BRANCH)"
#    fi
# }

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    if [ "$git_highlight" = yes ]; then
        PS1='${debian_chroot:+($debian_chroot)}\[\e[0;36m\]\u@\h:\[\e[00m\] \[\e[0;33m\]\w\[\e[00m\] \[\e[0;31m\]$(get_git_status)\[\e[00m\] \$ '
    else
        PS1='${debian_chroot:+($debian_chroot)}\[\e[0;36m\]\u@\h:\[\e[00m\] \[\e[0;33m\]\w\[\e[00m\] \$ '
    fi
else # "$color_prompt = no" or not exist
    if [ "$git_highlight" = yes ]; then
        PS1='${debian_chroot:+($debian_chroot)}\u@\h: \w $(get_git_status) \$ '
    else
        PS1='${debian_chroot:+($debian_chroot)}\u@\h: \w \$ '
    fi
fi
unset color_prompt force_color_prompt git_highlight

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias launch='gnome-desktop-item-edit ~/Desktop/ --create-new'

alias mntsmb-server='sudo smbmount //192.168.1.15/stuff /mnt/smb/server -o username=voventus,password=samba'
alias mntsmb-router='sudo smbmount //192.168.1.1/disk_a1 /mnt/smb/router'

alias umntsmb-server='sudo umount /mnt/smb/server'
alias umntsmb-router='sudo umount /mnt/smb/router'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

export EDITOR=vim
