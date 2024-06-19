# My dotfiles
This directory contains dotfiles for my system

## Requirements
Ensure you have the following installed on your system

### Git
```sudo apt install git```

### Stow
```sudo apt install stow```

## Installation
First, clone the dotfiles repo in your $HOME directory using git
```
git clone git@github.com:Stan15/dotfiles.git
cd dotfiles
```
then use GNU stow to create symlinks
```stow .```

### Starship
Optionally install starship with the following command, for a nice looking terminal prompt
```
curl -sS https://starship.rs/install.sh | sh
```
