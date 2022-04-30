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

  -- nvim-tree
  use {
    "kyazdani42/nvim-tree.lua",
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
    config = function()
      require("conf.nvim-tree").setup()
    end,
  }

  -- Status line
  use {
    "windwp/windline.nvim",
    event = "VimEnter",
    -- after = "nvim-treesitter",
    config = function()
      require("conf.windline").setup()
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

  -- LSP 基础服务
  use {
    "neovim/nvim-lspconfig",
    config = function()
      require("conf.nvim-lspconfig")
    end
  }

  -- 自动安装 LSP
  use {
    "williamboman/nvim-lsp-installer",
    config = function()
      require("conf.nvim-lsp-installer")
    end
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
      "p00f/nvim-ts-rainbow" -- 彩虹括号
    },
    config = function()
      require("conf.nvim-treesitter")
    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
