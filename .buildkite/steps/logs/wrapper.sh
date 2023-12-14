#!/bin/bash

# set explanation: https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425
# set -euxo pipefail # print executed commands to the terminal
set -euo pipefail # don't print executed commands to the terminal

. ./buildkite/steps/log/logs.sh | sed -e '/^---\s\|^+++\s\|^~~~\s/!s/^/  /'
