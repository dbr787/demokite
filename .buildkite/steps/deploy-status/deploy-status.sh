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

# Function to update file content
update_file() {
    local template_file="./assets/template.html"
    local output_file="./assets/annotation.html"

    # Named parameters
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

    # Parsing named parameters
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --title)
                new_title="$2"
                shift 2
                ;;
            --subtitle)
                new_subtitle="$2"
                shift 2
                ;;
            --application)
                application="$2"
                shift 2
                ;;
            --environment)
                environment="$2"
                shift 2
                ;;
            --deployed-version)
                deployed_version="$2"
                shift 2
                ;;
            --new-version)
                new_version="$2"
                shift 2
                ;;
            --deployment-status)
                deployment_status="$2"
                shift 2
                ;;
            --deployment-progress)
                deployment_progress="$2"
                shift 2
                ;;
            --last-updated)
                last_updated="$2"
                shift 2
                ;;
            --buildkite-job)
                buildkite_job="$2"
                shift 2
                ;;
            --application-link)
                application_link="$2"
                shift 2
                ;;
            *)
                echo "Unknown parameter: $1"
                exit 1
                ;;
        esac
    done

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

    # Read the content of the annotation.html file and update or add the row
    local table_rows_content
    table_rows_content=$(awk -v app="$application" -v env="$environment" -v new_row="$new_table_row" '
    BEGIN { row_exists = 0 }
    /<tr>/ {
        if ($0 ~ "<td>" app "</td>" && $0 ~ "<td>" env "</td>") {
            if (!row_exists) {
                print new_row
                row_exists = 1
            }
        } else {
            print
        }
    }
    END {
        if (!row_exists) {
            print new_row
        }
    }
    ' "$output_file")

    # Replace {{table_rows}} with the new content
    awk -v new_table_rows="$table_rows_content" '
    {
        if ($0 ~ /{{table_rows}}/) {
            gsub(/{{table_rows}}/, new_table_rows)
        }
        print
    }
    ' "$output_file" > "${output_file}.tmp" && mv "${output_file}.tmp" "$output_file"

    # Update the title and subtitle
    sed -i "s/{{title}}/${new_title}/g" "$output_file"
    sed -i "s/{{subtitle}}/${new_subtitle}/g" "$output_file"

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

update_file --title "New Title" \
            --subtitle "New Subtitle" \
            --application "App1" \
            --environment "Env1" \
            --deployed-version "1.0" \
            --new-version "1.1" \
            --deployment-status "Success" \
            --deployment-progress "100%" \
            --last-updated "2024-05-25" \
            --buildkite-job "Job1" \
            --application-link "http://example.com"

ls -la ./assets
cat ./assets/template.html
cat ./assets/annotation.html

printf '%b\n' "$(cat ./assets/annotation.html)" | buildkite-agent annotate --style 'info' --context 'example'
