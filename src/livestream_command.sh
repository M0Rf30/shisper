#!/usr/bin/env bash

media_file="${args[media_file]}"
model_file="ggml-$(config_get model).bin"

play_stream "${media_file}" "${model_file}"
