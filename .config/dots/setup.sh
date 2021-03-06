#!/bin/sh

# fish configuration
chsh -s /usr/bin/fish
fish_update_completions

## pkgfile configuration
pkgfile -u
systemctl enable --now pkgfile-update.timer

# git configuration
git config --global user.name cosmo
git config --global user.email cosmo@cosmo.red
git config --global color.ui true
git config --global core.editor nvim
