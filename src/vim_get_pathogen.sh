#!/bin/bash
echo "INFO: Fetching Pathogen"
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim &&\
echo "INFO: Cloning nerdtree"
git clone https://github.com/preservim/nerdtree.git ~/.vim/bundle/nerdtree &&\
echo "INFO: Add to ~/.vimrc:"
echo "call pathogen#infect()"
echo "call pathogen#helptags() \"If you like to get crazy"
