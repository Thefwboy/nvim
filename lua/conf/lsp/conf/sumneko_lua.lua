local runtime_path = vim.split(package.path, ";")
return {
  cmd = {"lua-language-server"},
  filetypes = {"lua"},
  log_level = 2,
  -- 再比如我将该服务器的工作域范围改成了当前所在目录的工作区，避免了重复运行多个同样的语言服务器的问题
  root_dir = function()
    return vim.fn.getcwd()
  end,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = runtime_path
      },
      diagnostics = {
        globals = {"vim"}
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
        },
        maxPreload = 2000,
        preloadFileSize = 50000,
      },
      telemetry = {
        enable = false
      },
      completion = { callSnippet = "Both" },
    }
  }
}
