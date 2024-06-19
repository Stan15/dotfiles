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

## Optional tools
### Tmux
First install tmux
```
sudo apt install tmux
```

Next install tpm (Tmux Plugin Manager)
```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Next, source the tmux config file:
```
tmux source-file ~/.config/tmux/tmux.conf
```

Finally, enter a tmux session and install the plugins using `<leader>I` (leader is set to space in my tmux config)

### Starship
Install starship with the following command, for a nice looking terminal prompt
```
curl -sS https://starship.rs/install.sh | sh
```
