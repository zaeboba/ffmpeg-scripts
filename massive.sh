#!/bin/bash
VIDEO_EXT=".mkv"
AUDIO_EXT=".mka"

for filename in ./*${VIDEO_EXT}; do
FILE_PATH="$(dirname "$filename")" # Путь
FILE_NAME="$(basename "$filename" "$VIDEO_EXT")" # Имя без расширения

ffmpeg -y -i "${FILE_NAME}${VIDEO_EXT}" -i "./Audio 1/${FILE_NAME}${AUDIO_EXT}" -i "./Audio 2/${FILE_NAME}${AUDIO_EXT}" -map 0:0 -map 1:0 -map 0:1 -map 2:0 -map 0:2 -c copy -shortest "${FILE_NAME}-merged${VIDEO_EXT}"
done