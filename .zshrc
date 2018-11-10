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
    zgen prezto git
    zgen prezto command-not-found

    # Modules
    zgen load djui/alias-tips
    zgen load junegunn/fzf
    zgen load lukechilds/zsh-nvm
    zgen load zsh-users/zsh-autosuggestions
    zgen load zsh-users/zsh-completions
    zgen load zsh-users/zsh-history-substring-search
    zgen load zsh-users/zsh-syntax-highlighting

    # Save all to init script
    zgen save
fi
