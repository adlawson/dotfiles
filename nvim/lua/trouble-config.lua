local trouble = require 'trouble'

local opts = {silent = true, noremap = true}
local remap = {silent = true, noremap = false}
local function set_keymap(...) vim.api.nvim_set_keymap(...) end

set_keymap('n', '<leader>tt', '<cmd>TroubleToggle workspace_diagnostics<cr>', opts)
set_keymap('n', '<leader>tr', '<cmd>TroubleRefresh<cr>', opts)
set_keymap('n', '<leader>fr', '<cmd>TroubleToggle lsp_references<cr>', remap)

trouble.setup({
  auto_open = false,
  auto_close = false,
  icons = false,
  padding = false,
})
