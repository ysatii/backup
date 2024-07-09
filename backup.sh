#!/bin/bash
if [[ $(rsync -ac --delete ~/ /tmp/backup --progress -v) ]]  ; then
        logger succsess backup script.sh
else
        logger error backup script.sh
fi
