#! /bin/bash
#############################
#author:wanghai
#############################

get_source_code_sub_dir_list_path=`which source_code_sub_dir_list.log`
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

loop=1
current_data=`date "+%Y_%m_%d_%H_%M_%S"`
before_modify=all_sub_dir_git_init_2014_06_07
after_modify=intel_clovertral_p_android_4.4

#############################

git_server_addr=192.168.2.5
on_git_server_android_source_code_name=intel_clovertral_p_android_4.4

Step0=1
if [ $Step0 -eq 1 ]; then


    echo -en "\033[32m"
    echo
    date "+%Y-%m-%d %H:%M:%S"
    echo "Start get android source code from $git_server_addr:$on_git_server_android_source_code_name "
    echo
    echo -en "\033[0m"

    #for tmp_git_name in `cat $current_source_code_top_dir`
    for tmp_git_name in `ls $current_path`
    do

        tmp=${tmp_git_name%.*} 
        has_git_dir=$current_path/$tmp/.git

        if [ -d $has_git_dir ];then
            echo  $loop : $has_git_dir
            sed -i 's/'"$before_modify"'/'"$after_modify"'/' $has_git_dir/config
            ((loop++))
        fi

    done

    android_top_dir_has_git=$current_path/.git
    if [ -d $android_top_dir_has_git ]; then
        echo  $loop : $android_top_dir_has_git
             sed -i 's/'"$before_modify"'/'"$after_modify"'/' $android_top_dir_has_git/config
    fi

    echo -en "\033[35m"
    echo
    echo "Finshed : get android source code from $git_server_addr:$on_git_server_android_source_code_name !!"
    date "+%Y-%m-%d %H:%M:%S"
    echo
    echo -en "\033[0m"

fi


