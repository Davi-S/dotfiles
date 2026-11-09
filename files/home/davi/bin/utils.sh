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


# ==============================================================================
# LEVELS (volume, brightness)
# Shared by the *-control scripts (which change a level) and the *-notify-daemon
# scripts (which notify when a level changed).
# ==============================================================================

# The maximum output volume (1.0 = 100%, 1.5 = 150%). Volume percentages are
# relative to it: 100% means MAX_VOLUME.
MAX_VOLUME=1.5

# How long level notifications stay on screen, in milliseconds
LEVEL_NOTIFY_TIMEOUT=1000

# Prints the target percentage for an action, clamped to 0-100.
# Fails if the action is not valid.
# $1: current percentage
# $2: action: +<amount>, -<amount> or <amount> (absolute)
target_percentage() {
  local current="$1" action="$2" target

  if [[ "$action" =~ ^\+([0-9]+)$ ]]; then
    target=$(( current + BASH_REMATCH[1] ))
  elif [[ "$action" =~ ^-([0-9]+)$ ]]; then
    target=$(( current - BASH_REMATCH[1] ))
  elif [[ "$action" =~ ^[0-9]+$ ]]; then
    target=$action
  else
    return 1
  fi

  if (( target > 100 )); then target=100; fi
  if (( target < 0 )); then target=0; fi
  echo "$target"
}

# Sends a notification with a progress bar. Notifications with the same id
# replace each other (SwayNC "synchronous" hint) instead of stacking.
# $1: id, $2: title, $3: body, $4: percentage for the progress bar
notify_level() {
  notify-send \
    -h "string:x-canonical-private-synchronous:$1" \
    -h "int:value:$4" \
    -t "$LEVEL_NOTIFY_TIMEOUT" \
    "$2" "$3"
}

# Where brightness-control keeps its state (saved levels, locks, DDC buses) and
# writes the current level of DDC/CI monitors, which send no events of their own
BRIGHTNESS_STATE_DIR="${XDG_RUNTIME_DIR:-/tmp}/brightness"

# Prints the monitor (connector name, e.g. eDP-1) a backlight device belongs to
# $1: backlight device, e.g. amdgpu_bl1
backlight_connector() {
  readlink -f "/sys/class/backlight/$1" | sed -nE 's#.*/card[0-9]+-([^/]+)/[^/]+$#\1#p'
}

# Prints the brightness of a backlight device as a whole percentage
# $1: backlight device
backlight_percentage() {
  awk -v cur="$(brightnessctl -d "$1" g)" -v max="$(brightnessctl -d "$1" m)" \
    'BEGIN { printf "%.0f", (cur / max) * 100 }'
}

# Prints a human readable name for a monitor: "Laptop" for built-in screens,
# make and model for the others (e.g. "AOC 27G2G4")
# $1: connector name, e.g. HDMI-A-1
monitor_label() {
  case "$1" in
    eDP*|LVDS*|DSI*) echo "Laptop" ;;
    *)
      local label
      label=$(hyprctl monitors -j 2>/dev/null \
        | jq -r --arg name "$1" '.[] | select(.name == $name) | "\(.make) \(.model)"')
      echo "${label:-$1}"
      ;;
  esac
}

# Prints the volume of an audio device as a whole percentage. The output volume
# is relative to MAX_VOLUME; the microphone is not limited, so it is plain.
# $1: @DEFAULT_AUDIO_SINK@ or @DEFAULT_AUDIO_SOURCE@
volume_percentage() {
  local max=1
  [[ "$1" == "@DEFAULT_AUDIO_SINK@" ]] && max="$MAX_VOLUME"
  wpctl get-volume "$1" 2>/dev/null \
    | awk -v max="$max" '{ printf "%.0f", ($2 / max) * 100 }'
}
