-- Базовые бинды (не относящиеся к плагинам) 

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
-- alt+` - открыть терминал в новой вкладке + сразу заходит в режим терминала
vim.keymap.set('n', '<A-`>', ':tabnew | terminal<CR>i', { noremap = true, silent = true })
-- Выход из режима терминала используя esc
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
-- Уменьшение ширины окна
vim.keymap.set('n', '<A-1>', ':vertical resize -5<CR>', { noremap = true, silent = true })
-- Увеличение ширины окна
vim.keymap.set('n', '<A-2>', ':vertical resize +5<CR>', { noremap = true, silent = true })
-- alt+3 - Перейти на пред. вкладку
vim.keymap.set('n', '<A-3>', ':tabprevious<CR>', { noremap = true, silent = true })
-- alt+4 - Перейти на след. вкладку
vim.keymap.set('n', '<A-4>', ':tabnext<CR>', { noremap = true, silent = true })
