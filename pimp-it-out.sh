#!/bin/bash
#
# pimp-it-out.sh
#
# Tristan M. Chase
# Created: Fri Mar 16 01:14:07 EDT 2018
#
# Description: Customizes a fresh install with my preferred dotfiles and plugins.

clear
printf "%b\n" "$(basename "${0}")"
printf "%b\n" "Answer the questions that follow to customize your fresh install."
printf "%s " "Only the items answered with y or Y will be installed."
read

# Preserve current directory
_startdir="$(pwd)"

# Install basic packages
_basic_packages=(anacron aptitude byobu curl git htop ranger vim-gtk wget)
printf "%s " "Install basic packages ("${_basic_packages[@]}")?"
read _basic_packages_yN
function __basic_packages__ {
	sudo apt-get install "${_basic_packages[@]}"
}

# Vim Plugins
printf "%s " "Install vim plugins (pathogen vim-neatstatus vim-solarized)?"
read _vim_plugins_yN
function __vim_plugins__ {
	## pathogen
	mkdir -p ~/.vim/autoload ~/.vim/bundle && \
	curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

	## vim-neatstatus
	cd ~/.vim/bundle
	git clone https://github.com/tristanchase/vim-neatstatus.git

	## vim-solarized
	cd ~/.vim/bundle
	git clone https://github.com/tristanchase/vim-colors-solarized.git
}

# My devel scripts
_devel_scripts=(coapt loco gen-keys)
printf "%s " "Install coapt and loco?"
read _my_scripts_yN
function __my_scripts__ {
	for _script in "${_devel_scripts[@]}"; do
	    sh -c "$(curl -fsSL https://raw.githubusercontent.com/tristanchase/"${_script}"/main/install.sh)"
	done
}

# Dotfiles
printf "%s " "Install dotfiles?"
read _dotfiles_yN
function __dotfiles__ {
	    cd ${HOME}
	    git clone https://github.com/tristanchase/dotfiles.git
	    sh -c ${HOME}/dotfiles/makesymlinks.sh
	    mkdir -p ~/.vim/tmp
}

# zsh
printf "%s " "Install zsh?"
read _zsh_yN
function __zsh__ {
	sudo apt-get install zsh
	chsh -s /bin/zsh
}

# oh-my-zsh (depends on zsh)
if [[ "${_zsh_yN}" =~ (y|Y) ]]; then
	printf "%s " "Install oh-my-zsh?"
	read _oh_my_zsh_yN
else
	_oh_my_zsh_yN="n"
fi
function __oh_my_zsh__ {
	cd ${HOME}
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

## Printer drivers
printf "%s " "Install printer drivers?"
read _printer_drivers_yN
function __printer_drivers__ {
	sudo apt-get install cups
	_destdir="${HOME}/Downloads/brother"
	mkdir -p "${_destdir}" && cd "${_destdir}"
	curl -LSso linux-brprinter-installer https://raw.githubusercontent.com/tristanchase/printer-install/main/linux-brprinter-installer-2.1.1-1
	sudo bash linux-brprinter-installer MFC-J625DW
}

# Chrome
printf "%s " "Install Chrome?"
read _google_chrome_yN
function __google_chrome__ {
	set -o errexit
	_pimpdir="${HOME}/Downloads/pimp-dir"
	mkdir -p "${_pimpdir}"
	_destdir=${HOME}/Downloads/google-chrome
	mkdir -p "${_destdir}" && cd "${_destdir}"

	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo apt install ./google-chrome-stable_current_amd64.deb

	printf "%s " "Would you like google-chrome-stable to update in the background?"
	read _yN
	if [[ "${_yN}" =~ (y|Y) ]]; then
		cd "${_pimpdir}"
		wget https://raw.githubusercontent.com/tristanchase/pimp-it-out/main/install-helpers/zzz.sh
		wget https://raw.githubusercontent.com/tristanchase/pimp-it-out/main/install-helpers/zzz-google-chrome-upgrade
		mv zzz.sh zzz
		chmod 755 *
		rsync -avu zzz ${HOME}/bin
		sudo rsync -avu zzz-google-chrome-upgrade /etc/cron.daily
		_holddir="${HOME}/.local/share/coapt/hold"
		mkdir -p "${_holddir}" && printf "%b\n" "google-chrome-stable" >> "${_holddir}"/held-packages
		#mkdir -p "${_holddir}" && touch "${_holddir}"/google-chrome-stable
	fi

	rm -r "${_pimpdir}"
}

# Dropbox
printf "%s " "Install Dropbox?"
read _dropbox_yN
function __dropbox__ {
	printf "%b\n" "Dropbox install function under construction. Try again later. :P"
}

function __install__ {
	[[ "${_basic_packages_yN}" =~ (y|Y) ]] && __basic_packages__ || printf "%b\n" "Install basic packages: skipped"
	[[ "${_vim_plugins_yN}" =~ (y|Y) ]] && __vim_plugins__ || printf "%b\n" "Install vim plugins: skipped"
	[[ "${_my_scripts_yN}" =~ (y|Y) ]] && __my_scripts__ || printf "%b\n" "Install my scripts: skipped"
	[[ "${_dotfiles_yN}" =~ (y|Y) ]] && __dotfiles__ || printf "%b\n" "Install dotfiles: skipped"
	[[ "${_zsh_yN}" =~ (y|Y) ]] && __zsh__ || printf "%b\n" "Install zsh: skipped"
	[[ "${_oh_my_zsh_yN}" =~ (y|Y) ]] && __oh_my_zsh__ || printf "%b\n" "Install oh my zsh: skipped"
	[[ "${_printer_drivers_yN}" =~ (y|Y) ]] && __printer_drivers__ || printf "%b\n" "Install printer drivers: skipped"
	[[ "${_google_chrome_yN}" =~ (y|Y) ]] && __google_chrome__ || printf "%b\n" "Install Chrome: skipped"
	[[ "${_dropbox_yN}" =~ (y|Y) ]] && __dropbox__ || printf "%b\n" "Install Dropbox: skipped"
}

printf "%b\n"
printf "%s " "Ready to install? (y or Y to install; any other key to quit)"
read _install_yN
[[ "${_install_yN}" =~ (y|Y) ]] && __install__ || printf "%b\n" "Quitting..."

# Return to starting directory
cd "${_startdir}"

exit 0
