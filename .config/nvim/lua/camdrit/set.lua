-- explorer (netrw)
vim.cmd([[let g:netrw_bufsettings = 'noma nomad nu nobl nowrap ro']]) -- line numbers in netrw

-- line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- tabs & indentation
vim.opt.tabstop = 4 -- 2 spaces for tabs
vim.opt.shiftwidth = 4 -- 2 spaces for indent width
vim.opt.expandtab = true -- expand tab to spaces
vim.opt.autoindent = true -- copy indent from current line when starting new one

-- word wrap
vim.opt.wrap = false

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true -- mixed case assumes case-sensitive
vim.opt.hlsearch = false -- don't highlight previous search pattern matches
vim.opt.incsearch = true -- incremental search highlighting


-- highlight current line
vim.opt.cursorline = true

-- terminal theme
vim.opt.termguicolors = true

-- force dark mode
vim.opt.background = "dark"

-- enables gutter for extra info (i.e. breakpoint icon)
vim.opt.signcolumn = "yes"

-- allow backspace on indent, end of line or insert mode start position
vim.opt.backspace = "indent,eol,start"

-- don't comment next line when returning comment
vim.cmd([[autocmd FileType * set formatoptions-=ro]])

-- clipboard
vim.opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
vim.opt.splitright = true -- split vertical window to the right
vim.opt.splitbelow = true -- split horizontal window to the bottom

-- no swap
vim.opt.swapfile = false

-- don't backup buffers
vim.opt.backup = false

-- enable long undo history
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- minimum lines above and below cursor
vim.opt.scrolloff = 8

-- update freq
vim.opt.updatetime = 50

-- leader :)
vim.g.mapleader = " "

