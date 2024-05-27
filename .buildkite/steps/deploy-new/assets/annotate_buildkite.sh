#!/bin/bash

annotate_buildkite() {
  local json_file="./assets/annotation.json"
  local html_file="./assets/annotation.html"
  local debug=""

  while [[ "$#" -gt 0 ]]; do
    case $1 in
      --debug) debug="$2"; shift ;;
      *) echo "Unknown parameter passed: $1"; return 1 ;;
    esac
    shift
  done

  # Check if the required files exist
  if [[ ! -f $json_file ]]; then
    echo "JSON file not found!"
    return 1
  fi

  if [[ ! -f $html_file ]]; then
    echo "HTML file not found!"
    return 1
  fi

  # Extract style and context from JSON
  local style=$(jq -r '.style // "info"' $json_file)
  local context=$(jq -r '.context // "deploy-01"' $json_file)

  if [[ $debug == "debug" ]]; then
    echo "Style: $style"
    echo "Context: $context"
  fi

  cat $html_file | buildkite-agent annotate --style "$style" --context "$context"
}

# Export the function so it can be used in other scripts
export -f annotate_buildkite
