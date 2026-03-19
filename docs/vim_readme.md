# Vim Setup

A lightweight Vim configuration designed to replicate core VSCode/Cursor workflows on low-memory machines (8GB RAM). No Node.js background processes, no Electron — just Vim with a small set of focused plugins.

---

## Prerequisites

### 1. Homebrew

If not already installed:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. fzf and ripgrep

fzf powers file finding and search. ripgrep is required for project-wide grep.

```bash
brew install fzf ripgrep
$(brew --prefix)/opt/fzf/install
```

### 3. vim-plug

The plugin manager. Run this once:

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

---

## Installation

1. Copy the vimrc to `~/.vimrc`
2. Open Vim and run:

```
:PlugInstall
```

3. Fully quit and reopen Vim (`ZQ` or `:qa!`)

Language servers (pyright for Python, clangd for C++) install automatically the first time you open a relevant file — no manual setup needed.

---

## Plugins

| Plugin | Purpose |
|---|---|
| `junegunn/fzf` + `junegunn/fzf.vim` | Fuzzy file finding, grep, buffer switching |
| `prabirshrestha/vim-lsp` | LSP client (go to definition, references, rename) |
| `mattn/vim-lsp-settings` | Auto-installs language servers on first file open |
| `prabirshrestha/asyncomplete.vim` | Completion menu |
| `prabirshrestha/asyncomplete-lsp.vim` | Wires LSP into the completion menu |
| `airblade/vim-gitgutter` | Inline git diff signs + hunk staging |
| `tpope/vim-fugitive` | Full git interface (`:Git`, `:Gblame`, `:Gdiff`) |
| `mg979/vim-visual-multi` | Multi-cursor |
| `tpope/vim-commentary` | Toggle comments |
| `morhetz/gruvbox` | Color scheme |

---

## Key Bindings

### File navigation

| Key | Action |
|---|---|
| `Ctrl+P` | Fuzzy file search (like Cmd+P in VSCode) |
| `Ctrl+B` | Switch between open buffers |
| `Cmd+F` | Search lines in current file |
| `\f` | Project-wide live grep (requires ripgrep) |
| `-` | Open file browser at current file's directory |

### LSP

| Key | Action |
|---|---|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Find all references |
| `K` | Hover documentation |
| `F2` | Rename symbol across project |
| `[d` / `]d` | Previous / next diagnostic |
| `\ca` | Code actions (quick fixes, imports) |
| `gi` | Go to implementation |

### Git

| Key | Action |
|---|---|
| `:Git` | Git status panel (`s` to stage, `cc` to commit) |
| `:Gblame` | Inline git blame |
| `:Gdiff` | Diff current file against index |
| `\hp` | Preview hunk under cursor |
| `\hs` | Stage hunk under cursor |
| `\hu` | Undo hunk under cursor |
| `]q` / `[q` | Next / previous item in quickfix list |

### Multi-cursor

| Key | Action |
|---|---|
| `Cmd+D` | Select next match (add cursor, like Ctrl+D in VSCode) |
| `Ctrl+Shift+Up/Down` | Add cursor above / below |
| `gcc` | Toggle comment on current line |
| `gc` (visual) | Toggle comment on selection |

### macOS navigation

| Key | Action |
|---|---|
| `Option+Right/Left` | Move by word |
| `Shift+Option+Right/Left` | Select by word |
| `Cmd+Right/Left` | Jump to end / start of line |
| `Cmd+Shift+Right/Left` | Select to end / start of line |

### Splits

| Key | Action |
|---|---|
| `Ctrl+H/J/K/L` | Move focus between splits |
| `:vsp` | Open vertical split |
| `:sp` | Open horizontal split |

### Completion

| Key | Action |
|---|---|
| `Tab` | Next completion suggestion |
| `Shift+Tab` | Previous completion suggestion |
| `Enter` | Accept completion |

---

## Terminal Setup

`Cmd+D` and `Option+Arrow` bindings require your terminal to forward those keys to Vim.

**iTerm2** — go to Preferences → Profiles → Keys and set the Left Option key to `Esc+`. For Cmd keys, add manual bindings under Preferences → Keys → Key Bindings.

**Kitty** — add to `~/.config/kitty/kitty.conf`:

```
map cmd+right send_text all \x1b[1;3C
map cmd+left  send_text all \x1b[1;3D
```

**MacVim** — all bindings work natively with no terminal configuration needed. Recommended if you want the closest match to the macOS text conventions without configuration overhead.

To verify a binding is being received by Vim, run `:verbose map <D-d>` (or whichever key) from command mode.

---

## Verifying the Setup

After `:PlugInstall` and restarting Vim, run:

```
:checkhealth
```

This reports any missing binaries, failed language server installs, or plugin issues. Common things to check:

- fzf binary found — needs `brew install fzf`
- ripgrep found — needs `brew install ripgrep`
- Language server installed for your filetype — open a `.py` or `.cpp` file and wait a few seconds for `vim-lsp-settings` to auto-install it

---

## Apple Silicon vs Intel

The vimrc points to the Apple Silicon Homebrew path by default:

```vim
Plug '/opt/homebrew/opt/fzf'
```

If you are on an Intel Mac, comment that line out and uncomment:

```vim
Plug '/usr/local/opt/fzf'
```
