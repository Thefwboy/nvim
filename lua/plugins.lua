local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself

  use 'lewis6991/impatient.nvim'

  -- 使用中文文档
  use {
    "yianwillis/vimcdoc",
  }

  -- Colorscheme
  use {
    "sainnhe/everforest",
    config = function()
      vim.cmd "colorscheme everforest"
    end,
  }

  -- Better icons
  use {
    "kyazdani42/nvim-web-devicons",
    module = "nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup { default = true }
    end,
  }



  -- 为了能让状态栏显示 git 信息，所以这个插件是必须的
  use {
    "lewis6991/gitsigns.nvim",
    requires = {
      -- 依赖于该插件（一款 Lua 开发使用的插件）
      "nvim-lua/plenary.nvim"
    },
    config = function()
      require("conf.gitsigns").setup()
    end
  }

  -- nvim-tree
  use {
    "kyazdani42/nvim-tree.lua",
    wants = "nvim-web-devicons",
    config = function()
      require("conf.nvim-tree").setup()
    end,
  }

  -- Status line
  use {
    "nvim-lualine/lualine.nvim",
    event = "VimEnter",
    after = "nvim-treesitter",
    config = function()
      require("conf.lualine").setup()
    end,
    wants = "nvim-web-devicons",
  }
  use {
    "SmiteshP/nvim-gps",
    requires = "nvim-treesitter/nvim-treesitter",
    module = "nvim-gps",
    wants = "nvim-treesitter",
    config = function()
      require("nvim-gps").setup()
    end,
  }


  -- Buffer line
  use {
    "akinsho/nvim-bufferline.lua",
    event = "BufReadPre",
    requires = {
      "famiu/bufdelete.nvim" -- 删除 buffer 时不影响现有布局
    },
    config = function()
      require("conf.bufferline").setup()
    end,
  }

  -- IndentLine
  use {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = function()
      require("conf.indentblankline").setup()
    end,
  }

  -- 自动匹配括号
  use {
    "windwp/nvim-autopairs",
    config = function()
      require("conf.nvim-autopairs").setup()
    end
  }

  -- 快速更改单词
  use {
    "AndrewRadev/switch.vim",
    config = function()
      require("conf.switch").setup()
    end
  }

  -- 内置终端
  use {
    "akinsho/toggleterm.nvim",
    config = function()
      require("conf.toggleterm").setup()
    end
  }

  -- 键位绑定器
  use {
    "folke/which-key.nvim",
    config = function()
      require("conf.which-key").setup()
    end
  }

  -- LSP
  use {
    "neovim/nvim-lspconfig",
    config = function()
      require("conf.lsp").setup()
    end,
    requires = {
      "williamboman/nvim-lsp-installer",
      "ray-x/lsp_signature.nvim",
    },
  }

  -- LSP UI 美化
  use {
    "tami5/lspsaga.nvim",
    config = function()
      require("conf.lspsaga")
    end
  }

  -- LSP 进度提示
  use {
    "j-hui/fidget.nvim",
    config = function()
      require("conf.fidget")
    end
  }

  -- 语法高亮
  use {
    "nvim-treesitter/nvim-treesitter",
    run = {":TSupdate"},
    requires = {
      "p00f/nvim-ts-rainbow", -- 彩虹括号
      "windwp/nvim-ts-autotag"
    },
    config = function()
      require("conf.nvim-treesitter")
    end
  }

  -- 自动代码补全系列插件
  use {
    "hrsh7th/nvim-cmp",  -- 代码补全核心插件，下面都是增强补全的体验插件
    requires = {
      {"hrsh7th/vim-vsnip"}, -- vsnip 引擎，用于获得代码片段支持
      {"hrsh7th/cmp-vsnip"}, -- 适用于 vsnip 的代码片段源
      {"hrsh7th/cmp-nvim-lsp"}, -- 替换内置 omnifunc，获得更多补全
      {"hrsh7th/cmp-path"}, -- 路径补全
      {"hrsh7th/cmp-buffer"}, -- 缓冲区补全
      {"hrsh7th/cmp-cmdline"}, -- 命令补全
      {"f3fora/cmp-spell"}, -- 拼写建议
      {"rafamadriz/friendly-snippets"}, -- 提供多种语言的代码片段
      {"lukas-reineke/cmp-under-comparator"}, -- 让补全结果的排序更加智能
      {"tzachar/cmp-tabnine", run = "./install.sh"} -- tabnine 源,提供基于 AI 的智能补全
    },
    config = function()
      require("conf.nvim-cmp")
    end
  }

  -- 代码注释
  use {
    "numToStr/Comment.nvim",
    requires = {
      "JoosepAlviste/nvim-ts-context-commentstring"
    },
    config = function()
      require("conf.Comment")
    end
  }

  -- view tree
  use {
    "liuchengxu/vista.vim",
    config = function()
      require("conf.vista")
    end
  }
  use {
    'stevearc/aerial.nvim',
    config = function() require('aerial').setup() end
  }

  -- 代码截图
  use {
    "kristijanhusak/vim-carbon-now-sh",
  }

  -- 显示网页色
  use {
    "norcalli/nvim-colorizer.lua",
    config = function()
      vim.o.termguicolors = true
      require("colorizer").setup()
    end
  }

  -- Markdown
  use {
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = "markdown",
    cmd = { "MarkdownPreview" },
  }

  -- 多光标模式
  use {
    "terryma/vim-multiple-cursors",
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)


