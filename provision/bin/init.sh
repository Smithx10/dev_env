#!/usr/bin/env bash
OS=$(uname)
APPS=(
    'curl'
    'git' 
    'tmux'
    'vim'
    )
REPOS=(
    'https://github.com/pangloss/vim-javascript'
    'https://github.com/hashivim/vim-hashicorp-tools'
    'https://github.com/fatih/vim-go'
    'https://github.com/google/vim-glaive'
    'https://github.com/leafgarland/typescript-vim'
    'https://github.com/google/vim-codefmt'
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
    '/.vim'
    '/.vim/bundle'
    '/.vim/autoload'
    '/.vim/colors'
    )

install_vimrc() {
    cd ${HOME}
    echo "cloning Smithx10/dotfiles"
    git clone https://github.com/Smithx10/dotfiles
    echo "copying vimrc"
    cp ./dotfiles/.vimrc ${HOME}/.vimrc
    echo "copying theme"
    cp ./dotfiles/onedark.vim ${HOME}/.vim/colors/onedark.vim
}

compile_YCM() {
    cd ${HOME}/.vim/bundle/YouCompleteMe
    git submodule update --init --recursive
    ./install.py --all
}


install_YCM_Prereqs() {
    # This could def use community support
    if [ -x "$(command -v apt-get)" ]; then
        curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
        sudo apt-get install -y build-essential \
                                cmake \
                                nodejs \
                                python-dev \
                                python3-dev

    elif [ -x "$(command -v brew)" ]; then
        echo "placeholder for brew deps"

    elif [ -x "$(command -v pkg)" ]; then
        echo "placeholder for pkg deps"

    elif [ -x "$(command -v pacman)" ]; then
        echo "placeholder for pacman deps"
    else
        echo "I'm not sure what your package manager is! Please install $1 on your own and run this deploy script again. Tests for package managers are in the deploy script you just ran starting at line 13. Feel free to make a pull request at https://github.com/parth/dotfiles :)" 
    fi 
}

install_app() {
    # This could def use community support
    if [ -x "$(command -v apt-get)" ]; then
            sudo apt-get update && sudo apt-get install $1 -y

    elif [ -x "$(command -v brew)" ]; then
            brew install $1

    elif [ -x "$(command -v pkg)" ]; then
            sudo pkg install $1

    elif [ -x "$(command -v pacman)" ]; then
            sudo pacman -S $1
    else
        echo "I'm not sure what your package manager is! Please install $1 on your own and run this deploy script again. Tests for package managers are in the deploy script you just ran starting at line 13. Feel free to make a pull request at https://github.com/parth/dotfiles :)" 
    fi 
}

install_pathogen() {
    if [[ -e ${HOME}/.vim/autoload/pathogen.vim ]]; then
        echo "pathogen.vim already exists"
    else
        echo "Creating ${HOME}/.vim/autoload and curling pathogen.vim there"
        mkdir -p ~/.vim/autoload \
        && curl -LSso ${HOME}/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
    fi
}

check_for_apps() {
    for APP in "${APPS[@]}"; do
        echo "Checking to see if $APP is installed"
        if ! [ -x "$(command -v $APP)" ]; then
            install_app $APP
        else
            echo "$APP is installed."
        fi
    done
}

check_for_repos() {
    for REPO in "${REPOS[@]}"; do
        REPODIR=$(echo $REPO | rev | cut -d\/ -f1 | rev)
        if [[ ! -d ${HOME}/.vim/bundle/${REPODIR} ]]; then
            echo "git cloning the repos into bundle"
            git clone $REPO ${HOME}/.vim/bundle/${REPODIR}
        else 
            echo "${HOME}/.vim/bundle/${REPODIR} already exists"
        fi
    done
}

check_for_dirs() {
    for DIR in  "${DIRS[@]}"; do
        if [[ ! -d ${HOME}${DIR} ]]; then
            echo "Creating the Directory ${HOME}${DIR}"
            mkdir -p ${HOME}${DIR}
        else
            echo "${HOME}${DIR} already exists"
        fi
    done
}

main() {
    check_for_apps \
    && install_pathogen \
    && check_for_dirs \
    && check_for_repos \
    && install_YCM_Prereqs \
    && compile_YCM \
    && install_vimrc
}

main

