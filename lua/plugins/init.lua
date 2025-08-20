-- Настройка менеджера плагинов
local plugins = {
    "plugins/nvim-tree",
    "plugins/color-scheme",
    "plugins/tree-sitter",
    "plugins/cmp",
    "plugins/lsp",
    "plugins/status-bar",
    "plugins/mini-surround",
    "plugins/dashboard",
}

local lazypath = vim.fn.stdpath("config") .. "/deps/plugins/lazy.nvim"
vim.opt.rtp:prepend(lazypath)
local for_setup = {}
for _, v in ipairs(plugins) do
   for_setup[#for_setup+1] = require(v)
end
require("lazy").setup(for_setup)
