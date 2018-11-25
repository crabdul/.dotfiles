## [zgen - ZSH plugin manager](https://github.com/tarjoilija/zgen)

- [awesome-zsh-plugins](https://github.com/unixorn/awesome-zsh-plugins)


# Initial installation

## Install zgen, zsh plugin manager

```bash
git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
```

## Move dotfiles to root dir

```bash
bash ~/.dotfiles/install.sh
```

## Install package and apps

```bash
brew bundle --file=~/.Brewfile
```

## NeoVim

### Symlink config file

```bash
mkdir -p ~/.config/nvim && ln -s ~/.dotfiles/.init.vim .config/nvim/init.vim
```

### Install vim-plug, vim plugin manager

```bash
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### Synlink theme

```bash
mkdir ~/.config/nvim/colors && ln -s ~/.dotfiles/Tomorrow-Night.vim ~/.config/nvim/colors/Tomorrow-Night.vim
```

### Install vim plugins

```bash
vi
:PlugInstall
```

## Load iterm2 preferences

In General/Preferences, set custom folder path
```
~/.dotfiles/iterm2
```

# Vim setup

Symlinking theme

```bash
ln -s ~/.dotfiles/Tomorrow-Night.vim ~/.config/nvim/colors/Tomorrow-Night.vim
```


## npm

- [sindresorhus/emoj](https://github.com/sindresorhus/emoj) 

