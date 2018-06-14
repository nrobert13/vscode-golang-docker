#!/bin/sh

# Check script arguments
if [ "$#" -gt 1 ]; then
    echo "Illegal number of arguments."
    echo "Script expects one or no arguments. If an argument is given, it is used as a root path."
    exit
fi

ROOT_PATH=$HOME/vscode-golang-docker
if [ "$#" -eq 1 ]; then
    ROOT_PATH="$1"
fi

echo "Running vscode-golang-docker in $ROOT_PATH."

# Folder structure.
GO_PATH=$ROOT_PATH/go
VSCODE_PATH=$ROOT_PATH/.vscode
CONFIG_PATH=$ROOT_PATH/.config

mkdir "$ROOT_PATH" 2> /dev/null
mkdir "$GO_PATH" 2> /dev/null
mkdir "$GO_PATH"/src 2> /dev/null
mkdir "$VSCODE_PATH" 2> /dev/null
mkdir "$CONFIG_PATH" 2> /dev/null

# Run Docker Container.
docker run --network host --rm -it --name vscode-golang-docker --privileged --ipc host \
           -v "$GO_PATH":/home/docker/go \
           -v "$VSCODE_PATH":/home/docker/.vscode \
           -v "$CONFIG_PATH":/home/docker/.config/Code \
           -e DISPLAY="$DISPLAY" -v /tmp/.X11-unix:/tmp/.X11-unix -v "$HOME"/.Xauthority:/home/docker/.Xauthority \
           -u $(id -u $USER):$(id -g $USER) hvarga/vscode-golang-docker
