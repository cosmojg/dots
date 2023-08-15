#!/usr/bin/env bash
# prepend private bin directories to PATH or promote if already present
function __path_prepend {
	if [[ -d $1 ]]; then
		PATH=:${PATH}
		PATH=$1${PATH//:$1:/:}
	fi
}
__path_prepend "${HOME}"/.local/share/junest/bin
__path_prepend "${HOME}"/.local/bin
__path_prepend "${HOME}"/bin

# append private bin directories to PATH or demote if already present
function __path_append {
	if [[ -d $1 ]]; then
		PATH=${PATH}:
		PATH=${PATH//:$1:/:}$1
	fi
}
__path_append "${HOME}"/.junest/usr/bin_wrappers

# set locale and timezone
export LANG="en_US.UTF-8"
export TZ="America/New_York"

# indicate support for colors in terminal
export TERM="xterm-256color"
export COLORTERM="truecolor"

# set default editor with EDITOR and VISUAL
export EDITOR=nvim
export VISUAL=${EDITOR}

# set defaults for Julia and MATLAB
export JULIA_EDITOR=${EDITOR}
export JULIA_NUM_THREADS=auto
export JULIA_SHELL=bash
export MATLAB_SHELL=bash

# exit script if not running interactively
[[ $- != *i* ]] && return

# run zellij if remote and not already running
if [[ -n ${SSH_TTY} && -z ${ZELLIJ} ]]; then
	zellij attach -c && exit
fi

# run fish if installed and not already running
__fish_path=$(type -p fish)
if [[ -n ${__fish_path} && -z ${__fish_setup} ]]; then
	export SHELL=${__fish_path}
	exec fish
fi

# record infinite history
HISTSIZE=-1
HISTFILESIZE=-1

# ignore duplicate lines and lines with leading spaces
HISTCONTROL=ignoreboth

# append history rather than overwriting
shopt -s histappend

# resize output if display exists
[[ -n ${DISPLAY} ]] && shopt -s checkwinsize

# print a pretty prompt
PS1="\[\e[32;1m\][\A]\[\e[m\] \[\e[36m\]\u\[\e[m\]@\[\e[34m\]\h\[\e[33m\] \w \[\e[31m\][\$?]\[\e[m\] \$ "
PROMPT_COMMAND=''

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE="${HOME}"/.local/bin/micromamba
export MAMBA_ROOT_PREFIX="${HOME}"/micromamba
__mamba_setup="$("${MAMBA_EXE}" shell hook --shell bash --root-prefix "${MAMBA_ROOT_PREFIX}" 2>/dev/null)"
if [[ $? -eq 0 ]]; then
	eval "${__mamba_setup}"
else
	alias micromamba="${MAMBA_EXE}" # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<
