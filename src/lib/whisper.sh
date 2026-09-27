MODEL_URL="https://huggingface.co/ggerganov/whisper.cpp/resolve/main"

download_model() {
  local model="$1"
  local dest="${MODEL_PATH}/ggml-${model}.bin"

  echo -e "[$(cyan_bold " INFO ")] Downloading ggml-${model}.bin ..."
  if ! curl -# -f -L -C - "${MODEL_URL}/ggml-${model}.bin" -o "${dest}.part"; then
    echo -e "[$(red_bold " FAILED ")] Unable to download ggml-${model}.bin"
    exit 1
  fi
  mv "${dest}.part" "${dest}"
}

is_valid_model() {
  [[ "$(head -c 4 "$1" 2>/dev/null)" == "lmgg" ]]
}

run_whisper() {
  local media_file="$1"
  local model_file="$2"
  local lang="${3:-auto}"
  local sub_format="$4"

  whisper-cli \
    --file "${media_file%.*}" \
    --language "${lang}" \
    --model "${MODEL_PATH}/ggml-${model_file}.bin" \
    --output-"${sub_format}" \
    --no-timestamps >/dev/null

  echo -e "[$(green_bold "  OK  ")] Completed"
  echo -e "[$(cyan_bold " INFO ")] Generated transcription is:"
  echo -e "${media_file%.*}.${sub_format}"
}
