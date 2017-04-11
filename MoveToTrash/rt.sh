#!/bin/bash

TRASH_PATH=~/.local/share/Trash
DEBUG=no

if [ ! -d $TRASH_PATH/files ]; then
    mkdir -p $TRASH_PATH/files
fi
if [ ! -d $TRASH_PATH/info ]; then
    mkdir -p $TRASH_PATH/info
fi

for i in "$@"; do
    if [[ $i =~ ^/ ]]; then
        trash=$i
    else
        trash=`pwd`/$i
    fi

    trash=$(echo $trash | sed "s/\/*$//")
    f_name=$(echo $trash | sed "s/\/.*\///")

    [ $DEBUG == "yes" ] && echo $trash
    [ $DEBUG == "yes" ] && echo $f_name
    if [ ! -e "$trash" ]; then
        echo -e "Error : "$trash
        echo -e "        \e[1;31mFile or Directory does not exists !\e[0m"
        continue
    fi
    echo "Move to Trash : "$trash


    if [ -e "$TRASH_PATH/files/$f_name" ]; then
        num=$[ $(ls -a "$TRASH_PATH/files" | grep ^"$f_name" | wc -l) + 1 ]
        f_name=$f_name.$num
        [ $DEBUG == "yes" ] && echo $f_name
    fi

    mv "$trash" "$TRASH_PATH/files/$f_name"
    echo -e "[Trash Info]\nPath=$trash\nDeletionDate="`date +%Y-%m-%dT%H:%M:%S` > "$TRASH_PATH/info/$f_name.trashinfo"
    
done

echo "Finished !"