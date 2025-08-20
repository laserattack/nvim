local headers = {
    {
        [[                (`.             ]],
        [[                 \ `.           ]],
        [[                  )  `._..---._ ]],
        [[\`.       __...---`         o  )]],
        [[ \ `._,--'           ,    ___,' ]],
        [[  ) ,-._          \  )   _,-'   ]],
        [[ /,'    ``--.._____\/--''       ]],
        [[                                ]],
    },
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
    dir = '~/.config/nvim/deps/plugins/dashboard-nvim',
    event = 'VimEnter',
    config = function()
        vim.api.nvim_set_hl(0, 'DashboardHeader', { fg = '#7fb4ca' })
        require('dashboard').setup {
            config = {
                header = headers[2],
                shortcut = {
                    { desc = "Wanna code?" }
                },
                mru = {
                    enable = true,
                    label = ""
                },
                project = {
                    enable = false,
                },
                footer = { "", "Do good stuff!" },
            },
        }
    end,
    dependencies = {
        { dir = '~/.config/nvim/deps/plugins/nvim-web-devicons' }
    }
}
