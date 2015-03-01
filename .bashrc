# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

source ~/.vars #user/app specific config variables

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

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

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias e='emacsclient -t'
alias ec='emacsclient -c'
alias emacs='/usr/bin/emacs24'
alias git_clean='git clean -df & git checkout -- .' #undo all unstaged changes
alias prompt="export PS1='${debian_chroot:+($debian_chroot)}\$ '" #need a simple prompt?


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
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#Environment variables
export EDITOR=atom
export DEBFULLNAME=$USERFULLNAME
export DEBEMAIL=$EMAIL

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export MYSQL_PS1="[\d]> " # more details: "(\u@\h) [\d]> "

#Git
export GIT_EDITOR=atom
export GIT_COMMITTER_NAME=$USERFULLNAME
export GIT_COMMITTER_EMAIL=$EMAIL
export GIT_AUTHOR_NAME=$USERFULLNAME
export GIT_AUTHOR_EMAIL=$EMAIL
export GIT_SSL_NO_VERIFY=true

#golang
export GOOS=linux 
export GOARCH=amd64 


export BEEP=/usr/share/sounds/KDE-Im-Message-In.ogg
export BEEPMP3=$HOME/.local/share/sounds/CRASH_6.mp3
alias beep='paplay $BEEP'

#start or restart nginx
alias restart_php_nginx='sudo killall php-fpm; sudo $(which php-fpm) -d listen=/var/run/php-fpm/php-fpm.sock; (pidof nginx 1>/dev/null  && sudo $(which nginx) -s reload) || sudo $(which nginx)'
alias restart_php='sudo killall php-fpm; sudo $(which php-fpm) -d listen=/var/run/php-fpm/php-fpm.sock'
alias restart_nginx='(pidof nginx 1>/dev/null  && sudo $(which nginx) -s reload) || sudo $(which nginx)'

#see https://gist.github.com/1688857
export RUBY_GC_HEAP_INIT_SLOTS=1000000
export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=1000000000
export RUBY_HEAP_FREE_MIN=500000


#have jruby use 2.0 rather than 1.9,
export JRUBY_OPTS=--2.0

#for google app engine
export SERVER_SOFTWARE=Dev

#internationalization
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

#emacs shell fixes
export NODE_NO_READLINE=1

export NODE_ENV=development #development environment by default

#opengl mesa3d related variables
export LIBGL_ALWAYS_SOFTWARE=0 #don't default to software rendering


export PATH=$HOME/.composer/vendor/bin:$HOME/apps/redis/bin:$HOME/apps/phoronix/bin:$HOME/apps/din/bin:$HOME/apps/julia/bin:$HOME/apps/rust/bin:$HOME/.cabal/bin:$HOME/apps/haskell/bin:$HOME/apps/opam:$HOME/apps/r/bin:$HOME/apps/bin:$HOME/apps/inkscape/bin:$HOME/.rbenv/bin:$HOME/apps/calibre/calibre:$HOME/apps/php/bin:$HOME/apps/php/sbin:$HOME/apps/nginx/nginx/sbin:$PATH

#bash_completion for apps
source $HOME/apps/bash_completion/wp-completion.bash

#languages
#rbenv initialize and gemset use
eval "$(rbenv init -)"
export RBENV_GEMSET_FILE="$HOME/.rbenv-gemsets" 
export RBENV_GEMSETS="main"

export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
workon py27
#workon py34
#export PIP_VIRTUALENV_BASE=$WORKON_HOME
export PIP_RESPECT_VIRTUALENV=true

#tell python about some libraries you want it to be able to import
export PYTHONPATH=${PYTHONPATH}:$HOME/apps/gcloud/google-cloud-sdk/platform/gsutil/third_party/boto:$HOME/apps/gcloud/google-cloud-sdk/platform/gsutil/third_party/gcs-oauth2-boto-plugin:$HOME/apps/gsutil


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
export PS1='${debian_chroot:+($debian_chroot)}\$ '
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

# OPAM configuration
. $HOME/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

# The next line updates PATH for the Google Cloud SDK.
source "$HOME/apps/gcloud/google-cloud-sdk/path.bash.inc"

# The next line enables bash completion for gcloud.
source "$HOME/apps/gcloud/google-cloud-sdk/completion.bash.inc"

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh
