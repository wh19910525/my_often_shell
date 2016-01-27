#!/bin/bash

#######################################
# Author: hai.wang 
#######################################

para0=$0
para1=$1
para2=$2
para3=$3
para4=$4

current_path="`pwd`"
repo_bin="wb_repo.sh"
all_patch_dir="all_patch_dir"

today_patch_dir="patch_`date "+%Y-%m-%d"`"
save_today_patch_path="$current_path/$all_patch_dir/$today_patch_dir"

old_manirest_name="manifest_old_`date "+%Y-%m-%d-%H-%M"`"
old_manifest_file="$save_today_patch_path/$old_manirest_name"

save_all_git_manifest="$save_today_patch_path/save_all_git_manifest"


#######################################

####### funtion1 ########
start_color_value=31
end_color_value=36

color_value=$start_color_value
usage_color () {
    echo -en "\033[${color_value}m"
    echo "  $1  "
    echo -en "\033[0m"
    if [ $color_value -eq $end_color_value ];then
        color_value=31
    else
        ((color_value++))
    fi
}

####### funtion2 ########
Usage(){
    usage_color "Please use [`basename $para0` aosp_dir]"
}

####### funtion3 ########


#######################################




############### main ###############
if [ $# -ne 1 ];then
    Usage
elif [ -d $para1 ];then

Step_1=0
#if [ $Step_1 -ne 0 ];then

#1. get old manifest
    usage_color "1. Get old manifest ..."
    mkdir $save_today_patch_path -p
    cd $current_path/$para1
    $repo_bin manifest -o $old_manifest_file >> /dev/null 2>&1
    echo

#2. get pull
    usage_color "2. Update all repository ..."
    cd $current_path/$para1
    $repo_bin pull
    echo

#3. get new manifest
    usage_color "3. Get newest manifest ..."
    new_manirest_name="manifest_new_`date "+%Y-%m-%d-%H-%M"`"
    new_manifest_file="$save_today_patch_path/$new_manirest_name"
    cd $current_path/$para1
    $repo_bin manifest -o $new_manifest_file >> /dev/null 2>&1
    echo

#4. compare Step1 and Step3, get diff patch
    usage_color "4. Get diff patch between old and new manifest ..."

    # read old_file_ev_line
    while read old_file_ev_line
    do

        old_repository_and_branch_name=${old_file_ev_line%:*}
        old_branch_commit=${old_file_ev_line##*:}
        old_repository_name=${old_file_ev_line%%:*}

        # read new_file_ev_line
        while read new_file_ev_line
        do
            new_repository_and_branch_name=${new_file_ev_line%:*}
            new_branch_commit=${new_file_ev_line##*:}
            if [ $old_repository_and_branch_name == $new_repository_and_branch_name ];then
                if [ $old_branch_commit != $new_branch_commit ];then
                    usage_color "Modify[$old_repository_and_branch_name]"
                    mkdir -p $save_today_patch_path/$old_repository_name
                    cd $current_path/$para1/$old_repository_name
                    git format-patch $old_branch_commit -o $save_today_patch_path/$old_repository_name >> /dev/null 2>&1
                    break
                fi
            fi
        done < $new_manifest_file

    done < $old_manifest_file

    echo

#5. zip all patch
    usage_color "5. Zip all patch ..."
    cd $save_today_patch_path
    zip -r $today_patch_dir.zip ./* >> /dev/null 2>&1
    mv $today_patch_dir.zip ../

    echo
    usage_color "Today patch : [$save_today_patch_path.zip]"
    echo
#fi

#6. get all git res manifest
    usage_color "6. Zip all patch ..."
    cd $current_path/$para1
    
    for every_to_dir in `ls` 
    do
        if [ -e $every_to_dir/.git ];then
            #echo $every_to_dir
            mkdir -p $save_all_git_manifest/$every_to_dir
            cd $current_path/$para1/$every_to_dir
            git whatchanged > $save_all_git_manifest/$every_to_dir/$every_to_dir-commit.log
            cd $current_path/$para1
        else
            echo [$every_to_dir] is not a git res, skip ...
        fi
    done

#7. 

else
    usage_color "[$para1] does not exist or [$para1] is not dir file ..."
    Usage
fi


