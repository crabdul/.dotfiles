
export PATH="$HOME/bin:$PATH"

export PATH="$HOME/.nvm/nvm.sh:$PATH"

export WORKON_HOME=$HOME/.virtualenvs

# Placeholder 'workon' shell function:
# Will only be executed on the first call to 'workon'
workon() {
    unfunction "$0"
    if command -v pyenv 1>/dev/null 2>&1; then
        eval "$(pyenv init -)"
    fi
    source "$(pyenv which virtualenvwrapper.sh)"
    $0 "$@"
}

# nvm initialisation
export NVM_DIR="$HOME/.nvm"

# Placeholder 'yarn' shell function:
# Will only be executed on the first call to 'yarn'
yarn() {
    # Remove this function, subsequent calls will execute 'yarn' directly
    unfunction "$0"
    if command -v nvm >/dev/null 2>&1; then
        return
    fi
    source $(brew --prefix nvm)/nvm.sh
    # Execute 'yarn' binary
    $0 "$@"
}

node() {
    unfunction "$0"
    if command -v nvm >/dev/null 2>&1; then
        echo "nvm"
        return
    fi
    source $(brew --prefix nvm)/nvm.sh
    $0 "$@"
}

if [ -z "$TMUX" ]; then
    tmux attach -t d || tmux new -s d
fi

if type nvim > /dev/null 2>&1; then
    alias vi=nvim
    alias vim=nvim
fi

export EDITOR="vi"

# Navigation
alias dot="~/.dotfiles"

# fzf via Homebrew
if [ -e /usr/local/opt/fzf/shell/completion.zsh ]; then
    source /usr/local/opt/fzf/shell/key-bindings.zsh
    source /usr/local/opt/fzf/shell/completion.zsh
fi

# fzf + ag configuration
if command -v ag 1>/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden --vimgrep'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_DEFAULT_OPTS="
    --color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108
    --color info:108,prompt:109,spinner:108,pointer:168,marker:168
    --bind='ctrl-o:execute(code {})+abort'
    "
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

# Share history between shell instances
setopt share_history

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

# Prezto history substring search
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down


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
    export FZF_DEFAULT_COMMAND='rg --files --hidden --vimgrep'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_DEFAULT_OPTS="
    --color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108
    --color info:108,prompt:109,spinner:108,pointer:168,marker:168
    --bind='ctrl-o:execute(code {})+abort'
    "
fi

# Aliases

alias cl=clear

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

# cdf - cd into the directory of the selected file
cdf() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

alias snips="cd $HOME/.vim/plugged/vim-snippets/UltiSnips"

# Tmux
alias tm="tmux"
alias tma="tmux attach -t d || tmux new -s d"
alias tmd="tmux detach"
alias tml="tmux ls"
#

# =============================================================================
# Source work config
# =============================================================================

if [ -s "$HOME/.zshrc.work" ]; then
    source "$HOME/.zshrc.work"
fi

# Prezto
source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

# Prezto Plugins
source "$HOME/.zinit/plugins/zdharma---history-search-multi-word/history-search-multi-word.plugin.zsh"
source "$HOME/.zinit/plugins/zdharma---fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
source "$HOME/.zsh/plugins/zsh-autosuggestions.zsh"
