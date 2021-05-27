for /f "tokens=*" %%a in ('powershell -command "Get-Clipboard"') do set CLIPBOARD_TEXT=%%a

youtube-dl --no-playlist --output "M:\Youtube\%%(title)s.%%(ext)s" %CLIPBOARD_TEXT%
start M:\Youtube
pause