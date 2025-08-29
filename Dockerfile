FROM ubuntu:22.04

# Установка зависимостей
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    tar \
    git \
    xclip \
    ripgrep \
    build-essential \
    cmake \
    libx11-dev \
    libxkbfile-dev \
    && apt-get clean

RUN curl -LO https://github.com/neovim/neovim/releases/download/v0.11.3/nvim-linux-x86_64.tar.gz \
    && tar -xzf nvim-linux-x86_64.tar.gz -C /usr/local --strip-components=1 \
    && rm nvim-linux-x86_64.tar.gz

RUN curl -LO https://github.com/sergei-mironov/xkb-switch/archive/refs/tags/1.8.5.tar.gz \
    && tar -xzf 1.8.5.tar.gz \
    && rm 1.8.5.tar.gz

WORKDIR /xkb-switch-1.8.5

RUN mkdir build && cd build \
    && cmake .. \
    && make \
    && make install

RUN ldconfig

WORKDIR /
RUN rm -rf /xkb-switch-1.8.5
#

# Копирование конфига
COPY . /root/.config/nvim/
#

WORKDIR /workspace
