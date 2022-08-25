num_of_arguments=$#
params_list=$*
usage_example="example: ./video_splitter split_in_ten_second_chunks.mp4 10"

#checking if the user asked for help
for param in "$@"
do
	if [ $param == "help" ]
	then
		echo $usage_example
		exit
	fi
done


if [ $num_of_arguments == 2 ]
then
	#getting video length in seconds
	video_length=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 $1)
	video_length=${video_length%.*}
	

	time_start=0
	number_of_file=0
	chunk_length=$2
	echo "Splitting ${1} video into chunks of ${chunk_length} seconds..."
	while ((time_start < video_length))
	do
		ffmpeg -y -hide_banner -loglevel error -i ${1} -ss ${time_start} -t ${chunk_length} mogo-${number_of_file}.mp4
		((time_start+=chunk_length))
		((number_of_file+=1))
	done
	echo "Done!"
else
	echo "You must put at least the input filename and the time chunk chunk_length in seconds, ${usage_example}"
fi
exit



