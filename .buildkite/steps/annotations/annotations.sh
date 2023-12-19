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


cat <<EOT >> ./assets/test01.md
line 1
line 2
EOT
buildkite-agent artifact upload "assets/test01.md" --log-level error;
printf '%b\n' "$(cat ./assets/test01.md)" | buildkite-agent annotate --style 'success' --context 'test01'

cat <<EOT >> ./assets/test02.md
\`\`\`term\nThis is a $MY_TEST_VAR \033[0;31mtest\033[0m\n\`\`\`
line 2
EOT
buildkite-agent artifact upload "assets/test02.md" --log-level error;
printf '%b\n' "$(cat ./assets/test02.md)" | buildkite-agent annotate --style 'success' --context 'test02'

cat <<EOT >> ./assets/test03.md
line 1
\`\`\`term
This is a $MY_TEST_VAR \033[0;31mtest\033[0m
\`\`\`
line 2
EOT
buildkite-agent artifact upload "assets/test03.md" --log-level error;
printf '%b\n' "$(cat ./assets/test03.md)" | buildkite-agent annotate --style 'success' --context 'test03'


IMAGE_NAME="my-secured-image";

cat <<EOF >> wiz-docker-scan-annotation.md
<details>
<summary>Wiz Docker Image Scan for $IMAGE_NAME does not meet policy requirements.</summary>
line 1
\`\`\`term
Results of the scan go \033[0;31mhere\033[0m
\`\`\`
line 2  
</details>
EOF
buildkite-agent artifact upload "wiz-docker-scan-annotation.md" --log-level error;
printf '%b\n' "$(cat wiz-docker-scan-annotation)" | buildkite-agent annotate --context 'ctx-wiz-docker-scan' --style 'warning' ;



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

