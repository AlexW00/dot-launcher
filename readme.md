# Dot-Launcher

Dot-Launcher is a Bash script to quickly open and edit dotfiles.

![CleanShot 2022-08-01 at 10 25 24](https://user-images.githubusercontent.com/55558407/182106546-6dc69c9a-a37f-4e33-8564-c4d7ed8112cb.gif)

## 🚚 Dependencies

- [Git](https://git-scm.com/)
- [Fzf](https://github.com/junegunn/fzf)

## 💿 Installation

1. (Install the [dependencies](#dependencies))
2. Download [dot.sh](./dot.sh) and save it in a directory of your choice.
3. `chmod +x /path/to/dot.sh` to make it executable
4. To execute the script from anywhere, add the following line to your `~/.bashrc`/`~/.zshrc`:
    ```bash
    alias dot='/path/to/dot.sh'
    ```

## ⚙️ Configuration

You can configure the following variables in the `dot.sh` file:
- `dot_dir`: the directory where the dotfiles are stored. (default: `$HOME/.config`)
- `nested_levels`: the number of nested levels to search for dotfiles. (default: `3`)
- `dot_file_extensions`: allowed file extensions for dotfiles. (default: `".txt" ".json" ".yml" ".yaml" ".conf" ".ini" ".toml" ".xml" ".vim" ".lua" "rc" "profile" ".resources"`)
- `do_ignore_gitignored_files`: whether or not to ignore files also ignored by git (default: `"true"`)

## 💻 Usage

Simply run `dot` in your terminal.
