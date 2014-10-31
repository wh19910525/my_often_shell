
para1=$1
loop=1
current_path=`pwd`

#############################

#git_admin_config=gitosis.conf
git_admin_config="006_xmm6321_code_4_4_4_user.txt"
android_top_dir="rockchip_xm6321_4_4_4"
android_source_code_list="android_rockchip_xm6321_4_4_4_git_list"
git_repositories_name_prefix="rk_intel_444"

current_source_code_top_dir=`which $android_source_code_list`
#write_git_source_codei_list="wb_git_gly@pbserver wanghai_157 wanghaifei legang ShuaiNanXiang ChenYinJun DingYuBin LeGang_r yuanhaiping xinkun liuxingde qichaomin zhangjuyuan zjk zhaojingrong laiyuanzhao liuwei huangsheng panyiwen"
write_git_source_codei_list="wb_git_gly@pbserver wanghai_157 qichaomin huangsheng panyiwen liuwei liuxingde hulin"
read_git_source_code_list="tanglei"


Step1=1
if [ $Step1 -eq 1 ];then

 
if [ -e $git_admin_config ];then
    rm $git_admin_config
fi

    echo "####################################################" >> $git_admin_config
    echo "###### $android_top_dir  ######" >> $git_admin_config
    echo "####################################################" >> $git_admin_config
    for tmp_git_name in `cat $current_source_code_top_dir`
    do

        tmp=${tmp_git_name%.*} 
        echo "[group ${git_repositories_name_prefix}_${tmp}_rw_$loop]" >> $git_admin_config
        echo "writable = $android_top_dir/$tmp" >> $git_admin_config
        echo "members = $write_git_source_codei_list" >> $git_admin_config
        echo >> $git_admin_config
        
        echo "[group ${git_repositories_name_prefix}_${tmp}_ro_$loop]" >> $git_admin_config
        echo "readonly = $android_top_dir/$tmp" >> $git_admin_config
        echo "members = $read_git_source_code_list" >> $git_admin_config
        echo >> $git_admin_config
        echo >> $git_admin_config

        ((loop++))
    done

fi

