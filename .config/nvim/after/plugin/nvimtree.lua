local api = require("nvim-tree.api")

vim.api.nvim_create_augroup("NvimTreeResize", {
    clear = true,
})

vim.api.nvim_create_autocmd({ "VimResized", "WinResized" }, {
    group = "NvimTreeResize",
    callback = function()
        local winid = api.tree.winid()
        if (winid) then
            api.tree.reload()
        end
    end
})
