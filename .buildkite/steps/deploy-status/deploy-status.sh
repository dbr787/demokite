#!/bin/bash

# set explanation: https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425
# set -euo pipefail # don't print executed commands to the terminal
set -euo pipefail

# source shared functions
. .buildkite/assets/functions.sh

# capture original working directory
current_dir=$(pwd)
current_dir_contents=$(ls -lah "$current_dir")

# change into step directory
cd .buildkite/steps/deploy-status/

# Function to escape special characters for sed
escape_string() {
    printf '%s\n' "$1" | sed -e 's/[\/&]/\\&/g'
}

# Function to update file content
update_file() {
    local template_file="./assets/template.html"
    local output_file="./assets/annotation.html"
    local new_title
    local new_subtitle
    local application
    local environment
    local deployed_version
    local new_version
    local deployment_status
    local deployment_progress
    local last_updated
    local buildkite_job
    local application_link

    # Assign escaped arguments to variables
    new_title=$(escape_string "$1")
    new_subtitle=$(escape_string "$2")
    application=$(escape_string "$3")
    environment=$(escape_string "$4")
    deployed_version=$(escape_string "$5")
    new_version=$(escape_string "$6")
    deployment_status=$(escape_string "$7")
    deployment_progress=$(escape_string "$8")
    last_updated=$(escape_string "$9")
    buildkite_job=$(escape_string "${10}")
    application_link=$(escape_string "${11}")

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

    new_table_row=$(escape_string "$new_table_row")

    # Create a temporary file for sed commands
    temp_file=$(mktemp)
    cp "$output_file" "$temp_file"

    # Update the contents of the annotation.html file
    sed -e "s/{{title}}/${new_title}/g" \
        -e "s/{{subtitle}}/${new_subtitle}/g" \
        -e "s/{{table_rows}}/${new_table_row}/g" \
        "$temp_file" > "$output_file"

    # Remove the temporary file
    rm "$temp_file"

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

update_file "New Title" "New Subtitle" "App1" "Env1" "1.0" "1.1" "Success" "100%" "2024-05-25" "Job1" "http://example.com"
