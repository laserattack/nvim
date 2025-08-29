# docker build -t neovim:v0.11.3 .

FROM ubuntu:22.04

# Установка nvim
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    tar \
    git \
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
