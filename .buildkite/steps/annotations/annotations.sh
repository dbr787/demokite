#!/bin/bash

# set explanation: https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425
# set -euxo pipefail # print executed commands to the terminal
set -euo pipefail # don't print executed commands to the terminal

# feedback/issues
# tbc
# tbc
# tbc

# source shared functions
. .buildkite/assets/functions.sh;

# capture original working directory
cur_dir=$(pwd)
cur_dir_contents=$(ls -lah $cur_dir)

# change into steps/annotations/ directory
cd .buildkite/steps/annotations/;

# upload assets as artifacts
buildkite-agent artifact upload "assets/*" --log-level error;

# annotate
buildkite-agent annotate 'Example `default` style annotation' --context 'ctx-default'
buildkite-agent annotate 'Example `info` style annotation' --style 'info' --context 'ctx-info'
buildkite-agent annotate 'Example `warning` style annotation' --style 'warning' --context 'ctx-warning'
buildkite-agent annotate 'Example `error` style annotation' --style 'error' --context 'ctx-error'
buildkite-agent annotate 'Example `success` style annotation' --style 'success' --context 'ctx-success'
buildkite-agent annotate 'Example `info` style annotation with multiline text\n\nThis is the second line\n\nThis is the third line' --style 'info' --context 'ctx-info-multiline'
