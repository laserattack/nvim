-- Базовые настройки (не относящиеся к плагинам)

-- всегда показывать строку с вкладками
vim.opt.showtabline = 2
-- слева от номеров строк пустое пространство размером с 1 символ
vim.opt.signcolumn = "yes"
-- Чтобы не было подвисаний при работе LSP
vim.opt.updatetime = 300
-- Отключение системного статус-бара, т.к. его заменяет плагин
-- vim.opt.laststatus = 0
vim.opt.showmode = false
vim.opt.showcmd = false
-- Для нормального взамодействия с системным буфером
vim.opt.clipboard = "unnamedplus"
-- Отключение swap файлов
vim.opt.swapfile = false
-- Относительные номера строк
vim.opt.number = true
vim.opt.relativenumber = true
-- Чтобы не было разбиения строки если она не помещается в ширину экрана
vim.opt.wrap = false
vim.wo.linebreak = true
-- Оффест скролла чтобы не нужно было доходить до самого низа
-- при скролле на стрелочки на клавиатуре
vim.opt.scrolloff = 8
-- Таб = 4 пробела
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
-- Настройка внешнего вида курсора (во всех режимах одинаковый + мигает)
vim.opt.guicursor = "a:block-blinkon500-blinkoff500"

-- При открытии nvim (если открывается файл) рабочая директория
-- меняется на директорию в которой этот файл
vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = function(data)
        local directory = vim.fn.isdirectory(data.file) == 1
        if not directory then
            local current_file = vim.api.nvim_buf_get_name(0)
            if current_file ~= "" then
                local file_dir = vim.fn.fnamemodify(current_file, ":h")
                vim.cmd("cd " .. vim.fn.fnameescape(file_dir))
            end
        end
    end,
})
