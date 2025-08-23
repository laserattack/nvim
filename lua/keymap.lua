-- Базовые бинды (не относящиеся к плагинам) 

-- alt+h - скрытие/возвращение подсветки резульатов поиска
vim.keymap.set('n', '<A-h>', function()
    vim.opt.hlsearch = not vim.opt.hlsearch:get()
end, { noremap = true, silent = true })
-- alt+w - циклическое переключение между окнами
vim.keymap.set("n", "<A-w>", "<C-w>w", { noremap = true, silent = true })
-- Tab/Shift-Tab для сдвига текста в визуальном режиме 
vim.keymap.set("v", "<Tab>", ">gv", { noremap = true, silent = true })
vim.keymap.set("v", "<S-Tab>", "<gv", { noremap = true, silent = true })
-- alt+z - vim.opt.wrap = false/true
vim.keymap.set('n', '<A-z>',
    function()
        vim.opt.wrap = not vim.opt.wrap:get()
    end, { noremap = true, silent = true })
-- alt+` - открыть терминал
vim.keymap.set('n', '<A-`>', ':split | terminal<CR>', { noremap = true, silent = true })
-- Автоматически startinsert при открытии терминала
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    command = "startinsert"
})
-- Выход из режима терминала используя esc
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
-- Уменьшение ширины окна
vim.keymap.set('n', '<A-1>', ':vertical resize -5<CR>', { noremap = true, silent = true })
-- Увеличение ширины окна
vim.keymap.set('n', '<A-2>', ':vertical resize +5<CR>', { noremap = true, silent = true })
-- Уменьшение высоты окна
vim.keymap.set('n', '<A-9>', ':horizontal resize -5<CR>', { noremap = true, silent = true })
-- Увеличение высоты окна
vim.keymap.set('n', '<A-0>', ':horizontal resize +5<CR>', { noremap = true, silent = true })
-- alt+3 - Перейти на пред. вкладку
vim.keymap.set('n', '<A-3>', ':tabprevious<CR>', { noremap = true, silent = true })
-- alt+4 - Перейти на след. вкладку
vim.keymap.set('n', '<A-4>', ':tabnext<CR>', { noremap = true, silent = true })
