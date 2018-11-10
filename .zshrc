# load zgen
source "${HOME}/.zgen/zgen.zsh"

# if the init scipt doesn't exist
if ! zgen saved; then
    echo "Creating a zgen save"

    # Prezto
    zgen prezto

    # Prezto options
    zgen prezto editor key-bindings 'vim'
    zgen prezto prompt theme 'sorin'
    
    # Prezto modules
    zgen prezto git
    zgen prezto command-not-found
    zgen prezto syntax-highlighting

    # Modules
    zgen load zsh-users/zsh-completions src

    # Save all to init script
    zgen save
fi
