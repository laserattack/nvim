-- Базовые бинды (не относящиеся к плагинам)
-- Бинды плагинов в файликах с подключением плагинов

vim.keymap.set(
    'n', '<leader>`',
    function()
        vim.cmd('tabnew')
        vim.cmd('terminal')
    end,
    { noremap = true, silent = true }
)
vim.keymap.set(
    't', '<Esc>',
    function()
        vim.cmd("stopinsert")
    end,
    {noremap = true, silent = true}
)

vim.api.nvim_create_autocmd("TermOpen", { pattern = "*", command = "startinsert" })
vim.keymap.set("v", "<Tab>", ">gv", { noremap = true, silent = true })
vim.keymap.set("v", "<S-Tab>", "<gv", { noremap = true, silent = true })
vim.keymap.set('v', 'p', 'p:let @+=@0<CR>', { noremap = true, silent = true })
vim.keymap.set(
    'n', '<leader>w',
    function()
        vim.opt.wrap = not vim.opt.wrap:get()
    end,
    { noremap = true, silent = true }
)
vim.keymap.set({'n','v'}, '<Up>', '<C+Up>')
vim.keymap.set({'n','v'}, '<Down>', '<C+Down>')
vim.keymap.set({'n','v'}, '<Left>', '<C+Left>')
vim.keymap.set({'n','v'}, '<Right>', '<C+Right>')
