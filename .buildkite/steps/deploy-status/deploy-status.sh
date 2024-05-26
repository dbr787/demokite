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

# Function to update the JSON file
update_json() {
    local template_file="./assets/template.json"
    local json_file="./assets/deployment.json"

    # Named parameters with default values
    local new_title=""
    local new_subtitle=""
    local application=""
    local environment=""
    local deployed_version=""
    local new_version=""
    local deployment_status=""
    local deployment_progress=""
    local last_updated=""
    local buildkite_job=""
    local application_link=""

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

    # If deployment.json does not exist, create it from the template
    if [[ ! -f "$json_file" ]]; then
        cp "$template_file" "$json_file"
    fi

    # Display contents of the original JSON file for troubleshooting
    echo "Contents of the original JSON file:"
    cat "$json_file"

    # Update the JSON file
    updated_json=$(jq 'if $new_title != "" then .title = $new_title else . end |
        if $new_subtitle != "" then .subtitle = $new_subtitle else . end |
        if $application != "" and $environment != "" then 
            .deployments |= (map(if .application == $application and .environment == $environment then 
                .deployed_version = $deployed_version | 
                .new_version = $new_version | 
                .deployment_status = $deployment_status | 
                .deployment_progress = $deployment_progress | 
                .last_updated = $last_updated | 
                .buildkite_job = $buildkite_job | 
                .application_link = $application_link 
            else . end) 
            + if map(.application == $application and .environment == $environment) | any then [] else [{
                "application": $application,
                "environment": $environment,
                "deployed_version": $deployed_version,
                "new_version": $new_version,
                "deployment_status": $deployment_status,
                "deployment_progress": $deployment_progress,
                "last_updated": $last_updated,
                "buildkite_job": $buildkite_job,
                "application_link": $application_link
            }] end)
        else . end' --arg new_title "$new_title" \
                    --arg new_subtitle "$new_subtitle" \
                    --arg application "$application" \
                    --arg environment "$environment" \
                    --arg deployed_version "$deployed_version" \
                    --arg new_version "$new_version" \
                    --arg deployment_status "$deployment_status" \
                    --arg deployment_progress "$deployment_progress" \
                    --arg last_updated "$last_updated" \
                    --arg buildkite_job "$buildkite_job" \
                    --arg application_link "$application_link" \
        "$json_file")

    # Save updated JSON to file
    echo "$updated_json" > "$json_file"

    # Display contents of the updated JSON file for troubleshooting
    echo "Contents of the updated JSON file:"
    cat "$json_file"

    # Create the timestamped backup of the updated JSON file
    local dir_path
    local file_name
    dir_path=$(dirname "$json_file")
    file_name=$(basename "$json_file" .json)
    local timestamp
    timestamp=$(date +%Y%m%d%H%M%S)
    local timestamped_file="${dir_path}/${file_name}-${timestamp}.json"
    cp "$json_file" "$timestamped_file"

    echo "JSON file updated successfully: $json_file"
    echo "Timestamped backup created at: $timestamped_file"
}

update_json --title "New Title" \
            --subtitle "New Subtitle" \
            --application ":bison: Bison" \
            --environment "Development" \
            --deployed-version ":github: BLAH" \
            --new-version ":github: BLOO" \
            --deployment-status "Success" \
            --deployment-progress 10 \
            --last-updated "" \
            --buildkite-job "Buildkite Job" \
            --application-link "Application Link"

sleep 5;
update_json --title "Another New Title"

sleep 5;
update_json --subtitle "Another New Subtitle"

sleep 5;
update_json --subtitle "Another New Subtitle"


# List the contents of the directory to verify
ls -lah ./assets/
