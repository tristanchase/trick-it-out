#! /bin/bash
set -o errexit

_startdir="$(pwd)"

_destdir="${HOME}"/Downloads/google-chrome
mkdir -p "${_destdir}" && cd "${_destdir}"

#wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
#sudo apt install ./google-chrome-stable_current_amd64.deb

printf "%b\n" "Would you like google-chrome-stable to update in the background? (y/N)"
read _yN
if [[ "${_yN}" =~ (y|Y) ]]; then
	#rsync -avu
fi

cd "${_startdir}"
