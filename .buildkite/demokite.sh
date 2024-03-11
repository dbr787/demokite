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

# this bit is an ugly hack to avoid checking metadata on first run of the script
CURRENT_STATE=""
FIRST_STEP_KEY="begin"
CURRENT_DIR=$(pwd)

if [ "$BUILDKITE_STEP_KEY" != "$FIRST_STEP_KEY" ]; then
  CURRENT_STATE=$(buildkite-agent meta-data get "choice")
  echo "BUILDKITE_STEP_KEY: $BUILDKITE_STEP_KEY"
  if [ $CURRENT_STATE = "logs" ]; then
    pipeline_prepare ".buildkite/steps/logs" "logs.yml" $CURRENT_DIR "logs.json"
    pipeline_prepare ".buildkite/steps/ask" "ask.yml" $CURRENT_DIR "ask.json"
    pipeline_merge "logs.json" "ask.json" > "merged.json"
    # artifact_upload "merged.json"
    pipeline_upload "merged.json"
  fi
  if [ $CURRENT_STATE = "annotations" ]; then
    pipeline_prepare ".buildkite/steps/annotations" "annotations.yml" $CURRENT_DIR "annotations.json"
    pipeline_prepare ".buildkite/steps/ask" "ask.yml" $CURRENT_DIR "ask.json"
    pipeline_merge "annotations.json" "ask.json" > "merged.json"
    # artifact_upload "merged.json"
    pipeline_upload "merged.json"
  fi
  if [ $CURRENT_STATE = "parallel-steps" ]; then
    pipeline_prepare ".buildkite/steps/parallel-steps" "parallel-steps.yml" $CURRENT_DIR "parallel-steps.json"
    pipeline_prepare ".buildkite/steps/ask" "ask.yml" $CURRENT_DIR "ask.json"
    pipeline_merge "parallel-steps.json" "ask.json" > "merged.json"
    # artifact_upload "merged.json"
    pipeline_upload "merged.json"
  fi
else
  echo "not current state"
  pipeline_prepare ".buildkite/steps/ask" "ask.yml" $CURRENT_DIR "ask.json"
  # artifact_upload "ask.json"
  pipeline_upload "ask.json"
fi



# STEP_OUTPUT=$(cat <<EOF
#   - label: ":thumbsup: Pass build"
#     command: "echo 'Exiting build with status 0' && exit 0"
# EOF
# )

# sed -e '/---/d' -e '/steps:/d' -e '/^$/d' .buildkite/steps/wait.yml



# merge multiple json pipeline definitions into one and upload
# current_dir=$(pwd)
# pipeline_prepare ".buildkite/steps/logs" "logs.yml" $current_dir "logs.json"
# pipeline_prepare ".buildkite/steps/annotations" "annotations.yml" $current_dir "annotations.json"
# pipeline_merge "logs.json" "annotations.json" > "merged.json"
# artifact_upload "merged.json"
# pipeline_upload "merged.json"


# here is where im working 
# pipeline_prepare ".buildkite/steps/ask" "ask.yml" $current_dir "ask.json"
# artifact_upload "ask.json"
# pipeline_upload "ask.json"


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
