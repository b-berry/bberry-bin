#!/bin/bash

# This script initializes a tmux session per user specs

set -e

function log_info() {
  >&2 echo -e "[\\e[1;94mINFO\\e[0m] $*"
}

function log_warn() {
  >&2 echo -e "[\\e[1;93mWARN\\e[0m] $*"
}

function log_error() {
  >&2 echo -e "[\\e[1;91mERROR\\e[0m] $*"
}

function assert_depend() {
  depends=("$@")
  depend_fail=0
  for d in "${depends[@]}"; do
      if [ -z $(command -v $d) ]; then
          echo "WARN: Dependency not satisfied: $d"
          (( depend_fail += 1 ))
      fi
  done
  if [ $depend_fail -gt 0 ]; then
      return 1
  else
      return 0
  fi
}

function tmux_init_session() {
  tmuxSessionName=${1:=desktop}
  if assert_depend tmux; then
    if tmux has-session -t ${tmuxSessionName}; then
      tmux new-sess -A ${tmuxSessionName}
    else
      echo "INFO: Building tmux session ${tmuxSessionName}"
      tmux new-session -d -s ${tmuxSessionName} &&\
      tmux new-window -d -t ${tmuxSessionName}:1 -n far &&\
      tmux new-window -d -t ${tmuxSessionName}:2 -n near &&\
      tmux new-window -d -t ${tmuxSessionName}:3 -n src -c ~/src &&\
      tmux new-window -d -t ${tmuxSessionName}:4 -n ops -c ~/src &&\
      tmux new-window -d -t ${tmuxSessionName}:5 &&\
      tmux select-window -t ${tmuxSessionName}:3 &&\
      tmux att -t ${tmuxSessionName}
    fi
  else
    echo "ERROR: Depend tmux not found" && exit 1
  fi
}
