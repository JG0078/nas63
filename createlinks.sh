#!/bin/bash
# This file can be setup in the cron to keep duplicates off of the system

unlinkDup () {
  #  $1 -> Filename that we are searching for
  #  $2 -> Directory that we are searching in

  filename1=$(basename "$1")  ##Get the filename for searching in the directory tree
  duplicate=$(find "$2" -type f -name "$filename1" | wc -l)
  if [ $duplicate == 1 ]; then
    filename2=$(find "$2" -type f -name "$filename1")
    echo "Main file $filename2"
    echo "Duplicate file $1"

    # Check the file is exists or not
    if [ -f "$1" ] ; then
      rm "$1"
    fi
    echo "$1 is removed"
    ln -s "$filename2" "$1"
    linkdetails=$(ls -l $1)
    echo "New Link Created -> $linkdetails"
  fi

}


walk_dir () {
  shopt -s nullglob dotglob
  for pathname in "$1"/*; do
    if [ -d "$pathname" ]; then
      walk_dir "$pathname"
    else
      case "$pathname" in
        *.mkv|*.avi|*.mpg)
          if [[ ! -L "$pathname" ]]; then
            unlinkDup "$pathname" "/plex/library/tv"
            unlinkDup "$pathname" "/plex/library/movies"
          fi
        ;;
      *.png|*.nfo|*.part|*.rar|*.sfv|*.r0*|*.r1*)
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
