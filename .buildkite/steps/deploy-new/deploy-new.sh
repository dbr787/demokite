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

# Source the combined update functions
source ./assets/update_script.sh

update_deployment --key "deployments.bison-dev.deployment_status.text" --value "Updated Status Text" --debug "debug"

# Annotate using buildkite-agent
update_annotation --debug "debug"