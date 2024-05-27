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

# create the annotation from the original json file
update_annotation --debug "debug";
sleep 5;

# update values in the json file
deployment_key="deployments.bison-dev"
update_json --key "$deployment_key.old_version.text" --value "$previous_commit" --debug "debug";
update_json --key "$deployment_key.new_version.text" --value "$current_commit";
update_json --key "$deployment_key.deployment_strategy.text" --value "Canary";
update_json --key "$deployment_key.deployment_progress.text" --value ":large_green_circle::white_circle::white_circle::white_circle::white_circle:";
update_json --key "$deployment_key.deployment_status.text" --value "Updated Status Text" ;

# update the annotation
update_annotation --debug "debug";
sleep 5;

ls -lah ./assets/;
