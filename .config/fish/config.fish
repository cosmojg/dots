#!/usr/bin/env fish
if status is-interactive
  and not set -q __fish_setup
  # Install dependencies
  if type -q pacman
    sudo pacman -Syu alacritty base-devel bat btop duf dust exa fish fisher fd fzf git git-delta man-db man-pages moreutils mosh neovim pandoc progress python python-black python-pip python-pre-commit ripgrep rsync ruff scrcpy shellcheck shfmt syncthing tealdeer tmux vivid yamllint zoxide
    if type -q yay
      yay -Syu micromamba-bin
    else if type -q paru
      paru -Syu micromamba-bin
    else
      echo "Please install dependencies from the AUR"
    end
  else if type -q brew
    brew install alacritty bash bat black btop coreutils duf dust exa fish fisher fd fzf font-fira-code-nerd-font font-fira-mono-nerd-font git git-delta gnu-tar less micromamba moreutils mosh neovim openssh pandoc progress pre-commit ripgrep rsync ruff scrcpy shellcheck shfmt syncthing tealdeer tmux vivid yamllint zoxide zsh
  else
    echo "Please install dependencies using your package manager"
  end

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

  # Configure man to use bat
  set -Ux MANPAGER "sh -c 'col -bx | bat -l man -p'"

  # Set ripgrep configuration path
  set -Ux RIPGREP_CONFIG_PATH "$HOME/.config/ripgrep/config"

  # Set aliases for common commands
  alias -s ls="exa"
  alias -s cat="bat"
  alias -s grep="rg"
  alias -s find="fd"

  # Configure fish to use Catppuccin
  fisher install catppuccin/fish
  fish_config theme save "Catppuccin Mocha"

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
