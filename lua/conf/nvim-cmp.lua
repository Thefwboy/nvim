local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

--   פּ ﯟ   some other good icons
local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

-- find more here: https://www.nerdfonts.com/cheat-sheet
cmp.setup {
  -- 指定补全引擎
  snippet = {
    expand = function(args)
      -- 使用 vsnip 引擎
      vim.fn["vsnip#anonymous"](args.body)
    end
  },
  -- 指定补全源（安装了补全源插件就在这里指定）
  sources = cmp.config.sources(
  {
    {name = "vsnip"},
    {name = "nvim_lsp"},
    {name = "path"},
    {name = "buffer"},
    {name = "cmdline"},
    {name = "spell"},
    {name = "cmp_tabnine"}
  }
  ),
  -- 格式化补全菜单
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
    -- Kind icons
    vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
    vim_item.menu = ({
      vsnip = "[Snippet]",
      nvim_lsp = "[LSP]",
      path = "[Path]",
      buffer = "[Buffer]",
      cmdline = "[Cmd]",
      spell = "[Spell]",
      cmp_tabnine = "[AISnip]"
    })[entry.source.name]
    return vim_item
  end,
  },
  -- 对补全建议排序
  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      require("cmp-under-comparator").under,
      require("cmp_tabnine.compare"),
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order
    }
  },
  -- 绑定补全相关的按键
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<CR>"] = cmp.mapping.confirm(),
    ["<C-k>"] = cmp.mapping(
    {
      i = function()
        if cmp.visible() then
          cmp.abort()
        else
          cmp.complete()
        end
      end,
      c = function()
        if cmp.visible() then
          cmp.close()
        else
          cmp.complete()
        end
      end
    }
    ),
    ["<Tab>"] = cmp.mapping(
    function(fallback)
      if cmp.visible() then
        local entry = cmp.get_selected_entry()
        if not entry then
          cmp.select_next_item({behavior = cmp.SelectBehavior.Select})
        end
        cmp.confirm()
      else
        fallback()
      end
    end,
    {"i", "s", "c"}
    )
  },
  confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
  },
  window = {
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      winhighlight = "NormalFloat:NormalFloat,FloatBorder:TelescopeBorder",
    },
  },
  experimental = {
    ghost_text = false,
    native_menu = false,
  },
}

-- 命令行 / 模式提示
cmp.setup.cmdline("/", {
  sources = {
    {name = "buffer"}
  }
})

-- 命令行 : 模式提示
cmp.setup.cmdline(":", {
  sources = cmp.config.sources({
    {name = "path"}
  }, {
    {name = "cmdline"}
  })
})

