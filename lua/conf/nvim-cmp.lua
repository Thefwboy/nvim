local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
cmp_autopairs.lisp[#cmp_autopairs.lisp+1] = "racket"

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
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s", "c", }),

    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s", "c", }),
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

