FROM ubuntu:rolling

# house cleaning
RUN sudo apt update

# install software
RUN sudo apt install curl neovim vim-python3

# use curl to install pyenv

# install onivim if you dare

# ENTRYPOINT # non yet

