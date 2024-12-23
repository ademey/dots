#!/usr/bin/env bash
#
# Gist https://gist.github.com/mmirus/840c907f02dfb491a150be4e459893d1
#
# Forked from https://gist.github.com/omc8db/d95462784bc1c5c41f7f489df5dbc377
#
#   Use rofi to pick emoji because that's what this
#   century is about apparently...
#
#   Requirements:
#     rofi, wtype, wl-copy, curl
#
#   Usage:
#     1. Download all emoji
#        $ rofi-emoji --download
#
#     2. Run it!
#        $ rofi-emoji
#
#   Notes:
#     * You'll need a emoji font like "Noto Emoji" or "EmojiOne".
#     * Confirming an item will automatically paste it WITHOUT
#       writing it to your clipboard.
#     * Ctrl+C will copy it to your clipboard WITHOUT pasting it.
#

# Where to save the emojis file.
EMOJI_FILE="$HOME/.cache/emojis.txt"

function notify() {
	if [ "$(command -v notify-send)" ]; then
		notify-send "$1" "$2"
	fi
}

function download() {
	notify "$(basename "$0")" 'Downloading all emoji for your pleasure'

	curl https://unicode.org/emoji/charts/full-emoji-list.html |
		grep -Po "class='(chars|name)'>\K[^<]+" |
		paste - - >"$EMOJI_FILE"

	notify "$(basename "$0")" "We're all set!"
}

function display() {
	emoji=$(grep -v '#' "$EMOJI_FILE" | grep -v '^[[:space:]]*$')
	line=$(echo "$emoji" | tofi --prompt-text=" emoji:")
	# line=$(echo "$emoji" | rofi -dmenu -i -p emoji -kb-secondary-copy "" -kb-custom-1 Ctrl+c "$@")
	exit_code=$?

	IFS=$'\t' read -r -a line <<<"$line"

	if [ $line ]; then
		sleep 0.1 # Delay pasting so the text-entry can come active
		wl-copy "${line[0]}"
    echo "${line[0]}"
    # notify-send "emoji exit0:" "${line[0]}"
  else
		echo "canceled"
	fi
}

# Some simple argparsing
if [[ "$1" =~ -D|--download ]]; then
	download
	exit 0
elif [[ "$1" =~ -h|--help ]]; then
	echo "usage: $0 [-D|--download]"
	exit 0
fi

# Download all emoji if they don't exist yet
if [ ! -f "$EMOJI_FILE" ]; then
	download
fi

# display displays :)
display "$@"
