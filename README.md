## dots
dotfiles

---

## dependencies
#### compositor
* [sway](https://wiki.archlinux.org/index.php/Sway)
  * [grim](https://github.com/emersion/grim)*
  * [light](https://wiki.archlinux.org/index.php?title=Light)
  * [mako](https://github.com/emersion/mako)*
  * [redshift-wlr-gamma-control-git](https://wiki.archlinux.org/index.php/Redshift)
  * [slurp](https://github.com/emersion/slurp)*
  * [swayidle](https://github.com/swaywm/swayidle)
  * [swaylock](https://github.com/swaywm/swaylock)
  * [waybar](https://github.com/Alexays/Waybar)*
    * [otf-font-awesome](https://github.com/FortAwesome/Font-Awesome)
  * [xorg-server-xwayland](https://wiki.archlinux.org/index.php/Wayland#XWayland)

#### editor
* [neovim](https://wiki.archlinux.org/index.php/Neovim)

#### launcher
* [bemenu](https://github.com/Cloudef/bemenu)*

#### shell
* [fish](https://wiki.archlinux.org/index.php/Fish)
  * [pkgfile](https://wiki.archlinux.org/index.php/Pkgfile)
  * [python](https://wiki.archlinux.org/index.php/Python)

#### terminal
* [alacritty](https://wiki.archlinux.org/index.php/Alacritty)
  * [wl-clipboard-x11](https://github.com/brunelli/wl-clipboard-x11)

\* work in progress

---

## instructions
#### installation
1. ```git clone --bare git@github.com:cosmojg/dots.git $HOME/.dots```
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
  * move one-time fish setup out of config.fish
* configure automatic updates for pacman, brew, and fisher

---

## license

[GNU General Public License 3.0](LICENSE)
