#!/usr/bin/env bash

declare -r ZIGZAG_CONFIG_ROOT=/usr/share/zigzag/ansible/root.yml
declare force=false
declare extra_vars=''

write_config()
{
  local params=(
    -i "localhost,"
    -c local $ZIGZAG_CONFIG_ROOT
  )

  if [ -n "$extra_vars" ]; then
    params+=("--extra-vars $extra_vars")
  fi

  ansible-playbook "${params[@]}"
}

show_warning()
{
  echo "This script is used to bootstrap zigzag configuration" 2>&1
  echo "It will override current system setup. If you want to" 2>&1
  echo "continue pass force flag (-f)" 2>&1
  exit 1
}

# set variables based on flags
while getopts 'v:f' flag; do
  case "${flag}" in
    f) force=true ;;
    v) extra_vars="${OPTARG}" ;;
    *) error "Unexpected option ${flag}" ;;
  esac
done

# run
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user" 2>&1
  exit 1
elif [[ "$force" = false ]]; then
  show_warning
else
  write_config
fi
