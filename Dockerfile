FROM base/archlinux

ARG ONPREMISE_HTTP_PROXY
ARG USERNAME

ENV TMP_BIN=/tmp/provision/bin
ENV TMP_ETC=/tmp/provision/etc
ENV ONPREMISE_HTTP_PROXY=${ONPREMISE_HTTP_PROXY}
ENV ONPREMISE_HTTPS_PROXY=${ONPREMISE_HTTP_PROXY}
ENV USERNAME=${USERNAME}
ENV https_proxy=${ONPREMISE_HTTP_PROXY}

RUN pacman -Sy --noconfirm \
            base-devel \
            unzip \
            git \
            zsh \
            neovim \
            openssh \
            tmux \
            go \
            yajl \
            aws-cli \
            bind-tools \
            python \
            python-pip \
            openssl-1.0 \
            nodejs \
            npm \
            yarn \
            cmake


COPY ./provision /tmp/provision

RUN chmod +x ${TMP_BIN}/* \
        && for i in ${TMP_BIN}/*_install.sh; do $i; done \
        && zsh ${TMP_BIN}/configure_prezto.sh \
        && cp ${TMP_ETC}/zshrc ${HOME}/.zshrc \
        && cp ${TMP_ETC}/zprestorc ${HOME}/.zprestorc

RUN su ${USERNAME} -c 'yaourt -Sy --noconfirm \
            powershell-bin \
            nvm'

RUN pwsh ${TMP_BIN}/powercli_install.ps
