download_model() {
  local model="$1"

  echo -e "[$(cyan_bold " INFO ")] Downloading latest ggml-${model}.bin ..."
  curl -# -L -C - "https://ggml.ggerganov.com/ggml-model-whisper-${model}.bin" \
    -o "${MODEL_PATH}/ggml-${model}.bin"
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
