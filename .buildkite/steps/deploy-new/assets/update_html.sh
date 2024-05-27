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
      def generate_td(deployment; field):
        "<td class=\"" + (deployment[field].class // "") + "\">" +
        if (deployment[field].link // "") != "" then
          "<a href=\"" + (deployment[field].link // "") + "\">" + (deployment[field].emoji // "") + " " + (deployment[field].text // "") + "</a>"
        else
          (deployment[field].emoji // "") + " " + (deployment[field].text // "")
        end + "</td>";

      .deployments | to_entries[] |
      "<tr>" +
      (["application", "environment", "old_version", "new_version", "deployment_strategy", "deployment_status", "deployment_progress", "started", "finished", "duration", "job", "deployment"]
      | map(generate_td(.value; .))) | join("") +
      "</tr>"
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
