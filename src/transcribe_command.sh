#!/usr/bin/env bash
media_file="${args[media_file]}"
lang="${args[--lang]}"
model="${args[--model]}"
sub_format="${args[--format]}"

check_media "${media_file}"
check_media_type "${media_file}"
extract_audio "${media_file}"
check_models "${model}"
run_whisper "${media_file}" "${model}" "${lang}" "${sub_format}"
clean_temp_file "${media_file}"
