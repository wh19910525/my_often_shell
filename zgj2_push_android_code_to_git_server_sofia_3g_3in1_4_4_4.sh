
para1=$1
loop=1
current_path=`pwd`
#current_source_code_top_dir=$current_path/$para1
current_source_code_top_dir=`which $0`
current_source_code_top_dir=${current_source_code_top_dir%/*}
current_source_code_top_dir=$current_source_code_top_dir/not_in_globle_path/sofia_3g_3in1_4_4_4_git_list
echo "current_source_code_top_dir=$current_source_code_top_dir"

#############################

#git_admin_config=gitosis.conf
git_admin_config="009_intel_sofia_3g_3in1_4_4_4.txt"
android_top_dir="intel_sofia_3g_3in1_4_4_4"
write_git_source_codei_list="wb_git_gly wanghai_157 wanghaifei legang ShuaiNanXiang ChenYinJun DingYuBin LeGang_r yuanhaiping xinkun liuxingde qichaomin zhangjuyuan zjk zhaojingrong laiyuanzhao liuwei huangsheng panyiwen hulin huangjiyu hesl"
read_git_source_code_list="tanglei buguoliang zhonglongcai chenqi"


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
        if [ $tmp_git_name == "end_android_project" ];then
            echo "Skip $tmp_git_name ...."
        else

        tmp=${tmp_git_name} 
        echo "[group sofia_3g_3in1_${tmp}_rw_$loop]" >> $git_admin_config
        echo "writable = $android_top_dir/$tmp" >> $git_admin_config
        echo "members = $write_git_source_codei_list" >> $git_admin_config
        echo >> $git_admin_config
        
        echo "[group sofia_3g_3in1_${tmp}_ro_$loop]" >> $git_admin_config
        echo "readonly = $android_top_dir/$tmp" >> $git_admin_config
        echo "members = $read_git_source_code_list" >> $git_admin_config
        echo >> $git_admin_config
        echo >> $git_admin_config

        ((loop++))

        fi

    done

fi

