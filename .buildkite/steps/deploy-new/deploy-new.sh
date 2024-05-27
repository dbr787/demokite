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

minus_2_comment=$(git log -1 --pretty=format:%h HEAD~2)
previous_commit=$(git log -1 --pretty=format:%h HEAD~1)
current_commit=$(git log -1 --pretty=format:%h)

deployment_key="deployments.llama-prod"
update_json --key "$deployment_key.old_version.text" --value "$previous_commit"
update_json --key "$deployment_key.new_version.text" --value "$current_commit"
deployment_key="deployments.llama-dev"
update_json --key "$deployment_key.old_version.text" --value "$previous_commit"
update_json --key "$deployment_key.new_version.text" --value "$current_commit"
deployment_key="deployments.kangaroo-prod"
update_json --key "$deployment_key.old_version.text" --value "$minus_2_comment"
update_json --key "$deployment_key.new_version.text" --value "$current_commit"
deployment_key="deployments.kangaroo-dev"
update_json --key "$deployment_key.old_version.text" --value "$minus_2_comment"
update_json --key "$deployment_key.new_version.text" --value "$current_commit"
update_annotation --debug "debug";
sleep 5;

start_time=$(date +"%Y-%m-%d %H:%M:%S")
start_time_epoch=$(date +"%s")
calculate_duration() {
  local current_time_epoch=$(date +"%s")
  echo "$((current_time_epoch - start_time_epoch))s"
}
deployment_key="deployments.llama-dev"
update_json --key "$deployment_key.started.text" --value "$start_time"
update_json --key "$deployment_key.deployment_progress.text" --value ":white_circle::white_circle::white_circle::white_circle::white_circle:"
update_json --key "$deployment_key.deployment_status.emoji" --value ":bk-status-running:"
update_json --key "$deployment_key.deployment_status.text" --value "In Progress"
update_json --key "$deployment_key.deployment_status.class" --value "center bold orange"
update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
update_annotation
sleep 2
deployment_key="deployments.kangaroo-dev"
update_json --key "$deployment_key.started.text" --value "$start_time"
update_json --key "$deployment_key.deployment_progress.text" --value ":white_circle::white_circle::white_circle::white_circle::white_circle:"
update_json --key "$deployment_key.deployment_status.emoji" --value ":bk-status-running:"
update_json --key "$deployment_key.deployment_status.text" --value "In Progress"
update_json --key "$deployment_key.deployment_status.class" --value "center bold orange"
update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
update_annotation
sleep 5

deployment_key="deployments.llama-dev"
update_json --key "$deployment_key.deployment_progress.text" --value ":large_green_circle::white_circle::white_circle::white_circle::white_circle:"
update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
update_annotation
sleep 1
deployment_key="deployments.kangaroo-dev"
update_json --key "$deployment_key.deployment_progress.text" --value ":large_green_circle::white_circle::white_circle::white_circle::white_circle:"
update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
update_annotation
sleep 5

deployment_key="deployments.llama-dev"
update_json --key "$deployment_key.deployment_progress.text" --value ":large_green_circle::large_green_circle::white_circle::white_circle::white_circle:"
update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
update_annotation
sleep 1
deployment_key="deployments.kangaroo-dev"
update_json --key "$deployment_key.deployment_progress.text" --value ":large_green_circle::large_green_circle::white_circle::white_circle::white_circle:"
update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
update_annotation
sleep 5

deployment_key="deployments.llama-dev"
update_json --key "$deployment_key.deployment_progress.text" --value ":large_green_circle::large_green_circle::large_green_circle::white_circle::white_circle:"
update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
deployment_key="deployments.kangaroo-dev"
update_json --key "$deployment_key.deployment_progress.text" --value ":large_green_circle::large_green_circle::large_green_circle::white_circle::white_circle:"
update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
update_annotation
sleep 5

deployment_key="deployments.llama-dev"
update_json --key "$deployment_key.deployment_progress.text" --value ":large_green_circle::large_green_circle::large_green_circle::large_green_circle::white_circle:"
update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
update_annotation
sleep 5
deployment_key="deployments.kangaroo-dev"
update_json --key "$deployment_key.deployment_progress.text" --value ":large_green_circle::large_green_circle::large_green_circle::large_green_circle::white_circle:"
update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
update_annotation
sleep 1


deployment_key="deployments.llama-dev"
end_time=$(date +"%Y-%m-%d %H:%M:%S")
update_json --key "$deployment_key.finished.text" --value "$end_time"
update_json --key "$deployment_key.deployment_progress.text" --value ":large_green_circle::large_green_circle::large_green_circle::large_green_circle::large_green_circle:"
update_json --key "$deployment_key.deployment_status.emoji" --value ":bk-status-passed:"
update_json --key "$deployment_key.deployment_status.text" --value "Completed"
update_json --key "$deployment_key.deployment_status.class" --value "center bold green"
update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
update_annotation
sleep 2
deployment_key="deployments.kangaroo-dev"
end_time=$(date +"%Y-%m-%d %H:%M:%S")
update_json --key "$deployment_key.finished.text" --value "$end_time"
update_json --key "$deployment_key.deployment_progress.text" --value ":large_green_circle::large_green_circle::large_green_circle::large_green_circle::large_green_circle:"
update_json --key "$deployment_key.deployment_status.emoji" --value ":bk-status-passed:"
update_json --key "$deployment_key.deployment_status.text" --value "Completed"
update_json --key "$deployment_key.deployment_status.class" --value "center bold green"
update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
update_annotation
sleep 2

deployment_key="deployments.llama-prod"

start_time=$(date +"%Y-%m-%d %H:%M:%S")
start_time_epoch=$(date +"%s")
calculate_duration() {
  local current_time_epoch=$(date +"%s")
  echo "$((current_time_epoch - start_time_epoch))s"
}

update_json --key "$deployment_key.started.text" --value "$start_time"
update_json --key "$deployment_key.deployment_progress.text" --value ":white_circle::white_circle::white_circle::white_circle::white_circle:"
update_json --key "$deployment_key.deployment_status.emoji" --value ":bk-status-running:"
update_json --key "$deployment_key.deployment_status.text" --value "In Progress"
update_json --key "$deployment_key.deployment_status.class" --value "center bold orange"
update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
update_annotation
sleep 7

update_json --key "$deployment_key.deployment_progress.text" --value ":large_green_circle::white_circle::white_circle::white_circle::white_circle:"
update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
update_annotation
sleep 7

update_json --key "$deployment_key.deployment_progress.text" --value ":large_green_circle::large_green_circle::white_circle::white_circle::white_circle:"
update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
update_annotation
sleep 7

update_json --key "$deployment_key.deployment_progress.text" --value ":large_green_circle::large_green_circle::large_green_circle::white_circle::white_circle:"
update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
update_annotation
sleep 7

update_json --key "$deployment_key.deployment_progress.text" --value ":large_green_circle::large_green_circle::large_green_circle::large_green_circle::white_circle:"
update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
update_annotation
sleep 7

end_time=$(date +"%Y-%m-%d %H:%M:%S")
update_json --key "$deployment_key.finished.text" --value "$end_time"
update_json --key "$deployment_key.deployment_progress.text" --value ":large_green_circle::large_green_circle::large_green_circle::large_green_circle::large_green_circle:"
update_json --key "$deployment_key.deployment_status.emoji" --value ":bk-status-passed:"
update_json --key "$deployment_key.deployment_status.text" --value "Completed"
update_json --key "$deployment_key.deployment_status.class" --value "center bold green"
update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
update_annotation

ls -lah ./assets/;
