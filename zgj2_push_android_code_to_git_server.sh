
para1=$1
loop=1
current_path=`pwd`
#current_source_code_top_dir=$current_path/$para1
current_source_code_top_dir=`which android_4_git_list`
echo "current_source_code_top_dir=$current_source_code_top_dir"

#############################

git_admin_config=003_clovertrain44.txt
#git_admin_config=test_git_admin_config.txt
android_top_dir="intel_clovertral_p_android_4.4"
write_git_source_codei_list="wb_git_gly@pbserver wanghai_157 wanghaifei legang ShuaiNanXiang ChenYinJun DingYuBin LeGang_r yuanhaiping xinkun liuxingde qichaomin zhangjuyuan zjk zhaojingrong laiyuanzhao"
read_git_source_code_list="tanglei"

Step1=1
if [ $Step1 -eq 1 ];then

    echo "####################################################" >> $git_admin_config
    echo "###### $android_top_dir  ######" >> $git_admin_config
    echo "####################################################" >> $git_admin_config
    for tmp_git_name in `cat $current_source_code_top_dir`
    do

        tmp=${tmp_git_name%.*} 
        echo "[group ${tmp}_rw_$loop]" >> $git_admin_config
        echo "writable = $android_top_dir/$tmp" >> $git_admin_config
        echo "members = $write_git_source_codei_list" >> $git_admin_config
        echo >> $git_admin_config
        
        echo "[group ${tmp}_ro_$loop]" >> $git_admin_config
        echo "readonly = $android_top_dir/$tmp" >> $git_admin_config
        echo "members = $read_git_source_code_list" >> $git_admin_config
        echo >> $git_admin_config
        echo >> $git_admin_config

        ((loop++))
    done

fi

