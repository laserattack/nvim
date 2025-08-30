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

```
xhost +local:docker >/dev/null 2>&1
nd() {
    if [ ! $# -eq 0 ]; then
        [[ -d "$1" ]] || [[ -f "$1" ]] || touch "$1"

        local target_path=$(realpath "$1")

        docker run -it --rm --name nvimd \
            -v /tmp/.X11-unix:/tmp/.X11-unix \
            -v ~/.config/nvim:/root/.config/nvim \
            -v $HOME:/VIRTUAL$HOME \
            -e DISPLAY=$DISPLAY \
            -w "/VIRTUAL$(dirname "$target_path")" \
            nvimd \
            nvim "/VIRTUAL$target_path"
    else
        local current_dir=$(pwd)
        
        docker run -it --rm --name nvimd \
            -v /tmp/.X11-unix:/tmp/.X11-unix \
            -v ~/.config/nvim:/root/.config/nvim \
            -v $HOME:/VIRTUAL$HOME \
            -e DISPLAY=$DISPLAY \
            -w "/VIRTUAL$current_dir" \
            nvimd \
            nvim
    fi
}
```

Далее сделать `source ~/.bashrc` и пользоваться nvim'ом через `nd <PATH>`

### Устройство конфига

- Все зависимости в папке `deps`, ничего не будет ни откуда скачиваться
- О том как добавить какой-нибудь Language Server написано в `lua/plugins/lsp.lua`
- О том как добавить парсер для какого-нибудь языка в tree-sitter (умная подсветка) написано в `lua/plugins/tree-sitter.lua`

### Версии софта в образе

- nvim: `0.11.3`
- xclip: `0.13`
- xkb-switch: `2.1.0`
- ripgrep: `14.1.0`
