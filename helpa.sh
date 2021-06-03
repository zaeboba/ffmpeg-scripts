# Слоумо

ffmpeg -i 'input.mp4' -f rawvideo -b 100000000  -vcodec rawvideo -s 1280x720 -y - | ffmpeg -f rawvideo -r 100 -s 1280x720 -i - -b 8000000 -y output.mp4


# Таймлапс из видео (ускорить видео)

## 0.125 — в 8 раз
ffmpeg -i input.mp4 -filter:v "setpts=0.125*PTS" -r 60 -an output.mp4

## С кодеком
ffmpeg -i input.mp4 -filter:v "setpts=0.125*PTS" -vcodec libx264 -b:v 20m -r 60 -an output.mp4

## Замедлить видео — аналогично, только PTS > 1


# Видео для Twitter (особый кодек, иначе плохо)

ffmpeg -i input.mp4 -vcodec libx264 -pix_fmt yuv420p -strict -2 output.mp4

ffmpeg -i input.mp4 -vcodec libx264 -pix_fmt yuv420p -strict -2 -acodec none output.mp4

ffmpeg -i input.mp4 -vcodec libx264 -pix_fmt yuv420p -strict -2 -acodec aac output.mp4


# Наложить текст заданным шрифтом

## Обычным фильтром
ffmpeg -i in.mp4 -vf drawtext="fontfile='/home/maximal/.fonts/truetype/PT Sans/PTC55F.ttf': \
	text='вправо!': fontcolor=white: fontsize=48: box=1: boxcolor=black@0.5: \
	boxborderw=5: x=(w-text_w)/2-300: y=(h-text_h)/2-200:enable='between(t,4.5,7)'" -b 22000k -c:a copy out.mp4

## Комплексным фильтром
ffmpeg -i in.mp4 -filter_complex '[0:v]drawtext=fontfile=Ubuntu-L.ttf: text=sijeko.ru: \
	fontcolor=white: fontsize=40: box=1: boxcolor=black@0.4: \
	boxborderw=5: x=(w-text_w)-20: y=(h-text_h)-20,split=4[out1][out2][out3][out4]' <4 выхода>


# Таймлапс из картинок

## Оригинальный размер
ffmpeg -start_number 41 -r 10 -i FHD%04d.JPG -vcodec libx264 -b:v 5m -r 30 a_video.mp4

## С ресайзом
ffmpeg -start_number 41 -r 10 -i FHD%04d.JPG -vcodec libx264 -b:v 5m -r 30 -s 608x342 a_video.mp4

## Если картинки не пронумерованы (но в алфавитном порядке)

### Сначала сделать список файлов
find -type f -name '*.jpg' -exec echo "file '{}'" \; | sort > 000-files.txt

### Потом из списка сделать видео
ffmpeg -r 60/1 -f concat -safe 0 -i 000-files.txt -c:v libx264 -vf "fps=60,format=yuv420p" -y 000-video.mp4

* 60/1 — 60 исходных файлов будут сведены в одну секунду видео (наоборот: 1/4 — каждую картинку растянуть на 4 секунды)
* fps=60 — количество кадров в секунду (если 60/1 и fps=60, значит, в секунде будет 60 исходных картинок)


# Видео в гифку

## Генерация палитры
ffmpeg -y -ss 30 -t 3 -i input.mp4 -vf fps=20,scale=320:-1:flags=lanczos,palettegen palette.png

## Генерация гифки
ffmpeg -y -ss 30 -t 3 -i input.mp4 -i palette.png -filter_complex "fps=20,scale=320:-1:flags=lanczos[x];[x][1:v]paletteuse" output.gif
