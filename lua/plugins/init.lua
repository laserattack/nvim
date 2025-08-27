-- Настройка менеджера плагинов
local plugins = {
    "plugins/telescope",
    "plugins/color-scheme",
    "plugins/tree-sitter",
    "plugins/cmp",
    "plugins/lsp",
    "plugins/mini-surround",
}

vim.opt.rtp:prepend(CFGP.."/deps/plugins/lazy.nvim")
local for_setup = {}
for _, v in ipairs(plugins) do
    for_setup[#for_setup+1] = require(v)
end
require("lazy").setup(for_setup)
