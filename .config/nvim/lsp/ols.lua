vim.lsp.config('ols', {
    cmd = { 'ols' },
    filetypes = { 'odin' },
    root_markers = {
        'ols.json', 'odinfmt.json', '.git', '*.odin'
    },
    init_options = {
        checker_args = "-strict-style",
    }
})
