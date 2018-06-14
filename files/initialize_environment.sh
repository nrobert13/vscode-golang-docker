#!/bin/bash

# Check to see if there is a need to install Visual Studio Code extensions,
if [ ! -d $HOME/.vscode/extensions ]; then
    echo "Installing default Visual Studio Code extensions."

    echo "Install vscode-docker"
    code --install-extension PeterJausovec.vscode-docker

    echo "Install vscode-go"
    code --install-extension ms-vscode.Go
    go get -u -v github.com/ramya-rao-a/go-outline
    go get -u -v github.com/acroca/go-symbols
    go get -u -v github.com/mdempsky/gocode
    go get -u -v github.com/rogpeppe/godef
    go get -u -v golang.org/x/tools/cmd/godoc
    go get -u -v github.com/zmb3/gogetdoc
    go get -u -v github.com/golang/lint/golint
    go get -u -v github.com/fatih/gomodifytags
    go get -u -v golang.org/x/tools/cmd/gorename
    go get -u -v sourcegraph.com/sqs/goreturns
    go get -u -v golang.org/x/tools/cmd/goimports
    go get -u -v github.com/cweill/gotests/...
    go get -u -v golang.org/x/tools/cmd/guru
    go get -u -v github.com/josharian/impl
    go get -u -v github.com/haya14busa/goplay/cmd/goplay
    go get -u -v github.com/uudashr/gopkgs/cmd/gopkgs
    go get -u -v github.com/davidrjenni/reftools/cmd/fillstruct
    go get -u -v github.com/alecthomas/gometalinter
    gometalinter --install
    go get -u -v github.com/derekparker/delve/cmd/dlv

    echo "Install vscode-markdown"
    code --install-extension yzhang.markdown-all-in-one

    echo "Install vscode-gitlens"
    code --install-extension eamodio.gitlens

    echo "Install vscode-favorite-items"
    code --install-extension kdcro101.favorites

    echo "Install vscode-shellcheck"
    code --install-extension timonwong.shellcheck

    echo "Install vscode-trailingspaces"
    code --install-extension shardulm94.trailing-spaces

    echo "Install vscode-icons"
    code --install-extension robertohuertasm.vscode-icons

    echo "Install Bracket Pair Colorizer"
    code --install-extension CoenraadS.bracket-pair-colorizer

    echo "Install Bookmarks"
    code --install-extension alefragnani.Bookmarks

    echo "Install Code Spell Checker"
    code --install-extension streetsidesoftware.code-spell-checker

    echo "Install markdownlint"
    code --install-extension DavidAnson.vscode-markdownlint

    echo "Install Text Marker"
    code --install-extension ryu1kn.text-marker
fi

# Check to see if the Visual Studio Code configuration file exists.
if [ ! -f $HOME/.config/Code/User/settings.json ]; then
    echo "Installing default Visual Studio Code configuration file."
	mkdir -p $HOME/.config/Code/User
	cp /tmp/vscode-config.json $HOME/.config/Code/User/settings.json
fi