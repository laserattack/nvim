# Сборка и запуск
## docker build -t neovim:v0.11.3 .
## docker run -d -it -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY neovim:v0.11.3

# Для корректной работы xlip на хосте также сделать
## xhost +local:docker

FROM ubuntu:22.04

# Установка nvim
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    tar \
    git \
    xclip \
    ripgrep \
    && apt-get clean

RUN curl -LO https://github.com/neovim/neovim/releases/download/v0.11.3/nvim-linux-x86_64.tar.gz \
    && tar -xzf nvim-linux-x86_64.tar.gz -C /usr/local --strip-components=1 \
    && rm nvim-linux-x86_64.tar.gz
#

# Установка конфига
COPY . /root/.config/nvim/
#

WORKDIR /workspace
