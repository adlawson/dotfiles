local cmp = require "cmp"

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

vim.api.nvim_create_autocmd({"TextChangedI", "TextChangedP"}, {
  callback = function()
    local _, col = vim.api.nvim_win_get_cursor(0)
    local cursor = vim.api.nvim_get_current_line()[col]
    if foo and not string.match(cursor, '^\\w$') and cmp.visible() then
      cmp.close()
    end
  end,
  pattern = "*",
})

cmp.setup({
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  },{
    { name = 'buffer' },
  }),
  completion = {
    autocomplete = false, -- manual only
    completeopt = 'menu,menuone,noselect,noinsert',
  },
  mapping = {
    ['<c-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['<c-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    ["<c-o>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.close()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<esc>'] = cmp.mapping.close(),
    ['<cr>'] = cmp.mapping.confirm({ select = false }),
  },
})
