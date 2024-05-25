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

update_html_file() {
  local title=""
  local subtitle=""
  local application=""
  local environment=""
  local deployed_version=""
  local new_version=""
  local deployment_status=""
  local deployment_progress=""
  local last_updated=""
  local buildkite_job=""
  local application_link=""

  while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
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
      *)
        shift
        ;;
    esac
  done

  # Read the existing HTML template
  html_file="./assets/template.html"
  html_content=$(cat "$html_file")

  # Escape variables for sed
  escaped_title=$(printf '%s\n' "$title" | sed 's/[\/&]/\\&/g')
  escaped_subtitle=$(printf '%s\n' "$subtitle" | sed 's/[\/&]/\\&/g')

  # Update title and subtitle in HTML content using different delimiter
  html_content=$(echo "$html_content" | sed "s|<p class=\"h3 pb1\">.*</p>|<p class=\"h3 pb1\">$escaped_title</p>|")
  html_content=$(echo "$html_content" | sed "s|<p>{{subtitle}}</p>|<p>$escaped_subtitle</p>|")

  # Generate the new table row
  new_row=$(cat <<EOF
    <tr>
      <td>$application</td>
      <td>$environment</td>
      <td>$deployed_version</td>
      <td>$new_version</td>
      <td>$deployment_status</td>
      <td>$deployment_progress</td>
      <td>$last_updated</td>
      <td>$buildkite_job</td>
      <td>$application_link</td>
    </tr>
EOF
)

  # Insert the new row before the </table> tag
  html_content=$(echo "$html_content" | sed "s|{{table_rows}}|$new_row\n    {{table_rows}}|")

  # Remove the {{table_rows}} placeholder
  html_content=$(echo "$html_content" | sed "s|{{table_rows}}||")

  # Save the updated HTML content back to the file
  echo "$html_content" > "$html_file"
}

# Example usage within a script
update_html_file \
  --title "🐥 Buildkite Deployment Status Demo" \
  --subtitle "This annotation can be used to view the status of deployments" \
  --application ":bison: Bison" \
  --environment "Development" \
  --deployed-version ":github: 1a1e395" \
  --new-version ":github: c1fcce1" \
  --deployment-status "In Progress" \
  --deployment-progress "10" \
  --last-updated "" \
  --buildkite-job "Buildkite Job" \
  --application-link "Application Link"



























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
