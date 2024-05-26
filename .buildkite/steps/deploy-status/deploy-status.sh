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
    local new_style=""
    local new_context=""
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
            --style)
                new_style="$2"
                shift 2
                ;;
            --context)
                new_context="$2"
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
                echokite "Unknown parameter: $1" red none normal
                exit 1
                ;;
        esac
    done

    # Check if the template file exists
    if [[ ! -f "$template_file" ]]; then
        echokite "Template file not found!" red none normal
        return 1
    fi

    # If deployment.json does not exist, create it from the template
    if [[ ! -f "$json_file" ]]; then
        cp "$template_file" "$json_file"
    fi

    # Display contents of the original JSON file for troubleshooting
    echo "Contents of the original JSON file:"
    cat "$json_file"

    # Check if any meaningful parameter is provided
    if [[ -z "$new_title" && -z "$new_subtitle" && -z "$new_style" && -z "$new_context" && -z "$application" && -z "$environment" && -z "$deployed_version" && -z "$new_version" && -z "$deployment_status" && -z "$deployment_progress" && -z "$last_updated" && -z "$buildkite_job" && -z "$application_link" ]]; then
        echokite "No parameters provided. No updates will be made to the JSON file." red none normal
        return
    fi

    # Ensure at least application and environment are provided for deployment updates
    if [[ -n "$application" && -z "$environment" ]]; then
        echokite "Environment parameter is missing. No updates will be made to the JSON file." red none normal
        return
    fi

    if [[ -z "$application" && -n "$environment" ]]; then
        echokite "Application parameter is missing. No updates will be made to the JSON file." red none normal
        return
    fi

    # Ensure that if any deployment-specific parameter is provided, both application and environment are provided
    if [[ -z "$application" || -z "$environment" ]]; then
        if [[ -n "$deployed_version" || -n "$new_version" || -n "$deployment_status" || -n "$deployment_progress" || -n "$last_updated" || -n "$buildkite_job" || -n "$application_link" ]]; then
            echokite "Deployment-specific parameter provided without application and environment. No updates will be made to the JSON file." red none normal
            return
        fi
    fi

    # Update the JSON file
    updated_json=$(jq 'if $new_title != "" then .title = $new_title else . end |
        if $new_subtitle != "" then .subtitle = $new_subtitle else . end |
        if $new_style != "" then .style = $new_style else . end |
        if $new_context != "" then .context = $new_context else . end |
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
                    --arg new_style "$new_style" \
                    --arg new_context "$new_context" \
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
    timestamp=$(date -u +"%Y%m%d%H%M%S%3N")
    local timestamped_file="${dir_path}/${file_name}-${timestamp}.json"
    cp "$json_file" "$timestamped_file"

    echokite "JSON file updated successfully: $json_file" green none normal
    echokite "Timestamped backup created at: $timestamped_file" green none normal
}

# Function to update the HTML file from the JSON file
update_html() {
    local json_file="./assets/deployment.json"
    local html_template_file="./assets/template.html"
    local html_output_file="./assets/annotation.html"

    # Check if the JSON file exists
    if [[ ! -f "$json_file" ]]; then
        echokite "JSON file not found!" red none normal
        return 1
    fi

    # Check if the HTML template file exists
    if [[ ! -f "$html_template_file" ]]; then
        echokite "HTML template file not found!" red none normal
        return 1
    fi

    # Display contents of the original HTML file for troubleshooting
    echo "Contents of the original HTML file:"
    cat "$html_template_file"

    # Read values from the JSON file
    local title
    title=$(jq -r '.title' "$json_file")
    local subtitle
    subtitle=$(jq -r '.subtitle' "$json_file")

    # Generate table rows from deployments
    local table_rows
    table_rows=$(jq -r '.deployments | map("<tr><td>" + .application + "</td><td>" + .environment + "</td><td>" + .deployed_version + "</td><td>" + .new_version + "</td><td>" + .deployment_status + "</td><td>" + (.deployment_progress|tostring) + "</td><td>" + .last_updated + "</td><td>" + .buildkite_job + "</td><td><a href=\"" + .application_link + "\">Link</a></td></tr>") | join("")' "$json_file")

    # Read the HTML template content
    local html_content
    html_content=$(<"$html_template_file")

    # Replace placeholders with values
    html_content=$(echo "$html_content" | sed "s/{{title}}/$title/" | sed "s/{{subtitle}}/$subtitle/" | sed "s/{{table_rows}}/$table_rows/")

    # Display contents of the updated HTML file for troubleshooting
    echo "Contents of the updated HTML file:"
    echo "$html_content"

    # Save the updated HTML content to the output file
    echo "$html_content" > "$html_output_file"

    echokite "HTML file updated successfully: $html_output_file" green none normal
}

update_json \
  --title "New Title" \
  --subtitle "New Subtitle" \
  --style "success" \
  --context "deploy-02" \
  --application ":bison: Bison" \
  --environment "Development" \
  --deployed-version ":github: BLAH" \
  --new-version ":github: BLOO" \
  --deployment-status "Success" \
  --deployment-progress 10 \
  --last-updated "" \
  --buildkite-job "Buildkite Job" \
  --application-link "Application Link"

sleep 5
update_html

sleep 5
update_json \
  --title "Another New Title"

sleep 5
update_html

sleep 5
update_json \
  --subtitle "Another New Subtitle"

sleep 5
update_html

sleep 5
update_json \
  --style "warning"

sleep 5
update_html

sleep 5
update_json \
  --context "deploy-03"

sleep 5
update_html

sleep 5
update_json \
  --application "MyNewApp"

# shouldn't work
sleep 5
update_json \
  --environment "MyNewEnv"

# create new row
sleep 5
update_json \
  --application "MyNewApp" \
  --environment "MyNewEnv"

# shouldn't work
sleep 5
update_json \
  --deployed-version "MyNewEnv"

# shouldn't work
sleep 5
update_json \
  --last-updated "ages ago"

# List the contents of the directory to verify
ls -lah ./assets/
