config.load_autoconfig()

config.bind('M', 'hint links spawn mpv {hint-url}')
config.bind('Z', 'hint links spawn kitty -e yt-dlp {hint-url}')
config.bind('t', 'set-cmd-text -s :open -t')


# Bottom!
config.source('qutewal.py')
