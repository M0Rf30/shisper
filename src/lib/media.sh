#!/usr/bin/env bash

check_media_type() {
  local media_file="$1"

  mime_type=$(file -i "${media_file}" | cut -d":" -f 2)
  mime_type_stripped="${mime_type//[[:blank:]]/}"
  media_type="${mime_type_stripped//;*/}"

  case "${media_type}" in
  audio*)
    echo audio
    ;;
  video*)
    echo video
    ;;
  stream*)
    echo stream
    ;;
  *)
    echo error
    exit 1
    ;;
  esac
}

extract_audio() {
  local media_file="$1"

  ffmpeg -y \
    -i "${media_file}" \
    -acodec pcm_s16le -ac 1 -ar 16000 \
    "${media_file}.wav" 2> /dev/null
}
