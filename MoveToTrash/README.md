# Move To Trash

A very simple tool for linux to replace `rm -rf`.

It will create 'Trash' directory on '~/.local/share/' automatically. Variable '$TRASH_PATH' used to set trash path.

You can create a symbolic link which named `rt`, and put it into '/usr/bin', then the commamd `rm -rf xxx` could be replace by `rt xxx`.