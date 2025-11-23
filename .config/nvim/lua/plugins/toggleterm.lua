return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        local toggleterm = require("toggleterm")

        local uname = vim.loop.os_uname()
        local shell = ""
        if uname.sysname:find 'Windows' and true then
            shell = "pwsh"
        else
            shell = "GIT_CONFIG_GLOBAL=~/.gitconfig-nvim RUNNING_IN_NVIM=1 zsh"
        end

        toggleterm.setup({
            hide_numbers = true,
            direction = "horizontal",
            shell = shell,
            auto_scroll = true,
            autochdir = true,
        })
    end,
}
