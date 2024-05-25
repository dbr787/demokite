#!/bin/bash

# set explanation: https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425
# set -euxo pipefail # print executed commands to the terminal
set -euo pipefail # don't print executed commands to the terminal

# source shared functions
. .buildkite/assets/functions.sh;

# capture original working directory
current_dir=$(pwd)
current_dir_contents=$(ls -lah $current_dir)

# change into step directory
cd .buildkite/steps/deploy-status/;

update_html_table() {
  local application=""
  local environment=""
  local deployed_version=""
  local new_version=""
  local deployment_status=""
  local deployment_progress=""
  local last_updated=""
  local buildkite_job=""
  local application_link=""
  local title=""
  local subtitle=""
  local annotation_style="info"
  local annotation_context="example"
  local original_html_file="annotation.html"  # Default value

  while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
      --application)
        application="$2"
        shift
        shift
        ;;
      --environment)
        environment="$2"
        shift
        shift
        ;;
      --deployed-version)
        deployed_version="$2"
        shift
        shift
        ;;
      --new-version)
        new_version="$2"
        shift
        shift
        ;;
      --deployment-status)
        deployment_status="$2"
        shift
        shift
        ;;
      --deployment-progress)
        deployment_progress="$2"
        shift
        shift
        ;;
      --last-updated)
        last_updated="$2"
        shift
        shift
        ;;
      --buildkite-job)
        buildkite_job="$2"
        shift
        shift
        ;;
      --application-link)
        application_link="$2"
        shift
        shift
        ;;
      --html-file)
        original_html_file="$2"
        shift
        shift
        ;;
      --title)
        title="$2"
        shift
        shift
        ;;
      --subtitle)
        subtitle="$2"
        shift
        shift
        ;;
      --annotation-style)
        annotation_style="$2"
        shift
        shift
        ;;
      --annotation-context)
        annotation_context="$2"
        shift
        shift
        ;;
      *)
        shift
        ;;
    esac
  done

  # Generate a unique HTML file name using a timestamp suffix
  timestamp=$(date +%Y%m%d%H%M%S)
  html_file="${original_html_file%.html}_$timestamp.html"

  # Check if the original HTML file exists, use template if not
  if [ ! -f "$original_html_file" ]; then
    cp ./assets/template.html "$original_html_file"
  fi

  # Function to generate table row
  generate_row() {
    echo "    <tr>
      <td>$application</td>
      <td>$environment</td>
      <td>$deployed_version</td>
      <td>$new_version</td>
      <td>$deployment_status</td>
      <td>$deployment_progress</td>
      <td>$last_updated</td>
      <td>$buildkite_job</td>
      <td>$application_link</td>
    </tr>"
  }

  # Read existing HTML content
  html_content=$(cat "$original_html_file")

  # Escape variables for sed
  escaped_title=$(printf '%s\n' "$title" | sed -e 's/[\/&]/\\&/g')
  escaped_subtitle=$(printf '%s\n' "$subtitle" | sed -e 's/[\/&]/\\&/g')

  # Update title and subtitle if provided
  if [[ -n "$title" ]]; then
    html_content=$(echo "$html_content" | sed "s|<p class=\"h3 pb1\">.*</p>|<p class=\"h3 pb1\">$escaped_title</p>|")
  fi
  if [[ -n "$subtitle" ]]; then
    html_content=$(echo "$html_content" | sed "s|<p>{{subtitle}}</p>|<p>$escaped_subtitle</p>|")
  fi

  # Check if the row exists
  if grep -q "<td>$application</td><td>$environment</td>" <<< "$html_content"; then
    # Update existing row
    updated_row=$(generate_row)
    html_content=$(echo "$html_content" | sed -z "s|<tr>\n.*<td>$application</td><td>$environment</td>.*\n</tr>|$updated_row|")
  else
    # Add new row
    new_row=$(generate_row)
    html_content=$(echo "$html_content" | sed "s|</table>|$new_row\n</table>|")
  fi

  # Save the updated HTML content to the new file
  echo "$html_content" > "$html_file"

  # Also update the original HTML file
  echo "$html_content" > "$original_html_file"

  # Run the buildkite-agent annotate command
  printf '%b\n' "$(cat "$html_file")" | buildkite-agent annotate --style "$annotation_style" --context "$annotation_context"
}

# Example usage within a script
update_html_table \
  --application ":bison: Bison" \
  --environment "Development" \
  --deployed-version ":github: 1a1e395" \
  --new-version ":github: c1fcce1" \
  --deployment-status "In Progress" \
  --deployment-progress "10" \
  --last-updated "" \
  --buildkite-job "Buildkite Job" \
  --application-link "Application Link" \
  --title "🐥 Buildkite Deployment Status Demo" \
  --subtitle "This annotation can be used to view the status of deployments" \
  --annotation-style "info" \
  --annotation-context "example"


























# update_html() {
#   json_input=$1
#   html_template=$2
#   html_output=$3

#   title=$(jq -r '.annotation.title' "$json_input")
#   subtitle=$(jq -r '.annotation.subtitle' "$json_input")

#   # Function to generate table rows
#   generate_rows() {
#     jq -c '.annotation.deployments[]' "$json_input" | while read -r deployment; do
#       application=$(echo "$deployment" | jq -r '.application')
#       environment=$(echo "$deployment" | jq -r '.environment')
#       deployed_version=$(echo "$deployment" | jq -r '.deployed_version')
#       new_version=$(echo "$deployment" | jq -r '.new_version')
#       deployment_status=$(echo "$deployment" | jq -r '.deployment_status')
#       deployment_progress=$(echo "$deployment" | jq -r '.deployment_progress')
#       last_updated=$(echo "$deployment" | jq -r '.last_updated')
#       buildkite_job=$(echo "$deployment" | jq -r '.buildkite_job')
#       application_link=$(echo "$deployment" | jq -r '.application_link')

#       echo "    <tr>
#       <td>$application</td>
#       <td>$environment</td>
#       <td>$deployed_version</td>
#       <td>$new_version</td>
#       <td>$deployment_status</td>
#       <td>$deployment_progress</td>
#       <td>$last_updated</td>
#       <td>$buildkite_job</td>
#       <td>$application_link</td>
#     </tr>"
#     done
#   }

#   # Generate the table rows
#   table_rows=$(generate_rows)

#   # Read the template and replace placeholders
#   sed -e "s|{{title}}|$title|g" \
#       -e "s|{{subtitle}}|$subtitle|g" \
#       -e "/{{table_rows}}/ {
#             r /dev/stdin
#             d
#           }" "$html_template" <<< "$table_rows" > "$html_output"
# }

# HTML_TEMPLATE="./assets/template.html"
# HTML_OUTPUT="./assets/output.html"
# JSON_INPUT="./assets/deploy-status.json"

# update_html "./assets/deploy-status.json" "./assets/template.html" "./assets/output.html"

# printf '%b\n' "$(cat ./assets/output.html)" | buildkite-agent annotate --style 'info' --context 'example'













# # replace variables in annotation file
# FILE_PATH="./assets/example01.md"

# EPOCH=$(date +%s)
# TEMP_FILE_PATH="./assets/example01-$EPOCH.md"
# cp "$FILE_PATH" "$TEMP_FILE_PATH"

# TIMESTAMP=$(date)
# TIMESTAMP=$(date +"%y-%m-%d %H:%M:%S:%3N %Z")
# ROW_1="<tr> <td>Bison</td> <td>Development</td> <td>:github: 1a1e395</td> <td>1a1e395</td> <td class=\"bold orange\">:bk-status-running: In Progress</td> <td>$TIMESTAMP</td> </tr>"
# ROW_2="<tr> <td>Bison</td> <td>Test</td> <td>1a1e395</td> <td>1a1e395</td> <td class=\"bold gray\">:bk-status-pending: Waiting</td> <td>$TIMESTAMP</td> </tr>"
# ROW_3="<tr> <td>Bison</td> <td>Production</td> <td>1a1e395</td> <td>1a1e395</td> <td class=\"bold gray\">:bk-status-pending: Waiting</td> <td>$TIMESTAMP</td> </tr>"

# replace_file_var $TEMP_FILE_PATH "\$BUILDKITE_BUILD_URL" "$BUILDKITE_BUILD_URL"
# replace_file_var $TEMP_FILE_PATH "\$BUILDKITE_JOB_ID" "$BUILDKITE_JOB_ID"
# replace_file_var $TEMP_FILE_PATH "\$BUILDKITE_LABEL" "$BUILDKITE_LABEL"
# replace_file_var $TEMP_FILE_PATH "<!--\$ROW_1-->\$" "$ROW_1"
# replace_file_var $TEMP_FILE_PATH "<!--\$ROW_2-->\$" "$ROW_2"
# replace_file_var $TEMP_FILE_PATH "<!--\$ROW_3-->\$" "$ROW_3"

# printf '%b\n' "$(cat $TEMP_FILE_PATH)" | buildkite-agent annotate --style 'info' --context 'example'

# sleep 10;

# EPOCH=$(date +%s)
# TEMP_FILE_PATH="./assets/example01-$EPOCH.md"
# cp "$FILE_PATH" "$TEMP_FILE_PATH"

# TIMESTAMP=$(date)
# TIMESTAMP=$(date +"%y-%m-%d %H:%M:%S:%3N %Z")
# ROW_1="<tr> <td>Bison</td> <td>Development</td> <td>1a1e395</td> <td>1a1e395</td> <td class=\"bold green\">:bk-status-passed: Successful</td> <td>$TIMESTAMP</td> </tr>"
# ROW_2="<tr> <td>Bison</td> <td>Test</td> <td>1a1e395</td> <td>1a1e395</td> <td class=\"bold gray\">:bk-status-pending: Waiting</td> <td>$TIMESTAMP</td> </tr>"
# ROW_3="<tr> <td>Bison</td> <td>Production</td> <td>1a1e395</td> <td>1a1e395</td> <td class=\"bold gray\">:bk-status-pending: Waiting</td> <td>$TIMESTAMP</td> </tr>"
# replace_file_var $TEMP_FILE_PATH "\$BUILDKITE_BUILD_URL" "$BUILDKITE_BUILD_URL"
# replace_file_var $TEMP_FILE_PATH "\$BUILDKITE_JOB_ID" "$BUILDKITE_JOB_ID"
# replace_file_var $TEMP_FILE_PATH "\$BUILDKITE_LABEL" "$BUILDKITE_LABEL"
# replace_file_var $TEMP_FILE_PATH "<!--\$ROW_1-->\$" "$ROW_1"
# replace_file_var $TEMP_FILE_PATH "<!--\$ROW_2-->\$" "$ROW_2"
# replace_file_var $TEMP_FILE_PATH "<!--\$ROW_3-->\$" "$ROW_3"

# printf '%b\n' "$(cat $TEMP_FILE_PATH)" | buildkite-agent annotate --style 'info' --context 'example'

# sleep 5;

# EPOCH=$(date +%s)
# TEMP_FILE_PATH="./assets/example01-$EPOCH.md"
# cp "$FILE_PATH" "$TEMP_FILE_PATH"

# TIMESTAMP=$(date)
# TIMESTAMP=$(date +"%y-%m-%d %H:%M:%S:%3N %Z")
# ROW_1="<tr> <td>Bison</td> <td>Development</td> <td>1a1e395</td> <td>1a1e395</td> <td class=\"bold green\">:bk-status-passed: Successful</td> <td>$TIMESTAMP</td> </tr>"
# ROW_2="<tr> <td>Bison</td> <td>Test</td> <td>1a1e395</td> <td>1a1e395</td> <td class=\"bold orange\">:bk-status-running: In Progress</td> <td>$TIMESTAMP</td> </tr>"
# ROW_3="<tr> <td>Bison</td> <td>Production</td> <td>1a1e395</td> <td>1a1e395</td> <td class=\"bold gray\">:bk-status-pending: Waiting</td> <td>$TIMESTAMP</td> </tr>"
# replace_file_var $TEMP_FILE_PATH "\$BUILDKITE_BUILD_URL" "$BUILDKITE_BUILD_URL"
# replace_file_var $TEMP_FILE_PATH "\$BUILDKITE_JOB_ID" "$BUILDKITE_JOB_ID"
# replace_file_var $TEMP_FILE_PATH "\$BUILDKITE_LABEL" "$BUILDKITE_LABEL"
# replace_file_var $TEMP_FILE_PATH "<!--\$ROW_1-->\$" "$ROW_1"
# replace_file_var $TEMP_FILE_PATH "<!--\$ROW_2-->\$" "$ROW_2"
# replace_file_var $TEMP_FILE_PATH "<!--\$ROW_3-->\$" "$ROW_3"

# printf '%b\n' "$(cat $TEMP_FILE_PATH)" | buildkite-agent annotate --style 'info' --context 'example'

# buildkite-agent annotate --style 'success' --context 'example'

# # upload assets as artifacts
# # buildkite-agent artifact upload "assets/*" --log-level error;
