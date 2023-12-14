#!/bin/bash

# set explanation: https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425
# set -euxo pipefail # print executed commands to the terminal
set -euo pipefail # don't print executed commands to the terminal

echo -e "--- I wrote a song for you :yellow_heart: :guitar:";
echo -e "\033[33m... and it was called yellow\033[0m"
str1="\033[93mbut i prefer bright yellow\033[0m"
str2=", "
str3="\033[35msometimes magenta\033[0m"
str4=", and on rare occassions "
str5="\033[36ma refreshing cyan\033[0m"
echo -e "$str1$str2$str3$str4$str5"

link0="Here is some text, and "
link1='\033]1339;url='"https://www.buildkite.com/"';content='"here is a link to the Buildkite website"'\a'
link2=" and here is some more text"
echo -e "$link0$link1$link2"

echo -e ":buildkite: The current working directory is:\n$(pwd)";

echo -e "\033[33m... and it was called yellow\033[0m"

ls -la;

cd .buildkite/steps/logs/;

buildkite-agent artifact upload man-beard.gif;

echo -e "--- I wrote a song for you :yellow_heart:";

echo -e "\033[33m... and it was called yellow\033[0m"

echo '--- How about GIFs?'

printf 'hello\033]1338;url='"artifact://man-beard.gif"';alt='"man-beard"'\t\ahello\n'

echo '--- How about links?'

printf '\033]1339;url='"https://www.buildkite.com/"'\a\n'

printf '\033]1339;url='"https://www.buildkite.com/"';content='"This is a link to the Buildkite website"'\a\n'

echo '--- This is a collapsed log group :white_check_mark:' && cat lorem-ipsum.txt

echo '~~~ This is a de-emphasized log group :no_entry:' && cat lorem-ipsum.txt

echo '+++ This is an expanded log group :star2:' && cat lorem-ipsum.txt

# https://buildkite.com/docs/pipelines/managing-log-output#redacted-environment-variables
# These variables will be redacted from logs....

MY_PASSWORD="ThisIsASecret"
MY_SECRET="ThisIsASecret"
MY_TOKEN="ThisIsASecret"
MY_ACCESS_KEY="ThisIsASecret"
MY_SECRET_KEY="ThisIsASecret"
MY_CONNECTION_STRING="ThisIsASecret" # (added in Agent v3.53.0)

echo "MY_PASSWORD=$MY_PASSWORD"
echo "MY_SECRET=$MY_SECRET"
echo "MY_TOKEN=$MY_TOKEN"
echo "MY_ACCESS_KEY=$MY_ACCESS_KEY"
echo "MY_SECRET_KEY=$MY_SECRET_KEY"
echo "MY_CONNECTION_STRING=$MY_CONNECTION_STRING"
