#!/bin/bash

update_json() {
  local json_file="./assets/annotation.json"
  local deployment_key=""
  local key=""
  local new_value=""
  local debug=""

  while [[ "$#" -gt 0 ]]; do
    case $1 in
      --deployment_key) deployment_key="$2"; shift ;;
      --key) key="$2"; shift ;;
      --new_value) new_value="$2"; shift ;;
      --debug) debug="$2"; shift ;;
      *) echo "Unknown parameter passed: $1"; return 1 ;;
    esac
    shift
  done

  if [[ ! -f $json_file ]]; then
    echo "JSON file not found!"
    return 1
  fi

  if [[ -z $deployment_key || -z $key || -z $new_value ]]; then
    echo "Usage: update_json --deployment_key <deployment_key> --key <key> --new_value <new_value> [--debug debug]"
    return 1
  fi

  if [[ $debug == "debug" ]]; then
    echo "Contents of $json_file before update:"
    cat $json_file
  fi
  
  # Update the JSON file using jq
  jq --arg deployment_key "$deployment_key" --arg key "$key" --arg new_value "$new_value" '
    (.deployments[$deployment_key] | .[$key]) = $new_value
  ' $json_file > tmp.$$.json && mv tmp.$$.json $json_file

  if [[ $debug == "debug" ]]; then
    echo "Contents of $json_file after update:"
    cat $json_file
  fi
}

# Export the function so it can be used in other scripts
export -f update_json
