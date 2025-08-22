-- Плагин позволяет обрамлять текст в парные символы

return {
    dir = CFGP..'/deps/plugins/mini.surround',
    config = function ()
        require('mini.surround').setup()
    end
}
