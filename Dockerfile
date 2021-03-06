FROM base/devel

ARG ONPREMISE_HTTP_PROXY
ARG USERNAME

ENV TMP_BIN=/tmp/provision/bin
ENV TMP_ETC=/tmp/provision/etc
ENV ONPREMISE_HTTP_PROXY=${ONPREMISE_HTTP_PROXY}
ENV ONPREMISE_HTTPS_PROXY=${ONPREMISE_HTTP_PROXY}
ENV USERNAME=${USERNAME}
ENV https_proxy=${ONPREMISE_HTTP_PROXY}

COPY ./provision /tmp/provision

RUN ${TMP_BIN}/configure_locale.sh

RUN pacman -Sy --noconfirm \
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
            cmake \
    && pip install \
            neovim \
            httpie

RUN chmod +x ${TMP_BIN}/* \
        && for i in ${TMP_BIN}/*_install.sh; do echo "Running ${i} ..." && $i; done \
        && zsh ${TMP_BIN}/configure_prezto.sh \
        && cp ${TMP_ETC}/zshrc ${HOME}/.zshrc \
        && cp ${TMP_ETC}/zpreztorc ${HOME}/.zpreztorc \
        && cp ${TMP_ETC}/aliases ${HOME}/.aliases

RUN su ${USERNAME} -c 'yaourt -Sy --m-arg --skippgpcheck --noconfirm \
            powershell-bin \
            nvm \
            ncurses5-compat-libs'

RUN pwsh ${TMP_BIN}/powercli_install.ps
