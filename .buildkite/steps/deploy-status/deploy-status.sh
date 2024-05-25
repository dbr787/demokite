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

# Function to update file content
update_file() {
    local template_file="template.html"
    local output_file="annotation.html"
    local new_title="$1"
    local new_subtitle="$2"
    local application="$3"
    local environment="$4"
    local deployed_version="$5"
    local new_version="$6"
    local deployment_status="$7"
    local deployment_progress="$8"
    local last_updated="$9"
    local buildkite_job="${10}"
    local application_link="${11}"
    
    # Check if the template file exists
    if [[ ! -f "$template_file" ]]; then
        echo "Template file not found!"
        return 1
    fi

    # If annotation.html does not exist, create it from the template
    if [[ ! -f "$output_file" ]]; then
        cp "$template_file" "$output_file"
    fi

    # Create the new table row
    local new_table_row="<tr>
        <td>${application}</td>
        <td>${environment}</td>
        <td>${deployed_version}</td>
        <td>${new_version}</td>
        <td>${deployment_status}</td>
        <td>${deployment_progress}</td>
        <td>${last_updated}</td>
        <td>${buildkite_job}</td>
        <td><a href=\"${application_link}\">Link</a></td>
    </tr>"

    # Update the contents of the annotation.html file
    sed -i "s/{{title}}/${new_title}/g" "$output_file"
    sed -i "s/{{subtitle}}/${new_subtitle}/g" "$output_file"
    sed -i "s/{{table_rows}}/${new_table_row}/g" "$output_file"

    # Create the timestamped backup of the updated annotation.html
    local dir_path
    local file_name
    dir_path=$(dirname "$output_file")
    file_name=$(basename "$output_file" .html)
    local timestamp
    timestamp=$(date +%Y%m%d%H%M%S)
    local timestamped_file="${dir_path}/${file_name}_${timestamp}.html"
    cp "$output_file" "$timestamped_file"
    
    echo "Output file updated successfully. Timestamped file created at $timestamped_file"
}

# Example usage
# Uncomment the following line to run the function with arguments
update_file "New Title" "New Subtitle" "App1" "Env1" "1.0" "1.1" "Success" "100%" "2024-05-25" "Job1" "http://example.com"




























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
