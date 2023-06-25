#!/usr/bin/env bash

media_file="${args[media_file]}"
sub_format="${args[sub_format]}"

check_media "${media_file}"
check_sub "${media_file}" "${sub_format}"
play_media "${media_file}" "${sub_format}"