#! /usr/local/bin bash
function killgrep() {
  local PID
  local GREP_PID

  if [ -z "$1" ]; then
    echo "Usage: killgrep <pattern>"
    return 1
  fi

  PID=$(pgrep -f "$1")
  if [ -z "$PID" ]; then
    echo "No process found matching pattern: $1"
    return 1
  fi

  echo "$PID" | xargs kill -9 
}
