
Debian
====================
This directory contains files used to package trawd/traw-qt
for Debian-based Linux systems. If you compile trawd/traw-qt yourself, there are some useful files here.

## traw: URI support ##


traw-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install traw-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your sendqt binary to `/usr/bin`
and the `../../share/pixmaps/send128.png` to `/usr/share/pixmaps`

traw-qt.protocol (KDE)

