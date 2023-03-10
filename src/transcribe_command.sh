#!/usr/bin/env bash

media_file="${args[media_file]}"

media_type=$(check_media_type "${media_file}")

echo -e "[$(green_bold "  OK  ")] File media type detected: ${media_type}"

extract_audio "${media_file}"
run_whisper "${media_file}"