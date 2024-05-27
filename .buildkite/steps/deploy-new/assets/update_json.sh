#!/bin/bash

update_json() {
  local json_file="./assets/annotation.json"
  local key=""
  local value=""
  local debug=""

  while [[ "$#" -gt 0 ]]; do
    case $1 in
      --key) key="$2"; shift ;;
      --value) value="$2"; shift ;;
      --debug) debug="$2"; shift ;;
      *) echo "Unknown parameter passed: $1"; return 1 ;;
    esac
    shift
  done

  if [[ ! -f $json_file ]]; then
    echo "JSON file not found!"
    return 1
  fi

  if [[ -z $key || -z $value ]]; then
    echo "Usage: update_json --key <key> --value <value> [--debug debug]"
    return 1
  fi

  if [[ $debug == "debug" ]]; then
    echo "Contents of $json_file before update:"
    cat $json_file
  fi
  
  # Update the JSON file using jq
  jq --arg key "$key" --arg value "$value" '
    setpath(([$key] | split(".")); $value)
  ' $json_file > tmp.$$.json && mv tmp.$$.json $json_file

  if [[ $debug == "debug" ]]; then
    echo "Contents of $json_file after update:"
    cat $json_file
  fi
}

# Export the function so it can be used in other scripts
export -f update_json
