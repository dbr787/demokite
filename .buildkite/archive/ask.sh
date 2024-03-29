#!/bin/bash

set -euxo pipefail

decision_steps=$(cat <<EOF
  - block: ":thinking_face: What now?"
    prompt: "Choose the next set of steps to be dynamically generated"
    fields:
      - select: "Choices"
        key: "choice"
        options:
          - label: ":terminal: Show some cool log features"
            value: "log-stuff"
          - label: ":people_holding_hands: Run some jobs in parallel"
            value: "parallel"
          - label: ":memo: Create some annotations"
            value: "annotate"
          - label: ":thumbsup: Finish the build green"
            value: "build-pass"
          - label: ":thumbsdown: Finish the build red"
            value: "build-fail"
  - label: "Process input"
    command: ".buildkite/ask.sh"
EOF
)

wait_step=$(cat <<EOF
  - wait
EOF
)

# this bit is an ugly hack to avoid checking metadata on first run of the script
current_state=""
first_step_key="initial-pipeline-upload"
if [ "$BUILDKITE_STEP_KEY" != "$first_step_key" ]; then
  current_state=$(buildkite-agent meta-data get "choice")
else
  printf "steps:\n"
  printf "%s\n" "$decision_steps"
  exit 0
fi


# - "./log_image.sh artifact://man-beard.gif"
# - echo -e "I wrote a song for you \033[33mand it was called yellow\033[0m :yellow_heart:"
# - printf '\033]1338;url='"artifact://man-beard.gif"';alt='"man-beard"'\a\n'
# command: "echo :earth_asia: Hello, world! %N of %t"
# command: "cd .buildkite && ./parallel_job.sh"

    # command: |
    #   buildkite-agent annotate 'Example `default` style' --context 'ctx-default'
    #   buildkite-agent annotate 'Example `info` style' --style 'info' --context 'ctx-info'
    #   buildkite-agent annotate 'Example `warning` style' --style 'warning' --context 'ctx-warn'
    #   buildkite-agent annotate 'Example `error` style' --style 'error' --context 'ctx-error'
    #   buildkite-agent annotate 'Example `success` style' --style 'success' --context 'ctx-success'

new_yaml=""
case $current_state in
  log-stuff)
    action_step=$(cat <<EOF
  - label: ":terminal: Log stuff"
    commands: 
      - "cd .buildkite"
      - "buildkite-agent artifact upload man-beard.gif"
      
      - echo -e "--- I wrote a song for you :yellow_heart:"
      - echo -e "\033[33m... and it was called yellow\033[0m"
      
      - "echo '--- How about GIFs?'"
      - printf '\033]1338;url='"artifact://man-beard.gif"';alt='"man-beard"'\a'
      
      - "echo '--- How about links?'"
      - "./inline_link.sh https://www.buildkite.com"
      - "./inline_link.sh https://buildkite.com/unblock"
      
      - "echo '--- This is a collapsed log group :white_check_mark:' && cat lorem-ipsum.txt"
      - "echo '~~~ This is a de-emphasized log group :no_entry:' && cat lorem-ipsum.txt"
      - "echo '+++ This is an expanded log group :star2:' && cat lorem-ipsum.txt"
EOF
)
    new_yaml=$(printf "%s\n%s\n%s" "$action_step" "$wait_step" "$decision_steps")
  ;;

  parallel)
    action_step=$(cat <<EOF
  - label: ":zap: Parallel steps"
    command: ".buildkite/parallel_job.sh"
    parallelism: 10
EOF
)
    new_yaml=$(printf "%s\n%s\n%s" "$action_step" "$wait_step" "$decision_steps")
  ;;

  annotate)
    action_step=$(cat <<EOF
  - label: ":memo: Annotate"
    commands:
      - "buildkite-agent annotate 'Example \`default\` style annotation' --context 'ctx-default'"
      - "buildkite-agent annotate 'Example \`info\` style annotation' --style 'info' --context 'ctx-info'"
      - "buildkite-agent annotate 'Example \`warning\` style annotation' --style 'warning' --context 'ctx-warning'"
      - "buildkite-agent annotate 'Example \`error\` style annotation' --style 'error' --context 'ctx-error'"
      - "buildkite-agent annotate 'Example \`success\` style annotation' --style 'success' --context 'ctx-success'"
EOF
)
    new_yaml=$(printf "%s\n%s\n%s" "$action_step" "$wait_step" "$decision_steps")
  ;;

  build-pass)
    action_step=$(cat <<EOF
  - label: ":thumbsup: Pass build"
    command: "echo 'Exiting build with status 0' && exit 0"
EOF
)
    new_yaml=$(printf "%s\n" "$action_step")
  ;;

  build-fail)
    action_step=$(cat <<EOF
  - label: ":thumbsdown: Fail build"
    command: "echo 'Exiting build with status 1' && exit 1"
EOF
)
    new_yaml=$(printf "%s\n" "$action_step")
  ;;
esac

printf "%s\n" "$new_yaml" | buildkite-agent pipeline upload
