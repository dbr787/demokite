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
    local fg_color="$2"
    local bg_color="$3"
    local style="$4"
    local ansi_text="$text" # empty
    local ansi_fg_color="37" # white
    local ansi_bg_color="47" # white/none
    local ansi_style="0" # normal
    
    [ $style == "normal" ] && ansi_style="0"
    [ $style == "italic" ] && ansi_style="3"
    [ $style == "underline" ] && ansi_style="4"
    [ $style == "blink" ] && ansi_style="5"
    [ $style == "strike" ] && ansi_style="9"

    [ $fg_color == "black" ] && ansi_fg_color="30"
    [ $fg_color == "red" ] && ansi_fg_color="31"
    [ $fg_color == "green" ] && ansi_fg_color="32"
    [ $fg_color == "yellow" ] && ansi_fg_color="33"
    [ $fg_color == "blue" ] && ansi_fg_color="34"
    [ $fg_color == "magenta" ] && ansi_fg_color="35"
    [ $fg_color == "cyan" ] && ansi_fg_color="36"
    [ $fg_color == "white" ] && ansi_fg_color="37"
    [ $fg_color == "bright_black" ] && ansi_fg_color="90"
    [ $fg_color == "bright_red" ] && ansi_fg_color="91"
    [ $fg_color == "bright_green" ] && ansi_fg_color="92"
    [ $fg_color == "bright_yellow" ] && ansi_fg_color="93"
    [ $fg_color == "bright_blue" ] && ansi_fg_color="94"

    [ $bg_color == "none" ] && ansi_bg_color="47" # white renders nobackground
    [ $bg_color == "gray" ] && ansi_bg_color="40"
    [ $bg_color == "red" ] && ansi_bg_color="41"
    [ $bg_color == "green" ] && ansi_bg_color="42"

    echo -e "\033[${ansi_style};${ansi_fg_color};${ansi_bg_color}m${ansi_text}\033[0m"
}

echokite "hello this is my colored text" yellow none normal
echokite "hello this is my colored text" bright_green none italic
echokite "hello this is my colored text" magenta none underline
echokite "hello this is my colored text" bright_blue none blink
echokite "hello this is my colored text" bright_red none strike
echokite "hello this is my colored text" blue none italic

test1=$(echokite "hello this is my colored text" yellow none normal)
test2=$(echokite "hello this is my colored text" bright_green none italic)
test3=$(echokite "hello this is my colored text" bright_blue none blink)
echo -e "Here we go! $test1 and then $test2 and then $test3 - Hooray!"



echo ""
echo "With Buildkite logs, we have 13 different text foreground colors to choose from..."
echokite "  01. We have black text" black none normal
echokite "  02. We have red text" red none normal
echokite "  03. We have green text" green none normal
echokite "  04. We have yellow text" yellow none normal
echokite "  05. We have blue text" blue none normal
echokite "  06. We have magenta text" magenta none normal
echokite "  07. We have cyan text" cyan none normal
echokite "  08. We have white text" white none normal
echokite "  09. We have bright black text" bright_black none normal
echokite "  10. We have bright red text" bright_red none normal
echokite "  11. We have bright green text" bright_green none normal
echokite "  12. We have bright yellow text" bright_yellow none normal
echokite "  13. We have bright blue text" bright_blue none normal
echo ""
echo "We also have 3 different background colors..."
echo -e "  $(echokite "01. We have red background" white red normal)"
str_bg02=$(echokite "  02. We have green background" black green normal)
str_bg03=$(echokite "  03. We have gray background" white gray normal)



echo ""
echo "We can also style text with 5 different variations..."
echokite "  01. We have normal style" white none normal
echokite "  02. We have italic style" white none italic
echokite "  03. We have underlined style" white none underline
echokite "  04. We have blinking style" white none blink
echokite "  05. We have striked style" white none strike
echo ""
str01=$(echokite "All of these" bright_green red normal)
str02=$(echokite "options and styles" magenta gray italic)
str03=$(echokite "can be used" bright_red green underline)
str04=$(echokite "in any combination" bright_blue none blink)
str05=$(echokite "you desire!" cyan none strike)
echo -e "$str01 $str02 $str03 $str04 $str05"
echo ""





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
