#!/bin/sh

dot_dir="$HOME/.config" # dotfile directory
nested_levels="4" # number of nested levels to search for dotfiles
dot_file_extensions=(".txt" ".json" ".yml" ".yaml" ".conf" ".ini" ".toml" ".xml" ".vim" ".lua" "rc" "profile" ".resources") # dotfile extensions to search for

# check if "gum" and "git" are installed
dependencies="gum git"
for dependency in $dependencies; do
    if ! command -v $dependency >/dev/null 2>&1; then
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
    for ext in ${dot_file_extensions[@]}; do
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

    # gitignored files:
    gitignored_files=$(git -C "$dot_dir" ls-files --others --exclude-standard)

    # if gitignored files is not empty
    if [ -n "$gitignored_files" ]; then
        # remove gitignored files from the list
        files=$(echo "$files" | grep -v -E "$gitignored_files")
    fi

    # remove all files that don't end with one of the dot file extensions regex
    files=$(echo "$files" | grep -E "$(buildDotFileRegex)")
    echo "$files"
}


# pipe files to command "gum filter" and open the result in the default editor
$EDITOR $(getDotFiles | gum filter)