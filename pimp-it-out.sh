#!/bin/bash
#
# pimp-it-out.sh
#
# Tristan M. Chase
# Created: Fri Mar 16 01:14:07 EDT 2018
#
# Description: Customizes your fresh install with your preferred dotfiles and plugins.

# Install basic packages
sudo apt-get install aptitude byobu git htop ranger vim-gtk wget zsh

# Vim Plugins
## pathogen
    mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

## vim-neatstatus
    cd ~/.vim/bundle
    git clone git://github.com/maciakl/vim-neatstatus.git

## vim-solarized
    cd ~/.vim/bundle
    git clone git://github.com/altercation/vim-colors-solarized.git

## Create tmp for swapfiles
    mkdir -p ~/.vim/tmp

## .vimrc (in Dotfiles section below)

# oh-my-zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    echo "You may have to switch to zsh or something (chsh -s /bin/zsh).  See the post-pimp-out.txt file for details."

# Dotfiles
    cd ~
    git clone git://github.com/tristanchase/dotfiles.git
    sh -c ~/dotfiles/makesymlinks.sh

# Dropbox

# Chrome

# My devel scripts
## coapt
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/tristanchase/coapt/master/coapt_install.sh)"

## loco
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/tristanchase/loco/master/loco_install.sh)"

# Printer drivers
     

# Other packages (some of these are quite large)


