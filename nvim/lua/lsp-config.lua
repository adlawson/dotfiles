local lsp_config = require 'lspconfig'
local lsp_util = require 'lspconfig/util'
local null_ls = require 'null-ls'

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.golangci_lint,
  },
})

vim.diagnostic.config({
  severity_sort = true,
  update_in_insert = false,
  virtual_text = false,
})

local function common_formatting(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end
end

local function common_keymap(client, bufnr)
  local bufopts = { noremap=true, silent=true }
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  buf_set_keymap('n', '<C-LeftMouse>',   '<LeftMouse><cmd>lua vim.lsp.buf.definition()<cr>', bufopts)
  buf_set_keymap('n', '<localleader>ff', '<cmd>lua vim.lsp.buf.definition()<cr>', bufopts)
  buf_set_keymap('n', '<localleader>fr', '<cmd>lua vim.lsp.buf.references()<cr>', bufopts)
  buf_set_keymap('n', '<localleader>fs', '<cmd>lua vim.lsp.buf.hover()<cr>', bufopts)
  buf_set_keymap('n', '<localleader>fa', '<cmd>lua vim.lsp.buf.code_action()<cr>', bufopts)
  buf_set_keymap('v', '<localleader>fa', '<cmd>lua vim.lsp.buf.range_code_action()<cr>', bufopts)
  buf_set_keymap('n', '<localleader>fe', '<cmd>lua vim.diagnostic.open_float()<cr>', bufopts)
  buf_set_keymap('n', '<localleader>f[', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', bufopts)
  buf_set_keymap('n', '<localleader>f]', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', bufopts)

  vim.keymap.set('n', '<localleader>wd', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<localleader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<localleader>wq', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
end

local function common_on_attach(client, bufnr)
    common_keymap(client, bufnr)
    common_formatting(client, bufnr)
end

-- ----------------------------------------------------------------------------
-- go
-- ----------------------------------------------------------------------------

lsp_config.gopls.setup((function()
  local function organize_imports()
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

  local function on_attach(client, bufnr)
    common_on_attach(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = organize_imports,
      })
    end
  end

  return {
    cmd = {'gopls', '-remote=auto', 'serve'},
    filetypes = {'go', 'gomod', 'gowork', 'gohtmltmpl', 'gotexttmpl', 'gotmpl'},
    single_file_support = true,
    root_dir = root_dir,
    root_dir = lsp_util.root_pattern(unpack(vim.g.go_gopls_root_dir or {
      'go.work',
      'go.mod',
      ',git',
      'main.go',
    })),
    on_attach = on_attach,
    settings = {
      gopls = vim.g.go_gopls_settings or {
        analyses = {
          fieldalignment = true,
          nilness = true,
          unusedparams = true,
          unusedwrite = true,
        },
        staticcheck = true,
        expandWorkspaceToModule = true,
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


-- ----------------------------------------------------------------------------
-- terraform
-- ----------------------------------------------------------------------------

lsp_config.terraformls.setup((function()
  return {}
end)())
