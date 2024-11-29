# Change working directory to the top-most Finder window location

function cdf() {
	cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')";
}

# Dev

d() {
  $VISUAL ${1:-.}
  $VISUAL_GIT ${1:-.}
}

# Get Bundle ID of macOS app
# Example: bundleid terminal

bundleid() {
  local ID=$( osascript -e 'id of app "'"$1"'"' )
  if [ ! -z $ID ]; then
    echo $ID | tr -d '[:space:]' | pbcopy
    echo "$ID (copied to clipboard)"
  fi
}
