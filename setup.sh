#!/bin/bash
set -e

DOTFILES_DIR=~/dotfiles

# Detect OS / Distro
# Currently supported: macOS, Debian-based distros
function detect_platform() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "macOS"
  elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if command -v apt &> /dev/null; then
      echo "debian"
    else
      echo "unsupported"
    fi
  else
    echo "unsupported"
  fi
}

function install_packages_mac() {
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
}

function install_packages_debian() {
  # mkdir ~/.local/bin if not exists
  mkdir -p ~/.local/bin

  # Install Starship if not already installed
  if ! command -v starship &> /dev/null
  then
      echo "Installing Starship..."
      curl -sS https://starship.rs/install.sh | sh -s -- -y --bin-dir ~/.local/bin
      echo "Starship installed!"
  else
      echo "Starship has already been installed."
  fi

  # Install Sheldon if not already installed
  if ! command -v sheldon &> /dev/null
  then
      echo "Installing Sheldon..."
      curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh \
      | bash -s -- --repo rossmacarthur/sheldon --to ~/.local/bin
      echo "Sheldon installed!"
  else
      echo "Sheldon has already been installed."
  fi
}

PLATFORM=$(detect_platform)
if [ "$PLATFORM" == "unsupported" ]; then
  echo "Unsupported platform. Exiting..."
  exit 1
else
  echo "Platform detected: $PLATFORM"
fi

echo "Creating symbolic links..."

# zshrc
if [ "$PLATFORM" == "macOS" ]; then
  ln -sfn "$DOTFILES_DIR/zsh/.zshrc" ~/.zshrc
else
  ln -sfn "$DOTFILES_DIR/zsh/.zshrc.woq" ~/.zshrc  # zshrc without Amazon Q Config
fi

# sheldon
ln -sfn "$DOTFILES_DIR/sheldon" ~/.sheldon

# starship
ln -sfn "$DOTFILES_DIR/starship/starship.toml" ~/.starship.toml

echo "Symbolic links created!"

echo "Installing packages..."
if [ "$PLATFORM" == "macOS" ]; then
  install_packages_mac
elif [ "$PLATFORM" == "debian" ]; then
  install_packages_debian
fi
echo "Packages installed!"
