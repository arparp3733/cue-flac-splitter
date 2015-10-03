#!/bin/bash
flag=0
`mkdir ../temp`
output_file="../temp/formatted_output"

input=`ls ../*.cue`

while read i
do
	j=`echo $i | cut -d' ' -f1`
	k=`echo $i | cut -d' ' -f2-500`
	k1=`echo $k | cut -d'"' -f2`
	k2=`echo $k | cut -f1`
	if [ $j = "TRACK" ]
	then
		track_no=`echo $k1 | cut -d' ' -f1`
		flag=1
	elif [ $j = "PERFORMER" ]
	then
		if [ $flag = "1" ]
		then
			track_artist=`echo $k1`
			echo -e "Track $track_no artist : "$track_artist >> $output_file
		else
			album_artist=`echo $k1`
			echo -e "Album artist : "$album_artist >> $output_file
		fi
	elif [ $j = "TITLE" ]
	then
		if [ $flag = "1" ]
		then
			track_title=`echo $k1`
			echo -e "Track $track_no title : "$track_title >> $output_file
		else
			album_title=`echo $k1`
			echo -e "Album title : "$album_title >> $output_file
		fi
	elif [ $j = "REM" ]
	then
		temp=`echo $k2 | cut -d' ' -f1`
		if [ $temp = "GENRE" ]
		then
			album_genre=`echo $k2 | cut -d' ' -f2-4 | cut -d'"' -f2-50 | cut -d'"' -f1`
			echo -e "Album genre : "$album_genre >> $output_file
		fi
	fi
	# how to read additional lines from this point itself? --> use continue! :-P
done < "$input"
