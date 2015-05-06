#!/bin/bash

#######################################
# Author: hai.wang 
#######################################


android_src_dir=android
other_flag=bootsystems

current_path=`pwd`
current_date=`date "+%Y-%m-%d-hour-%H"`
save_manifest_file=$current_path/$android_src_dir/wb_project/tools/manifest/$current_date.xml
tmp_android_manifest=$current_path/$android_src_dir/wb_project/tools/manifest/android_f.xml

##############

if [ -d $android_src_dir -a -d $other_flag ]; then

    echo "this is sofia top dir ..."
    wb_repo.sh manifest -o $save_manifest_file
else
    echo "this is not sofia top dir ..."
    exit 1
fi        

cd $android_src_dir
echo "============== following is android part ==============" >> $save_manifest_file
wb_repo.sh manifest -o $tmp_android_manifest
cat $tmp_android_manifest >> $save_manifest_file
rm $tmp_android_manifest


