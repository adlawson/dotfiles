local lsp_config = require 'lspconfig'
local lsp_util = require 'lspconfig/util'
local null_ls = require 'null-ls'

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.golangci_lint,
  },
})

vim.diagnostic.config({
  update_in_insert = false,
})

local attach_keymap = function(client, bufnr)
  local bufopts = { noremap=true, silent=true }
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  buf_set_keymap('n', '<localleader>ff', '<cmd>lua vim.lsp.buf.definition()<cr>', bufopts)
  --buf_set_keymap('n', '<localleader>fr', '<cmd>lua vim.lsp.buf.references()<cr>', bufopts)
  buf_set_keymap('n', '<localleader>fs', '<cmd>lua vim.lsp.buf.hover()<cr>', bufopts)
  buf_set_keymap('n', '<localleader>fa', '<cmd>lua vim.lsp.buf.code_action()<cr>', bufopts)
  buf_set_keymap('v', '<localleader>fa', '<cmd>lua vim.lsp.buf.range_code_action()<cr>', bufopts)
  buf_set_keymap('n', '<localleader>fe', '<cmd>lua vim.lsp.diagnostic.open_float()<cr>', bufopts)
  buf_set_keymap('n', '<localleader>f[', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', bufopts)
  buf_set_keymap('n', '<localleader>f]', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', bufopts)

end

-- ----------------------------------------------------------------------------
-- go
-- ----------------------------------------------------------------------------

lsp_config.gopls.setup((function()
  local config = vim.g.gopls or {}
  local root_dir = config.root_dir
  if not root_dir then
    root_dir = lsp_util.root_pattern('go.work', 'go.mod', ',git', 'main.go')
  end

  local organize_imports = function()
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)

    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
        else
          vim.lsp.buf.execute_command(r.command)
        end
      end
    end
  end

  local on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = organize_imports,
      })
    end
    attach_keymap(client, bufnr)
  end

  return {
    cmd = {'gopls', 'serve'},
    filetypes = {'go', 'gomod', 'gohtmltmpl', 'gotexttmpl'},
    root_dir = root_dir,
    on_attach = on_attach,
    settings = {
      gopls = {
        analyses = {
          fieldalignment = true,
          nilness = true,
          unusedparams = true,
          unusedwrite = true,
        },
        staticcheck = config.staticcheck,
        expandWorkspaceToModule = config.expand_workspace_to_module,
        memoryMode = 'DegradeClosed',
      },
    },
    init_options = {
      codelenses = {
        generate = true,
        gc_details = true,
        test = true,
        tidy = true,
      },
    },
  }
end)())
