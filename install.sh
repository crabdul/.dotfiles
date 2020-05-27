#!/bin/bash

# Utils. {{{
answer_is_yes() {
    [[ "$REPLY" =~ ^[Yy]$ ]] \
        && return 0 \
        || return 1
}

ask() {
    print_question "$1"
    read
}

ask_for_confirmation() {
    print_question "$1 (y/n)"
    read -n 1
    printf "\n"
}

execute() {
    $1 &> /dev/null
    print_result $? "${2:-$1}"
}

get_answer() {
    printf "$REPLY"
}

print_error() {
    # Print output in red
    printf "\e[0;31m ☠️  $1 $2\e[0m\n"
}

print_info() {
    # Print output in purple
    printf "\e[0;35m $1\e[0m\n\n"
}

print_question() {
    # Print output in yellow
    printf "\e[0;33m ❔ $1\e[0m"
}

print_result() {
    [ $1 -eq 0 ] \
        && print_success "$2" \
        || print_error "$2"

    [ "$3" == "true" ] && [ $1 -ne 0 ] \
        && exit
}

print_success() {
    # Print output in green
    printf "\e[0;32m] ✨ $1\e[0m\n"
}

# }}}

# Install. {{{

symlink_files() {

    local i=""
    local sourceFile=""
    local targetFile=""

    for i in $@; do

        sourceFile="$(pwd)/$i"
        targetFile="$HOME/$(printf "%s" "$i")"

        if [ -e "$targetFile" ]; then
            if [ "$(readlink "$targetFile")" != "sourceFile" ]; then

                ask_for_confirmation "'$targetFile' already exists, do you want to overwrite it?"
                if answer_is_yes; then
                    rm -rf "$targetFile"
                    execute "ln -fs $sourceFile $targetFile" "$sourceFile → $targetFile"
                else
                    print_error "$sourceFile → $targetFile"
                fi

            else
                print_success "$sourceFile → $targetFile"
            fi
        else
            execute "ln -fs $sourceFile $targetFile" "$sourceFile → $targetFile"
        fi
    done

}

declare -a FILES_TO_SYMLINK=$(find . .config -type f -maxdepth 3 \
    -name ".*" \
    -not -name .DS_Store \
    -not -name .git \
    -not -name .gitignore \
    -not -name .Brewfile \
    -not -name .Brewfile.lock.json \
    | sed -e 's|//|/|' | sed -e 's|./.|.|')


declare -a FOLDERS_TO_SYMLINK=$(find \
    .config \
    .hammerspoon \
    -type f -maxdepth 5)

symlink_files $FILES_TO_SYMLINK
symlink_files $FOLDERS_TO_SYMLINK

# }}}
