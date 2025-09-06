#!/usr/bin/env bash

n() {
    local script_dir=$(dirname "$(realpath "$0")")
    
    if [[ "$1" == "--help" ]]; then
        echo "Usage:"
        echo "  <nvimd.sh path> [file/dir]    - Open file/directory in nvim"
        echo "  <nvimd.sh path> --install     - Build nvimd image"
        echo "  <nvimd.sh path> --uninstall   - Remove nvimd image"
        echo "  <nvimd.sh path> --help        - Show nvimd help"
        return 0
    fi

    if [[ "$1" == "--install" ]]; then
        echo "Building nvimd image..."
        docker build -t nvimd "$script_dir"
        docker builder prune -f
        return 0
    fi
    
    if [[ "$1" == "--uninstall" ]]; then
        echo "Removing nvimd image..."
        docker rmi nvimd
        docker builder prune -f
        return 0
    fi

    if ! docker image inspect nvimd &>/dev/null; then
        echo "Error: nvimd image not found!"
        echo "Run: $(realpath "$0") --install"
        return 1
    fi

    if [ ! $# -eq 0 ]; then
        [[ -d "$1" ]] || [[ -f "$1" ]] || touch "$1"
        local target_path=$(realpath "$1")
        local mount_dir=$(dirname "$target_path")

        docker run -it --rm \
            --hostname="$(hostname)" \
            --env "DISPLAY=$DISPLAY" \
            --volume "/tmp/.X11-unix:/tmp/.X11-unix:ro" \
            --volume "${XAUTHORITY:-${HOME}/.Xauthority}:/root/.Xauthority:ro" \
            --volume "$script_dir:/root/.config/nvim" \
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
            --volume "$script_dir:/root/.config/nvim" \
            --volume "$current_dir:/VIRTUAL$current_dir" \
            --workdir "/VIRTUAL$current_dir" \
            nvimd \
            nvim
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    n "$@"
fi
