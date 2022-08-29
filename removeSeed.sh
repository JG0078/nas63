#!/bin/bash

# port, username, password
SERVER="localhost:9091"
ST=600

# use transmission-remote to get torrent list from transmission-remote list
TORRENTLIST=`transmission-remote $SERVER --list | sed -e '1d' -e '$d' | awk '{print $1}' | sed -e 's/[^0-9]*//g'`

# for each torrent in the list
for TORRENTID in $TORRENTLIST
do
    INFO=$(transmission-remote $SERVER --torrent $TORRENTID --info)
    echo -e "Processing #$TORRENTID - $(echo $INFO | sed -e 's/.*Name: \(.*\) Hash.*/\1/')"
    
    # check if torrent download is completed
    DL_COMPLETED=`echo $INFO | grep "Done: 100%"`
    # check torrents current state is
    STATE_STOPPED=`echo $INFO | grep "State: Seeding\|State: Stopped\|State: Finished\|State: Idle"` 

    # if the torrent is "Stopped", "Finished", or "Idle after downloading 100%"
    if [ "$DL_COMPLETED" ] && [ "$STATE_STOPPED" ]; then
    	echo "Torrent #$TORRENTID is completed. Waiting $ST seconds before removing torrent from list."
		SEEDTIME=`transmission-remote $SERVER -n 'transmission:transmission' -t $TORRENTID -i | grep "Seeding Time"| cut -d "(" -f2 | cut -d ")" -f1| awk '{print $1}'`
		if [ $SEEDTIME -gt $ST ];
			echo "Seeding Time: $SEEDTIME - waiting ...."
		then
	    	echo "Torrent #$TORRENTID has seeded more than $ST seconds.  Removing NOW"
	    	transmission-remote $SERVER --torrent $TORRENTID --remove-and-delete  #--remove 
		fi;
		#transmission-remote $SERVER --torrent $TORRENTID --remove
    else
        echo "Torrent #$TORRENTID is not completed. Ignoring."
    fi
    
    echo ""

done
#STEST=`transmission-remote $SERVER  -n 'transmission:transmission' -t 1 -i`
#echo "$STEST"
