# Мой конфиг neovim

- Шрифтом терминала надо поставить `JetBrainsMono Nerd Font Regular` ([ссылочка](https://www.nerdfonts.com/font-downloads))
- Репозиторий склонировать в `~/.config`, должна появиться папка `~/.config/nvim`
- Все зависимости в папке `deps`, ничего не будет ни откуда скачиваться
- О том как добавить какой-нибудь Language Server написано в `lua/plugins/lsp.lua`
- О том как добавить парсер для какого-нибудь языка в tree-sitter (умная подсветка) написано в `lua/plugins/tree-sitter.lua`

### Что должно быть в системе чтобы это работало

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
