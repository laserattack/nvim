-- Базовые бинды (не относящиеся к плагинам)

-- Работа с терминалом 
do
    local function toggle_terminal()
        if vim.api.nvim_get_mode().mode == 't' then
            os.execute("history -a")
            vim.cmd('q')
        else
            vim.cmd('tabnew')
            vim.cmd('terminal')
        end
    end
    -- alt+` - открыть/закрыть терминал
    vim.keymap.set({'n', 't'}, '<A-`>', toggle_terminal, { noremap = true, silent = true })
    -- Выход из режима терминала через ESC
    vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', {noremap = true, silent = true})
    -- Автоматически startinsert при открытии терминала
    vim.api.nvim_create_autocmd("TermOpen", { pattern = "*", command = "startinsert" })
end

-- Работа с файлами
do
    local function toggle_netrw()
        if vim.bo.filetype == 'netrw' then
            vim.cmd('q')
        else
            vim.cmd('tabnew')
            vim.cmd('Explore')
        end
    end
    -- Открывает дерево директорий в новой вкладке/закрывает его
    vim.keymap.set('n', '<A-e>', toggle_netrw, { noremap = true, silent = true })
end

-- Работа с текстом
do
    -- Переключение подсветки результатов поиска
    local function toggle_search_highlight()
        vim.opt.hlsearch = not vim.opt.hlsearch:get()
    end
    -- Переключение режима строк
    local function toggle_wrap_mode()
        vim.opt.wrap = not vim.opt.wrap:get()
    end
    -- Tab/Shift-Tab для сдвига текста в визуальном режиме 
    vim.keymap.set("v", "<Tab>", ">gv", { noremap = true, silent = true })
    vim.keymap.set("v", "<S-Tab>", "<gv", { noremap = true, silent = true })
    -- p - вставка в режиме выделения без перезаписи буфера копирования
    vim.keymap.set('v', 'p', 'p:let @+=@0<CR>', { noremap = true, silent = true })
    -- alt+h - скрытие/возвращение подсветки резульатов поиска
    vim.keymap.set('n', '<A-h>', toggle_search_highlight, { noremap = true, silent = true })
    -- alt+z - vim.opt.wrap = false/true
    vim.keymap.set('n', '<A-z>', toggle_wrap_mode, { noremap = true, silent = true })
    -- Отключение стрелочек (переназначение на ctrl+)
    vim.keymap.set({'n','v'}, '<Up>', '<C+Up>')
    vim.keymap.set({'n','v'}, '<Down>', '<C+Down>')
    vim.keymap.set({'n','v'}, '<Left>', '<C+Left>')
    vim.keymap.set({'n','v'}, '<Right>', '<C+Right>')
    -- Скролл экран вверх/экран вниз на alt+u/d
    vim.keymap.set('n', '<A-u>', '<C-u>', { noremap = true, silent = true })
    vim.keymap.set('n', '<A-d>', '<C-d>', { noremap = true, silent = true })
end

do
    -- Работа с вкладками/окнами
    -- alt+w - циклическое переключение между окнами
    vim.keymap.set("n", "<A-w>", "<C-w>w", { noremap = true, silent = true })
    -- alt+3 - Перейти на пред. вкладку
    vim.keymap.set('n', '<A-1>', ':tabprevious<CR>', { noremap = true, silent = true })
    -- alt+4 - Перейти на след. вкладку
    vim.keymap.set('n', '<A-2>', ':tabnext<CR>', { noremap = true, silent = true })
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
-- Исполнение текущей строки как lua кода
vim.keymap.set('n', 'el', '<cmd>lua _G.eval_lua_line()<CR>')
