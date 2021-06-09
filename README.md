# Dotfiles 🎈

### Symlink config files 🔗

This symlinks any necessary files that need to be in `$HOME`

```bash

bash ~/.dotfiles/install.sh
```

### Install prezto

```bash
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto" 
Run ./install.sh
```

### Install zsh plugins

```bash
git clone https://github.com/zdharma/history-search-multi-word.git ~/.zsh/plugins/history-search-multi-word
git clone https://github.com/zdharma/fast-syntax-highlighting ~/.zsh/plugins/fast-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/plugins/zsh-autosuggestions
```

### Install brew packages 🍺

First install vim

Brew bundle is used to install dependencies including Mac applications, even
ones from the Mac App store.

```bash brew bundle --file=~.Brewfile ```

### Install vim-plug, the vim plugin manager

```bash sh -c 'curl -fLo
"${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim
--create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' ```

### Setup iTerm2 👾

In General/Preferences, set custom folder path

```
~/.dotfiles/config/iterm2
```

Install [Mono font](https://www.jetbrains.com/lp/mono/)

### NVIM

- Install coc plugins
- create python env

### NVM

```bash nvm install 12.16.2 ```

### Scripts

```bash mkdir /opt/scripts sudo ln -s ~/.dotfiles/scripts/ /opt ```

### Setup

- Make iTerm theme minimal
- Set scroll speed to high
- Set Jetbrains theme in iterm
- Delay until repeat top
- Key repeat fast
- Use Horizon theme in iTerm
- Use ligatures and 14pt font in iTerm
