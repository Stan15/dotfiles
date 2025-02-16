#!/bin/sh

config_key_for_current_env="current_env"
load_env() {
  check_yq  # Ensure yq is installed before proceeding

  local config_file="$1"

  if [[ -z "$config_file" ]]; then
    echo "❌ Error: Please provide a valid path to your dotfiles environment configuration file" >&2
    return 2
  elif [[ ! -f "$config_file" ]]; then
    echo -e "❌ Error: Cannot configure dotfiles environment - $config_file not found. Please create one as found in the 'dotfiles' repository: \033[4;34mhttps://github.com/Stan15/dotfiles\033[0m" >&2
    return 1
  fi

  # Read the current environment from the config file
  current_env=$(yq -r ".default.$config_key_for_current_env" "$config_file")

  if [[ "$current_env" == "null" || -z "$current_env" ]]; then
    printf "\033[1;31m❌ Error:\033[0m Missing or invalid configuration in '\033[1;33m%s\033[0m'.\n\n" "$config_file" >&2
    printf "The file must include a '[default]' section with a valid '\033[1;34m%s\033[0m' key. Example:\n\n" "$config_key_for_current_env" >&2
    printf "\033[1;37m  [\033[1;32mdefault\033[1;37m]\n" >&2
    printf "  \033[1;34m%s\033[0m = \033[1;32m\"personal\"\033[0m\n\n" "$config_key_for_current_env" >&2
    printf "\033[0mPlease update the configuration and restart your terminal session.\n" >&2
    printf "For more details, refer to the documentation: \033[1;36mhttps://github.com/Stan15/dotfiles\033[0m\n" >&2
    return 3
  fi

  # Export each key-value pair
  while IFS= read -r line; do
    export "$line"
  done < <(yq -r "(.default * .[\"$current_env\"]) | to_entries | .[] | \"\(.key)=\(.value | @json)\"" "$config_file")

  echo "⚙️ dotfiles environment $current_env loaded."

  return 0
}

check_yq() {
  if ! command -v yq &> /dev/null; then
    echo "⚠️ 'yq' is not installed. It is required to load environment configurations."

    read -p "Would you like to install 'yq' now? (y/N): " response
    if [[ "$response =~ ^[Yy]$" ]]; then
      install_yq
    else
      cat >&2 <<-EOF
Please install 'yq' manually using:
  - macOS: brew install yq
  - Linux: sudo apt install yq  (or snap install yq)
  - Windows: choco install yq
EOF
      return 127
    fi
  fi
}

install_yq() {
  echo "Installing 'yq'..."
  if [[ "$OSTYPE" == "darwin"* ]]; then
    brew install yq
  elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if command -v apt &> /dev/null; then
      sudo apt update && sudo apt install -y yq
    elif command -v snap &> /dev/null; then
      sudo snap install yq
    else
      echo "Unknown Linux package manager. Please install manually."
    fi
  elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
    choco install yq
  else
    echo "Unsupported OS. Please install yq manually."
  fi

  if command -v yq &> /dev/null; then
    echo "✅ 'yq' successfully installed!"
  else
    echo "❌ Installation failed. Please install manually."
  fi
}

# Set default config file if no argument is provided
CONFIG_FILE="${1:-./dotfiles.toml}"
if [[ -f "$CONFIG_FILE" ]]; then
  load_env $CONFIG_FILE
else
  echo "Error: Configuration file '$CONFIG_FILE' not found!"
fi
