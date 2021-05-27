for /f "tokens=*" %%a in ('powershell -command "Get-Clipboard"') do set CLIPBOARD_TEXT=%%a
youtube-dl --extract-audio -i --audio-format mp3 --audio-quality 0 --no-part --no-mtime --embed-thumbnail --add-metadata --output "M:\Music\%%(title)s.%%(ext)s" "%CLIPBOARD_TEXT%"
start M:\Music
pause