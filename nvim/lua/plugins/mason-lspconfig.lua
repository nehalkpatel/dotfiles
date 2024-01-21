local opts = {
  ensure_installed = {
    "efm",
    "lua_ls",
  }
}
return {
  "williamboman/mason-lspconfig.nvim",
  opts = opts,
  event = "BufReadPre",
  dependencies = "williamboman/mason.nvim",
}
