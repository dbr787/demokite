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
printf '%b\n' "$(cat ./assets/example01.md)" | buildkite-agent annotate --style 'success' --context 'example01'

# cat <<-____EOF | cat
# <details>
# <summary>Wiz Docker Image Scan for $image_name does not meet policy requirements</summary>
# \`\`\`term
# Results of the scan goes here
# \`\`\`
# </details>
# ____EOF | buildkite-agent annotate --style 'warning' --context 'example02'

MY_TEST_VAR="test success"

echo -e "\`\`\`term\nThis is a $MY_TEST_VAR \033[0;31mtest\033[0m\n\`\`\`" | buildkite-agent annotate --style 'warning' --context 'example02'


cat <<EOT >> ./assets/greetings.md
line 1
line 2
EOT

printf '%b\n' "$(cat ./assets/greetings.md)" | buildkite-agent annotate --style 'success' --context 'example99'

# cat << EOF | buildkite-agent annotate --style 'warning' --context 'example03'
#   \`\`\`term\nThis is a $MY_TEST_VAR \033[0;31mtest\033[0m\n\`\`\`
# EOF

# cat << EOF | buildkite-agent annotate --style 'warning' --context 'example04'
#   ```term\nThis is a $MY_TEST_VAR \033[0;31mtest\033[0m\n```
# EOF

# printf '%b\n' "$(cat << EOF | buildkite-agent annotate --style 'warning' --context 'example04'
#   \`\`\`term\nThis is a $MY_TEST_VAR \033[0;31mtest\033[0m\n\`\`\`
# EOF)"

# printf '%b\n' "$(cat << EOF | buildkite-agent annotate --style 'warning' --context 'example04'
#   ```term\nThis is a $MY_TEST_VAR \033[0;31mtest\033[0m\n```
# EOF"

# buildkite-agent annotate 'Example `default` style annotation' --context 'ctx-default'
# buildkite-agent annotate 'Example `info` style annotation' --style 'info' --context 'ctx-info'
# buildkite-agent annotate 'Example `success` style annotation' --style 'success' --context 'ctx-success'
# buildkite-agent annotate 'Example `warning` style annotation' --style 'warning' --context 'ctx-warning'
# buildkite-agent annotate 'Example `error` style annotation' --style 'error' --context 'ctx-error'

