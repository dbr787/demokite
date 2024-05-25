#!/bin/bash

# set explanation: https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425
# set -euxo pipefail # print executed commands to the terminal
set -euo pipefail # don't print executed commands to the terminal

# source shared functions
. .buildkite/assets/functions.sh;

# capture original working directory
current_dir=$(pwd)
current_dir_contents=$(ls -lah "$current_dir")

# change into step directory
cd .buildkite/steps/deploy-status/;

# Function to update file content
update_file() {
    local template_file="./assets/template.html"
    local output_file="./assets/annotation.html"
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

    # Escape slashes and ampersands in the replacements
    local esc_new_title=$(printf '%s\n' "$new_title" | sed 's:[\\/&]:\\&:g')
    local esc_new_subtitle=$(printf '%s\n' "$new_subtitle" | sed 's:[\\/&]:\\&:g')
    local esc_new_table_row=$(printf '%s\n' "$new_table_row" | sed 's:[\\/&]:\\&:g')

    # Update the contents of the annotation.html file
    sed -i "s|{{title}}|${esc_new_title}|g" "$output_file"
    sed -i "s|{{subtitle}}|${esc_new_subtitle}|g" "$output_file"
    sed -i "s|{{table_rows}}|${esc_new_table_row}|g" "$output_file"

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
