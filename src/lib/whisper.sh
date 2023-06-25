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
  local sub_format="$4"

  whisper.cpp \
    --file "${media_file%%.*}" \
    --language "${lang}" \
    --model "${MODEL_PATH}/${model_file}" \
    --output-"${sub_format}" \
    --no-timestamps >/dev/null

  echo -e "[$(green_bold "  OK  ")] Completed"
  echo -e "[$(cyan_bold " INFO ")] Generated transcription is:"
  echo -e "${media_file%%.*}.${sub_format}"
}

run_whisper_stream() {
  local model_file="$1"
  local lang="$2"

  if [[ "${lang}" == "auto" ]]; then
    lang="en"
  fi

  whisper.cpp-stream \
    --language "${lang}" \
    --model "${MODEL_PATH}/${model_file}"

  echo -e "[$(green_bold "  OK  ")] Completed"
}
