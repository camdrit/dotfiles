return {
    "klen/nvim-config-local",
    config = function()
        local config_local = require('config-local')
        config_local.setup({
            config_files = { ".nvim.lua", ".nvimrc" },
            hashfile = vim.fn.stdpath('data') .. '/config-local',
            autocommands_create = true,
            commands_create = true,
            silent = false,
            lookup_parents = false,
        })
    end
}
