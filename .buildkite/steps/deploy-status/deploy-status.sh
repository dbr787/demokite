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
    echo "Running update_json function..."

    local json_file="./assets/deploy-status.json"

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

    # Check if the JSON file exists
    if [[ ! -f "$json_file" ]]; then
        echo "JSON file not found!"
        return 1
    fi

    # Update the JSON file
    jq 'if $new_title != "" then .title = $new_title else . end |
        if $new_subtitle != "" then .subtitle = $new_subtitle else . end |
        if $application != "" and $environment != "" then 
            .deployments |= map(if .application == $application and .environment == $environment then 
                .deployed_version = $deployed_version | 
                .new_version = $new_version | 
                .deployment_status = $deployment_status | 
                .deployment_progress = $deployment_progress | 
                .last_updated = $last_updated | 
                .buildkite_job = $buildkite_job | 
                .application_link = $application_link 
            else . end) 
            | if map(.application == $application and .environment == $environment) | any then . else .deployments += [{
                "application": $application,
                "environment": $environment,
                "deployed_version": $deployed_version,
                "new_version": $new_version,
                "deployment_status": $deployment_status,
                "deployment_progress": $deployment_progress,
                "last_updated": $last_updated,
                "buildkite_job": $buildkite_job,
                "application_link": $application_link
            }] end
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
        "$json_file" > "${json_file}.tmp" && mv "${json_file}.tmp" "$json_file"

    echo "JSON file updated successfully: $json_file"
}

# Function to generate HTML from the JSON file
generate_html() {
    echo "Running generate_html function..."

    local json_file="./assets/deploy-status.json"
    local template_file="./assets/template.html"
    local output_file="./assets/annotation.html"

    # Check if the JSON file exists
    if [[ ! -f "$json_file" ]]; then
        echo "JSON file not found!"
        return 1
    fi

    # Read values from the JSON file
    local title=$(jq -r '.title' "$json_file")
    local subtitle=$(jq -r '.subtitle' "$json_file")
    local table_rows=$(jq -r '.deployments[] | "<tr><td>" + .application + "</td><td>" + .environment + "</td><td>" + .deployed_version + "</td><td>" + .new_version + "</td><td>" + .deployment_status + "</td><td>" + (.deployment_progress|tostring) + "%</td><td>" + .last_updated + "</td><td>" + .buildkite_job + "</td><td><a href=\"" + .application_link + "\">Link</a></td></tr>"' "$json_file" | paste -sd "" -)

    # Create the HTML file from the template
    cp "$template_file" "$output_file"
    sed -i "s/{{title}}/${title}/g" "$output_file"
    sed -i "s/{{subtitle}}/${subtitle}/g" "$output_file"
    sed -i "s/{{table_rows}}/${table_rows}/g" "$output_file"

    echo "HTML file generated successfully: $output_file"
}

# Update JSON file with parameters
update_json --title "New Title" \
            --subtitle "New Subtitle" \
            --application ":bison: Bison" \
            --environment "Development" \
            --deployed-version ":github: 1a1e395" \
            --new-version ":github: c1fcce1" \
            --deployment-status "In Progress" \
            --deployment-progress 10 \
            --last-updated "" \
            --buildkite-job "Buildkite Job" \
            --application-link "Application Link"

# Generate HTML from updated JSON
generate_html

ls -lah ./assets/

printf '%b\n' "$(cat ./assets/annotation.html)" | buildkite-agent annotate --style 'info' --context 'example'
