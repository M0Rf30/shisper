#!/usr/bin/env bash

media_file="${args[media_file]}"
model_file="ggml-$(config_get model).bin"
lang="$(config_get lang)"

check_media "${media_file}"
check_media_type "${media_file}"
extract_audio "${media_file}"
check_models "${model_file}"
run_whisper "${media_file}" "${model_file}" "${lang}"
clean_temp_file "${media_file}"
