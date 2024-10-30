#!/bin/bash

DOTFILES_DIR=~/dotfiles

echo "Creating symbolic links..."

# zshrc (without Amazon Q Config)
ln -sfn "$DOTFILES_DIR/zsh/.zshrc.woq" ~/.zshrc

# sheldon
ln -sfn "$DOTFILES_DIR/sheldon" ~/.sheldon

# Install Starship if not already installed
if ! command -v starship &> /dev/null
then
    echo "Installing Starship..."
    curl -sS https://starship.rs/install.sh | sh
fi

# Install Sheldon if not already installed
if ! command -v sheldon &> /dev/null
then
    echo "Installing Sheldon..."
    curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh \
    | bash -s -- --repo rossmacarthur/sheldon --to ~/.local/bin
fi
