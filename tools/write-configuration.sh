#!/usr/bin/env bash

declare -r ZIGZAG_CONFIG_ROOT=/usr/share/zigzag/ansible/root.yml

write_config()
{
  shift # first argument is force flag

  echo ansible-playbook \
    -i "localhost," \
    -c local \
    "$@" \
    $ZIGZAG_CONFIG_ROOT
}

show_warning()
{
  echo "This script is used to bootstrap zigzag configuration" 2>&1
  echo "It will override current system setup. If you want to" 2>&1
  echo "continue pass force flag (-f)" 2>&1
  exit 1
}

if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user" 2>&1
  exit 1
elif [[ $1 != '-f' ]]; then
  show_warning
else
  write_config "$@"
fi
