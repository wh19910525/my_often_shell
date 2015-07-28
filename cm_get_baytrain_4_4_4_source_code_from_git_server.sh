#! /bin/bash
#############################
#author:wanghai
#############################

loop=1
current_data=`date "+%Y_%m_%d_%H_%M_%S"`

android_top_dir=android_baytrain_4.4.4_source_code_$current_data
git_server_addr=10.92.11.203
on_git_server_android_source_code_name=intel_baytrain_android_4_4_4

get_source_code_sub_dir_list_path=`which android_4_4_4_bytrain_git_list`
echo get_source_code_sub_dir_list_path=$get_source_code_sub_dir_list_path
current_path=`pwd`

if [ $# -eq 1 ]; then
    para1=$1
    current_source_code_top_dir=$current_path/$para1
elif [ "x$get_source_code_sub_dir_list_path" != "x" ]; then
    para1=$get_source_code_sub_dir_list_path
    current_source_code_top_dir=$para1
    echo current_source_code_top_dir=$current_source_code_top_dir
else
    echo -en "\033[35m"
    echo "Usage : wb_get_android_source_code_from_git_server.sh [source_code_sub_dir_list.log]"
    echo -en "\033[0m"
    exit 1

fi


#############################

Step1=1
if [ $Step1 -eq 1 ]; then

    mkdir $android_top_dir -p
    cd $android_top_dir


    echo -en "\033[32m"
    echo
    date "+%Y-%m-%d %H:%M:%S"
    echo "Start get android source code from $git_server_addr:$on_git_server_android_source_code_name "
    echo

    echo -en "\033[0m"


    for tmp_git_name in `cat $current_source_code_top_dir`
    do

        #echo git clone  git@$git_server_addr:$on_git_server_android_source_code_name/$tmp_git_name
        git clone  git@$git_server_addr:$on_git_server_android_source_code_name/$tmp_git_name.git
        echo "$loop : Clone $on_git_server_android_source_code_name/$tmp_git_name.git successed!!"

        echo 
        echo 

        ((loop++))
    done

    if [ -e android_top ]; then
        pwd
        mv android_top/* .
        mv android_top/.git* .
        
        rm android_top -rf
    fi


    echo -en "\033[35m"

    echo
    echo "Finshed : get android source code from $git_server_addr:$on_git_server_android_source_code_name !!"
    date "+%Y-%m-%d %H:%M:%S"
    echo

    echo -en "\033[0m"

fi


