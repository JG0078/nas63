#!/bin/bash

walk_dir () {
    shopt -s nullglob dotglob

    for pathname in "$1"/*; do
        if [ -d "$pathname" ]; then
            walk_dir "$pathname"
        else
            case "$pathname" in
                *.mkv|*.avi)
                    printf '%s\n' "$pathname"
                    filename1=$(basename "$pathname")
                    printf '%s\n' "$filename1"

                    duplicate=$(find /plex/library/tv -type f -name "$filename1" | wc -l)
                    echo $duplicate
                    if [ $duplicate == 1 ]; then
                      echo "Do Something with the duplicate here"
                      filename2=$(find /plex/library/tv -type f -name "$filename1")
                      echo "Main file $filename2"
   
                      $(mv $pathname newnamefile)
                      echo "The file is renamed."
                    fi
            esac
        fi
    done
}

DOWNLOADING_DIR=/plex/library/downloads
walk_dir "$DOWNLOADING_DIR"
