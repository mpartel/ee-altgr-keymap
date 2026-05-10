This repository contains a keymap for US keyboards that enables the following:

    AltGr+A -> ä
    AltGr+O -> ö
    AltGr+U -> ü
    AltGr+] -> õ
    AltGr+S -> š
    (plus the capitalized versions)

## X11 / Wayland installation

Run `./install.sh` (no sudo). It installs the symbols files to `~/.config/xkb/symbols/` and writes a small `~/.config/xkb/rules/evdev.xml` so the layouts show up in the GNOME / KDE layout selectors.

After logging out and back in, you can either pick the layouts from the desktop's keyboard settings, or run `setxkbmap ee_altgr`.

There's also layout `ee_uk_altgr` for UK keyboards.

## Windows installation

Use the Microsoft Keyboard Layout Creator to compile the klc file or [download the compiled package](http://goo.gl/h7jTOJ).

