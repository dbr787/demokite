#!/bin/bash

# set explanation: https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425
# set -euxo pipefail # print executed commands to the terminal
set -euo pipefail # don't print executed commands to the terminal

# source shared functions
. .buildkite/assets/functions.sh;

# capture original working directory
current_dir=$(pwd);
current_dir_contents=$(ls -lah $current_dir);

# change into step directory
cd .buildkite/steps/deploy-progress/;

# source local functions
source ./assets/functions.sh;

# upload assets as artifacts
buildkite-agent artifact upload "assets/*.gif" --log-level error;

minus_2_comment=$(git log -1 --pretty=format:%h HEAD~2)
previous_commit=$(git log -1 --pretty=format:%h HEAD~1)
current_commit=$(git log -1 --pretty=format:%h)

update_json --key "deployments.llama-prod.old_version.text" --value "$previous_commit"
update_json --key "deployments.llama-prod.new_version.text" --value "$current_commit"
update_json --key "deployments.llama-dev.old_version.text" --value "$previous_commit"
update_json --key "deployments.llama-dev.new_version.text" --value "$current_commit"
update_json --key "deployments.kangaroo-prod.old_version.text" --value "$minus_2_comment"
update_json --key "deployments.kangaroo-prod.new_version.text" --value "$current_commit"
update_json --key "deployments.kangaroo-dev.old_version.text" --value "$minus_2_comment"
update_json --key "deployments.kangaroo-dev.new_version.text" --value "$current_commit"
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
sleep 3

deployment_key="deployments.llama-dev"
update_json --key "$deployment_key.deployment_progress.text" --value ":large_green_circle::large_green_circle::white_circle::white_circle::white_circle:"
update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
update_annotation
sleep 2

deployment_key="deployments.kangaroo-dev"
update_json --key "$deployment_key.deployment_progress.text" --value ":large_green_circle::white_circle::white_circle::white_circle::white_circle:"
update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
update_annotation
sleep 7

deployment_key="deployments.kangaroo-dev"
update_json --key "$deployment_key.deployment_progress.text" --value ":large_green_circle::large_green_circle::white_circle::white_circle::white_circle:"
update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
update_annotation
sleep 5

update_json --key "deployments.llama-dev.deployment_progress.text" --value ":large_green_circle::large_green_circle::large_green_circle::white_circle::white_circle:"
update_json --key "deployments.llama-dev.duration.text" --value "$(calculate_duration)"
update_json --key "deployments.kangaroo-dev.deployment_progress.text" --value ":large_green_circle::large_green_circle::large_green_circle::white_circle::white_circle:"
update_json --key "deployments.kangaroo-dev.duration.text" --value "$(calculate_duration)"
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
sleep 5

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
