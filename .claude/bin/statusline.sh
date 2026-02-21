#!/bin/sh
# Claude Code status line - mirrors oh-my-posh prompt (path + git branch)

input=$(cat)
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')

# Shorten home directory to ~
home="$HOME"
short_cwd=$(echo "$cwd" | sed "s|^$home|~|")

# Fish Shell PWD convention: last two dirs in full, ancestors abbreviated to first letter
display_path=$(echo "$short_cwd" | awk -F'/' '{
  # Count non-empty parts
  n = 0
  for (i = 1; i <= NF; i++) if ($i != "") parts[++n] = $i

  # Edge cases
  if (n == 0) { print "~"; next }
  if (n == 1 && $0 ~ /^~/) { print "~"; next }

  result = ""
  # Determine how many leading parts to abbreviate (all except last two)
  prefix = ($0 ~ /^\//) ? "/" : ""
  if ($0 ~ /^~/) { prefix = "~" }

  start = 1
  if ($0 ~ /^~/) start = 2  # skip the "~" token itself

  # Parts to abbreviate: from start up to (n - 2), keep last 2 in full
  abbrev_end = n - 2
  for (i = start; i <= n; i++) {
    p = parts[i]
    if (i <= abbrev_end) {
      # abbreviate to first character
      p = substr(p, 1, 1)
    }
    if (i == start) result = prefix "/" p
    else result = result "/" p
  }

  # Clean up double slashes
  gsub(/\/\/+/, "/", result)
  # Remove trailing slash unless root
  if (length(result) > 1) sub(/\/$/, "", result)
  print result
}')

# ANSI colors (approximating pink #c6a0f6 → magenta, blue #8aadf4 → blue)
pink='\033[35m'
blue='\033[34m'
reset='\033[0m'

# Git branch (skip optional locks so we never block)
git_branch=""
if git_output=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null); then
  git_branch="$git_output"
elif git_output=$(git -C "$cwd" --no-optional-locks rev-parse --short HEAD 2>/dev/null); then
  git_branch="$git_output"
fi

if [ -n "$git_branch" ]; then
  printf "${pink} %s${reset} ${blue}%s${reset}" "$display_path" " $git_branch"
else
  printf "${pink} %s${reset}" "$display_path"
fi
