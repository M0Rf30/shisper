#!/usr/bin/env bash

clean_temp_file() {
  local media_file="$1"

  echo -e "[$(cyan_bold " INFO ")] Deleting temporary wav files"
  rm "${media_file}.wav"
}

check_models() {
  local model_file="$1"

  if [[ ! -d "${MODEL_PATH}" ]]; then
    mkdir -p "${MODEL_PATH}"
  fi

  if [[ -f "${MODEL_PATH}/${model_file}" ]]; then
    echo -e "[$(yellow_bold " WARN ")] ${MODEL_PATH}/${model_file} is present"
  else
    download_model "${model_file}"
  fi
}
