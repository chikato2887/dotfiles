#!/bin/bash

input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // "Unknown"')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
vim_mode=$(echo "$input" | jq -r '.vim.mode // empty')

# Build progress bar (20 chars wide)
build_bar() {
  local pct="$1"
  local width=20
  local filled=$(echo "$pct $width" | awk '{printf "%d", int($1 * $2 / 100 + 0.5)}')
  local empty=$((width - filled))
  local bar=""
  for i in $(seq 1 $filled); do bar="${bar}#"; done
  for i in $(seq 1 $empty); do bar="${bar}-"; done
  echo "$bar"
}

# Context section
if [ -n "$used_pct" ]; then
  used_int=$(echo "$used_pct" | awk '{printf "%d", int($1 + 0.5)}')
  bar=$(build_bar "$used_pct")

  # Color: green < 70%, yellow < 90%, red >= 90%
  if [ "$used_int" -ge 90 ]; then
    color="\033[31m"
  elif [ "$used_int" -ge 70 ]; then
    color="\033[33m"
  else
    color="\033[32m"
  fi
  reset="\033[0m"

  ctx_str=$(printf " [${color}${bar}${reset} ${used_int}%%]")
else
  ctx_str=""
fi

# Vim mode section
if [ -n "$vim_mode" ]; then
  if [ "$vim_mode" = "INSERT" ]; then
    vim_str=$(printf " \033[92m[INSERT]\033[0m")
  else
    vim_str=$(printf " \033[33m[NORMAL]\033[0m")
  fi
else
  vim_str=""
fi

printf "%s%s%s" "$model" "$ctx_str" "$vim_str"
