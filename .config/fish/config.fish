#!/usr/bin/env fish
if status is-interactive
  and not set -q __fish_setup
  # Install dependencies with pacman
  if type -q pacman
    sudo pacman -Syu alacritty awesome-terminal-fonts base-devel bat btop duf dust exa fish fisher fd ffmpeg fzf git git-delta man-db man-pages moreutils mosh neovim openssh openssl otf-firamono-nerd otf-fira-sans pandoc pkgfile progress python python-black python-pip python-pre-commit ripgrep rsync ruff shellcheck shfmt syncthing tealdeer ttf-firacode-nerd ttf-ibmplex-mono-nerd ttf-sourcecodepro-nerd vivid xz yamllint zellij zoxide

    # Let fisher manage itself
    fisher install jorgebucaran/fisher

    # Keep pkgfile up-to-date for use with command-not-found
    pkgfile -u
    # if type -q junest
    #   systemctl --user enable --now pkgfile-update.timer
    # end

    # Replace yay with paru
    if type -q yay
      yay -Syu paru-bin
      paru -Rns yay
      paru -Syu mdformat micromamba-bin

    # Install AUR dependencies with paru
    else if type -q paru
      paru -Syu mdformat micromamba-bin

    # Print an error message
    else
      echo "Please install dependencies from the AUR"
    end

  # Install dependencies with brew
  else if type -q brew
    brew update
    brew upgrade
    brew install alacritty bash bat black btop coreutils duf dust exa fish fisher fd ffmpeg fzf font-awesome-terminal-fonts font-blex-mono-nerd-font font-charter font-cooper-hewitt font-fira-code-nerd-font font-fira-mono-nerd-font font-fira-sans font-sauce-code-pro-nerd-font git git-delta gnu-sed gnu-tar ipython jq less man-db mdformat micromamba moreutils mosh neovim openssh openssl pandoc progress pre-commit python ripgrep rsync ruff shellcheck shfmt syncthing tealdeer vivid xz yamllint zellij zoxide zsh

    fisher install jorgebucaran/fisher

  # Print an error message
  else
    echo "Please install dependencies using your package manager"
  end

  # Install NvChad
  git clone "https://github.com/NvChad/NvChad" "$HOME/.config/nvim" --depth 1

  # Remove fish greeting
  set -Ux fish_greeting

  # Configure fzf to use fd and Catppuccin
  set -Ux FZF_DEFAULT_COMMAND "fd --type file --strip-cwd-prefix --color=always --follow --hidden --exclude .git"
  set -Ux FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
  set -Ux FZF_DEFAULT_OPTS "--ansi \
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
  --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
  set -Ux FZF_CTRL_T_OPTS "--preview 'bat -n --color=always {} 2>/dev/null || tree -C {}' $FZF_DEFAULT_OPTS"

  # Set LS_COLORS with vivid
  set -Ux LS_COLORS (vivid generate catppuccin-mocha)

  # Prepare micromamba for initialization
  set -Ux MAMBA_EXE (type -p micromamba)
  set -Ux MAMBA_ROOT_PREFIX "$HOME/micromamba"

  # Configure bat to use Catppuccin
  git clone "https://github.com/catppuccin/bat.git" "$HOME/.config/bat/themes" --depth 1
  set -Ux BAT_THEME "Catppuccin-mocha"
  bat cache --build

  # Configure man to use bat
  set -Ux MANPAGER "sh -c 'col -bx | bat -l man -p'"

  # Set default pagers to use less with color passthrough
  set -Ux PAGER "less -RF --mouse"
  set -Ux BAT_PAGER "$PAGER"
  set -Ux DELTA_PAGER "$PAGER"

  # Set ripgrep configuration path
  set -Ux RIPGREP_CONFIG_PATH "$HOME/.config/ripgrep/config"

  # Configure btop to use Catppuccin
  git clone "https://github.com/catppuccin/btop.git" "$HOME/.config/btop/catppuccin" --depth 1
  ln -s "$HOME/.config/btop/catppuccin/themes" "$HOME/.config/btop/themes"

  # Set aliases for common commands
  alias -s ls="exa"
  alias -s cat="bat"
  alias -s grep="rg"
  alias -s find="fd"

  # Configure fish to use Catppuccin
  fisher install catppuccin/fish
  fish_config theme save "Catppuccin Mocha"

  # Configure fish to use tide
  fisher install IlanCosman/tide

  # Update completions
  fish_update_completions

  # Track whether fish has been set up
  set -Ux __fish_setup true

else if status is-interactive
  # Commands to run in interactive sessions can go here
  set -gx SHELL (type -p fish)

  # Initialize micromamba
  $MAMBA_EXE shell hook --shell fish --prefix $MAMBA_ROOT_PREFIX | source

  # Initialize zoxide
  zoxide init fish | source
  alias cd="z"
end
