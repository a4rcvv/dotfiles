#!/bin/bash

DOTFILES_DIR=~/dotfiles

echo "Creating symbolic links..."

# zshrc
ln -sfn "$DOTFILES_DIR/zsh/.zshrc" ~/.zshrc

# sheldon
ln -sfn "$DOTFILES_DIR/sheldon" ~/.sheldon

echo "Done!"

# Install brew if not installed
if ! command -v brew &> /dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo "Homebrew installed!"
else
  echo "Homebrew has already been installed."
fi

echo "Installing packages..."
echo "Note: password may be required."
brew bundle --file="$DOTFILES_DIR/brew/core.rb"

echo "Done!"
echo "Note: personal brew packages are not installed. Run 'brew bundle --file=$DOTFILES_DIR/brew/personal.rb' to install them."
echo "Note: Restart your terminal to apply changes."
