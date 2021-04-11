!/bin/bash

ffmpeg -y -i "${FILE_NAME}.mkv" -i "./Audio 1/${FILE_NAME}.mka" -i "./Subtitles/Crunchyroll/${FILE_NAME}.ass" -map 0:v -map 0:a -map 1:a -map 2:s -c:v copy -c:a copy -c:s srt -shortest "${FILE_NAME}-merged${VIDEO_EXT}"
done

#Теперь попытаюсь объяснить как это работает:

#1. Флаг -i это сокращение от input, т.е. входной файл. В данном примере их у нас 3 (видео, озвучка и сабы), но мы понимаем, что их может быть сколько угодно. Главное помнить про последовательность этих файлов
#2. Флаг -map означает что взять из какого файла и куда разместить. Т.е. например -map 0:v -map 0:a означает, что я из первого файла беру только видео и аудио потоки; -map 1:a - из второго файла беру только аудиопоток и -map 2:s из 3 файла я беру только сабы. Соотвественно если порядок входных файлов изменится, то и порядок у флага map также должен измениться.
#3. Флаг -c это копирование потоков. В данном случае мы не конвертируем никакой поток, а лишь копируем в конечное видео. -c:v означает, что копируем видео поток, -c:a - аудиопоток и -c:s субтитры. Однако тут уже нет привычного copy и указывается тип кодировки для формата .ass. Если у тебя сабы в формате .srt, то нужно будет указать флаг -c:s mov_text вместо -c:s srt. (-c:s mov_text я не тестировал, т.к. у меня нет сабов в формате srt, но в теории должно работать. Если что-то пойдет не так, то пиши, попробую разобраться)

# идеале при помощи map можно еще и сортировать аудиодорожки и субтитры в плеере. Т.е. например если у тебя по дефолту идет японская озучка, то можно на первое место поставить русскую или любую другую.