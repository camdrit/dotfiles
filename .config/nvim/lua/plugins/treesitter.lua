return {
  "nvim-treesitter/nvim-treesitter",
  branch = 'master',
  lazy = false,
  build = ":TSUpdate",
  dependencies = { "nvim-treesitter/playground" },
  config = function()
    local treesitter = require("nvim-treesitter.configs")

    treesitter.setup({
      ensure_installed = { 
        "c",
	"lua",
	"vim",
	"vimdoc",
	"query",
	"markdown",
	"markdown_inline",
	"json",
	"javascript",
	"html",
	"css",
	"bash", 
	"dockerfile",
	"gitignore",
	"cpp",
	"c_sharp",
	"diff",
	"cmake",
	"odin"
      },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
      }
    })
  end,
}
