#! /bin/bash

#######################################
# Author: hai.wang 
#######################################


loop=1
Para1=.
git_list_name=xxx_git_list

this_bin_path=`which $0`
tools_top_dir=${this_bin_path%/*}
git_list_path=$tools_top_dir/not_in_globle_path/$git_list_name

#####################

if [ $# -eq 1 ];then
   Para1=$1 
fi


echo aosp_top_dir = $Para1

rm $git_list_path

for tmp_dir in `ls $Para1`
do
    delete_suffix=${tmp_dir%.*}
    echo $loop : $delete_suffix
    echo $delete_suffix >> $git_list_path
    ((loop++))
    
done


