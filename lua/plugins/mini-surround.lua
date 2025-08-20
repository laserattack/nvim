-- Плагин позволяет обрамлять текст в парные символы

return {
    dir = '~/.config/nvim/deps/plugins/mini.surround',
    config = function ()
        require('mini.surround').setup()
    end
}
