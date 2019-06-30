## dots
#### dotfiles

---

## dependencies
#### compositor
* [sway](https://wiki.archlinux.org/index.php/Sway)
    * [light](https://wiki.archlinux.org/index.php?title=Light)
    * [mako](https://github.com/emersion/mako)
    * [redshift-wlr-gamma-control-git](https://wiki.archlinux.org/index.php/Redshift)
    * [swayidle](https://github.com/swaywm/swayidle)
    * [swaylock](https://github.com/swaywm/swaylock)

#### editor
* [neovim](https://wiki.archlinux.org/index.php/Neovim)

#### launcher
* [bemenu](https://github.com/Cloudef/bemenu)

#### shell
* [fish](https://wiki.archlinux.org/index.php/Fish)

#### terminal
* [alacritty](https://wiki.archlinux.org/index.php/Alacritty)
    * [wl-clipboard-x11](https://github.com/brunelli/wl-clipboard-x11)

---

## instructions
#### installation
1. ```git clone --bare https://github.com/cosmojg/dots.git $HOME/.dots```
1. ```git --git-dir=$HOME/.dots/ --work-tree=$HOME checkout```
1. ```git --git-dir=$HOME/.dots/ --work-tree=$HOME config --local status.showUntrackedFiles no```

#### usage
1. ```dots add <file or folder>```
1. ```dots commit -m "<commit message>"```
1. ```dots push -u origin master```

see: https://www.atlassian.com/git/tutorials/dotfiles

---

## to-do
* configure bemenu or switch to fzf
* configure mako
* configure waybar
* write a setup script
