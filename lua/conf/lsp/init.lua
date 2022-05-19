local M = {}

local servers = {
  -- 语言服务器名称：配置选项
  sumneko_lua = require("conf.lsp.conf.sumneko_lua"),
  tsserver = require("conf.lsp.conf.tsserver"),
  html = require("conf.lsp.conf.html"),
  cssls = require("conf.lsp.conf.cssls"),
  -- pyright = require("lsp.pyright"),
  gopls = require("conf.lsp.conf.gopls"),
  -- jsonls = require("lsp.jsonls"),
  -- zeta_note = require("lsp.zeta_note"),
  -- sqls = require("lsp.sqls"),
  -- vuels = require("lsp.vuels")
}

local lsp_signature = require"lsp_signature"
lsp_signature.setup {
  bind = true,
  handler_opts = {
    border = "rounded",
  },
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities) -- for nvim-cmp

-- local function on_attach(client, bufnr)
  -- Configure key mappings
  -- require("conf.lsp.keymaps").setup(client, bufnr)
-- end

local opts = {
  -- on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

require("conf.lsp.handlers").setup()

function M.setup()
  -- Installer
  require("conf.lsp.nvim-lsp-installer").setup(servers, opts)
end
return M

