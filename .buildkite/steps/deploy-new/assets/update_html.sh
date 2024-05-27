#!/bin/bash

update_html() {
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

  if [[ $debug == "debug" ]]; then
    echo "Contents of $html_file before update:"
    cat $html_file
  fi

  # Extract values from JSON
  local title=$(jq -r '.title' $json_file)
  local subtitle=$(jq -r '.subtitle' $json_file)
  local last_updated=$(jq -r '.last_updated' $json_file)

  # Function to generate table rows from JSON
  generate_table_rows() {
    jq -r '
      .deployments | to_entries[] | 
      "<tr>
        <td class=\"\(.value.application.class)\"><a href=\"\(.value.application.link)\">\(.value.application.text)</a></td>
        <td class=\"\(.value.environment.class)\"><a href=\"\(.value.environment.link)\">\(.value.environment.text)</a></td>
        <td class=\"\(.value.old_version.class)\"><a href=\"\(.value.old_version.link)\">\(.value.old_version.text)</a></td>
        <td class=\"\(.value.new_version.class)\"><a href=\"\(.value.new_version.link)\">\(.value.new_version.text)</a></td>
        <td class=\"\(.value.deployment_status.class)\"><a href=\"\(.value.deployment_status.link)\">\(.value.deployment_status.text)</a></td>
        <td class=\"\(.value.deployment_progress.class)\"><a href=\"\(.value.deployment_progress.link)\">\(.value.deployment_progress.text)</a></td>
        <td class=\"\(.value.last_updated.class)\"><a href=\"\(.value.last_updated.link)\">\(.value.last_updated.text)</a></td>
        <td class=\"\(.value.job.class)\"><a href=\"\(.value.job.link)\">\(.value.job.text)</a></td>
        <td class=\"\(.value.deployment.class)\"><a href=\"\(.value.deployment.link)\">\(.value.deployment.text)</a></td>
      </tr>"
    ' $json_file
  }

  # Generate table rows
  local table_rows=$(generate_table_rows)

  if [[ $debug == "debug" ]]; then
    echo "Contents of table_rows:"
    printf '%s\n' "$table_rows"
  fi

  # Escape special characters for sed and handle newlines
  local esc_table_rows=$(printf '%s\n' "$table_rows" | sed -z 's/\n/\\n/g' | sed -z 's/[\/&]/\\&/g')

  if [[ $debug == "debug" ]]; then
    echo "Contents of esc_table_rows:"
    printf '%s\n' "$esc_table_rows"
  fi

  # Replace placeholders in HTML template using a different delimiter
  sed -i -e "s|[[title]]|$esc_title|g" \
         -e "s|[[subtitle]]|$esc_subtitle|g" \
         -e "s|[[table_rows]]|$esc_table_rows|g" \
         -e "s|[[table_caption]]|Last updated: $esc_last_updated|g" \
         $html_file

  if [[ $debug == "debug" ]]; then
    echo "Contents of $html_file after update:"
    cat $html_file
  fi

  echo "Updated HTML file: $html_file"
}

# Export the function so it can be used in other scripts
export -f update_html
