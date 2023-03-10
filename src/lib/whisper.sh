#!/usr/bin/env bash
download_model() {
  local model_file="$1"

  echo -e "[$(cyan_bold " INFO ")] Downloading latest ${model_file} ..."
  curl -# -L -C - "https://huggingface.co/datasets/ggerganov/whisper.cpp/resolve/main/${model_file}" \
    -o "${MODEL_PATH}/${model_file}"
}

run_whisper() {
  local media_file="$1"
  local model_file="$2"
  local lang="$3"

  whisper.cpp \
    -m "${MODEL_PATH}/${model_file}" \
    -f "${media_file}.wav" \
    -l "${lang}" \
    --output-srt \
    --no-timestamps >/dev/null

  echo -e "[$(green_bold " OK ")] Completed"
  echo -e "[$(cyan_bold " INFO ")] Generated transcription is:"
  echo -e "${media_file}.wav.srt"
}
