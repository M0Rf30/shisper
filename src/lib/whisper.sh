#!/usr/bin/env bash

run_whisper() {
  local media_file="$1"

  whisper.cpp \
    -m /home/gianluca/.local/share/whispercpp/ggml-base.en.bin \
    -f "${media_file}.wav" \
    --output-srt \
    --print-progress > /dev/null
}
