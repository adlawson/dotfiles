local trouble = require 'trouble'

local opts = {silent = true, noremap = true}
local remap = {silent = true, noremap = false}
local function set_keymap(...) vim.api.nvim_set_keymap(...) end

set_keymap('n', '<leader>xx', '<cmd>TroubleToggle <cr>', opts)
set_keymap('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>', opts)
set_keymap('n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>', opts)
set_keymap('n', '<leader>xr', '<cmd>TroubleRefresh<cr>', opts)
set_keymap('n', '<leader>fr', '<cmd>TroubleToggle lsp_references<cr>', remap)

trouble.setup({
  auto_open = true,
  auto_close = true,
  icons = false,
  mode = "document_diagnostics",
  padding = false,
  use_diagnostic_signs = true,
})
