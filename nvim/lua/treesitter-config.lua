require'nvim-treesitter.configs'.setup {
  ensure_installed = { "go", "gomod", "gowork", "help", "make", "terraform", "yaml" },
  sync_install = false,
  auto_install = false,
  highlight = {
    enable = true,
  },
}
