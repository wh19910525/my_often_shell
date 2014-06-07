
para1=$1
loop=1
current_path=`pwd`
current_source_code_top_dir=$current_path/$para1


#############################

git_admin_config=gitosis.conf
#git_admin_config=test_git_admin_config.txt
android_top_dir="all_sub_dir_git_init_2014_06_07"
write_git_source_codei_list="wb_git_gly@pbserver wanghai_157"
read_git_source_code_list="wanghaifei legang ShuaiNanXiang ChenYinJun DingYuBin LeGang_r xinkun liuxingde yuanhaiping tanglei2 qichaomin zhangjuyuan fangbinglin zjk"

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

