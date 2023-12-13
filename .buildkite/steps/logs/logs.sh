#!/bin/bash

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