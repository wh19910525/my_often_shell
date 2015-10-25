#! /bin/bash

#######################################
# Author: hai.wang 
#######################################

gitosis_admin_path=~/works/gitosis-admin

this_bin_path=`which $0`
tools_top_dir=${this_bin_path%/*}
permissions_file_name=not_in_globle_path/git_repositories_per/every_repositories_permissions.txt
permissions_config_file=$tools_top_dir/$permissions_file_name
permissions_config_file_tmp=$tools_top_dir/${permissions_file_name}-tmp
 
########################

#Step 1.添加 新的key:
#get all key, but not suffix
get_all_soource_key=`ls $gitosis_admin_path/keydir`
get_all_soource_key_prefix=${get_all_soource_key//.pub/}
echo Member List: $get_all_soource_key_prefix

#Step 2.replace write_git_source_codei_list string
sed -i '/^write_git_source_codei_list=/d' $permissions_config_file
cp $permissions_config_file $permissions_config_file_tmp
echo write_git_source_codei_list=$get_all_soource_key_prefix > $permissions_config_file
cat $permissions_config_file_tmp >> $permissions_config_file
cd $tools_top_dir
git add $permissions_file_name
cd - > /dev/null 2>&1
rm $permissions_config_file_tmp

#Step 3.Add permissions for a new engineer
cd $gitosis_admin_path
company_szkj_push_public_code_to_git_server.sh
merge_all_gitosis_config.sh
git add .
git commit -m"add new key"
git push
cd - > /dev/null 2>&1

#4.


