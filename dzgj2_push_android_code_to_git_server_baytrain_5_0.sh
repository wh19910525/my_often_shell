#! /bin/bash
#############################
#author:wanghai
#############################

para1=$1
loop=1
current_path=`pwd`
current_source_code_top_dir=`which dzgj2_push_android_code_to_git_server_baytrain_5_0.sh`
current_source_code_top_dir=${current_source_code_top_dir%/*}
every_repositories_permissions_file=$current_source_code_top_dir/not_in_globle_path/git_repositories_per/every_repositories_permissions.txt
echo "current_source_code_top_dir=$current_source_code_top_dir"
manifest_file_path=$current_source_code_top_dir/not_in_globle_path/baytrain_5_0_manifest/baytrain_5_0_repo_res_list
echo "manifest_file_path=$manifest_file_path"

#############################

#git_admin_config=gitosis.conf
git_admin_config="008_intel_baytrain_5_0.txt"
android_top_dir="intel_baytrain_5_0"

######### add everyone permissions for repositories #########
while read ev_line
do
    if [ "write_git_source_codei_list" = ${ev_line%=*} ];then
        write_git_source_codei_list=${ev_line#*=}
    elif [ "read_git_source_code_list" = ${ev_line%=*} ];then
        read_git_source_code_list=${ev_line#*=}
    fi
done < $every_repositories_permissions_file
##################

Step1=1
if [ $Step1 -eq 1 ];then
 
if [ -e $git_admin_config ];then
    rm $git_admin_config
fi

    echo "####################################################" >> $git_admin_config
    echo "###### $android_top_dir  ######" >> $git_admin_config
    echo "####################################################" >> $git_admin_config
    for tmp_git_name in `cat $manifest_file_path`
    do

        tmp=$tmp_git_name 
        modify_tmp=${tmp_git_name////_} 
        #echo "modify_tmp=$modify_tmp"
        echo "[group baytrain_5_0_${modify_tmp}_rw_$loop]" >> $git_admin_config
        echo "writable = $android_top_dir/$tmp" >> $git_admin_config
        echo "members = $write_git_source_codei_list" >> $git_admin_config
        echo >> $git_admin_config
        
        echo "[group baytrain_5_0_${modify_tmp}_ro_$loop]" >> $git_admin_config
        echo "readonly = $android_top_dir/$tmp" >> $git_admin_config
        echo "members = $read_git_source_code_list" >> $git_admin_config
        echo >> $git_admin_config
        echo >> $git_admin_config

        ((loop++))
    done

fi

