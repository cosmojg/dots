#!/usr/bin/env fish
if status is-interactive
    # Let the children know who raised them
    set -gx FISH 1

    # Remove fish greeting
    set -gx fish_greeting

    # Configure man to use bat
    set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"

    # Set ripgrep configuration path
    set -gx RIPGREP_CONFIG_PATH "$HOME/.config/ripgrep/config"

    # Configure fzf to use fd and Catppuccin
    set -gx FZF_DEFAULT_COMMAND "fd --type file --strip-cwd-prefix --color=always --follow --hidden --exclude .git"
    set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
    set -gx FZF_DEFAULT_OPTS "--ansi \
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

    # Initialize zoxide
    zoxide init fish | source

    # Set aliases for common commands
    alias cd='z'
    alias ls='exa'
    alias cat='bat'
    alias less='bat --paging always'
    alias grep='rg'
    alias find='fd'
end
