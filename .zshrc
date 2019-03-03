# =============================================================================
# Environment Config
# =============================================================================

export PATH="$HOME/bin:$PATH"

export PATH="$PYENV_ROOT/bin:$PATH"

export PATH="/Users/$USER/miniconda3/bin:$PATH"

export PATH="/usr/local/opt/ruby/bin:$PATH"

export PATH="/usr/local/Cellar/rabbitmq/3.7.9/sbin:$PATH"

export PATH="$HOME/.nvm/versions/node/v10.15.0/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"

export PYENV_VIRTUALENV_DISABLE_PROMPT=1

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

export NVM_LAZY_LOAD=true


# =============================================================================
# NeoVim 
# =============================================================================

export EDITOR='nvim'

if type nvim > /dev/null 2>&1; then
    alias vim='nvim'
    alias vi='nvim'
fi

# =============================================================================
# Aliases
# =============================================================================

# General
alias sourcezsh='source ~/.zshrc'

# Navigation
alias dot="~/.dotfiles"

# Hub 
alias hpr='hub pull-request'
alias pulls='hub browse -- pulls'
alias wiki='hub browse -- wiki'

# zsh tools
alias shelloadtime="/usr/bin/time zsh -i -c exit"

# linux
function killport() { lsof -ti:$1 | xargs kill; }

# Plugins
alias f="fzf --preview 'bat --color \"always\" {}'"

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
    local files
    IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
    [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# Grep from vim file
function helpvim() { cat "$HOME/.dotfiles/.init.vim" | grep -A 1 -B 1 --color $*; }

# ctags 
# https://gist.github.com/nazgob/1570678
alias ctags="`brew --prefix`/bin/ctags"

function gctags() {
    dir="`git rev-parse --git-dir`"
    git ls-files | \
        ctags --tag-relative=yes -L - -f "$dir/$$.tags" --languages=-sql
    mv "$dir/$$.tags" "$dir/tags"
}

alias snips="cd $HOME/.vim/plugged/vim-snippets/UltiSnips"

# =============================================================================
# zgen
# =============================================================================

# load zgen
source "${HOME}/.zgen/zgen.zsh"

# if the init scipt doesn't exist
if ! zgen saved; then
    echo "Creating a zgen save"

    # Prezto
    zgen prezto

    # Prezto options
    zgen prezto prompt theme 'sorin'
    
    # Prezto modules
    zgen prezto command-not-found

    # Modules
    zgen load djui/alias-tips
    zgen load junegunn/fzf
    zgen load lukechilds/zsh-nvm
    zgen load zdharma/fast-syntax-highlighting
    zgen load zsh-users/zsh-autosuggestions
    zgen load zsh-users/zsh-completions
    zgen load zsh-users/zsh-history-substring-search

    # Save all to init script
    zgen save
fi

# =============================================================================
# Changing Directories
# =============================================================================

# If a command is issued that can't be executed as a normal command, and the
# command is the name of a directory, perform the cd command to that directory.
setopt auto_cd

# Make cd push the old directory onto the directory stack.
setopt auto_pushd

# Don't push multiple copies of the same directory onto the directory stack.
setopt pushd_ignore_dups

# =============================================================================
# Completion
# =============================================================================

# If a completion is performed with the cursor within a word, and a full
# completion is inserted, the cursor is moved to the end of the word.
setopt always_to_end

# If unset, the cursor is set to the end of the word if completion is started.
# Otherwise it stays there and completion is done from both ends.
setopt complete_in_word

# Don't beep on an ambiguous completion.
unsetopt list_beep

# Menu selection will be started unconditionally.
zstyle ':completion:*' menu selecti

# Try smart-case completion, then case-insensitive, then partial-word, and then
# substring completion.
# See http://zsh.sourceforge.net/Doc/Release/Completion-Widgets.html#Completion-Matching-Control.
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Z}{a-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Shift-Tab: Perform menu completion, like menu-complete, except that if a menu
# completion is already in progress, move to the previous completion rather than
# the next.
# See http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Completion.
[ -n "${terminfo[kcbt]}" ] && bindkey "${terminfo[kcbt]}" reverse-menu-complete

# =============================================================================
# History
# =============================================================================

# If the internal history needs to be trimmed to add the current command line,
# setting this option will cause the oldest history event that has a duplicate
# to be lost before losing a unique event from the list.
setopt hist_expire_dups_first

# When searching for history entries in the line editor, do not display
# duplicates of a line previously found, even if the duplicates are not
# contiguous.
setopt hist_find_no_dups

# Do not enter command lines into the history list if they are duplicates of the
# previous event.
setopt hist_ignore_dups

# Whenever the user enters a line with history expansion, don't execute the line
# directly; instead, perform history expansion and reload the line into the
# editing buffer.
setopt hist_verify

# This options works like APPEND_HISTORY except that new history lines are added
# to the $HISTFILE incrementally (as soon as they are entered), rather than
# waiting until the shell exits.
setopt inc_append_history

# Remember only one unique copy of the command.
setopt hist_ignore_all_dups

# Remove superfluous blanks.
setopt hist_reduce_blanks

# Omit older commands in favor of newer ones.
setopt hist_save_no_dups

# Ignore commands that start with space.
setopt hist_ignore_space

# See 2.5.4 of http://zsh.sourceforge.net/Guide/zshguide02.html.
[ -z "$HISTFILE" ] && HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# =============================================================================
# Input/Output
# =============================================================================

# If this option is unset, output flow control via start/stop characters
# (usually assigned to ^S/^Q) is disabled in the shell's editor.
unsetopt flow_control

# =============================================================================
# Key Bindings
# =============================================================================

# See
# http://pubs.opengroup.org/onlinepubs/7908799/xcurses/terminfo.html#tag_002_001_003_003
# for the table of terminfo, and see
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets
# for standard widgets of zsh.

# Home
[ -n "${terminfo[khome]}" ] && bindkey "${terminfo[khome]}" beginning-of-line
# End
[ -n "${terminfo[kend]}" ] && bindkey "${terminfo[kend]}" end-of-line
# Backspace
[ -n "${terminfo[kbs]}" ] && bindkey "${terminfo[kbs]}" backward-delete-char
# Delete
[ -n "${terminfo[kdch1]}" ] && bindkey "${terminfo[kdch1]}" delete-char
# Up-arrow
[ -n "${terminfo[kcuu1]}" ] && bindkey "${terminfo[kcuu1]}" up-line-or-history
# Down-arrow
[ -n "${terminfo[kcud1]}" ] && bindkey "${terminfo[kcud1]}" down-line-or-history
# Left-arrow
[ -n "${terminfo[kcub1]}" ] && bindkey "${terminfo[kcub1]}" backward-char
# Right-arrow
[ -n "${terminfo[kcuf1]}" ] && bindkey "${terminfo[kcuf1]}" forward-char


# =============================================================================
# fzf
# =============================================================================

# fzf via Homebrew
if [ -e /usr/local/opt/fzf/shell/completion.zsh ]; then
    source /usr/local/opt/fzf/shell/key-bindings.zsh
    source /usr/local/opt/fzf/shell/completion.zsh
fi

# fzf + ag configuration
if command -v ag 1>/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_DEFAULT_OPTS="
    --color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108
    --color info:108,prompt:109,spinner:108,pointer:168,marker:168
    --bind='ctrl-o:execute(code {})+abort'
    "
fi


# =============================================================================
# Source work config
# =============================================================================

if [ -s "$HOME/.zshrc.work" ]; then
    source "$HOME/.zshrc.work"
fi


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
