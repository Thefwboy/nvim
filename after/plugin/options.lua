local options = {
  -- utf8
  encoding = "UTF-8",
  fileencoding = "utf-8",
  -- 使用相对行号
  number = true,
  relativenumber = true,
  -- 缩进2个空格等于一个Tab
  tabstop = 2,
  softtabstop = 2,
  shiftround = true,
  -- >> << 时移动长度
  shiftwidth = 2,
  -- 空格替代tab
  expandtab = true,
  -- 新行对齐当前行
  autoindent = true,
  smartindent = true,
  -- 搜索大小写不敏感，除非包含大写
  ignorecase = true,
  smartcase = true,
  -- 高亮所在行
  cursorline = true,
  -- 显示左侧图标指示列
  signcolumn = "yes",
  -- jkhl 移动时光标周围保留8行
  scrolloff = 8,
  sidescrolloff = 8,
  -- 边输入边搜索
  incsearch = true,
  -- 当文件被外部程序修改时，自动加载
  autoread = true,
  -- 禁止创建备份文件
  backup = false,
  writebackup = false,
  swapfile = false,
  -- smaller updatetime
  updatetime = 300,
  -- 设置 timeoutlen 为等待键盘快捷键连击时间500毫秒
  timeoutlen = 500,
  -- split window 从下边和右边出现
  splitbelow = true,
  splitright = true,
  -- 自动补全不自动选中
  completeopt = "menu,menuone,noselect,noinsert",
  -- 样式
  background = "dark",
  termguicolors = true,
  -- 不可见字符的显示，这里只把空格显示为一个点
  -- list = true,
  -- listchars = "space:·",
  -- 补全增强
  wildmenu = true,
  -- Dont' pass messages to |ins-completin menu|
  shortmess = vim.o.shortmess .. 'c',
  -- 补全最多显示10行
  pumheight = 10,
  -- 永远显示 tabline
  showtabline = 2,
  -- 使用增强状态栏插件后不再需要 vim 的模式提示
  showmode = false,
  -- 使用系统剪贴板
  clipboard = "unnamedplus",
  -- 修改光标样式
  guicursor = "n-c-i:hor20-Cursor/lCursor"
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
