## Code here runs inside the initialize() function
## Use it for anything that you need to run before any other function, like
## setting environment variables:
## CONFIG_FILE=settings.ini
##
## Feel free to empty (but not delete) this file.
required_executables=(whisper.cpp ffmpeg mpv)

check_requirements() {
  for executable in "${required_executables[@]}"; do
    if ! command -v "${executable}" &>/dev/null; then
      echo -e "[$(red_bold " FAILED ")] ${executable} executable is required"
      exit 1
    fi

  done
}

check_requirements
