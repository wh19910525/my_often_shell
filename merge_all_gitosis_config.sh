#! /bin/bash

#######################################
# Author: hai.wang 
#######################################


gitosis_admin_path=~/works/gitosis-admin
gitosis_admin_configfile_name=gitosis.conf
gitosis_admin_config=$gitosis_admin_path/$gitosis_admin_configfile_name

loop=1

#####################

rm $gitosis_admin_config -rf

for tmp_file in `ls $gitosis_admin_path`
do
    if [ -f $gitosis_admin_path/$tmp_file ];then
        echo $loop : $tmp_file
        cat $gitosis_admin_path/$tmp_file >> $gitosis_admin_config
    fi
    ((loop++))
    
done

