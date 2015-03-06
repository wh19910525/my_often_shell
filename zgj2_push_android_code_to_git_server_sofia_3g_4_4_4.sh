#! /bin/bash
#############################
#author:wanghai
#############################

para1=$1
loop=1
current_path=`pwd`
current_source_code_top_dir=`which $0`
current_source_code_top_dir=${current_source_code_top_dir%/*}
echo "current_source_code_top_dir=$current_source_code_top_dir"
manifest_file_path=$current_source_code_top_dir/not_in_globle_path/sofia_3g_4_4_4_manifest/sofia_3g_4_4_4_git_list
echo "manifest_file_path=$manifest_file_path"

#############################

#git_admin_config=gitosis.conf
git_admin_config="007_intel_sofia_3g_4_4_4.txt"
android_top_dir="intel_sofia_3g_5_0"
write_git_source_codei_list="wb_git_gly wanghai_157 wanghaifei legang ShuaiNanXiang ChenYinJun DingYuBin LeGang_r yuanhaiping xinkun liuxingde qichaomin zhangjuyuan zjk zhaojingrong laiyuanzhao liuwei huangsheng panyiwen hulin huangjiyu hesl"
read_git_source_code_list="tanglei buguoliang zhonglongcai chenqi"


Step1=1
if [ $Step1 -eq 1 ];then

 
if [ -e $git_admin_config ];then
    rm $git_admin_config
fi

    echo "####################################################" >> $git_admin_config
    echo "###### intel_sofia_3g_4_4_4  ######" >> $git_admin_config
    echo "####################################################" >> $git_admin_config
    for tmp_git_name in `cat $manifest_file_path`
    do

        tmp=$tmp_git_name 
        modify_tmp=${tmp_git_name////_} 
        #echo "modify_tmp=$modify_tmp"
        echo "[group sofia_3g_4_4_4_${modify_tmp}_rw_$loop]" >> $git_admin_config
        echo "writable = $android_top_dir/$tmp" >> $git_admin_config
        echo "members = $write_git_source_codei_list" >> $git_admin_config
        echo >> $git_admin_config
        
        echo "[group sofia_3g_4_4_4_${modify_tmp}_ro_$loop]" >> $git_admin_config
        echo "readonly = $android_top_dir/$tmp" >> $git_admin_config
        echo "members = $read_git_source_code_list" >> $git_admin_config
        echo >> $git_admin_config
        echo >> $git_admin_config

        ((loop++))
    done

fi

