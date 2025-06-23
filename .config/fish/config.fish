#!/usr/bin/env fish
if status is-interactive
    and not set -q __fish_setup
    # Install dependencies with pacman
    if type -q pacman
        sudo pacman -Syu aichat alacritty awesome-terminal-fonts base-devel bat bfs btop duf dust eza fish fisher fd ffmpeg fzf git git-delta helix man-db man-pages moreutils mosh neovim openssh openssl otf-firamono-nerd otf-fira-sans pandoc pkgfile progress python ripgrep rsync shellcheck shfmt syncthing tealdeer ttf-firacode-nerd ttf-ibmplex-mono-nerd ttf-sourcecodepro-nerd uv vivid yamllint zellij zoxide zstd

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
        brew install aichat alacritty bash bat bfs btop coreutils duf dust eza fish fisher fd ffmpeg fzf font-awesome-terminal-fonts font-blex-mono-nerd-font font-charter font-cooper-hewitt font-fira-code-nerd-font font-fira-mono-nerd-font font-fira-sans font-sauce-code-pro-nerd-font git git-delta gnu-sed gnu-tar jq less man-db mdformat micromamba moreutils mosh neovim openssh openssl pandoc progress python ripgrep rsync shellcheck shfmt syncthing tealdeer uv vivid yamllint zellij zoxide zstd

        # Print an error message
    else
        echo "Please install dependencies using your package manager"
    end

    # Install uv-managed tools
    uv python install 3.13 --default --preview
    uv python install 3.13t --default --preview
    set -Ux UV_PYTHON "3.13t"
    uv venv --python 3.13t ~/.venv
    uv tool install aider-chat --python 3.12
    uv tool install ipython
    uv tool install jupyter-core --with jupyterlab --python 3.13
    uv tool install pre-commit
    uv tool install python-lsp-server[all]
    uv tool install ruff

    # Let fisher manage itself
    fisher install jorgebucaran/fisher

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
    git clone "https://github.com/catppuccin/bat.git" "$HOME/.config/bat/catppuccin" --depth 1
    ln -s "$HOME/.config/bat/catppuccin/themes" "$HOME/.config/bat/themes"
    set -Ux BAT_THEME "Catppuccin Mocha"
    bat cache --build

    # Configure man to use nvim
    set -Ux MANPAGER "nvim -c 'Man!' -c 'lua require(\"nvim-treesitter\")'"

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
    alias -s ls="eza"
    alias -s cat="bat"
    alias -s grep="rg"
    alias -s find="bfs"

    # Configure fish to use Catppuccin
    fisher install catppuccin/fish
    fish_config theme save "Catppuccin Mocha"

    # Configure fish to use tide
    fisher install IlanCosman/tide@v6
    tide configure --auto --style=Lean --prompt_colors='True color' --show_time='24-hour format' --lean_prompt_height='Two lines' --prompt_connection=Dotted --prompt_connection_andor_frame_color=Darkest --prompt_spacing=Compact --icons='Few icons' --transient=No

    # Update completions
    fish_update_completions

    # Track whether fish has been set up
    set -Ux __fish_setup true

else if status is-interactive
    # Initialize micromamba
    $MAMBA_EXE shell hook --shell fish --root-prefix $MAMBA_ROOT_PREFIX | source

    # Initialize zoxide
    zoxide init fish | source
    alias cd="z"
end
