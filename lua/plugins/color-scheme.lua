
return {
    dir = CFGP.."/deps/plugins/theme.nvim",
    dependencies = {
        { dir = CFGP.."/deps/plugins/colorbuddy.nvim" }
    },
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd.colorscheme("ilyasyoy")
    end
}

-- return {
--     dir = CFGP.."/deps/plugins/gruber-darker.nvim",
--     lazy = false,
--     priority = 1000,
--     config = function()
--         vim.cmd.colorscheme("gruber-darker")
--         vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#ffdd33', bold = true })
--     end
-- }
