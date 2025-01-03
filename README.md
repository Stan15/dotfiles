# My dotfiles
This directory contains dotfiles for my system

## Requirements
Ensure you have the following installed on your system

### Git
```
sudo apt install git
```

### Stow
```
sudo apt install stow
```

## Installation
First, clone the dotfiles repo in your $HOME directory using git
```
git clone git@github.com:Stan15/dotfiles.git
cd dotfiles
```
then use GNU stow to create symlinks
```
stow .
```

## Optional tools Setup
### Neovim
Install the latest version of neovim (I believe this config requires above 0.9.0)
```
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install neovim
```

For a couple of the default language servers to be installed, you need to have npm installed.

#### LSPs
You can install npm either [through your package manager](https://nodejs.org/en/download/package-manager/all), or your preferred method (using nvm, e.t.c)

#### Other dependencies
- ripgrep, for telescope grep search


### Tmux
First install tmux
```
sudo apt install tmux
```

Next install tpm (Tmux Plugin Manager)
```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
Restart your terminal session, or create a new terminal session.

Next, source the tmux config file:
```
tmux source-file ~/.config/tmux/tmux.conf
```

Finally, enter a tmux session and install the plugins using `<leader>I` (leader is set to the spacebar key in this tmux config)

### Starship
Install starship with the following command, for a nice looking terminal prompt
```
curl -sS https://starship.rs/install.sh | sh
```
