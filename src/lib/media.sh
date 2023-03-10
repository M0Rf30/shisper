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
  echo -e "${media_file}"

  ffmpeg -y \
    -loglevel quiet \
    -i "${media_file}" \
    -acodec pcm_s16le -ac 1 -ar 16000 \
    "${media_file}.wav"

  echo -e "[$(green_bold "  OK  ")] Audio extraction completed. File is:"
  echo -e "${media_file}.wav"

}

play_media() {
  local media_file="$1"

  echo -e "[$(cyan_bold " INFO ")] Playing file with generated transcription ..."
  echo -e "${media_file}"

  mpv \
    --quiet \
    --sub-file="${media_file}".wav.srt \
    "${media_file}" 1>/dev/null

  echo -e "[$(green_bold "  OK  ")] Playback completed."
}

play_stream() {
  local media_file
  media_file="$1"
  local model_file
  model_file="$2"
  local model_file
  lang="$3"
  local running
  running=1

  trap "running=0" SIGINT SIGTERM

  # continuous stream in native fmt (this file will grow forever!)
  local continous_stream_cmd
  continous_stream_cmd="ffmpeg -y \
  -loglevel quiet \
  -re \
  -probesize 32 \
  -i ${media_file} \
  -c copy /tmp/whisper-live0.aac &"

  eval "${continous_stream_cmd}"
  echo -e "[$(cyan_bold " INFO ")] Buffering audio. Please wait ..."
  sleep 30

  # do not stop script on error
  set +e

  i=0
  SECONDS=0
  while [ $running -eq 1 ]; do
    # extract the next piece from the main file above and transcode to wav. -ss sets start time and nudges it by -0.5s to catch missing words (??)
    err=1
    while [ "$err" -ne 0 ]; do
      if [ $i -gt 0 ]; then
        ffmpeg -y \
          -loglevel quiet \
          -v error \
          -noaccurate_seek \
          -i "/tmp/whisper-live0.aac" \
          -ar 16000 -ac 1 -c:a pcm_s16le \
          -ss $(("$i" * 30 - 1)).5 \
          -t 30 /tmp/whisper-live.wav 2>/tmp/whisper-live.err
      else
        ffmpeg -y \
          -loglevel quiet \
          -v error \
          -noaccurate_seek \
          -i "/tmp/whisper-live0.aac" \
          -ar 16000 -ac 1 -c:a pcm_s16le \
          -ss $(("$i" * 30)) \
          -t 30 \
          /tmp/whisper-live.wav 2>/tmp/whisper-live.err
      fi
      err=$(wc -l </tmp/whisper-live.err)
    done

    run_whisper "/tmp/whisper-live" "${model_file}" "${lang}"

    while [ $SECONDS -lt $((("$i" + 1) * 30)) ]; do
      sleep 1
    done
    ((i = i + 1))
  done

  killall -v ffmpeg
  killall -v whisper.cpp
}
