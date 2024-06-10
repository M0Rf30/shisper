#!/usr/bin/env bash

clean_temp_file() {
  local media_file="$1"

  echo -e "[$(cyan_bold " INFO ")] Deleting temporary wav files"
  rm "${media_file%.*}"
}

check_media() {
  local media_file="$1"

  if [[ ! -f "${media_file}" ]]; then
    echo -e "[$(red_bold " FAILED ")] File not found"
    exit 1
  fi
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

check_sub() {
  local media_file="$1"
  local sub_format="$2"

  if [[ ! -f "${media_file%.*}.${sub_format}" ]]; then
    echo -e "[$(red_bold " FAILED ")] Generated transcription not found"
    exit 1
  fi
}
