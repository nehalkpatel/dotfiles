require("config.globals")
require("config.options")
-- Lazy must be loaded after leader is set
require("config.lazy")
-- The following may depend on plugins loaded by lazy
require("config.keymaps")
require("config.autocmds")
