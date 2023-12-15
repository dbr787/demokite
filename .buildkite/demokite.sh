#!/bin/bash

# set explanation: https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425
# set -euxo pipefail # print executed commands to the terminal
set -euo pipefail # don't print executed commands to the terminal

# source shared functions
. .buildkite/assets/functions.sh;

# to use emojis
# :thisisfine: for failing build intentionally
# :perfection: for succeeding build intentionally
# :bash:
# :sadpanda:
# :partyparrot:
# :docker:
# :metal:
# :red_button:
# :terminal:
# :speech_balloon:
# :ghost:
# :writing_hand:
# :index_pointing_at_the_viewer:
# :brain:
# :mage:
# :astronaut:
# :scientist:
# :technologist:
# :teacher:
# :artist:
# :cook:
# :supervillain:
# :superhero:
# :ninja:
# :juggling:
# :shrug:
# :pinched_fingers:
# :nail_care:

CHOICE_ANNOTATIONS=""
CHOICE_LOGS=""
CHOICE_PARALLELISM=""
CHOICE_BUILD_PASS=""
CHOICE_BUILD_FAIL=""
CHOICES=""

# STEP_OUTPUT=$(cat <<EOF
#   - label: ":thumbsup: Pass build"
#     command: "echo 'Exiting build with status 0' && exit 0"
# EOF
# )

STEP_WAIT=$(cat .buildkite/steps/wait.yml)
STEP_HELLO=$(cat .buildkite/steps/hello.yml)
STEP_ANNOTATIONS=$(cat .buildkite/steps/annotations/annotations.yml)
STEP_LOGS=$(cat .buildkite/steps/logs/logs.yml)

# STEP_OUTPUT=$(printf "%s\n%s\n%s" "$HELLO_STEP" "$WAIT_STEP" "$HELLO_STEP")

# sed -e '/---/d' -e '/steps:/d' -e '/^$/d' .buildkite/steps/wait.yml

p_prepare () {
    local source_dir="$1"
    local source_file="$2"
    local output_dir="$3"
    local output_file="$4"
    local current_dir=$(pwd)
    cd "$source_dir"
    buildkite-agent artifact upload "$source_file" --log-level error
    buildkite-agent pipeline upload "$source_file" --dry-run --format json --log-level error > "$output_dir/$output_file"
    cd "$output_dir"
    buildkite-agent artifact upload "$output_file" --log-level error
    cd "$current_dir"
}

p_merge() {
    jq -s '{steps: [.[].steps[]]}' "$@"
}

p_upload() {
    local pipeline="$1"
    buildkite-agent pipeline upload "$pipeline" --log-level error
}

a_upload() {
    local artifact="$1"
    buildkite-agent artifact upload "$artifact" --log-level error
}

cur_dir=$(pwd)
p_prepare ".buildkite/steps/logs" "logs.yml" $cur_dir "logs.json"
p_prepare ".buildkite/steps/annotations" "annotations.yml" $cur_dir "annotations.json"
p_merge "logs.json" "annotations.json" > "merged.json"
a_upload "merged.json"
p_upload "merged.json"
ls -la $cur_dir









# echo "$STEP_LOGS"
# echo "$STEP_LOGS" >> step_logs.yml
# cat pipeline_upload.yml
# echo "$STEP_LOGS" | buildkite-agent pipeline upload
# buildkite-agent pipeline upload .buildkite/steps/logs/logs.yml --dry-run --format json > step_logs.json
# buildkite-agent artifact upload step_logs.json --log-level error;




# echo "$STEP_ANNOTATIONS"
# echo "$STEP_ANNOTATIONS" >> pipeline_upload.yml
# cat pipeline_upload.yml
# echo "$STEP_ANNOTATIONS" | buildkite-agent pipeline upload
# buildkite-agent pipeline upload .buildkite/steps/annotations/annotations.yml --dry-run --format json > step_annotations.json
# buildkite-agent artifact upload step_annotations.json --log-level error;

# jq -s 'reduce .[] as $file ([]; . + $file.steps)' *.json > merged.json
# buildkite-agent artifact upload step_annotations.json --log-level error;



# mv pipeline_upload.yml pipeline_upload_original.yml

# buildkite-agent artifact upload "pipeline_upload_original.yml" --log-level error;

# sanitises pipeline upload file
# just remove '---' and 'steps:' lines for now, might need to adjust this later to allow env: and agents: properties
# remove all but first occurence of '---' and 'steps:'
# sed -e '1!{/^---/d}' -e '/^[[:space:]]*steps:[[:space:]]*/d' pipeline_upload_original.yml > pipeline_upload_sanitised.yml
# sed '/^[[:space:]]*---[[:space:]]*/d; /^[[:space:]]*steps:[[:space:]]*/d' pipeline_upload_original.yml > pipeline_upload_sanitised.yml

# upload pipeline_upload.yml as artifact
# buildkite-agent artifact upload "pipeline_upload_sanitised.yml" --log-level error;

# pipeline upload
# cat pipeline_upload_sanitised.yml | buildkite-agent pipeline upload
