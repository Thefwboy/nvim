local M = {}

function M.setup()
  local whichkey = require "which-key"

  local conf = {
    plugins = {
      spelling = {
        -- 是否接管默认 z= 的行为
        enabled = true,
        suggestions = 20
      }
    },
    window = {
      border = "single", -- none, single, double, shadow
      position = "bottom", -- bottom, top
    },
  }

  local opts = {
    mode = "n", -- Normal mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  }

  local mappings = {
    ["w"] = { "<cmd>update!<CR>", "Save" },
    ["q"] = { "<cmd>q!<CR>", "Quit" },
    ["e"] = { "<cmd>NvimTreeToggle<CR>", "nvim-tree" },
    ["u"] = { "<cmd>Switch<CR>", "Switch"},
    ["v"] = { "<cmd>Vista!!<CR>", "Vista"},

    t = {
      name = "Terminal",
      t = { "<cmd>exe v:count.'ToggleTerm'<CR>", "Open Blew"},
      f = { "<cmd>lua require('toggleterm').float_toggle()<CR>", "Open Flew"},
      g = { "<cmd>lua require('toggleterm').lazygit_toggle()<CR>", "Open Lazygit"},
    },

    z = {
      name = "Packer",
      c = { "<cmd>PackerCompile<cr>", "Compile" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      s = { "<cmd>PackerSync<cr>", "Sync" },
      S = { "<cmd>PackerStatus<cr>", "Status" },
      u = { "<cmd>PackerUpdate<cr>", "Update" },
    },

  }

  whichkey.setup(conf)
  whichkey.register(mappings, opts)
end

return M
