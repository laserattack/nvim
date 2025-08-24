-- Глобальная переменная с путем до конфига
CFGP = vim.fn.stdpath('config')
-- Подгружает настройки nvim`a
require("settings")
-- Подгружает бинды
require("keymap")
-- Подгружает плагины и их настройки
require("plugins/init")
