#!/usr/bin/env bash

check_media_type() {
  local media_file="$1"

  mime_type=$(file -i "${media_file}" | cut -d":" -f 2)
  mime_type_stripped="${mime_type//[[:blank:]]/}"
  media_type="${mime_type_stripped//;*/}"

  case "${media_type}" in
  audio*) ;;
  video*) ;;
  stream*) ;;
  *)
    echo -e "[$(red_bold "FAILED")] File type not supported : ${media_type}"
    exit 1
    ;;
  esac

  echo -e "[$(green_bold "  OK  ")] File media type detected: ${media_type}"

}

extract_audio() {
  local media_file="$1"

  echo -e "[$(cyan_bold " INFO ")] Extracting main track as 16Khz wav from ..."
  echo -e "[$(cyan_bold " INFO ")] ${media_file}"

  ffmpeg -y \
    -i "${media_file}" \
    -acodec pcm_s16le -ac 1 -ar 16000 \
    "${media_file}.wav" 2>/dev/null

  echo -e "[$(green_bold "  OK  ")] Audio extraction completed. File is:"
  echo -e "[$(cyan_bold " INFO ")] ${media_file}.wav"

}
