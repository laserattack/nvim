-- Настройка менеджера плагинов
local plugins = {
    "plugins/nvim-tree",
    "plugins/color-scheme",
    "plugins/tree-sitter",
    "plugins/cmp",
    "plugins/lsp",
    "plugins/mini-surround",
    "plugins/dashboard",
    "plugins/fasm-highlight",
}

vim.opt.rtp:prepend(CFGP.."/deps/plugins/lazy.nvim")
local for_setup = {}
for _, v in ipairs(plugins) do
    for_setup[#for_setup+1] = require(v)
end
require("lazy").setup(for_setup)
