#! /bin/bash
#############################
#author:wanghai
#############################

######### func1 #########
usage () {
    echo -en "\033[32m"
    echo "Usage:"
    echo "  ./device/weibu/weibu_tools/merge_public2me.sh [Server_branch_name] "
    echo 
    echo "def server branch : $def_need_branch"
echo
echo
    echo -en "\033[0m"
}

########### Globle variable  ##########
Current_path=`pwd`
echo Current_path=$Current_path
Current_path_has_git=$Current_path/.git
Current_path_has_frameworks=$Current_path/frameworks

Current_git_branch=`git branch -a | sed -n '/'*'/p'`
echo Current_git_branch=$Current_git_branch
Will_push2_server_branch=${Current_git_branch#*\ } 
echo Will_push2_server_branch=$Will_push2_server_branch



################
#git push origin new_branch1:new_branch1

if [ -e $Current_path_has_git ]; then
    echo "$Current_path has .git !!"

    if [ -d $Current_path_has_frameworks ]; then
        echo "$Current_path_has_frameworks is android Top dir!!"
    ###########################
        echo git push origin $Will_push2_server_branch:$Will_push2_server_branch
        if [ $? -eq 0 ]; then
            echo -en "\033[32m"
            echo "You have push the [$Will_push2_server_branch] --> Server[192.168.2.5] !!"
            echo -en "\033[0m"
            echo 
        fi
    fi

###########################

else
    echo "$Current_path is not android Top dir!!"
fi












