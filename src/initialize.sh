required_executables=(whisper-cli ffmpeg mpv)

check_requirements() {
  for executable in "${required_executables[@]}"; do
    if ! command -v "${executable}" &>/dev/null; then
      echo -e "[$(red_bold " FAILED ")] ${executable} executable is required"
      exit 1
    fi

  done
}

check_requirements
