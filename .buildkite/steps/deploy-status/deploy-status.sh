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

EPOCH=$(date +%s)
TEMP_FILE_PATH="./assets/example01-$EPOCH.md"
cp "$FILE_PATH" "$TEMP_FILE_PATH"

TIMESTAMP=$(date)
TIMESTAMP=$(date +"%y-%m-%d %H:%M:%S:%3N %Z")
ROW_1="<tr> <td>Bison</td> <td>Development</td> <td>1a1e395</td> <td>1a1e395</td> <td class=\"bold orange\">:partyparrot: In Progress</td> <td>$TIMESTAMP</td> </tr>"
ROW_2="<tr> <td>Bison</td> <td>Test</td> <td>1a1e395</td> <td>1a1e395</td> <td class=\"bold gray\">Waiting</td> <td>$TIMESTAMP</td> </tr>"
ROW_3="<tr> <td>Bison</td> <td>Production</td> <td>1a1e395</td> <td>1a1e395</td> <td class=\"bold gray\">Waiting</td> <td>$TIMESTAMP</td> </tr>"

replace_file_var $TEMP_FILE_PATH "\$BUILDKITE_BUILD_URL" "$BUILDKITE_BUILD_URL"
replace_file_var $TEMP_FILE_PATH "\$BUILDKITE_JOB_ID" "$BUILDKITE_JOB_ID"
replace_file_var $TEMP_FILE_PATH "\$BUILDKITE_LABEL" "$BUILDKITE_LABEL"
replace_file_var $TEMP_FILE_PATH "<!--\$ROW_1-->\$" "$ROW_1"
replace_file_var $TEMP_FILE_PATH "<!--\$ROW_2-->\$" "$ROW_2"
replace_file_var $TEMP_FILE_PATH "<!--\$ROW_3-->\$" "$ROW_3"

printf '%b\n' "$(cat $TEMP_FILE_PATH)" | buildkite-agent annotate --style 'info' --context 'example'

sleep 10;

EPOCH=$(date +%s)
TEMP_FILE_PATH="./assets/example01-$EPOCH.md"
cp "$FILE_PATH" "$TEMP_FILE_PATH"

TIMESTAMP=$(date)
TIMESTAMP=$(date +"%y-%m-%d %H:%M:%S:%3N %Z")
ROW_1="<tr> <td>Bison</td> <td>Development</td> <td>1a1e395</td> <td>1a1e395</td> <td class=\"bold green\">:white_check_mark: Successful</td> <td>$TIMESTAMP</td> </tr>"
ROW_2="<tr> <td>Bison</td> <td>Test</td> <td>1a1e395</td> <td>1a1e395</td> <td class=\"bold gray\">Waiting</td> <td>$TIMESTAMP</td> </tr>"
ROW_3="<tr> <td>Bison</td> <td>Production</td> <td>1a1e395</td> <td>1a1e395</td> <td class=\"bold gray\">Waiting</td> <td>$TIMESTAMP</td> </tr>"
replace_file_var $TEMP_FILE_PATH "\$BUILDKITE_BUILD_URL" "$BUILDKITE_BUILD_URL"
replace_file_var $TEMP_FILE_PATH "\$BUILDKITE_JOB_ID" "$BUILDKITE_JOB_ID"
replace_file_var $TEMP_FILE_PATH "\$BUILDKITE_LABEL" "$BUILDKITE_LABEL"
replace_file_var $TEMP_FILE_PATH "<!--\$ROW_1-->\$" "$ROW_1"
replace_file_var $TEMP_FILE_PATH "<!--\$ROW_2-->\$" "$ROW_2"
replace_file_var $TEMP_FILE_PATH "<!--\$ROW_3-->\$" "$ROW_3"

printf '%b\n' "$(cat $TEMP_FILE_PATH)" | buildkite-agent annotate --style 'info' --context 'example'

sleep 5;

EPOCH=$(date +%s)
TEMP_FILE_PATH="./assets/example01-$EPOCH.md"
cp "$FILE_PATH" "$TEMP_FILE_PATH"

TIMESTAMP=$(date)
TIMESTAMP=$(date +"%y-%m-%d %H:%M:%S:%3N %Z")
ROW_1="<tr> <td>Bison</td> <td>Development</td> <td>1a1e395</td> <td>1a1e395</td> <td class=\"bold green\">Successful</td> <td>$TIMESTAMP</td> </tr>"
ROW_2="<tr> <td>Bison</td> <td>Test</td> <td>1a1e395</td> <td>1a1e395</td> <td class=\"bold orange\">In Progress</td> <td>$TIMESTAMP</td> </tr>"
ROW_3="<tr> <td>Bison</td> <td>Production</td> <td>1a1e395</td> <td>1a1e395</td> <td class=\"bold gray\">Waiting</td> <td>$TIMESTAMP</td> </tr>"
replace_file_var $TEMP_FILE_PATH "\$BUILDKITE_BUILD_URL" "$BUILDKITE_BUILD_URL"
replace_file_var $TEMP_FILE_PATH "\$BUILDKITE_JOB_ID" "$BUILDKITE_JOB_ID"
replace_file_var $TEMP_FILE_PATH "\$BUILDKITE_LABEL" "$BUILDKITE_LABEL"
replace_file_var $TEMP_FILE_PATH "<!--\$ROW_1-->\$" "$ROW_1"
replace_file_var $TEMP_FILE_PATH "<!--\$ROW_2-->\$" "$ROW_2"
replace_file_var $TEMP_FILE_PATH "<!--\$ROW_3-->\$" "$ROW_3"

printf '%b\n' "$(cat $TEMP_FILE_PATH)" | buildkite-agent annotate --style 'info' --context 'example'

# upload assets as artifacts
# buildkite-agent artifact upload "assets/*" --log-level error;
