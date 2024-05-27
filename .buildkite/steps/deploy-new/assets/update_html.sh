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
  local title=$(jq -r '.title // ""' $json_file)
  local subtitle=$(jq -r '.subtitle // ""' $json_file)

  # Get current time with milliseconds in UTC
  local last_updated=$(date -u +"%Y-%m-%dT%H:%M:%S.%3NZ")

  # Function to generate table rows from JSON
  generate_table_rows() {
    jq -r '
      .deployments | to_entries[] | 
      "<tr>
        <td class=\"\(.value.application.class // "")\">" + 
          if .value.application.link != "" then 
            "<a href=\"\(.value.application.link)\">\(.value.application.emoji // "") \(.value.application.text // "")</a>" 
          else 
            "\(.value.application.emoji // "") \(.value.application.text // "")" 
          end + "</td>
        <td class=\"\(.value.environment.class // "")\">" + 
          if .value.environment.link != "" then 
            "<a href=\"\(.value.environment.link)\">\(.value.environment.emoji // "") \(.value.environment.text // "")</a>" 
          else 
            "\(.value.environment.emoji // "") \(.value.environment.text // "")" 
          end + "</td>
        <td class=\"\(.value.old_version.class // "")\">" + 
          if .value.old_version.link != "" then 
            "<a href=\"\(.value.old_version.link)\">\(.value.old_version.emoji // "") \(.value.old_version.text // "")</a>" 
          else 
            "\(.value.old_version.emoji // "") \(.value.old_version.text // "")" 
          end + "</td>
        <td class=\"\(.value.new_version.class // "")\">" + 
          if .value.new_version.link != "" then 
            "<a href=\"\(.value.new_version.link)\">\(.value.new_version.emoji // "") \(.value.new_version.text // "")</a>" 
          else 
            "\(.value.new_version.emoji // "") \(.value.new_version.text // "")" 
          end + "</td>
        <td class=\"\(.value.deployment_strategy.class // "")\">" + 
          if .value.deployment_strategy.link != "" then 
            "<a href=\"\(.value.deployment_strategy.link)\">\(.value.deployment_strategy.emoji // "") \(.value.deployment_strategy.text // "")</a>" 
          else 
            "\(.value.deployment_strategy.emoji // "") \(.value.deployment_strategy.text // "")" 
          end + "</td>
        <td class=\"\(.value.deployment_status.class // "")\">" + 
          if .value.deployment_status.link != "" then 
            "<a href=\"\(.value.deployment_status.link)\">\(.value.deployment_status.emoji // "") \(.value.deployment_status.text // "")</a>" 
          else 
            "\(.value.deployment_status.emoji // "") \(.value.deployment_status.text // "")" 
          end + "</td>
        <td class=\"\(.value.deployment_progress.class // "")\">" + 
          if .value.deployment_progress.link != "" then 
            "<a href=\"\(.value.deployment_progress.link)\">\(.value.deployment_progress.emoji // "") \(.value.deployment_progress.text // "")</a>" 
          else 
            "\(.value.deployment_progress.emoji // "") \(.value.deployment_progress.text // "")" 
          end + "</td>
        <td class=\"\(.value.started.class // "")\">" + 
          if .value.started.link != "" then 
            "<a href=\"\(.value.started.link)\">\(.value.started.emoji // "") \(.value.started.text // "")</a>" 
          else 
            "\(.value.started.emoji // "") \(.value.started.text // "")" 
          end + "</td>
        <td class=\"\(.value.finished.class // "")\">" + 
          if .value.finished.link != "" then 
            "<a href=\"\(.value.finished.link)\">\(.value.finished.emoji // "") \(.value.finished.text // "")</a>" 
          else 
            "\(.value.finished.emoji // "") \(.value.finished.text // "")" 
          end + "</td>
        <td class=\"\(.value.duration.class // "")\">" + 
          if .value.duration.link != "" then 
            "<a href=\"\(.value.duration.link)\">\(.value.duration.emoji // "") \(.value.duration.text // "")</a>" 
          else 
            "\(.value.duration.emoji // "") \(.value.duration.text // "")" 
          end + "</td>
        <td class=\"\(.value.job.class // "")\">" + 
          if .value.job.link != "" then 
            "<a href=\"\(.value.job.link)\">\(.value.job.emoji // "") \(.value.job.text // "")</a>" 
          else 
            "\(.value.job.emoji // "") \(.value.job.text // "")" 
          end + "</td>
        <td class=\"\(.value.deployment.class // "")\">" + 
          if .value.deployment.link != "" then 
            "<a href=\"\(.value.deployment.link)\">\(.value.deployment.emoji // "") \(.value.deployment.text // "")</a>" 
          else 
            "\(.value.deployment.emoji // "") \(.value.deployment.text // "")" 
          end + "</td>
      </tr>"
    ' $json_file
  }

  # Generate table rows
  local table_rows=$(generate_table_rows)

  if [[ $debug == "debug" ]]; then
    echo "Contents of table_rows:"
    printf '%s\n' "$table_rows"
  fi

  # Replace placeholders in HTML template using awk
  awk -v title="$title" -v subtitle="$subtitle" -v table_rows="$table_rows" -v table_caption="Last updated: $last_updated" '
    {
      gsub(/\[\[title\]\]/, title);
      gsub(/\[\[subtitle\]\]/, subtitle);
      gsub(/\[\[table_rows\]\]/, table_rows);
      gsub(/\[\[table_caption\]\]/, table_caption);
    }
    {print}
  ' $html_file > tmp.html && mv tmp.html $html_file

  if [[ $debug == "debug" ]]; then
    echo "Contents of $html_file after update:"
    cat $html_file
  fi

  echo "Updated HTML file: $html_file"
}

# Export the function so it can be used in other scripts
export -f update_html