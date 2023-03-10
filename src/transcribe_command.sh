#!/usr/bin/env bash

media_file="${args[media_file]}"

check_media_type "${media_file}"
extract_audio "${media_file}"
run_whisper "${media_file}"
clean_temp_file "${media_file}"
