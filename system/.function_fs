# Create a new directory and enter it

mk() {
  mkdir -p "$@" && cd "$@"
}

# Fuzzy find file/dir

ff() {  find . -type f -iname "$1";}
fff() { find . -type f -iname "*$1*";}
fd() {  find . -type d -iname "$1";}
fdf() { find . -type d -iname "*$1*";}

# Show disk usage of current folder, or list with depth

duf() {
  du --max-depth=${1:-0} -c | sort -r -n | awk '{split("K M G",v); s=1; while($1>1024){$1/=1024; s++} print int($1)v[s]"\t"$2}'
}

# Check if resource is served compressed

check_compression() {
  curl --write-out 'Size (uncompressed) = %{size_download}\n' --silent --output /dev/null $1
  curl --header 'Accept-Encoding: gzip,deflate,compress' --write-out 'Size (compressed) =   %{size_download}\n' --silent --output /dev/null $1
  curl --head --header 'Accept-Encoding: gzip,deflate' --silent $1 | grep -i "cache\|content\|vary\|expires"
}

# Get gzipped file size

gz() {
  local ORIGSIZE=$(wc -c < "$1")
  local GZIPSIZE=$(gzip -c "$1" | wc -c)
  local RATIO=$(echo "$GZIPSIZE * 100/ $ORIGSIZE" | bc -l)
  local SAVED=$(echo "($ORIGSIZE - $GZIPSIZE) * 100/ $ORIGSIZE" | bc -l)
  printf "orig: %d bytes\ngzip: %d bytes\nsave: %2.0f%% (%2.0f%%)\n" "$ORIGSIZE" "$GZIPSIZE" "$SAVED" "$RATIO"
}

# Create a data URL from a file

dataurl() {
  local MIMETYPE=$(file --mime-type "$1" | cut -d ' ' -f2)
  if [[ $MIMETYPE == "text/*" ]]; then
    MIMETYPE="${MIMETYPE};charset=utf-8"
  fi
  echo "data:${MIMETYPE};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}
