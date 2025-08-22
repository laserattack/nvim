local headers = {
    {
        [[                                   __       ]],
        [[                               _.-~  )      ]],
        [[                    _..--~~~~,'   ,-/     _ ]],
        [[                 .-'. . . .'   ,-','    ,' )]],
        [[               ,'. . . _   ,--~,-'__..-'  ,']],
        [[             ,'. . .  (@)' ---~~~~      ,'  ]],
        [[            /. . . . '~~             ,-'    ]],
        [[           /. . . . .             ,-'       ]],
        [[          ; . . . .  - .        ,'          ]],
        [[         : . . . .       _     /            ]],
        [[        . . . . .          `-.:             ]],
        [[       . . . ./  - .          )             ]],
        [[      .  . . |  _____..---.._/ ____ ---- _  ]],
        [[~---~~~~----~~~~             ~~             ]],
        [[                                            ]],
    },
}

return {
    dir = CFGP..'/deps/plugins/dashboard-nvim',
    event = 'VimEnter',
    config = function()

        -- Встраиваю свою кастомную тему в плагин
        -- файл с именем theme и расширением .lua должен быть в директории lua/plugins/

        local theme = "dashboard-custom-theme"

        -- Подключается какая то кастомная тема
        if theme ~= "hyper" and theme ~= "doom" then
            local custom_theme_src_path = CFGP..'/lua/plugins/'..theme..'.lua'
            -- Если есть файл с кастомной темой в lua/plugins то подключается он
            if vim.fn.filereadable(custom_theme_src_path) == 1 then
                local custom_theme_dst_path = CFGP..'/deps/plugins/dashboard-nvim/lua/dashboard/theme/'..theme..'.lua'
                local source_content = vim.fn.readfile(custom_theme_src_path)
                vim.fn.writefile(source_content, custom_theme_dst_path)
            -- Указанного файла с кастомной темой нет => подключается стандартная hyper
            else
                theme = "hyper"
            end
        end
        --

        require('dashboard').setup {
            theme = theme,
            config = {
                header = headers[1],
            },
        }
    end,
    dependencies = {
        { dir = CFGP..'/deps/plugins/nvim-web-devicons' }
    }
}
