-- leader 键设置为空格
vim.g.mapleader = " "

local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }

-- Better escape using jk in insert and terminal mode
keymap("i", "jk", "<ESC>", default_opts)

-- Better window navigation
keymap("n", "<A-h>", "<C-w>h", default_opts)
keymap("n", "<A-j>", "<C-w>j", default_opts)
keymap("n", "<A-k>", "<C-w>k", default_opts)
keymap("n", "<A-l>", "<C-w>l", default_opts)

-- Center search results
keymap("n", "n", "nzz", default_opts)
keymap("n", "N", "Nzz", default_opts)

-- 将 C-u 和 C-d 调整为上下滑动 10 行而不是半页
keymap("n", "<C-u>", "10k", default_opts)
keymap("n", "<C-d>", "10j", default_opts)

-- Better indent
keymap("v", "<", "<gv", default_opts)
keymap("v", ">", ">gv", default_opts)

-- Paste over currently selected text without yanking it
keymap("v", "p", '"_dP', default_opts)

-- 用 H 和 L 代替 ^ 与 $
keymap("n", "H", "^", default_opts)
keymap("v", "H", "^", default_opts)
keymap("n", "L", "$", default_opts)
keymap("v", "L", "$", default_opts)

-- Cancel search highlighting with ESC
keymap("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", default_opts)

-- Move selected line / block of text in visual mode
keymap("x", "K", ":move '<-2<CR>gv-gv", default_opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", default_opts)

-- Resizing panes
keymap("n", "<Left>", ":vertical resize +1<CR>", default_opts)
keymap("n", "<Right>", ":vertical resize -1<CR>", default_opts)
keymap("n", "<Up>", ":resize -1<CR>", default_opts)
keymap("n", "<Down>", ":resize +1<CR>", default_opts)

-- Insert blank line
keymap("n", "]<Space>", "o<Esc>", default_opts)
keymap("n", "[<Space>", "O<Esc>", default_opts)

-- Terminal
keymap("t", "<Esc>", "<C-\\><C-n>", default_opts)

