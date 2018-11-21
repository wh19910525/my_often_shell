#!/bin/bash

#######################################
# Author: wanghai
#######################################

####### funtion1, 颜色输出字符串 ########
start_color_value=31
end_color_value=36

color_value=$start_color_value
print_color () {
    echo -en "\033[${color_value}m"
    echo "  $@  "
    echo -en "\033[0m"
    if [ $color_value -eq $end_color_value ];then
        color_value=31
    else
        ((color_value++))
    fi
}

