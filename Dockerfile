FROM ubuntu:16.04

# Author and Docker Image information.
LABEL maintainer="hrvoje.varga@gmail.com"
LABEL build="./scripts/build-vscode-golang-docker.sh"
LABEL run="./scripts/run-vscode-golang-docker.sh"

# Install necessary packages.
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    curl ca-certificates git libgtk2.0 libgconf-2-4 libnss3 libxtst6 \
    libcanberra-gtk-module libgl1-mesa-glx libxss1 sudo firefox xdg-utils

# Create user.
RUN addgroup --gid 1000 docker && \
    adduser --uid 1000 --ingroup docker --home /home/docker --shell /bin/bash --disabled-password --gecos "" docker && \
    usermod -a -G sudo docker && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Install Visual Studio Code.
RUN curl -L https://go.microsoft.com/fwlink/?LinkID=760868 -o /tmp/vscode.deb && \
    apt install -y /tmp/vscode.deb && \
    rm -f /tmp/vscode.deb

COPY files/vscode-config.json /tmp/vscode-config.json

# Remove cached packages.
RUN rm -rf /var/lib/apt/lists/*

# Install Go.
RUN curl -s https://dl.google.com/go/go1.10.3.linux-amd64.tar.gz | tar -v -C /usr/local -xz
ENV PATH $PATH:/usr/local/go/bin
RUN mkdir -p /home/docker/go/src && \
    chown -R docker:docker /home/docker/go
ENV GOPATH /home/docker/go
ENV PATH="/home/docker/go/bin:${PATH}"

# Install fixuid.
RUN curl -SsL https://github.com/boxboat/fixuid/releases/download/v0.4/fixuid-0.4-linux-amd64.tar.gz | tar -C /usr/local/bin -xzf - && \
    chown root:root /usr/local/bin/fixuid && \
    chmod 4755 /usr/local/bin/fixuid && \
    mkdir -p /etc/fixuid
COPY files/fixuid-config.yml /etc/fixuid/config.yml

# Install ShellCheck.
RUN curl -SsL https://storage.googleapis.com/shellcheck/shellcheck-latest.linux.x86_64.tar.xz -o /tmp/shellcheck-latest.linux.x86_64.tar.xz && \
    tar xvf /tmp/shellcheck-latest.linux.x86_64.tar.xz -C /tmp && \
    cp /tmp/shellcheck-latest/shellcheck /usr/local/bin/shellcheck && \
    rm -rf /tmp/shellcheck-latest.linux.x86_64.tar.xz && \
    rm -rf /tmp/shellcheck-latest

# Switch user.
USER docker:docker

# Set working directory.
WORKDIR /home/docker/go/src

# Fix user permissions.
ENTRYPOINT ["fixuid"]

# Initialize environment and start shell.
COPY files/initialize_environment.sh /usr/local/bin
CMD initialize_environment.sh;bash
