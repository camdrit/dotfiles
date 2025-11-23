return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local lualine = require("lualine")
        local utils = require("lualine.utils.utils")
        local highlight = require("lualine.highlight")
        local lazy_status = require("lazy.status")


        local colors = {
            bg = "#2E2B3B",
            black = "#17161D",
            purple = "#9580FF",
            white = "#F8F8F2",
            cyan = "#80FFEA",
            pink = "#FF80BF",
            yellow = "#FFFF80",
            green = "#8AFF80",
            visual = "#393649",
        }

        local diagnostics_message = require("lualine.component"):extend()
        diagnostics_message.default = {
            colors = {
                error = utils.extract_color_from_hllist(
                    { "fg", "sp" },
                    { "DiagnosticError", "LspDiagnosticsDefaultError", "DiffDelete" },
                    colors.pink
                ),
                warning = utils.extract_color_from_hllist(
                    { "fg", "sp" },
                    { "DiagnosticWarn", "LspDiagnosticsDefaultWarning", "DiffText" },
                    colors.yellow
                ),
                info = utils.extract_color_from_hllist(
                    { "fg", "sp" },
                    { "DiagnosticInfo", "LspDiagnosticsDefaultInformation", "DiffChange" },
                    colors.white
                ),
                hint = utils.extract_color_from_hllist(
                    { "fg", "sp" },
                    { "DiagnosticInfo", "LspDiagnosticsDefaultHint", "DiffAdd" },
                    colors.visual
                ),
            },
        }

        function diagnostics_message:init(options)
            diagnostics_message.super:init(options)
            self.options.colors = vim.tbl_extend("force", diagnostics_message.default.colors, self.options.colors or {})
            self.highlights = { error = "", warn = "", info = "", hint = "" }
            self.highlights.error = highlight.create_component_highlight_group(
                { fg = self.options.colors.error },
                "diagnostics_message_error",
                self.options
            )
            self.highlights.warn = highlight.create_component_highlight_group(
                { fg = self.options.colors.warn },
                "diagnostics_message_warn",
                self.options
            )
            self.highlights.info = highlight.create_component_highlight_group(
                { fg = self.options.colors.info },
                "diagnostics_message_info",
                self.options
            )
            self.highlights.hint = highlight.create_component_highlight_group(
                { fg = self.options.colors.hint },
                "diagnostics_message_hint",
                self.options
            )
        end

        function diagnostics_message:update_status(is_focused)
            local r, _ = unpack(vim.api.nvim_win_get_cursor(0))
            local diagnostics = vim.diagnostic.get(0, { lnum = r - 1 })
            if #diagnostics > 0 then
                local diag = diagnostics[1]
                for _, d in ipairs(diagnostics) do
                    if d.severity < diag.severity then
                        diagnostics = d
                    end
                end
                local icons = { " ", " ", " ", " " }
                local hl = { self.highlights.error, self.highlights.warn, self.highlights.info, self.highlights.hint }
                return highlight.component_format_highlight(hl[diag.severity]) ..
                    icons[diag.severity] .. " " .. diag.message
            else
                return ""
            end
        end

        local my_lualine_theme = {
            normal = {
                a = { fg = colors.black, bg = colors.purple, gui = 'bold' },
                b = { fg = colors.purple, bg = colors.bg },
                c = { fg = colors.white, bg = colors.bg },
            },

            command = {
                a = { fg = colors.black, bg = colors.cyan, gui = 'bold' },
                b = { fg = colors.cyan, bg = colors.bg },
            },

            visual = {
                a = { fg = colors.black, bg = colors.pink, gui = 'bold' },
                b = { fg = colors.pink, bg = colors.bg },
            },

            inactive = {
                a = { fg = colors.white, bg = colors.visual, gui = 'bold' },
                b = { fg = colors.black, bg = colors.white },
            },

            replace = {
                a = { fg = colors.black, bg = colors.yellow, gui = 'bold' },
                b = { fg = colors.yellow, bg = colors.bg },
                c = { fg = colors.white, bg = colors.bg },
            },

            insert = {
                a = { fg = colors.black, bg = colors.green, gui = 'bold' },
                b = { fg = colors.green, bg = colors.bg },
                c = { fg = colors.white, bg = colors.bg },
            },
        }

        lualine.setup({
            options = {
                theme = my_lualine_theme
            },
            sections = {
                lualine_c = {
                    { diagnostics_message },
                },
                lualine_x = {
                    {
                        lazy_status.updates,
                        cond = lazy_status.has_updates,
                        color = { fg = "#FFCA80" },
                    },
                    { "encoding" },
                    { "fileformat" },
                    { "filetype" },
                },
            },
        })
    end,
}
