# dotfiles

## External dependencies

Some tools the configs assume are on `PATH` aren't installed by the configs themselves. On Arch, most are covered by `packages.txt`. On macOS, install via Homebrew.

### Neovim

- **`tree-sitter-cli`** — required by `nvim-treesitter` (tracks the `main` branch, which compiles parsers from source at install time). Note that Homebrew's `tree-sitter` formula ships only the C library; the CLI is a separate formula.
  - macOS: `brew install tree-sitter-cli`
  - Other: `npm install -g tree-sitter-cli` or `cargo install tree-sitter-cli`
