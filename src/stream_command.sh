#!/usr/bin/env bash

model_file="ggml-$(config_get model).bin"
lang="$(config_get lang)"

check_models "${model_file}"
run_whisper_stream "${model_file}" "${lang}"
