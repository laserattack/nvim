# Мой конфиг neovim

## Работа через Docker

### Зависимости

- Шрифтом терминала надо поставить `JetBrainsMono Nerd Font Regular` ([ссылочка](https://www.nerdfonts.com/font-downloads))
- Система должна быть `X Window System`
- Docker
- Интернет-соединение

### Установка

Создание докер-контейнера с рабочим neovim и конфигом

```
xhost +local:docker
docker build -t nvimd .
docker builder prune -f
```
### Удаление 

```
docker rmi nvimd
docker builder prune -f
```

### Работа в nvim через docker (рекомендуется)

Надо добавить функцию `nd` (neovim docker) в `~/.bashrc`

```
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

## Работа с основной системы

- Система должна быть `X Window System`
- Шрифтом терминала надо поставить `JetBrainsMono Nerd Font Regular` ([ссылочка](https://www.nerdfonts.com/font-downloads))
- Репозиторий склонировать в `~/.config`, должна появиться папка `~/.config/nvim`
- Все зависимости в папке `deps`, ничего не будет ни откуда скачиваться
- О том как добавить какой-нибудь Language Server написано в `lua/plugins/lsp.lua`
- О том как добавить парсер для какого-нибудь языка в tree-sitter (умная подсветка) написано в `lua/plugins/tree-sitter.lua`

#### Утилита типо `xclip` (интерфейс командной строки к буферу обмена X) (есть в apt) 

Чтобы nvim мог взаимодействовать с системным буффером обмена

#### Утилита `ripgrep` (grep на максималках) (есть в apt)

Чтобы работал плагин `telescope` (умный поиск)

#### Утилита `xkb-switch` (можно скачать из релизов в этом репо)

Используется утилита [xkb-switch](https://github.com/sergei-mironov/xkb-switch) для автоматического переключения системной раскладки на `us` при выходе из режима вставки

Если в системе этой штуки нет или она не доступна через `xkb-switch` в терминале, то автоматического переключения не будет

Сборка  

```bash
mkdir build && cd build
cmake ..
make
```

Для успешной сборки `xkb-switch` должны быть установлены также пакеты `libx11-dev`, `libxkbfile-dev`

### Мои версии 

#### nvim

```
→ nvim --version
NVIM v0.11.3
```

#### xclip

```
→ xclip -version
xclip version 0.13
```

#### xkb-switch

```
→ xkb-switch --version
xkb-switch 2.1.0
```

#### rigrep

```
→ rg --version
ripgrep 14.1.0
```
