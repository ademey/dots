#!/usr/bin/env bash

# TODO: Fallback for no results
dict="willekeurig"
dict_url="https://www.ensie.nl"

# this url generates a link to a randome definition
get_random=$(curl -s $dict_url/$dict)
# get_random=$(curl -s "${dict_url}/wrong")
validate_redirect_page=$(echo $get_random | pup 'title' | grep "Redirect")
if [ ! -n "${validate_redirect_page}" ]; then
    echo "Kan geen woord vinden"
    exit 0
fi
# get the link from the request
redirect=$(echo $get_random | pup 'body a attr{href}' )

if [ -n "${redirect}" ]; then
    redirect_url=("${dict_url}${redirect}")
    get_def=$(curl -s $redirect_url)
    # Get the main content area and replace any relative urls with the full domain
    content=$(echo $get_def | pup '.card-body .content' | sed -e 's|href="/|href="http://www.ensie.nl/|')
    echo $content | lynx -dump -stdin
else
    echo "Er is iets misgegaan"
fi


