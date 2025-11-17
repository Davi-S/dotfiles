# Prints usage from top comment until "### END USAGE"
usage() {
  awk '
    NR == 1 && /^#!/ { next }
    /^### END USAGE/ { exit }
    /^#/ { sub(/^# ?/, ""); print }
  ' "$0"
  exit 1
}


# Parses help flags and calls usage()
check_help_flag() {
  for arg in "$@"; do
    case "$arg" in
      -h|--help)
        usage
        ;;
    esac
  done
}
