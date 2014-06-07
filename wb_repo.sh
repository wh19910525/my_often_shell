#!/bin/bash

#######################################
# Author: hai.wang 
#######################################

para1=$1
para2=$2

loop=1
globle_loop=1
current_path=`pwd`
current_source_code_top_dir=$current_path/$para1
current_data=`date "+%Y_%m_%d_%H_%M_%S"`

#############################

android_top_dir=android_source_code_$current_data
git_server_addr=192.168.2.5
on_git_server_android_source_code_name=all_sub_dir_git_init_2014_06_07

####### funtion1 ########
usage_color () {
    echo -en "\033[32m"
    echo "  $1  "
    echo -en "\033[0m"
}

####### funtion2 ########
usage_help () {
    echo -en "\033[31m
wb_repo.sh [options]
    options:
        -- status
        -- checkout
        -- branch
        -- pull
        -- push

"
    echo -en "\033[0m"
}

####### funtion3 ########
git_status (){
    echo repositories : $globle_loop
    if [ $# -eq 1 ]; then
        cd $1 >> /dev/null
        pwd
        git status 
        cd - >> /dev/null
    else
    
        pwd
        git status

    fi
    ((globle_loop++))
    echo
}

####### funtion4 ########
git_branch (){
    echo repositories : $globle_loop
    if [ $# -eq 1 ]; then
        cd $1 >> /dev/null
        pwd
        git branch $para2
        cd - >> /dev/null
    else
    
        pwd
        git branch $para2

    fi
    ((globle_loop++))
    echo
}

####### funtion5 ########
git_checkout (){
    echo repositories : $globle_loop
    if [ $# -eq 1 ]; then
        cd $1 >> /dev/null
        pwd
        git checkout .
        cd - >> /dev/null
    else
    
        pwd
        git checkout .

    fi
    ((globle_loop++))
    echo
}

####### funtion6 ########
git_pull (){
    echo repositories : $globle_loop
    if [ $# -eq 1 ]; then
        cd $1 >> /dev/null
        pwd
        git branch $para2
        git pull 
        cd - >> /dev/null
    else
    
        pwd
        git branch $para2
        git pull

    fi
    ((globle_loop++))
    echo
}

####### funtion7 ########
git_push (){
    echo repositories : $globle_loop
    if [ $# -eq 1 ]; then
        cd $1 >> /dev/null
        pwd
        git branch $para2
        git push 
        cd - >> /dev/null
    else
    
        pwd
        git branch $para2
        git push

    fi
    ((globle_loop++))
    echo
}





############# main func ##############
if [ $# -ne 0 ]; then

    if [ -d frameworks ]; then

        ###### git status ######
        if [ x$para1 = x"status" ];then

            for tmp in `ls` 
            do
                if [ -d $tmp -a $tmp != .git -a $tmp != out -a $tmp != pub ]; then
                    git_status $tmp
                fi        

            done

            git_status           

        ###### git branch ######
        elif [ x$para1 = x"branch" ]; then

            for tmp in `ls` 
            do
                if [ -d $tmp -a $tmp != .git -a $tmp != out -a $tmp != pub ]; then
                    git_branch $tmp
                fi        

            done

            git_branch

        ###### git checkout ######
        elif [ x$para1 = x"checkout" ]; then

            for tmp in `ls` 
            do
                if [ -d $tmp -a $tmp != .git -a $tmp != out -a $tmp != pub ]; then
                    git_checkout $tmp
                fi        

            done

            git_checkout

        ###### git pull ######
        elif [ x$para1 = x"pull" ]; then

            for tmp in `ls` 
            do
                if [ -d $tmp -a $tmp != .git -a $tmp != out -a $tmp != pub ]; then
                    git_pull $tmp
                fi        

            done

            git_pull

        ###### git push ######
        elif [ x$para1 = x"push" ]; then

            for tmp in `ls` 
            do
                if [ -d $tmp -a $tmp != .git -a $tmp != out -a $tmp != pub ]; then
                    git_push $tmp
                fi        

            done

            git_push
        fi

    else

        usage_color "Please in android 4.4 top dir ,Using this cmd!!"
        exit 1

    fi

else

    usage_help

fi









###############################

Step1=0
if [ $Step1 -eq 1 ]; then
if [ $# -eq 1 ]; then

mkdir $android_top_dir -p
cd $android_top_dir


    echo -en "\033[32m"

    date "+%Y-%m-%d %H:%M:%S"
    echo "Start get android source code from $git_server_addr:$on_git_server_android_source_code_name "

    echo -en "\033[0m"


for tmp_git_name in `cat $current_source_code_top_dir`
do

    #echo git clone  git@$git_server_addr:$on_git_server_android_source_code_name/$tmp_git_name
    git clone  git@$git_server_addr:$on_git_server_android_source_code_name/$tmp_git_name
    echo "$loop : Clone all_sub_dir_git_init_2014_06_07/$tmp_git_name successed!!"

    echo 
    echo 

    ((loop++))
done

if [ -e android_top ]; then
    pwd
    mv android_top/* .
    rm android_top -rf
fi

    echo -en "\033[35m"

    echo "Finshed : get android source code from $git_server_addr:$on_git_server_android_source_code_name !!"
    date "+%Y-%m-%d %H:%M:%S"

    echo -en "\033[0m"
fi
fi

################################


