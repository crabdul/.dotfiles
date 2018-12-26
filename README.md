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

Brew bundle is used to install dependencies including Mac applications, even ones from the Mac App store.

```bash
brew bundle --file=~/.Brewfile
```

**Setup NeoVim 💊**

Symlink the config file

```bash
mkdir -p ~/.config/nvim && ln -s ~/.dotfiles/.init.vim .config/nvim/init.vim
```

Synlink theme

```bash
mkdir ~/.config/nvim/colors && ln -s ~/.dotfiles/Tomorrow-Night.vim ~/.config/nvim/colors/Tomorrow-Night.vim
```

Install vim-plug, the vim plugin manager

```bash
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

And then install all vim plugins
```bash
vi
:PlugInstall
```

### ESLint

```bash
ln -s ~/.dotfiles/.eslintrc.js ~/.eslintrc.js
ln -s ~/.dotfiles/package.json ~/package.json
ln -s ~/.dotfiles/yarn.lock ~/yarn.lock
```

Install node modules

```bash
cd
yarn install
```

**Setup iTerm2 👾**

In General/Preferences, set custom folder path
```
~/.dotfiles/iterm2
```

**VS Code setup 💻**

Symlink vscode settings file

```bash
ln -s ~/.dotfiles/vscode-settings.json $HOME/Library/Application\ Support/Code/User/settings.json
```

In VS Code, extensions in `vscode-extensions.json` should appear as recommended in the plugins tab

**Karabiner ⌨️**

Symlink karabiner config file

```bash
ln -s ~/.dotfiles/karabiner.json ~/.config/karabiner/karabiner.json
```

**pgcli 🐘**

Symlink config file

```bash
ln -s ~/.dotfiles/pgcliconfig ~/.config/pgcli/config
```

**mjolnir**

Install lua

Download and uncompress https://www.lua.org/ftp/lua-5.2.4.tar.gz.

```bash
$ cd lua-5.2.4
$ make macosx
$ sudo make install
$ lua -v
Lua 5.2.4  Copyright (C) 1994-2015 Lua.org, PUC-Rio
```

Install lua modules

```bash
luarocks install mjolnir.hotkey
luarocks install mjolnir.application
luarocks install mjolnir.bg.grid
```
Symlink config file

```bash
mkdir $HOME/.mjolnir && ln -s $HOME/.dotfiles/.mjolnir/init.lua $HOME/.mjolnir/init.lua
```

Reload config in console
```
mjolnir.reload()
```
