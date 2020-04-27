#!/bin/bash
#
# pimp-it-out.sh
#
# Tristan M. Chase
# Created: Fri Mar 16 01:14:07 EDT 2018
#
# Description: Customizes my fresh install with my preferred dotfiles and plugins.

# Install basic packages
sudo apt-get install aptitude byobu curl git htop ranger vim-gtk wget

# Vim Plugins
## pathogen
    mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

## vim-neatstatus
    cd ~/.vim/bundle
    git clone https://github.com/tristanchase/vim-neatstatus.git

## vim-solarized
    cd ~/.vim/bundle
    git clone https://github.com/tristanchase/vim-colors-solarized.git
    
## Create tmp for swapfiles
    mkdir -p ~/.vim/tmp

## .vimrc (in Dotfiles section below)

# My devel scripts
## coapt
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/tristanchase/coapt/master/coapt_install.sh)"

## loco
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/tristanchase/loco/master/loco_install.sh)"

# Dotfiles
    cd ~
    git clone https://github.com/tristanchase/dotfiles.git
    sh -c ~/dotfiles/makesymlinks.sh

# zsh
echo "Would you like to install zsh (y/N)?"
read answer
case $answer in
	y|Y)
		sudo apt-get install zsh
		# oh-my-zsh
		echo "Would you like to install oh-my-zsh (y/N)?"
		read response
		case $response in
			y|Y)
				cd ~
				sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
				#echo "You may have to switch to zsh or something (chsh -s /bin/zsh).  See the post-pimp-out.txt file for details."
				;;
			*)
				;;
		esac
	*)
		;;
esac

# Dropbox

# Chrome

# This is dangerous; it leaves the user logged in as root!
## Printer drivers
#    cd ~/Downloads
#    curl -LSso linux-brprinter-installer https://raw.githubusercontent.com/tristanchase/printer-install/master/linux-brprinter-installer-2.1.1-1
#    sudo su
#    bash linux-brprinter-installer MFC-J625DW


# Other packages (some of these are quite large)

exit 0
