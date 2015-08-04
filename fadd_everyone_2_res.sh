#!/bin/bash

#######################################
# Author: hai.wang 
#######################################

cmd_all_path=`which $0`
all_cmd_top_dir=${cmd_all_path%/*}
need_prefix=frank3

loop=1
for tmp_cmd in `ls $all_cmd_top_dir`
do
    get_prefix=${tmp_cmd%%_*} 
    if [ x$get_prefix == x$need_prefix ];then
        #echo $loop : $tmp_cmd
        #echo $get_prefix
        $tmp_cmd
    fi

    ((loop++))
done

