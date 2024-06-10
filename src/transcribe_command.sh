#!/usr/bin/env bash

lang="$(config_get lang)"
media_file="${args[media_file]}"
model="$(config_get model)"
# sub_format="$(config_get sub_format)"
sub_format="${args[sub_format]}"

check_media "${media_file}"
check_media_type "${media_file}"
extract_audio "${media_file}"
check_models "${model}"
run_whisper "${media_file}" "${model}" "${lang}" "${sub_format}"
clean_temp_file "${media_file}"
