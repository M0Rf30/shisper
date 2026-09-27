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

  local model="${MODEL_PATH}/ggml-${model_file}.bin"

  if [[ -f "${model}" ]] && ! is_valid_model "${model}"; then
    echo -e "[$(yellow_bold " WARN ")] ${model} is not a valid ggml model, removing it"
    rm -f "${model}"
  fi

  if [[ -f "${model}" ]]; then
    echo -e "[$(cyan_bold " INFO ")] ${model} is present"
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
