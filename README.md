# Dotfiles 🎈

## Installation guide

**Install zgen, zsh plugin manager 🔌**

```bash
git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
```

**Symlink config files 🔗**

This moves all the necesary files that should be in the `$HOME` directory and symlinks them

```bash
bash ~/.dotfiles/install.sh
```

**Install brew packages 🍺**

Brew bundle is used to install dependencies including Mac applications, even
ones from the Mac App store.

```bash
brew bundle --file=~/.Brewfile
```

**Setup NeoVim 💊**

Symlink the config file

```bash
mkdir -p ~/.config/nvim && ln -s ~/.dotfiles/.init.vim
.config/nvim/init.vim
```

Synlink theme

```bash
ln -s ~/.dotfiles/.config/nvim/colors/Tomorrow-Night.vim
~/.config/nvim/colors/Tomorrow-Night.vim
```

Install vim-plug, the vim plugin manager

```bash
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

And then install all vim plugins
```bash
vi :PlugInstall
```

**Setup iTerm2 👾**

In General/Preferences, set custom folder path
```
~/.dotfiles/config/iterm2
```

**Karabiner ⌨️**

Symlink karabiner config file

```bash
ln -s ~/.dotfiles/.config/karabiner/karabiner.json
~/.config/karabiner/karabiner.json
```

**pgcli 🐘**

Symlink config file

```bash
ln -s ~/.dotfiles/pgcliconfig ~/.config/pgcli/config
```

**hammerspoon 🥄**

Install from [github](https://github.com/Hammerspoon/hammerspoon)

```bash
ln -s ~/.dotfiles/.hammerspoon/init.lua ~/.hammerspoon/init.lua
```
**Ultisnips**
```
ln -s ~/.dotfiles/.vim/ultisnips ~/.vim/ultisnips
```

**coc nvim**
```
ln -s ~/.dotfiles/.config/nvim/coc-settings.json
~/.config/nvim/coc-settings.json
```
