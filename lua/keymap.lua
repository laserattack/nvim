-- Базовые бинды (не относящиеся к плагинам)

-- Выход из терминала с сохранением истории
local function close_terminal()
    os.execute("history -a")
    vim.cmd('bdelete!')
end
-- Переключение режима строк
local function toggle_wrap_mode()
    vim.opt.wrap = not vim.opt.wrap:get()
end
-- Переключение подсветки результатов поиска
local function toggle_search_highlight()
    vim.opt.hlsearch = not vim.opt.hlsearch:get()
end
-- el - выполнение текущей строки луа кода 
vim.api.nvim_set_hl(0, "EvalLineOutput", { fg = "#ffffff", bg = "#000000" })

function _G.eval_lua_line()
    local line = vim.api.nvim_get_current_line()
    local bufnr = vim.api.nvim_get_current_buf()
    local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
    local ns = vim.api.nvim_create_namespace("eval_lua")

    local marks = vim.api.nvim_buf_get_extmarks(bufnr, ns, {lnum, 0}, {lnum, -1}, {details = true})
    if #marks > 0 then
        vim.api.nvim_buf_clear_namespace(bufnr, ns, lnum, lnum + 1)
        return
    end

    local output_lines = {}
    local function capture_print(...)
        local args = {...}
        for _, arg in ipairs(args) do
            table.insert(output_lines, tostring(arg))
        end
    end

    local original_print = print
    print = capture_print

    -- Исполнение чанка кода, могут быть и принты и возвращение результата через return
    local success, result = pcall(function()
        return loadstring(line)()
    end)

    -- Не удалось исполнить чанк, пытаюсь с return
    if not success then
        success, result = pcall(function()
            return loadstring("return " .. line)()
        end)
    end

    print = original_print

    local output
    if not success then
        output = "=> error"
    elseif #output_lines > 0 then
        if result ~= nil then
            result = tostring(result)
            output = "=> " .. table.concat(output_lines, ", ") .. " @@ "..tostring(result)
        else
            output = "=> " .. table.concat(output_lines, ", ")
        end
    else
        output = "=> " .. tostring(result)
    end

    vim.api.nvim_buf_set_extmark(bufnr, ns, lnum, 0, {
        virt_text = {{ output, "EvalLineOutput" }},
        virt_text_pos = "eol",
        hl_mode = "combine",
    })
end

vim.keymap.set('n', 'el', '<cmd>lua _G.eval_lua_line()<CR>')
-- Сделать директорию текущего открытого файла рабочей директорией
vim.keymap.set('n', 'cd', ':lcd %:p:h<CR>', { noremap = true, silent = true })
-- Скролл экран вверх/экран вниз на alt+u/d
vim.keymap.set('n', '<A-u>', '<C-u>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-d>', '<C-d>', { noremap = true, silent = true })
-- p - вставка в режиме выделения без перезаписи буфера копирования
vim.keymap.set('v', 'p', 'p:let @+=@0<CR>', { noremap = true, silent = true })
-- alt+h - скрытие/возвращение подсветки резульатов поиска
vim.keymap.set('n', '<A-h>', function() toggle_search_highlight() end, { noremap = true, silent = true })
-- alt+w - циклическое переключение между окнами
vim.keymap.set("n", "<A-w>", "<C-w>w", { noremap = true, silent = true })
-- Tab/Shift-Tab для сдвига текста в визуальном режиме 
vim.keymap.set("v", "<Tab>", ">gv", { noremap = true, silent = true })
vim.keymap.set("v", "<S-Tab>", "<gv", { noremap = true, silent = true })
-- alt+z - vim.opt.wrap = false/true
vim.keymap.set('n', '<A-z>', function() toggle_wrap_mode() end, { noremap = true, silent = true })
-- alt+` - открыть терминал
vim.keymap.set('n', '<A-`>', ':split | terminal<CR>', { noremap = true, silent = true })
-- Автоматически startinsert при открытии терминала
vim.api.nvim_create_autocmd("TermOpen", { pattern = "*", command = "startinsert" })
-- Выход из режима терминала используя esc/alt+` (с сохранением истории)
vim.keymap.set('t', '<Esc>', function() close_terminal() end, { noremap = true, silent = true })
vim.keymap.set('t', '<A-`>', function() close_terminal() end, { noremap = true, silent = true })
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
