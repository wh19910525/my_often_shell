#! /bin/bash
#############################
#author:wanghai
#############################

para1=$1
loop=1
current_path=`pwd`
current_source_code_top_dir=`which $0`
current_source_code_top_dir=${current_source_code_top_dir%/*}
every_repositories_permissions_file=$current_source_code_top_dir/not_in_globle_path/git_repositories_per/every_repositories_permissions.txt

############## need modify part ###############
git_admin_config="005_bytrain_code_4_4_4_user.txt"
android_top_dir_on_git_server_path="intel_baytrain_android_4_4_4"
every_sub_dir_list=$current_source_code_top_dir/not_in_globle_path/android_4_4_4_bytrain_git_list
group_name_prefix=baytrain444


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
    echo "###### $android_top_dir_on_git_server_path  ######" >> $git_admin_config
    echo "####################################################" >> $git_admin_config
    for tmp_git_name in `cat $every_sub_dir_list`
    do

        tmp=${tmp_git_name} 
        echo "[group ${group_name_prefix}_${tmp}_rw_$loop]" >> $git_admin_config
        echo "writable = $android_top_dir_on_git_server_path/$tmp" >> $git_admin_config
        echo "members = $write_git_source_codei_list" >> $git_admin_config
        echo >> $git_admin_config
        
        echo "[group ${group_name_prefix}_${tmp}_ro_$loop]" >> $git_admin_config
        echo "readonly = $android_top_dir_on_git_server_path/$tmp" >> $git_admin_config
        echo "members = $read_git_source_code_list" >> $git_admin_config
        echo >> $git_admin_config
        echo >> $git_admin_config

        ((loop++))
    done

fi

