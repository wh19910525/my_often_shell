#! /bin/bash
#############################
#author:wanghai
#############################


############## Start ###############
export delete_repo_string=git@192.168.2.5:from_manifest_get_ok_git_on_git_server_dir/
server_manifest_path="git@192.168.2.5:from_manifest_get_ok_git_on_git_server_dir/sofia_3g_manifest.git"
current_data=`date "+%Y_%m_%d_%H_%M_%S"`
source_code_top_dir=baytrain_5_0_$current_data
current_path=`pwd`
get_source_code_file_path=`which $0`
echo get_source_code_file_path=$get_source_code_file_path
MY_repo_Top_dir=`dirname $get_source_code_file_path`
Not_in_globle_dir=$MY_repo_Top_dir/not_in_globle_path
MY_repo_Top_dir=$MY_repo_Top_dir/not_in_globle_path/frank_repo
My_repo=$MY_repo_Top_dir/repo
echo MY_repo_Top_dir=$MY_repo_Top_dir

########################


if [ -e $My_repo ]; then
    echo "repo has exist !!"
else
    echo "repo do not exist, so we get it !!"
    cd $Not_in_globle_dir
    tar xf frank_repo.tar.gz
    cd -
fi

mkdir $source_code_top_dir
cd $source_code_top_dir

#echo "1. repo init"
$My_repo init -q -u $server_manifest_path

#echo cp $MY_repo_Top_dir/* .repo/repo/ -rf
cp $MY_repo_Top_dir/* .repo/repo/ -rf


#echo "2. repo sync"
$My_repo sync -q

cd -

############## end ###############


