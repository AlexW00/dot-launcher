#!/bin/bash

dot_dir="$HOME/.config" # dotfile directory
nested_levels="3" # number of nested levels to search for dotfiles
dot_file_extensions=(".zsh" ".txt" ".json" ".yml" ".yaml" ".conf" ".ini" ".toml" ".xml" ".vim" ".lua" "rc" "profile" ".resources") # dotfile extensions to search for
do_ignore_gitignored_files="true" # whether or not to ignore files also ignored by git

# check if "fzf" and "git" are installed
dependencies="fzf git"
for dependency in $dependencies; do
    if ! command -v "$dependency" >/dev/null 2>&1; then
        echo "Error: $dependency is not installed"
        exit 1
    fi
done

#exit on error
set -e

# check if the dotfile dir exists
if [ ! -d "$dot_dir" ]; then
    # exit 
    echo "Dot directory does not exist: $dot_dir"
    exit 1
fi

# creates a regex pattern for the dotfile extensions
buildDotFileRegex() {
    regex=""
    for ext in "${dot_file_extensions[@]}"; do
        if [ -z "$regex" ]; then
            regex="$ext"
        else
            regex="$regex|$ext"
        fi
    done
    regex="($regex)$" #only match end of string
    echo "$regex"
}

# returns all dotfiles in the dot directory, that match the dotfile regex
getDotFiles() {
    # get all files from x nested directories
    files=$(find "$dot_dir" -maxdepth $nested_levels -type f)

    # if do_ignore_gitignore is true, ignore files ignored by git
    if [ "$do_ignore_gitignored_files" = "true" ]; then
        # gitignored files:
        gitignored_files=$(git -C "$dot_dir" ls-files --others --exclude-standard)

        # if gitignored files is not empty
        if [ -n "$gitignored_files" ]; then
            # remove gitignored files from the list
            files=$(echo "$files" | grep -v -E "$gitignored_files")
        fi
    fi

    # remove all files that don't end with one of the dot file extensions regex
    files=$(echo "$files" | grep -E "$(buildDotFileRegex)")
    echo "$files"
}



# show the files using fzf
files=$(getDotFiles)
if [ -n "$files" ]; then
    files=$(echo "$files" | fzf --pointer="*" --ansi --preview "cat {}")
    if [ -n "$files" ]; then
        # open the file if it is selected 
        $EDITOR "$files"
    fi
fi