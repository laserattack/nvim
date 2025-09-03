# Моё рабочее окружение neovim

Я пользуюсь nvim через docker, чтобы не устанавливать ничего лишнего в систему

### Зависимости

- Шрифтом терминала надо поставить `JetBrainsMono Nerd Font Regular` ([ссылочка](https://www.nerdfonts.com/font-downloads))
- Система должна быть `X Window System`
- Docker
- Интернет-соединение

### Установка

Репозиторий склонировать в `~/.config`, должна появиться папка `~/.config/nvim`
Сделать `nvimd.sh` исполняемым

### Работа в nvim через docker

```
Usage:
  <nvimd.sh path> [file/dir]    - Open file/directory in nvim
  <nvimd.sh path> --install     - Build nvimd image
  <nvimd.sh path> --uninstall   - Remove nvimd image
  <nvimd.sh path> --help        - Show nvimd help
```

### Устройство конфига

- Все зависимости в папке `deps`, ничего не будет ни откуда скачиваться
- О том как добавить какой-нибудь Language Server написано в `lua/plugins/lsp.lua`
- О том как добавить парсер для какого-нибудь языка в tree-sitter (умная подсветка) написано в `lua/plugins/tree-sitter.lua`
- Если tree-sitter парсера для языка нет, то можно добавить обычный файл подсветки в `deps/syntax` и подключить ее в произвольный файл вставив первой строкой modeline типо `; vim: set filetype=fasm :` например подключит подсветку `deps/syntax/fasm.vim` для fasm файла

### Софт в образе 

- nvim
- xclip
- xkb-switch
- ripgrep

### Информация о системе в образе

```
Linux home 6.8.0-71-generic #71-Ubuntu SMP PREEMPT_DYNAMIC Tue Jul 22 16:52:38 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
```

### Бэкап образа

- Сохранение образа на диск `docker save -o nvimd.tar nvimd`
- Загрузка образа с диска `docker load -i nvimd.tar`

Имея репозиторий с конфигом и докер-образ, можно даже без интернета на любой `X Window System` с докером поднять свое рабочее окружение neovim 
