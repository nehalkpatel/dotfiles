local config = function()
  require("nvim-treesitter.configs").setup({
    indent = {
      enable = true,
    },
    autotag = {
      enable = true,
    },
    ensure_installed = {
      "markdown",
      "json",
      "yaml",
      "bash",
      "c",
      "lua",
      "python",
      "gitignore",
      "cpp",
      "diff",
      "gitcommit",
      "cmake",
      "rust",
    },
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = true,
    },
  })
end

return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  config = config,
}
