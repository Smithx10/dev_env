#!/bin/bash

set -eo pipefail

PROVISION_DIR=/tmp/provision
BIN_DIR=${PROVISION_DIR}/bin
ETC_DIR=${PROVISION_DIR}/etc
NVIM_DIR=~/.config/nvim
source ${PROVISION_DIR}/bin/set_proxy.sh

REPOS=(
    'https://github.com/pangloss/vim-javascript'
    'https://github.com/hashivim/vim-hashicorp-tools'
    'https://github.com/fatih/vim-go'
    'https://github.com/google/vim-glaive'
    'https://github.com/leafgarland/typescript-vim'
    'https://github.com/google/vim-codefmt'
    'https://github.com/google/vim-maktaba'
    'https://github.com/gutenye/json5.vim'
    'https://github.com/kien/ctrlp.vim'
    'https://github.com/Raimondi/delimitMate'
    'https://github.com/Yggdroot/indentLine'
    'https://github.com/scrooloose/nerdcommenter'
    'https://github.com/ternjs/tern_for_vim'
    'https://github.com/tomtom/tlib_vim'
    'https://github.com/SirVer/ultisnips'
    'https://github.com/vim-airline/vim-airline'
    'https://github.com/honza/vim-snippets'
    'https://github.com/Valloric/YouCompleteMe'
)
DIRS=(
    '/.config/nvim'
    '/.config/nvim/bundle'
    '/.config/nvim/autoload'
    '/.config/nvim/colors'
)

installPlugins() {
    for REPO in "${REPOS[@]}"; do
        REPODIR=$(echo $REPO | rev | cut -d\/ -f1 | rev)
        if [[ ! -d ${HOME}/.config/nvim/bundle/${REPODIR} ]]; then
            echo "git cloning the repos into bundle"
            git clone $REPO ${HOME}/.config/nvim/bundle/${REPODIR}
        else
            echo "${HOME}/.config/nvim/bundle/${REPODIR} already exists"
        fi
    done
}

compileYcm() {
    cd ${NVIM_DIR}/bundle/YouCompleteMe
    git submodule update --init --recursive
    ./install.py --clang-completer --go-completer --js-completer
}

installTern() {
    cd ${NVIM_DIR}/bundle/tern_for_vim
    npm install
}


installPathogen() {
    if [[ -e ${HOME}/.config/nvim/autoload/pathogen.vim ]]; then
        echo "pathogen.vim already exists"
    else
        echo "Creating ${HOME}/.config/nvim/autoload and curling pathogen.vim there"
        mkdir -p ~/.config/nvim/autoload \
        && curl -LSso ${HOME}/.config/nvim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
    fi
}

makeDirectories() {
    for DIR in  "${DIRS[@]}"; do
        if [[ ! -d ${HOME}${DIR} ]]; then
            echo "Creating the Directory ${HOME}${DIR}"
            mkdir -p ${HOME}${DIR}
        else
            echo "${HOME}${DIR} already exists"
        fi
    done
}

goGet() {
    go get golang.org/x/tools/cmd/guru
}

copyEtc() {
    cp ${ETC_DIR}/colors/* ${NVIM_DIR}/colors
    cp ${ETC_DIR}/autoload/* ${NVIM_DIR}/autoload
    cp ${ETC_DIR}/init.vim ${NVIM_DIR}
    cp ${ETC_DIR}/tmux.conf ~/.tmux.conf
    cp ${ETC_DIR}/tern-config ~/.tern-config
    cp ${ETC_DIR}/terraform.snippets ${NVIM_DIR}/bundle/vim-snippets/UltiSnips
}

main() {
    installPathogen \
    && makeDirectories \
    && installPlugins \
    && copyEtc \
    && compileYcm \
    && installTern \
    && goGet
}
main
