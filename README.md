# Моё рабочее окружение neovim

Я пользуюсь nvim через docker, чтобы не устанавливать ничего лишнего в систему

### Зависимости

- Шрифтом терминала надо поставить `JetBrainsMono Nerd Font Regular` ([ссылочка](https://www.nerdfonts.com/font-downloads))
- Система должна быть `X Window System`
- Docker
- Интернет-соединение

### Установка

Репозиторий склонировать в `~/.config`, должна появиться папка `~/.config/nvim`

Далее из `~/.config/nvim` выполнить

```
docker build -t nvimd .
docker builder prune -f
```

### Удаление 

```
docker rmi nvimd
docker builder prune -f
```

### Работа в nvim через docker

Надо добавить код ниже в `~/.bashrc`

```bash
n() {
    if [ ! $# -eq 0 ]; then
        [[ -d "$1" ]] || [[ -f "$1" ]] || touch "$1"
        local target_path=$(realpath "$1")
        local mount_dir=$(dirname "$target_path")

        docker run -it --rm \
            --hostname="$(hostname)" \
            --env "DISPLAY=$DISPLAY" \
            --volume "/tmp/.X11-unix:/tmp/.X11-unix:ro" \
            --volume "${XAUTHORITY:-${HOME}/.Xauthority}:/root/.Xauthority:ro" \
            --volume "${HOME}/.config/nvim:/root/.config/nvim" \
            --volume "$mount_dir:/VIRTUAL$mount_dir" \
            --workdir "/VIRTUAL$mount_dir" \
            nvimd \
            nvim "/VIRTUAL$target_path"
    else
        local current_dir=$(pwd)
        
        docker run -it --rm \
            --hostname="$(hostname)" \
            --env "DISPLAY=$DISPLAY" \
            --volume "/tmp/.X11-unix:/tmp/.X11-unix:ro" \
            --volume "${XAUTHORITY:-${HOME}/.Xauthority}:/root/.Xauthority:ro" \
            --volume "${HOME}/.config/nvim:/root/.config/nvim" \
            --volume "$current_dir:/VIRTUAL$current_dir" \
            --workdir "/VIRTUAL$current_dir" \
            nvimd \
            nvim
    fi
}
```

В докер всегда будет монтироваться конфиг из `~/.config/nvim` и директория открываемого объекта

Далее сделать `source ~/.bashrc` и пользоваться nvim'ом через `n <PATH>`

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

### Бэкап образа

- Сохранение образа на диск `docker save -o nvimd.tar nvimd`
- Загрузка образа с диска `docker load -i nvimd.tar`

Имея репозиторий с конфигом и докер-образ, можно даже без интернета на любой `X Window System` с докером поднять свое рабочее окружение neovim 
