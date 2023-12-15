#!/bin/bash

# set explanation: https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425
# set -euxo pipefail # print executed commands to the terminal
set -euo pipefail # don't print executed commands to the terminal

# feedback/issues
# log group inner content should be indented
# buildkite emojis dont display inside log groups, only in a group header
# links in group headers underline on hover, but are not clickable

# test sed indent
# . .buildkite/steps/logs/test.sh | sed -e '/^---\|^+++\|^~~~/!s/^/  /'
# . .buildkite/steps/logs/test.sh | sed -e '/^---\s\|^+++\s\|^~~~\s/!s/^/  /'
# echo "--- now the next one"
# . .buildkite/steps/logs/test.sh | sed -e '/^---\s\|^+++\s\|^~~~\s/!s/^/  /'

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
printf '  \033]1339;url='"https://www.buildkite.com/"';content='"  Links will always be this color, and will show an underline on hover"'\a\n'
printf '  \033]1339;url='"https://www.buildkite.com/"'\a\n'
link01="We can also include a link"
link02='\033]1339;url='"https://www.buildkite.com/"';content='"only on certain words"'\a'
link03="in a line of text"
echo -e "  $link01 $link02 $link03"
echo ""
echo -e "--- :frame_with_picture: $(echokite "But what about GIFs? I really like GIFs!" cyan none underline)"
printf '  \033]1338;url='"artifact://assets/bean.gif"';alt='"bean"'\t\a\n'
echo -e "--- :partyparrot: $(echokite "Of course we support Buildkite emojis" bright_yellow none underline) :thisisfine: :perfection: :bash: :sadpanda: :partyparrot: :docker: :metal: :red_button: :terminal: :speech_balloon: :ghost: :writing_hand: :index_pointing_at_the_viewer: :brain: :mage: :astronaut: :superhero: :ninja: :juggling: :shrug: :pinched_fingers:"
echo ""
echo -e "You can also use normal emojis within log groups (nested)! 😎 🥱 🐱 🦃 🥙 🍪 🥬 🌷 🛴 🧭 🏰 ⛄"
echo ""
echo -e "--- :nail_care: $(echokite "And then there's everything else..." bright_blue none underline)"
echo ""
echokite "  The current working directory is:" white none normal
echokite "    $cur_dir" blue none italic
echokite "  The contents of that directory is:" white none normal
echokite "$cur_dir_contents" blue none italic | sed -e 's/^/    /'
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
