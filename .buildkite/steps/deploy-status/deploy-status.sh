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

# Function to update the JSON and HTML files
update_files() {
    local json_template_file="./assets/template.json"
    local json_output_file="./assets/annotation.json"
    local html_template_file="./assets/template.html"
    local html_output_file="./assets/annotation.html"

    # Named parameters with default values
    local title=""
    local subtitle=""
    local style=""
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
                title="$2"
                shift 2
                ;;
            --subtitle)
                subtitle="$2"
                shift 2
                ;;
            --style)
                style="$2"
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

    # Check if any meaningful parameter is provided
    if [[ -z "$title" && -z "$subtitle" && -z "$style" && -z "$application" && -z "$environment" && -z "$deployed_version" && -z "$new_version" && -z "$deployment_status" && -z "$deployment_progress" && -z "$last_updated" && -z "$buildkite_job" && -z "$application_link" ]]; then
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

    # Check if the template JSON file exists
    if [[ ! -f "$json_template_file" ]]; then
        echokite "Template JSON file not found!" red none normal
        return 1
    fi

    # Create the JSON output file if it does not exist
    if [[ ! -f "$json_output_file" ]]; then
        cp "$json_template_file" "$json_output_file"
    fi

    # Read the context from the template JSON file
    local context=$(jq -r '.context' "$json_template_file")

    # Read the current style from the output JSON file
    local current_style=$(jq -r '.style' "$json_output_file")

    # Update the JSON file
    updated_json=$(jq 'if $title != "" then .title = $title else . end |
        if $subtitle != "" then .subtitle = $subtitle else . end |
        if $style != "" then .style = $style else . end |
        .context = $context |
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
        else . end' --arg title "$title" \
                    --arg subtitle "$subtitle" \
                    --arg style "$style" \
                    --arg context "$context" \
                    --arg application "$application" \
                    --arg environment "$environment" \
                    --arg deployed_version "$deployed_version" \
                    --arg new_version "$new_version" \
                    --arg deployment_status "$deployment_status" \
                    --arg deployment_progress "$deployment_progress" \
                    --arg last_updated "$last_updated" \
                    --arg buildkite_job "$buildkite_job" \
                    --arg application_link "$application_link" \
        "$json_output_file")

    # Check if there are updates to be made
    if [[ "$updated_json" == "$(cat "$json_output_file")" ]]; then
        echokite "No updates to be made." yellow none normal
        return
    fi

    # Save updated JSON to file
    echo "$updated_json" > "$json_output_file"

    # Display contents of the updated JSON file for troubleshooting
    echo "Updated JSON:"
    cat "$json_output_file"

    # Create the timestamped backup of the updated JSON file
    local dir_path=$(dirname "$json_output_file")
    local file_name=$(basename "$json_output_file" .json)
    local timestamp=$(date -u +"%Y%m%d%H%M%S%3N")
    local timestamped_file="${dir_path}/${file_name}-${timestamp}.json"
    cp "$json_output_file" "$timestamped_file"

    echokite "JSON file updated successfully: $json_output_file" green none normal
    echokite "Timestamped backup created at: $timestamped_file" green none normal

    # Check if the template HTML file exists
    if [[ ! -f "$html_template_file" ]]; then
        echokite "Template HTML file not found!" red none normal
        return 1
    fi

    # Create the HTML output file if it does not exist
    if [[ ! -f "$html_output_file" ]]; then
        cp "$html_template_file" "$html_output_file"
    fi

    # Read values from the JSON file
    local title=$(jq -r '.title' "$json_output_file")
    local subtitle=$(jq -r '.subtitle' "$json_output_file")
    local table_rows=$(jq -r '.deployments | map("<tr><td>" + .application + "</td><td>" + .environment + "</td><td>" + .deployed_version + "</td><td>" + .new_version + "</td><td>" + .deployment_status + "</td><td>" + (.deployment_progress|tostring) + "</td><td>" + .last_updated + "</td><td>" + .buildkite_job + "</td><td><a href=\"" + .application_link + "\">Link</a></td></tr>") | join("")' "$json_output_file")

    # Escape slashes and other special characters for sed
    title=$(echo "$title" | sed 's/[\/&]/\\&/g')
    subtitle=$(echo "$subtitle" | sed 's/[\/&]/\\&/g')
    table_rows=$(echo "$table_rows" | sed 's/[\/&]/\\&/g')

    # Read the HTML template content
    local html_content=$(<"$html_template_file")
    # Replace placeholders with values
    html_content=$(echo "$html_content" | sed "s/\[\[title\]\]/$title/" | sed "s/\[\[subtitle\]\]/$subtitle/" | sed "s/\[\[table_rows\]\]/$table_rows/")

    # Display contents of the updated HTML file for troubleshooting
    echo "Contents of the updated HTML file:"
    echo "$html_content"

    # Save the updated HTML content to the output file
    echo "$html_content" > "$html_output_file"

    # Create the timestamped backup of the updated HTML file
    local timestamped_html_file="${dir_path}/$(basename "$html_output_file" .html)-${timestamp}.html"
    cp "$html_output_file" "$timestamped_html_file"

    echokite "HTML file updated successfully: $html_output_file" green none normal
    echokite "Timestamped backup created at: $timestamped_html_file" green none normal

    # Pipe the contents of the final HTML file to the buildkite-agent annotate command
    echo "$html_content" | buildkite-agent annotate --style "$style" --context "$context"

    # If style is provided and different from current style, update it separately
    if [[ -n "$style" && "$style" != "$current_style" ]]; then
        buildkite-agent annotate --style "$style" --context "$context" --append
    fi
}

update_files \
  --title "New Title" \
  --subtitle "New Subtitle" \
  --style "success" \
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
update_files \
  --title "Another New Title"

sleep 5
update_files \
  --title "Another Another New Title"

sleep 5
update_files \
  --subtitle "Another New Subtitle"

sleep 5
update_files \
  --style "warning"

# # shouldn't work
# sleep 5
# update_files \
#   --application "MyNewApp"

# # shouldn't work
# sleep 5
# update_files \
#   --environment "MyNewEnv"

# create new row (kind of blank)
sleep 5
update_files \
  --application "MyNewApp" \
  --environment "MyNewEnv"

# # shouldn't work
# sleep 5
# update_files \
#   --deployed-version "MyNewEnv"

# # shouldn't work
# sleep 5
# update_files \
#   --last-updated "ages ago"

# List the contents of the directory to verify
ls -lah ./assets/
