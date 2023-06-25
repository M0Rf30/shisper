#!/usr/bin/env bash

lang="$(config_get lang)"
media_file="${args[media_file]}"
model_file="ggml-$(config_get model).bin"
# sub_format="$(config_get sub_format)"
sub_format="${args[sub_format]}"


check_media "${media_file}"
check_media_type "${media_file}"
extract_audio "${media_file}"
check_models "${model_file}"
run_whisper "${media_file}" "${model_file}" "${lang}" "${sub_format}"
clean_temp_file "${media_file}"
