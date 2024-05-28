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
# buildkite-agent artifact upload "assets/*.gif" --log-level error;

echo $BUILDKITE_REPO

minus_2_commit_short=$(git log -1 --pretty=format:%h HEAD~2)
previous_commit_short=$(git log -1 --pretty=format:%h HEAD~1)
current_commit_short=$(git log -1 --pretty=format:%h)

minus_2_commit_long=$(git log -1 --pretty=format:%H HEAD~2)
previous_commit_long=$(git log -1 --pretty=format:%H HEAD~1)
current_commit_long=$(git log -1 --pretty=format:%H)

update_json --key "deployments.llama-prod.old_version.text" --value "$previous_commit_short"
update_json --key "deployments.llama-prod.new_version.text" --value "$current_commit_short"
update_json --key "deployments.llama-dev.old_version.text" --value "$previous_commit_short"
update_json --key "deployments.llama-dev.new_version.text" --value "$current_commit_short"
update_json --key "deployments.kangaroo-prod.old_version.text" --value "$minus_2_commit_short"
update_json --key "deployments.kangaroo-prod.new_version.text" --value "$current_commit_short"
update_json --key "deployments.kangaroo-dev.old_version.text" --value "$minus_2_commit_short"
update_json --key "deployments.kangaroo-dev.new_version.text" --value "$current_commit_short"
update_json --key "deployments.llama-prod.old_version.title" --value "$previous_commit_long"
update_json --key "deployments.llama-prod.new_version.title" --value "$current_commit_long"
update_json --key "deployments.llama-dev.old_version.title" --value "$previous_commit_long"
update_json --key "deployments.llama-dev.new_version.title" --value "$current_commit_long"
update_json --key "deployments.kangaroo-prod.old_version.title" --value "$minus_2_commit_long"
update_json --key "deployments.kangaroo-prod.new_version.title" --value "$current_commit_long"
update_json --key "deployments.kangaroo-dev.old_version.title" --value "$minus_2_commit_long"
update_json --key "deployments.kangaroo-dev.new_version.title" --value "$current_commit_long"
update_annotation --debug "debug";
sleep 5;

# Update the image attributes
update_json --key "tr_image.src" --value "https://static.wikia.nocookie.net/nyancat/images/a/ac/Nyan_BalloonBlue.gif/revision/latest?cb=20230128002915"
update_json --key "tr_image.alt" --value "A new image description"
update_json --key "tr_image.title" --value "A new tooltip title"
update_json --key "tr_image.width" --value "100"
# update_json --key "tr_image.class" --value "new-class"
# update_json --key "tr_image.link" --value "https://new.image.link/"
update_annotation --debug "debug";
sleep 5;


# Define start time and variations
start_time=$(date +"%Y-%m-%d %H:%M:%S")
start_time_epoch=$(date -d "$start_time" +"%s")
start_time_long=$(date -d "$start_time" +"%Y-%m-%d %H:%M:%S")
start_time_short=$(date -d "$start_time" +"%H:%M:%S")

# Function to calculate duration
calculate_duration() {
  local current_time_epoch=$(date +"%s")
  echo "$((current_time_epoch - start_time_epoch))s"
}

deployment_key="deployments.llama-dev"
update_json --key "$deployment_key.started.text" --value "$start_time_short"
update_json --key "$deployment_key.started.title" --value "$start_time_long"
update_json --key "$deployment_key.deployment_progress.text" --value ":white_circle::white_circle::white_circle::white_circle::white_circle:"
update_json --key "$deployment_key.deployment_status.emoji" --value ":bk-status-running:"
update_json --key "$deployment_key.deployment_status.text" --value "In Progress"
update_json --key "$deployment_key.deployment_status.class" --value "center bold orange"
# update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
update_annotation
sleep 2

deployment_key="deployments.kangaroo-dev"
update_json --key "$deployment_key.started.text" --value "$start_time_short"
update_json --key "$deployment_key.started.title" --value "$start_time_long"
update_json --key "$deployment_key.deployment_progress.text" --value ":white_circle::white_circle::white_circle::white_circle::white_circle:"
update_json --key "$deployment_key.deployment_status.emoji" --value ":bk-status-running:"
update_json --key "$deployment_key.deployment_status.text" --value "In Progress"
update_json --key "$deployment_key.deployment_status.class" --value "center bold orange"
# update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
update_annotation
sleep 5

deployment_key="deployments.llama-dev"
update_json --key "$deployment_key.deployment_progress.text" --value ":large_green_circle::white_circle::white_circle::white_circle::white_circle:"
# update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
update_annotation
sleep 3

deployment_key="deployments.llama-dev"
update_json --key "$deployment_key.deployment_progress.text" --value ":large_green_circle::large_green_circle::white_circle::white_circle::white_circle:"
# update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
update_annotation
sleep 2

deployment_key="deployments.kangaroo-dev"
update_json --key "$deployment_key.deployment_progress.text" --value ":large_green_circle::white_circle::white_circle::white_circle::white_circle:"
# update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
update_annotation
sleep 7

deployment_key="deployments.kangaroo-dev"
update_json --key "$deployment_key.deployment_progress.text" --value ":large_green_circle::large_green_circle::white_circle::white_circle::white_circle:"
# update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
update_annotation
sleep 5

deployment_key="deployments.llama-dev"
update_json --key "$deployment_key.deployment_progress.text" --value ":large_green_circle::large_green_circle::large_green_circle::white_circle::white_circle:"
# update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
deployment_key="deployments.kangaroo-dev"
update_json --key "$deployment_key.deployment_progress.text" --value ":large_green_circle::large_green_circle::large_green_circle::white_circle::white_circle:"
# update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
update_annotation
sleep 5

deployment_key="deployments.llama-dev"
update_json --key "$deployment_key.deployment_progress.text" --value ":large_green_circle::large_green_circle::large_green_circle::large_green_circle::white_circle:"
# update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
update_annotation
sleep 5

deployment_key="deployments.kangaroo-dev"
update_json --key "$deployment_key.deployment_progress.text" --value ":large_green_circle::large_green_circle::large_green_circle::large_green_circle::white_circle:"
# update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
update_annotation
sleep 1

deployment_key="deployments.llama-dev"
end_time=$(date +"%Y-%m-%d %H:%M:%S")
end_time_epoch=$(date -d "$end_time" +"%s")
end_time_long=$(date -d "$end_time" +"%Y-%m-%d %H:%M:%S")
end_time_short=$(date -d "$end_time" +"%H:%M:%S")
update_json --key "$deployment_key.finished.text" --value "$end_time_short"
update_json --key "$deployment_key.finished.title" --value "$end_time_long"
update_json --key "$deployment_key.deployment_progress.text" --value ":large_green_circle::large_green_circle::large_green_circle::large_green_circle::large_green_circle:"
update_json --key "$deployment_key.deployment_status.emoji" --value ":bk-status-passed:"
update_json --key "$deployment_key.deployment_status.text" --value "Completed"
update_json --key "$deployment_key.deployment_status.class" --value "center bold green"
update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
update_annotation
sleep 5

deployment_key="deployments.kangaroo-dev"
end_time=$(date +"%Y-%m-%d %H:%M:%S")
end_time_epoch=$(date -d "$end_time" +"%s")
end_time_long=$(date -d "$end_time" +"%Y-%m-%d %H:%M:%S")
end_time_short=$(date -d "$end_time" +"%H:%M:%S")
update_json --key "$deployment_key.finished.text" --value "$end_time_short"
update_json --key "$deployment_key.finished.title" --value "$end_time_long"
update_json --key "$deployment_key.deployment_progress.text" --value ":large_green_circle::large_green_circle::large_green_circle::large_green_circle::large_green_circle:"
update_json --key "$deployment_key.deployment_status.emoji" --value ":bk-status-passed:"
update_json --key "$deployment_key.deployment_status.text" --value "Completed"
update_json --key "$deployment_key.deployment_status.class" --value "center bold green"
update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
update_annotation
sleep 2

deployment_key="deployments.llama-prod"
start_time=$(date +"%Y-%m-%d %H:%M:%S")
start_time_epoch=$(date -d "$start_time" +"%s")
start_time_long=$(date -d "$start_time" +"%Y-%m-%d %H:%M:%S")
start_time_short=$(date -d "$start_time" +"%H:%M:%S")
update_json --key "$deployment_key.started.text" --value "$start_time_short"
update_json --key "$deployment_key.started.title" --value "$start_time_long"
update_json --key "$deployment_key.deployment_progress.text" --value ":white_circle::white_circle::white_circle::white_circle::white_circle:"
update_json --key "$deployment_key.deployment_status.emoji" --value ":bk-status-running:"
update_json --key "$deployment_key.deployment_status.text" --value "In Progress"
update_json --key "$deployment_key.deployment_status.class" --value "center bold orange"
# update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
update_annotation
sleep 7

update_json --key "$deployment_key.deployment_progress.text" --value ":large_green_circle::white_circle::white_circle::white_circle::white_circle:"
# update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
update_annotation
sleep 7

update_json --key "$deployment_key.deployment_progress.text" --value ":large_green_circle::large_green_circle::white_circle::white_circle::white_circle:"
# update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
update_annotation
sleep 7

update_json --key "$deployment_key.deployment_progress.text" --value ":large_green_circle::large_green_circle::large_green_circle::white_circle::white_circle:"
# update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
update_annotation
sleep 7

update_json --key "$deployment_key.deployment_progress.text" --value ":large_green_circle::large_green_circle::large_green_circle::large_green_circle::white_circle:"
# update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
update_annotation
sleep 7

end_time=$(date +"%Y-%m-%d %H:%M:%S")
end_time_epoch=$(date -d "$end_time" +"%s")
end_time_long=$(date -d "$end_time" +"%Y-%m-%d %H:%M:%S")
end_time_short=$(date -d "$end_time" +"%H:%M:%S")
update_json --key "$deployment_key.finished.text" --value "$end_time_short"
update_json --key "$deployment_key.finished.title" --value "$end_time_long"
update_json --key "$deployment_key.deployment_progress.text" --value ":large_green_circle::large_green_circle::large_green_circle::large_green_circle::large_green_circle:"
update_json --key "$deployment_key.deployment_status.emoji" --value ":bk-status-passed:"
update_json --key "$deployment_key.deployment_status.text" --value "Completed"
update_json --key "$deployment_key.deployment_status.class" --value "center bold green"
update_json --key "$deployment_key.duration.text" --value "$(calculate_duration)"
update_annotation

buildkite-agent annotate --style "success" --context "deploy-01"

ls -lah ./assets/;
