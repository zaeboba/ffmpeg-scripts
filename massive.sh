#!/bin/bash
VIDEO_EXT=".mkv"
AUDIO_EXT=".mka"
SUBTITLES_EXT=".ass"
 
REMOVE_OLD_FILES=true
 
for filename in ./*${VIDEO_EXT}; do
    file_name="$(basename "$filename" "$VIDEO_EXT")"
    merged_file_name="${file_name}-merged${VIDEO_EXT}"
    
    stream_count=1
    
    audio_inputs=""
    audio_map=""
    
    # Detect all audio
    for audio_folder in ./Sounds/*; do
        if [ -d "$audio_folder" ]; then
            audio_inputs="${audio_inputs} -i \"${audio_folder}/${file_name}${AUDIO_EXT}\""
            audio_map="${audio_map} -map ${stream_count}"
            stream_count=$(expr $stream_count + 1)
        fi
    done
    
    subtitles_inputs=""
    subtitles_map=""
    
    # Detect all subtitles
    for subtitles_folder in ./Subtitles/*; do
        if [ -d "$subtitles_folder" ]; then
           subtitles_inputs="${subtitles_inputs} -i \"${subtitles_folder}/${file_name}${SUBTITLES_EXT}\""
           subtitles_map="${subtitles_map} -map ${stream_count}"
           stream_count=$(expr $stream_count + 1)
        fi
    done
    
    # Converting
    eval "ffmpeg -y -i \"${filename}\" ${audio_inputs} ${subtitles_inputs} -map 0:v -map 0:a ${audio_map} ${subtitles_map} -c:v copy -c:a copy -c:s srt -shortest \"${merged_file_name}\""
    
    # Removing
    if [ "$REMOVE_OLD_FILES" = true ]; then
        # Removing original videofile
        eval "rm \"${filename}\""
    
        # Removing audiofiles
        for audio_folder in ./Sounds/*; do
            if [ -d "$audio_folder" ]; then
                eval "rm \"${audio_folder}/${file_name}${AUDIO_EXT}\""
            fi
        done
    
        # Removing subtitles
        for subtitles_folder in ./Subtitles/*; do
            if [ -d "$subtitles_folder" ]; then
                eval "rm \"${subtitles_folder}/${file_name}${SUBTITLES_EXT}\""
            fi
        done
    
        # Renaming merged videofile to original name
        eval "mv \"${merged_file_name}\" \"${filename}\""
    fi
done
