#!/usr/bin/env bash

clean_temp_file() {
  local media_file="$1"

  echo -e "[$(cyan_bold " INFO ")] Deleting temporary wav files"
  rm "${media_file}.wav"
}
