#!/bin/bash

# TODO
# Tell a random dad joke
# 
# Make following block steps, i.e. # of parallelism when you choose print parallel

# dad_joke=$(curl -H "Accept: text/plain" https://icanhazdadjoke.com/)


decision_steps=$(cat <<EOF
  - block: ":thinking_face: What now?"
    prompt: "Choose the next set of steps to be dynamically generated"
    fields:
      - select: "Choices"
        key: "choice"
        options:
          - label: "Show some cool log features"
            value: "log-stuff"
          - label: "Print 'hello world' a bunch of times in parallel"
            value: "hello-world"
          - label: "Finish the build green"
            value: "build-pass"
          - label: "Finish the build red"
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

new_yaml=""
case $current_state in
  log-stuff)
    action_step=$(cat <<EOF
  - label: ":terminal: Show Log Stuff"
    command: "cd .buildkite && buildkite-agent artifact upload man-beard.gif && ./log_image.sh artifact://man-beard.gif"
EOF
)
    new_yaml=$(printf "%s\n%s\n%s" "$action_step" "$wait_step" "$decision_steps")
  ;;

  hello-world)
    action_step=$(cat <<EOF
  - label: ":zap: Parallel Steps"
    command: "echo 'Hello, world!'"
    parallelism: 5
EOF
)
    new_yaml=$(printf "%s\n%s\n%s" "$action_step" "$wait_step" "$decision_steps")
  ;;

  build-pass)
    action_step=$(cat <<EOF
  - label: ":thumbsup: Passing build"
    command: "echo 'Exiting build with status 0' && exit 0"
EOF
)
    new_yaml=$(printf "%s\n" "$action_step")
  ;;

  build-fail)
    action_step=$(cat <<EOF
  - label: ":thumbsdown: Failing build"
    command: "echo 'Exiting build with status 1' && exit 1"
EOF
)
    new_yaml=$(printf "%s\n" "$action_step")
  ;;
esac

printf "%s\n" "$new_yaml"
printf "%s\n" "$dad_joke"
printf "%s\n" "$new_yaml" | buildkite-agent pipeline upload
