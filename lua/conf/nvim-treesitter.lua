require("nvim-treesitter.configs").setup(
{
  -- 安装的高亮支持来源
  ensure_installed = "all",
  -- 同步下载高亮支持
  sync_install = false,
  -- 忽略安装
  ignore_install = {"phpdoc"},
  -- 高亮相关
  highlight = {
    -- 启用高亮支持
    enable = true,
    -- 使用 treesitter 高亮而不是 neovim 内置的高亮
    additional_vim_regex_highlighting = false
  },
  -- 缩进，关闭
  indent = {
    enable = false
  },
  -- 彩虹括号，由 nvim-ts-rainbow 插件提供
  rainbow = {
    enable = true,
    extended_mode = true
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
  context_commentstring = {
    enable = true
  },
  autotag = {
    enable = true,
  }
}
)
