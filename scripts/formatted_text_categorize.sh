#!/bin/bash
isTrack="false"

input="../temp/formatted_output"

output_album="../temp/album_info"
output_track="../temp/track_info"

let flag=0

while read i
do
	first_word=`echo $i | cut -d' ' -f1`
	second_word=`echo $i | cut -d' ' -f2`
	attrib_value=`echo $i | cut -d':' -f2-50`
	if [ $first_word = "Album" ]
	then
		album_attrib_name=`echo $second_word`
		if [ $album_attrib_name = "genre" ]
		then
			album_genre=`echo $attrib_value`
		elif [ $album_attrib_name = "title" ]
		then
			album_title=`echo $attrib_value`
		elif [ $album_attrib_name = "artist" ]
		then
			album_artist=`echo $attrib_value`
		fi
	else
		let flag=1-flag
		isTrack="true"
		track_no_temp=`echo $second_word`
		temp=`echo $track_no_temp | cut -c1-1`
		if [ $temp = "0" ]
		then
			track_no=`echo $track_no_temp | cut -c2-2`
		else
			track_no=`echo $track_no_temp`
		fi
		track_attrib_name=`echo $i | cut -d' ' -f3`
		if [ $track_attrib_name = "artist" ]
		then
			track_artist=`echo $attrib_value`
		elif [ $track_attrib_name = "title" ]
		then
			track_title=`echo $attrib_value`
		fi
		if [ $flag -eq 1 ]
		then
			continue
		fi
		echo "$track_no:$track_artist:$track_title" >> $output_track
		##insert renaming logic here
	fi
	
#	if [ $isTrack = "false" ]
#	then
		
#	else
		
#	fi
done < "$input"
echo "$album_title:$album_artist:$album_genre" >> $output_album
