local config = require("plugins.lsp.config").config()
require("lspconfig").svls.setup(config)
