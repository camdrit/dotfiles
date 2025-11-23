return {
    "camdrit/dracula-pro-nvim",
    priority = 1000,
    lazy = false,
    config = function()
        vim.cmd("syntax enable")
        vim.cmd("let g:dracula_colorterm = 0")
        vim.cmd("colorscheme dracula_pro")
    end
}
