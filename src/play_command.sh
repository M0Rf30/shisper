
#!/usr/bin/env bash

media_file="${args[media_file]}"

check_media "${media_file}"
check_srt "${media_file}"
play_media "${media_file}"