#!/bin/bash

# set explanation: https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425
# set -euxo pipefail # print executed commands to the terminal
set -euo pipefail # don't print executed commands to the terminal

# feedback/issues
# log group inner content should be indented
# buildkite emojis dont display inside log groups, only in group headers
# links in group headers underline on hover, but are not directly clickable

# source shared functions
. .buildkite/assets/functions.sh;

# capture original working directory
cur_dir=$(pwd)
cur_dir_contents=$(ls -lah $cur_dir)

# change into steps/logs/ directory
cd .buildkite/steps/logs/;

# upload assets as artifacts
buildkite-agent artifact upload "assets/*" --log-level error;

# start printing cool examples
echo -e "--- :rainbow: $(echokite "Expand this group to see text styling options" magenta none underline)"
echo ""
echo "  With Buildkite logs, there are 13 different text colors to choose from..."
echokite "    01. We have black text" black none normal
echokite "    02. We have red text" red none normal
echokite "    03. We have green text" green none normal
echokite "    04. We have yellow text" yellow none normal
echokite "    05. We have blue text" blue none normal
echokite "    06. We have magenta text" magenta none normal
echokite "    07. We have cyan text" cyan none normal
echokite "    08. We have white text" white none normal
echokite "    09. We have bright black text" bright_black none normal
echokite "    10. We have bright red text" bright_red none normal
echokite "    11. We have bright green text" bright_green none normal
echokite "    12. We have bright yellow text" bright_yellow none normal
echokite "    13. We have bright blue text" bright_blue none normal
echo ""
echokite "  There are also 3 different background colors..." white none normal
echo -e "    $(echokite "01. We have red background" white red normal)"
echo -e "    $(echokite "02. We have green background" black green normal)"
echo -e "    $(echokite "03. We have gray background" white gray normal)"
echo ""
echokite "  And we can style text with 5 different variations..." white none normal
echo -e "    $(echokite "01. We have normal style" white none normal)"
echo -e "    $(echokite "02. We have italic style" white none italic)"
echo -e "    $(echokite "03. We have underlined style" white none underline)"
echo -e "    $(echokite "04. We have blinking style" white none blink)"
echo -e "    $(echokite "05. We have striked style" white none strike)"
echo ""
str01=$(echokite "All of these" bright_green red normal)
str02=$(echokite "options and styles" magenta gray italic)
str03=$(echokite "can be used" bright_red green underline)
str04=$(echokite "in any combination" bright_blue none blink)
str05=$(echokite "you desire!" cyan none strike)
echo -e "  $str01 $str02 $str03 $str04 $str05"
echo ""
echo -e "--- :link: $(echokite "Expand this group to see some example links" bright_green none underline)"
echo ""
printf '  \033]1339;url='"https://www.buildkite.com/"';content='"Links will always be this color, and will show an underline on hover"'\a\n'
printf '  \033]1339;url='"https://www.buildkite.com/"'\a\n'
link01="We can also include a link"
link02='\033]1339;url='"https://www.buildkite.com/"';content='"only on certain words"'\a'
link03="in a line of text"
echo -e "  $link01 $link02 $link03"
echo ""
echo -e "--- :frame_with_picture: $(echokite "But what about GIFs? I really like GIFs!" cyan none underline)"
printf '  \033]1338;url='"artifact://assets/bean.gif"';alt='"bean"'\t\a\n'
echo -e "--- :partyparrot: $(echokite "Of course we support Buildkite emojis" bright_yellow none underline) :perfection: :bash: :sadpanda: :docker: :metal: :red_button: :terminal: :speech_balloon: :ghost: :brain: :mage: :astronaut: :juggling: :pinched_fingers:"
echo ""
echo -e "  You can also use unicode emojis within log groups (nested)! 😎 🥱 🐱 🦃 🥙 🍪 🥬 🌷 🛴 🧭 🏰 ⛄"
echo ""
echo -e "--- :nail_care: $(echokite "And then there's everything else..." bright_blue none underline)"
echo ""
echokite "  The default job working directory is:" white none normal
echokite "    $cur_dir" blue none italic
echokite "  The contents of that directory is:" white none normal
echokite "$cur_dir_contents" blue none italic | sed -e 's/^/    /'
echo ""

# Job lifecycle hooks have access to all the standard Buildkite environment variables.
echo "  Jobs and hooks have access to all the standard Buildkite environment variables..."
echokite "    BUILDKITE_PIPELINE_SLUG=$BUILDKITE_PIPELINE_SLUG" blue none italic
echokite "    CI=$CI" blue none italic
echokite "    BUILDKITE=$BUILDKITE" blue none italic
echokite "    BUILDKITE_ORGANIZATION_SLUG=$BUILDKITE_ORGANIZATION_SLUG" blue none italic
echokite "    BUILDKITE_PIPELINE_SLUG=$BUILDKITE_PIPELINE_SLUG" blue none italic
echokite "    BUILDKITE_PIPELINE_NAME=$BUILDKITE_PIPELINE_NAME" blue none italic
echokite "    BUILDKITE_PIPELINE_ID=$BUILDKITE_PIPELINE_ID" blue none italic
echokite "    BUILDKITE_PIPELINE_PROVIDER=$BUILDKITE_PIPELINE_PROVIDER" blue none italic
echokite "    BUILDKITE_PIPELINE_DEFAULT_BRANCH=$BUILDKITE_PIPELINE_DEFAULT_BRANCH" blue none italic
echokite "    BUILDKITE_REPO=$BUILDKITE_REPO" blue none italic
echokite "    BUILDKITE_BUILD_ID=$BUILDKITE_BUILD_ID" blue none italic
echokite "    BUILDKITE_BUILD_NUMBER=$BUILDKITE_BUILD_NUMBER" blue none italic
echokite "    BUILDKITE_BUILD_URL=$BUILDKITE_BUILD_URL" blue none italic
echokite "    BUILDKITE_BRANCH=$BUILDKITE_BRANCH" blue none italic
echokite "    BUILDKITE_TAG=$BUILDKITE_TAG" blue none italic
echokite "    BUILDKITE_COMMIT=$BUILDKITE_COMMIT" blue none italic
echokite "    BUILDKITE_MESSAGE=$BUILDKITE_MESSAGE" blue none italic
echokite "    BUILDKITE_SOURCE=$BUILDKITE_SOURCE" blue none italic
echokite "    BUILDKITE_BUILD_AUTHOR=$BUILDKITE_BUILD_AUTHOR" blue none italic
echokite "    BUILDKITE_BUILD_AUTHOR_EMAIL=$BUILDKITE_BUILD_AUTHOR_EMAIL" blue none italic
echokite "    BUILDKITE_BUILD_CREATOR=$BUILDKITE_BUILD_CREATOR" blue none italic
echokite "    BUILDKITE_BUILD_CREATOR_EMAIL=$BUILDKITE_BUILD_CREATOR_EMAIL" blue none italic
echokite "    BUILDKITE_REBUILT_FROM_BUILD_ID=$BUILDKITE_REBUILT_FROM_BUILD_ID" blue none italic
echokite "    BUILDKITE_REBUILT_FROM_BUILD_NUMBER=$BUILDKITE_REBUILT_FROM_BUILD_NUMBER" blue none italic
echokite "    BUILDKITE_PULL_REQUEST=$BUILDKITE_PULL_REQUEST" blue none italic
echokite "    BUILDKITE_PULL_REQUEST_BASE_BRANCH=$BUILDKITE_PULL_REQUEST_BASE_BRANCH" blue none italic
echokite "    BUILDKITE_PULL_REQUEST_REPO=$BUILDKITE_PULL_REQUEST_REPO" blue none italic
echokite "    BUILDKITE_TRIGGERED_FROM_BUILD_ID=$BUILDKITE_TRIGGERED_FROM_BUILD_ID" blue none italic
echokite "    BUILDKITE_TRIGGERED_FROM_BUILD_NUMBER=$BUILDKITE_TRIGGERED_FROM_BUILD_NUMBER" blue none italic
echokite "    BUILDKITE_TRIGGERED_FROM_BUILD_PIPELINE_SLUG=$BUILDKITE_TRIGGERED_FROM_BUILD_PIPELINE_SLUG" blue none italic
echokite "    BUILDKITE_JOB_ID=$BUILDKITE_JOB_ID" blue none italic
echokite "    BUILDKITE_LABEL=$BUILDKITE_LABEL" blue none italic
echokite "    BUILDKITE_COMMAND=$BUILDKITE_COMMAND" blue none italic
echokite "    BUILDKITE_ARTIFACT_PATHS=$BUILDKITE_ARTIFACT_PATHS" blue none italic
echokite "    BUILDKITE_RETRY_COUNT=$BUILDKITE_RETRY_COUNT" blue none italic
echokite "    BUILDKITE_TIMEOUT=$BUILDKITE_TIMEOUT" blue none italic
echokite "    BUILDKITE_STEP_KEY=$BUILDKITE_STEP_KEY" blue none italic
echokite "    BUILDKITE_STEP_ID=$BUILDKITE_STEP_ID" blue none italic
echokite "    BUILDKITE_PROJECT_SLUG=$BUILDKITE_PROJECT_SLUG" blue none italic
echokite "    BUILDKITE_PROJECT_PROVIDER=$BUILDKITE_PROJECT_PROVIDER" blue none italic
echokite "    BUILDKITE_SCRIPT_PATH=$BUILDKITE_SCRIPT_PATH" blue none italic
echokite "    BUILDKITE_AGENT_ID=$BUILDKITE_AGENT_ID" blue none italic
echokite "    BUILDKITE_AGENT_NAME=$BUILDKITE_AGENT_NAME" blue none italic
echokite "    BUILDKITE_AGENT_META_DATA_QUEUE=$BUILDKITE_AGENT_META_DATA_QUEUE" blue none italic
echokite "    BUILDKITE_AGENT_META_DATA_DOCKER=$BUILDKITE_AGENT_META_DATA_DOCKER" blue none italic
echokite "    BUILDKITE_AGENT_META_DATA_STACK=$BUILDKITE_AGENT_META_DATA_STACK" blue none italic
echokite "    BUILDKITE_AGENT_META_DATA_BUILDKITE_AWS_STACK=$BUILDKITE_AGENT_META_DATA_BUILDKITE_AWS_STACK" blue none italic
echokite "    BUILDKITE_AGENT_META_DATA_AWS_AVAILABILITY_ZONE=$BUILDKITE_AGENT_META_DATA_AWS_AVAILABILITY_ZONE" blue none italic
echokite "    BUILDKITE_AGENT_META_DATA_AWS_INSTANCE_ID=$BUILDKITE_AGENT_META_DATA_AWS_INSTANCE_ID" blue none italic
echokite "    BUILDKITE_AGENT_META_DATA_AWS_INSTANCE_TYPE=$BUILDKITE_AGENT_META_DATA_AWS_INSTANCE_TYPE" blue none italic
echokite "    BUILDKITE_AGENT_META_DATA_AWS_REGION=$BUILDKITE_AGENT_META_DATA_AWS_REGION" blue none italic
echokite "    BUILDKITE_AGENT_META_DATA_AWS_INSTANCE_LIFE_CYCLE=$BUILDKITE_AGENT_META_DATA_AWS_INSTANCE_LIFE_CYCLE" blue none italic
echokite "    BUILDKITE_AGENT_META_DATA_AWS_ACCOUNT_ID=$BUILDKITE_AGENT_META_DATA_AWS_ACCOUNT_ID" blue none italic
echokite "    BUILDKITE_AGENT_META_DATA_AWS_AMI_ID=$BUILDKITE_AGENT_META_DATA_AWS_AMI_ID" blue none italic
echokite "    BUILDKITE_AGENT_META_DATA_AWS_ARCHITECTURE=$BUILDKITE_AGENT_META_DATA_AWS_ARCHITECTURE" blue none italic
echokite "    BUILDKITE_PIPELINE_TEAMS=$BUILDKITE_PIPELINE_TEAMS" blue none italic
echokite "    BUILDKITE_BUILD_CREATOR_TEAMS=$BUILDKITE_BUILD_CREATOR_TEAMS" blue none italic

echo ""

echo -e "+++ :checkered_flag: $(echokite "fin" black none underline)"

# echo '--- This is a collapsed log group :white_check_mark:' && cat lorem-ipsum.txt
# echo '~~~ This is a de-emphasized log group :no_entry:' && cat lorem-ipsum.txt
# echo '+++ This is an expanded log group :star2:' && cat lorem-ipsum.txt



# https://buildkite.com/docs/pipelines/managing-log-output#redacted-environment-variables
# These variables should be redacted from logs....

# MY_PASSWORD="ThisIsASecret"
# MY_SECRET="ThisIsASecret"
# MY_TOKEN="ThisIsASecret"
# MY_ACCESS_KEY="ThisIsASecret"
# MY_SECRET_KEY="ThisIsASecret"
# MY_CONNECTION_STRING="ThisIsASecret" # (added in Agent v3.53.0)

# echo "MY_PASSWORD=$MY_PASSWORD"
# echo "MY_SECRET=$MY_SECRET"
# echo "MY_TOKEN=$MY_TOKEN"
# echo "MY_ACCESS_KEY=$MY_ACCESS_KEY"
# echo "MY_SECRET_KEY=$MY_SECRET_KEY"
# echo "MY_CONNECTION_STRING=$MY_CONNECTION_STRING"
