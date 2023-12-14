#!/bin/bash

# set explanation: https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425
# set -euxo pipefail # print executed commands to the terminal
set -euo pipefail # don't print executed commands to the terminal

# change into steps/logs/ directory
cd .buildkite/steps/logs/assets/;

# upload gifs as artifacts
buildkite-agent artifact upload "*.gif" --log-level error;

# echokite function to print text colors and styles
echokite () {
    local text="$1"
    local color="$2"
    local style="$3"
    local ansi_text="$text" # empty
    local ansi_color="37" # white
    local ansi_style="0" # normal
    
    [ $style == "normal" ] && ansi_style="0"
    [ $style == "italic" ] && ansi_style="3"
    [ $style == "underline" ] && ansi_style="4"
    [ $style == "blink" ] && ansi_style="5"
    [ $style == "strike" ] && ansi_style="9"

    [ $color == "black" ] && ansi_color="30"
    [ $color == "red" ] && ansi_color="31"
    [ $color == "green" ] && ansi_color="32"
    [ $color == "yellow" ] && ansi_color="33"
    [ $color == "blue" ] && ansi_color="34"
    [ $color == "magenta" ] && ansi_color="35"
    [ $color == "cyan" ] && ansi_color="36"
    [ $color == "white" ] && ansi_color="37"
    [ $color == "bright_black" ] && ansi_color="90"
    [ $color == "bright_red" ] && ansi_color="91"
    [ $color == "bright_green" ] && ansi_color="92"
    [ $color == "bright_yellow" ] && ansi_color="93"
    [ $color == "bright_blue" ] && ansi_color="94"

    echo -e "\033[${ansi_style};${ansi_color}m${ansi_text}\033[0m"
}

echokite "hello this is my colored text" yellow normal
echokite "hello this is my colored text" bright_green italic
echokite "hello this is my colored text" magenta underline
echokite "hello this is my colored text" bright_blue blink
echokite "hello this is my colored text" bright_red strike
echokite "hello this is my colored text" blue italic

test1=$(echokite "hello this is my colored text" yellow normal)
test2=$(echokite "hello this is my colored text" bright_green italic)
test3=$(echokite "hello this is my colored text" bright_blue blink)
echo -e "Here we go! $test1 and then $test2 and then $test3 - Hooray!"




echo -e "With Buildkite logs, we have 13 different text foreground colors to choose from..."
echokite "  01. We have black text" black normal
echokite "  02. We have red text" red normal
echokite "  03. We have green text" green normal
echokite "  04. We have yellow text" yellow normal
echokite "  05. We have blue text" blue normal
echokite "  06. We have magenta text" magenta normal
echokite "  07. We have cyan text" cyan normal
echokite "  08. We have white text" white normal
echokite "  09. We have bright black text" bright_black normal
echokite "  10. We have bright red text" bright_red normal
echokite "  11. We have bright green text" bright_green normal
echokite "  12. We have bright yellow text" bright_yellow normal
echokite "  13. We have bright blue text" bright_blue normal
echo -e ""
echo -e "Hopefully a blank line was printed"
printf "\n"
echo -e "Or now at least"

# echo -e "\033[30m01. black (FG30)\033[0m"
# echo -e "\033[31m02. red (FG31)\033[0m"
# echo -e "\033[32m03. green (FG32)\033[0m"
# echo -e "\033[33m04. yellow (FG33)\033[0m"
# echo -e "\033[34m05. blue (FG34)\033[0m"
# echo -e "\033[35m06. magenta (FG35)\033[0m"
# # echo -e "\033[95m   14. bright magenta (FG95)   \033[0m" # this color is the same as magenta (FG35)
# echo -e "\033[36m07. cyan (FG36)\033[0m"
# # echo -e "\033[96m   15. bright cyan (FG96)   \033[0m" # this color is the same as cyan (FG36)
# echo -e "\033[37m08. white (FG37)\033[0m"
# # echo -e "\033[97m   16. bright white (FG97)   \033[0m" # this color is the same as white (FG37)
# echo -e "\033[90m09. bright black (FG90)\033[0m"
# echo -e "\033[91m10. bright red (FG91)\033[0m"
# echo -e "\033[92m11. bright green (FG92)\033[0m"
# echo -e "\033[93m12. bright yellow (FG93)\033[0m"
# echo -e "\033[94m13. bright blue (FG94)\033[0m"

echo -e "--- \033[93mI wrote a song for you\033[0m :yellow_heart: :guitar:";
echo -e "\033[33m... and it was called yellow\033[0m"
str1="\033[93mbut i prefer bright yellow\033[0m"
str2=", "
str3="\033[35msometimes magenta\033[0m"
str4="\033[90;3m, and on rare occassions \033[0m"
str5="\033[36ma refreshing cyan\033[0m"
str6="."
echo -e "$str1$str2$str3$str4$str5$str6"
# echo -e "\033[90mbut let's see bright black too\033[0m"
# echo -e "\033[30mbut let's see dark   black too\033[0m"


str1="\033[30;42mI like to use a green background to show success\033[0m"
str2=", "
str3="\033[41ma red background to show failure\033[0m"
str4=", "
str5="\033[40mand a gray background for other highlights\033[0m"
str6="."
echo -e "$str1$str2$str3$str4$str5$str6"




link0="Here is some text, and "
link1='\033]1339;url='"https://www.buildkite.com/"';content='"here is a link to the Buildkite website"'\a'
link2=" and here is some more text"
echo -e "--- $link0$link1$link2"

echo -e ":buildkite: The current working directory is:\n$(pwd)";

ls -la;

# cd .buildkite/steps/logs/;

# buildkite-agent artifact upload man-beard.gif;

echo '--- How about GIFs?'

printf 'hello\033]1338;url='"artifact://man.gif"';alt='"man"'\t\ahello\n'

echo '--- How about links?'

printf '\033]1339;url='"https://www.buildkite.com/"'\a\n'

printf '\033]1339;url='"https://www.buildkite.com/"';content='"This is a link to the Buildkite website"'\a\n'

echo '--- This is a collapsed log group :white_check_mark:' && cat lorem-ipsum.txt

echo '~~~ This is a de-emphasized log group :no_entry:' && cat lorem-ipsum.txt

echo '+++ This is an expanded log group :star2:' && cat lorem-ipsum.txt

# https://buildkite.com/docs/pipelines/managing-log-output#redacted-environment-variables
# These variables should be redacted from logs....

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
