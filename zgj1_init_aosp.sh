#! /bin/bash
#############################
#author:wanghai
#############################

para0=$0
para1=$1
para2=$2
para3=$3
para4=$4

#########################

filter_files="--exclude=.git* --exclude=.repo --exclude=.gitignore"
current_date=`date "+%Y-%m-%d-%H-%M-%S"`
tmp_dir="tmp_dir_$current_date"



####### funtion1 ########
usage_color () {
    echo -en "\033[32m"
    echo "  $1  "
    echo -en "\033[0m"
}

####### funtion2 ########
Usage(){
    usage_color "Please use [`basename $para0` aosp_dir]"
}

####### funtion3 ########









############### main ###############
if [ $# -ne 1 ];then
    Usage
elif [ -e $para1 ];then
#    usage_color "$para1 exists ..."

    #1.tilter some files, such as .git .gitignore ...
    tar -czvf $para1.tar.gz ./$para1 $filter_files

    #2.unzip previous step zip file ...
    mkdir -p $tmp_dir
    tar -xvf $para1.tar.gz -C $tmp_dir

    #3. git init all top dir, get clone all dir ...
    cd $tmp_dir
    zgj1_create_all_dir_git_for_gitserver.sh $para1
    
    #4.
    mv $para1 every_top_has_git_init_aosp
    cd -
#    rm $para1.tar.gz

else
    usage_color "$para1 does not exists ..."
    Usage
fi


