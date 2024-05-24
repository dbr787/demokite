#!/bin/bash

# set explanation: https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425
# set -euxo pipefail # print executed commands to the terminal
set -euo pipefail # don't print executed commands to the terminal

# source shared functions
. .buildkite/assets/functions.sh;

# capture original working directory
current_dir=$(pwd)
current_dir_contents=$(ls -lah $current_dir)

# change into steps/annotations/ directory
cd .buildkite/steps/deploy-status/;

# replace variables in annotation file
FILE_PATH="./assets/example01.md"
TIMESTAMP=$(date)

ROW_1="<tr> <td>Bison</td> <td>Development</td> <td>1a1e395</td> <td>1a1e395</td> <td class=\"bold green\">Successful</td> <td>$TIMESTAMP</td> </tr>"
ROW_2="<tr> <td>Bison</td> <td>Development</td> <td>1a1e395</td> <td>1a1e395</td> <td class=\"bold green\">Successful</td> <td>$TIMESTAMP</td> </tr>"
ROW_3="<tr> <td>Bison</td> <td>Development</td> <td>1a1e395</td> <td>1a1e395</td> <td class=\"bold green\">Successful</td> <td>$TIMESTAMP</td> </tr>"

replace_file_var $FILE_PATH "\$BUILDKITE_BUILD_URL" "$BUILDKITE_BUILD_URL"
replace_file_var $FILE_PATH "\$BUILDKITE_JOB_ID" "$BUILDKITE_JOB_ID"
replace_file_var $FILE_PATH "\$BUILDKITE_LABEL" "$BUILDKITE_LABEL"
replace_file_var $FILE_PATH "\$ROW_1" "$ROW_1"

# annotate
# buildkite-agent annotate 'Example `error` style annotation' --style 'error' --context 'ctx-error'
# buildkite-agent annotate 'Example `warning` style annotation' --style 'warning' --context 'ctx-warning'
# buildkite-agent annotate 'Example `default` style annotation' --context 'ctx-default'
# buildkite-agent annotate 'Example `info` style annotation' --style 'info' --context 'ctx-info'

printf '%b\n' "$(cat $FILE_PATH)" | buildkite-agent annotate --style 'info' --context 'example'

sleep 5;




# upload assets as artifacts
buildkite-agent artifact upload "assets/*" --log-level error;
