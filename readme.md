# Dot-Launcher

Dot-Launcher is a Bash script to quickly open and edit dotfiles.

## Dependencies

- [Git](https://git-scm.com/)
- [Gum](https://github.com/charmbracelet/gum#installation)

## Installation

1. (Install the #{dependencies})
2. Download [dot.sh](./dot.sh) and save it in a directory of your choice.
3. To execute the script from anywhere, add the following line to your `~/.bashrc`/`~/.zshrc`:
    ```bash
    alias dot='/path/to/dot.sh'
    ```

## Configuration

You can configure the following variables in the `dot.sh` file:
- `dot_dir`: the directory where the dotfiles are stored. (default: `$HOME/.config`)
- `nested_levels`: the number of nested levels to search for dotfiles. (default: `4`)
- `dot_file_extensions`: allowed file extensions for dotfiles. (default: `".txt" ".json" ".yml" ".yaml" ".conf" ".ini" ".toml" ".xml" ".vim" ".lua" "rc" "profile" ".resources"`)

## Usage

Simply run `dot` in your terminal.