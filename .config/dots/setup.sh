#!/bin/sh

# initialize directory structure
mkdir -p "${HOME}"/code

# set global options for git
git config --global user.name Cosmo
git config --global user.email cosmo@cosmo.red
git config --global color.ui true
git config --global core.editor nvim

# install tmux config with sane defaults
git clone https://github.com/gpakosz/.tmux.git "${HOME}"/.tmux
ln -s -f "${HOME}"/.tmux/.tmux.conf "${HOME}"/.tmux.conf

# add catppuccin theme to bat
git clone https://github.com/catppuccin/bat.git "${HOME}"/.config/bat/themes

# fish configuration
chsh -s /usr/bin/fish

# keep pkgfile up-to-date for use with command-not-found
pkgfile -u
systemctl enable --now pkgfile-update.timer

# TODO:
# Add git hooks for shellcheck
# Migrate more of .bashrc to config.fish (see test.fish)
