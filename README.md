# vscode-golang-docker

vscode-golang-docker is a Go development environment inside a Docker container. It consists of a Visual Studio Code and various extensions to help you write, build, test and debug Go application. It will also help you to write your own shell scripts, Dockerfile and Markdown by using linters and other support tools.

All this from the convinience of your IDE - Visual Studio Code.

## Pull

Docker image is available on Docker Hub:

```plain
docker pull hvarga/vscode-golang-docker
```

## Build

You can also build it yourself:

```plain
./scripts/build-vscode-golang-docker.sh
```

## Run

After pull or build (described above), run the following script initialize and to start the container:

```plain
./scripts/run-vscode-golang-docker.sh [PROJECT_PATH]
```

Note that you need to have the script somewhere on your system. If you don't have it, install it using following commands:

```plain
wget https://github.com/hvarga/vscode-golang-docker/raw/master/scripts/run-vscode-golang-docker.sh -O /tmp/run-vscode-golang-docker.sh
chmod +x /tmp/run-vscode-golang-docker.sh
sudo mv /tmp/run-vscode-golang-docker.sh /usr/local/bin
```

Run it using following:

```plain
run-vscode-golang-docker.sh [PROJECT_PATH]
```

The script `run-vscode-golang-docker.sh` accepts an optional argument called `PROJECT_PATH`. `PROJECT_PATH` is a folder in which the source code of your Go application will be stored. `PROJECT_PATH` will also contain Visual Studio Code configuration data.

If this is your first time that you start `run-vscode-golang-docker.sh` script, it will take a little while to initialize the `PROJECT_PATH`, so be patient.

By default if not specifed, `PROJECT_PATH` will be set to `$HOME/vscode-golang-docker`.

After the script `run-vscode-golang-docker.sh` is finally started, it will give you a shell from which you can run Visual Studio Code by running:

```plain
code
```

Happy coding!