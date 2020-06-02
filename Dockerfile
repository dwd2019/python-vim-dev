FROM ubuntu:rolling
ARG DEBIAN_FRONTEND=noninteractive

# house cleaning
RUN apt update

# install software
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata
RUN apt install -y neovim python3-pynvim build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev python-openssl git sudo

# environment
ENV gitdir /opt/git
RUN mkdir -p ${gitdir}

# rust devel, rust is cool
WORKDIR ${gitdir}
RUN date && pwd && ls -l ${gitdir}
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH "${PATH}:${HOME}/.cargo/bin"
# RUN source $HOME/.cargo/env
### RUN $HOME/.cargo/bin/rustup override set 1.39.0

# new shell!
RUN git clone https://gitlab.redox-os.org/redox-os/ion/
RUN pwd && ls -ltrac
WORKDIR ${gitdir}/ion
RUN pwd && ls -ltrac
RUN RUSTUP=0 make
RUN make install prefix=/usr
RUN make update-shells prefix=/usr
RUN curl -fsSL https://starship.rs/install.sh | bash
RUN echo 'eval $(starship init ion)' >> ~/.config/ion/initrc

# use curl and linuxbrew to install pyenv and pipenv
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
RUN brew install pipenv
RUN curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash


# install onivim if you dare

# ENTRYPOINT # non yet
ENTRYPOINT = /usr/bin/ion

