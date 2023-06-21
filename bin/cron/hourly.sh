#!/bin/bash
export PATH="${PATH}:/usr/local/bin"
export SHELL="/usr/local/bin/fish"
heads() {
	/usr/local/bin/brew update && /usr/local/bin/brew upgrade
}
tails() {
	echo "GONE FISHING BRB"
}
if ((RANDOM % 2 < 1)); then heads; else tails; fi
