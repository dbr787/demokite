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

# Source local update functions
source ./assets/update_json.sh
source ./assets/update_html.sh
source ./assets/annotate_buildkite.sh

# update_json --key "deployments.bison-dev.deployment_status.text" --value "Updated Status Text" --debug "debug"
update_json --key "deployments.bison-dev.deployment_status.text" --value "Updated Status Text"
update_html --debug "debug"
annotate_buildkite --debug "debug"

# cat ./assets/annotation.html | buildkite-agent annotate --style "info" --context "deploy-01"
