#!/bin/bash
# Deploy these dotfiles to your setup.

if [[ $EUID -eq 1000 ]]; then
	sudo pacman -S base-devel fakeroot jshon expac git wget&&
	wget https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=packer &&
	mv PKGBUILD\?h\=packer PKGBUILD &&
	makepkg &&
	sudo pacman -U packer-*.pkg.tar.xz &&
    for package in $(cat depends.txt); do
        packer -S $package --noconfirm
    done
	echo "All done."
elif [[ $EUID -eq 0 ]]; then
	echo Do not run this script as root
fi
