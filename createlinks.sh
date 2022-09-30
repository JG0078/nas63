#!/bin/bash

walk_dir () {
  shopt -s nullglob dotglob
  for pathname in "$1"/*; do
    if [ -d "$pathname" ]; then
      walk_dir "$pathname"
    else
      case "$pathname" in
        *.mkv|*.avi|*.mpg)
          printf '%s\n' "$pathname"
          filename1=$(basename "$pathname")
          printf '%s\n' "$filename1"

          duplicate=$(find /plex/library/tv -type f -name "$filename1" | wc -l)
          echo $duplicate
          if [ $duplicate == 1 ]; then
            echo "Do Something with the duplicate here"
            filename2=$(find /plex/library/tv -type f -name "$filename1")
            echo "Main file $filename2"
            echo "Duplicate file $pathname"

            if [[ ! -L "$pathname" ]]; then
              # Check the file is exists or not
              if [ -f "$pathname" ] ; then
                rm "$pathname"
              fi
              echo "$pathname is removed"
              ln -s "$filename2" "$pathname"
            fi
          fi
        ;;
      *.png|*.nfo)
      ;;
      *)
        echo "File Extension: ${pathname##*.}"
        #echo "some other extension"
      ;;
      esac
    fi
  done
}

DOWNLOADING_DIR=/plex/library/downloads
walk_dir "$DOWNLOADING_DIR"
