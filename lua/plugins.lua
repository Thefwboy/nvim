local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

-- 每次保存 plugins.lua 自动安装插件
pcall(
  vim.cmd,
  [[
    augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
  ]]
)

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Install your plugins here
return packer.startup(function(use)
  use ("wbthomason/packer.nvim")

  -- Colortheme
  use {
    "luisiacc/gruvbox-baby",
    config = function()
      vim.cmd("colorscheme gruvbox-baby")
    end
  }

  use {
    "kyazdani42/nvim-tree.lua",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("config.nvim-tree").setup()
    end
  }

  use {
    "akinsho/bufferline.nvim",
    requires = {
      "kyazdani42/nvim-web-devicons",
      "moll/vim-bbye"
    },
    config = function()
      require("config.bufferline").setup()
    end
  }

  use {
    "nvim-lualine/lualine.nvim",
    requires = {
      "kyazdani42/nvim-web-devicons",
      "arkav/lualine-lsp-progress"
    },
    config = function()
      require("config.lualine").setup()
    end
  }

  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("config.treesitter").setup()
    end
  }

  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline"
    },
    config = function()
      require("config.cmp").setup()
    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
