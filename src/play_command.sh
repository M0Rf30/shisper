media_file="${args[media_file]}"
sub_format="${args[--format]}"

check_media "${media_file}"
check_sub "${media_file}" "${sub_format}"
play_media "${media_file}" "${sub_format}"
