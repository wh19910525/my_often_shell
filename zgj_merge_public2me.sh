#! /bin/bash
#############################
#author:wanghai
#############################

file_data=`date "+%Y-%m-%d-%H-%M-%S"`
tmp_current_branch=`git branch -a | sed -n '/'*'/p'`
all_branch=`git branch -a`
current_git_branch=${tmp_current_branch##*\ }
def_need_branch="7.85_br200_MIPI_BQ24196_CW120X_REL_public"
remotes_name="remotes/origin/$1"
cmd_para_1=$1
all_remote_branch="/tmp/tmp_branch_$file_data.log"
current_path=`pwd`
loop=1

######### func1 #########
print_all_remote_branch (){

    git branch -a > $all_remote_branch

    echo
    pwd
    echo "$loop : ========== Remote has fallowing branch : =========="
    for tmp_branch in `cat $all_remote_branch`
    do
        if [[ "$tmp_branch" =~ "remotes/origin" ]];then
            if [[ "$tmp_branch" =~ "HEAD" ]];then
                a=1
            elif [[ "$tmp_branch" =~ "remotes/origin" ]];then
                echo "    ${tmp_branch##*/}"
            fi
        fi
    done
echo ---------------------
echo
}

######### func2 #########
usage () {
    echo -en "\033[32m"
    echo "Usage:"
    echo "  zgj_merge_public2me.sh [Server_branch_name] "
    echo 
    echo "def server branch : $def_need_branch"
echo
echo
    echo -en "\033[0m"
}

######### func3 #########
check_branch_exit () {

#echo $all_branch
    if [[ "$all_branch" =~ "$remotes_name" ]];then
        echo -en "\033[33m"
        echo "This remote : $cmd_para_1 exits in git Server"
        echo -en "\033[0m"
        echo
    else
        echo -en "\033[35m"
        echo "This remote : $cmd_para_1 do not exit in git Server"
        echo "please input Current branch, or Use def branch : $def_need_branch"
        echo -en "\033[0m"
        echo
        exit 1
    fi 
    need_branch=$cmd_para_1
}



Step1=1
if [ $Step1 -eq 1 ];then

    if [ $# -ne 1 ]; then
        usage
        exit 2
        need_branch=$def_need_branch
    else
        check_branch_exit
    fi

    for tmp_git_name in `ls $current_path`
    do

        tmp=${tmp_git_name%.*} 
        has_git_dir=$current_path/$tmp/.git

        if [ -d $has_git_dir ];then

            cd $current_path/$tmp_git_name > /dev/null
            ## main ##
            print_all_remote_branch

            cp .git/config .git/config-$file_data

            echo "[branch \"$current_git_branch\"]" >> .git/config
            echo "    remote = origin" >>  .git/config
            echo "    merge = refs/heads/$need_branch" >>  .git/config
            #echo ======================
            #cat -n .git/config
            #echo ======================

            ######
            #echo git pull
            git pull
            #####

            cp .git/config-$file_data .git/config

            rm .git/config-$file_data
            rm $all_remote_branch

            cd - > /dev/null
            ((loop++))
        fi
    done

    android_top_dir_has_git=$current_path/.git
    if [ -d $android_top_dir_has_git ]; then
        cd $current_path/$tmp_git_name > /dev/null
        ## main ##
        print_all_remote_branch

        cp .git/config .git/config-$file_data

        echo "[branch \"$current_git_branch\"]" >> .git/config
        echo "    remote = origin" >>  .git/config
        echo "    merge = refs/heads/$need_branch" >>  .git/config
        #echo ======================
        #cat -n .git/config
        #echo ======================

        ######
        #echo git pull
        git pull
        #####

        cp .git/config-$file_data .git/config

        rm .git/config-$file_data
        rm $all_remote_branch

        cd - > /dev/null
    fi
fi



