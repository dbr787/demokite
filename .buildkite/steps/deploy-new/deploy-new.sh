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
cd .buildkite/steps/deploy-new/

# source local functions
source ./assets/functions.sh

previous_commit=$(git log -1 --pretty=format:%h HEAD~1)
current_commit=$(git log -1 --pretty=format:%h)
start_time=$(date -u +"%Y-%m-%dT%H:%M:%S.%3NZ")
calculate_duration() {
  local start_time="$1"
  local current_time=$(date -u +"%Y-%m-%dT%H:%M:%S.%3NZ")
  local start_seconds=$(date -u -d "$start_time" +"%s")
  local current_seconds=$(date -u -d "$current_time" +"%s")
  echo $((current_seconds - start_seconds))
}

deployment_key="deployments.llama-dev"
update_json --key "$deployment_key.old_version.text" --value "$previous_commit"
update_json --key "$deployment_key.new_version.text" --value "$current_commit"
update_annotation --debug "debug";
sleep 5;

update_json --key "$deployment_key.deployment_progress.text" --value ":large_green_circle::white_circle::white_circle::white_circle::white_circle:"
update_json --key "$deployment_key.deployment_status.emoji" --value ":bk-status-running:"
update_json --key "$deployment_key.deployment_status.text" --value "In Progress"
update_json --key "$deployment_key.deployment_status.class" --value "bold orange"
update_json --key "$deployment_key.duration.text" --value "$(calculate_duration $start_time) seconds"
update_annotation
sleep 2

update_json --key "$deployment_key.deployment_progress.text" --value ":large_green_circle::large_green_circle::white_circle::white_circle::white_circle:"
update_json --key "$deployment_key.duration.text" --value "$(calculate_duration $start_time) seconds"
update_annotation
sleep 2

update_json --key "$deployment_key.deployment_progress.text" --value ":large_green_circle::large_green_circle::large_green_circle::white_circle::white_circle:"
update_json --key "$deployment_key.duration.text" --value "$(calculate_duration $start_time) seconds"
update_annotation
sleep 2

update_json --key "$deployment_key.deployment_progress.text" --value ":large_green_circle::large_green_circle::large_green_circle::large_green_circle::white_circle:"
update_json --key "$deployment_key.duration.text" --value "$(calculate_duration $start_time) seconds"
update_annotation
sleep 2

end_time=$(date -u +"%Y-%m-%dT%H:%M:%S.%3NZ")
update_json --key "$deployment_key.started.text" --value "$end_time"
update_json --key "$deployment_key.deployment_progress.text" --value ":large_green_circle::large_green_circle::large_green_circle::large_green_circle::large_green_circle:"
update_json --key "$deployment_key.deployment_status.emoji" --value ":bk-status-passed:"
update_json --key "$deployment_key.deployment_status.text" --value "Completed"
update_json --key "$deployment_key.deployment_status.class" --value "bold green"
update_json --key "$deployment_key.duration.text" --value "$(calculate_duration $start_time) seconds"
update_annotation
# sleep 2

ls -lah ./assets/;
