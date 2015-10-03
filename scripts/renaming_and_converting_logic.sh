#!/bin/bash
isTrack="false"

album_info=`cat ../temp/album_info`
track_info="../temp/track_info"

album_title=`echo $album_info | cut -d':' -f1`
album_artist=`echo $album_info | cut -d':' -f2`
album_genre=`echo $album_info | cut -d':' -f3`

`mkdir ../mp3`
`mkdir ../wav`

`mv ../*.wav ../wav/`

while read i
do
	track_no=`echo $i | cut -d':' -f1`	
	track_artist=`echo $i | cut -d':' -f2`
	track_title=`echo $i | cut -d':' -f3`
	
	input_file_name="../wav/Track $track_no.wav"
	output_file_name="../mp3/$track_no - $track_title.mp3"
	
	echo -e "\nlame -b 320 --tt \"$track_title\" --tg \"$album_genre\" --ta \"$track_artist\" --tl \"$album_title\" --tn \"$track_no\" \"$input_file_name\" \"$output_file_name\"\n"
	`lame -b 320 --tt "$track_title" --tg "$album_genre" --ta "$track_artist" --tl "$album_title" --tn "$track_no" "$input_file_name" "$output_file_name"`
	
done < "$track_info"
