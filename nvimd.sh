#!/usr/bin/env bash

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

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    n "$@"
fi
