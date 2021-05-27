!/bin/bash
VIDEO_EXT=".mkv" # Желательно только MKV
AUDIO_EXT=".ac3" # Любой формат

for filename in ./*${VIDEO_EXT}; do
FILE_NAME="$(basename "$filename" "$VIDEO_EXT")" # Имя без расширения
MERGED_FILE_NAME="${FILE_NAME}-merged${VIDEO_EXT}" # Конечный результат

ffmpeg -y -i "${FILE_NAME}${VIDEO_EXT}" -i "${FILE_NAME}${AUDIO_EXT}" -map 0:0 -map 1:0 -map 0:1 -c copy -shortest "${FILE_NAME}-merged${VIDEO_EXT}"
#done
	# Удаление оригинала видео
	eval "rm \"${filename}\""

	# Удаление звука
	#for audio_folder in ./*; do #for audio_folder in ./Sounds/*; do # раскомментировай строку и выставить\изменить что нужно
		#if [ -d "$audio_folder" ]; then
			eval "rm \"${FILE_NAME}${AUDIO_EXT}\"" #eval "rm \"${audio_folder}/${FILE_NAME}${AUDIO_EXT}\""
		#fi
	#done

	# Оригинальное название
	eval "mv \"${MERGED_FILE_NAME}\" \"${filename}\""
done
