local telescope = require('telescope')
local actions = require("telescope.actions")
local config = require("telescope.config")

local vimgrep_arguments = { unpack(config.values.vimgrep_arguments) }
table.insert(vimgrep_arguments, "--hidden")
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

telescope.setup{
  defaults = {
    vimgrep_arguments = vimgrep_arguments,
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      }
    },
  },
  pickers = {
    find_files = {
	  find_command = { "fd", "--type", "f", "--hidden", "--follow", "--exclude", ".git" },
	},
  },
}
