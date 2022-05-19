local lsp_installer_servers = require("nvim-lsp-installer.servers")

-- WARN: 手动书写 LSP 配置文件
-- 名称：https://github.com/williamboman/nvim-lsp-installer#available-lsps
-- 配置：https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md


local M = {}
function M.setup(servers, options)
  -- 自动安装或启动 LanguageServers
  for server_name, _ in pairs(servers) do
    local server_available, server = lsp_installer_servers.get_server(server_name)
    -- 判断服务是否可用
    if server_available then
      -- 判断服务是否准备就绪，若就绪则启动服务
      server:on_ready(function()
        local opts = vim.tbl_deep_extend("force", options, servers[server.name] or {})
        server:setup(opts)
      end
      )
      -- 如果服务器没有下载，则通过 notify 插件弹出下载提示
      if not server:is_installed() then
        vim.notify("Install Language Server : " .. server_name, "WARN", {title = "Language Servers"})
        server:install()
      end
    end
  end

end
return M
