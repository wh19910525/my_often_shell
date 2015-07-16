
para1=$1
loop=1
current_path=`pwd`
#current_source_code_top_dir=$current_path/$para1
current_source_code_top_dir=`which $0`
current_source_code_top_dir=${current_source_code_top_dir%/*}
every_repositories_permissions_file=$current_source_code_top_dir/not_in_globle_path/git_repositories_per/every_repositories_permissions.txt
current_source_code_top_dir=$current_source_code_top_dir/not_in_globle_path/rk_sofia_3gr_5_1_git_list
echo "current_source_code_top_dir=$current_source_code_top_dir"

#############################

#git_admin_config=gitosis.conf
git_admin_config="010_rk_sofia_3gr_5_1.txt"
android_top_dir="rockchip_sofia3gr_5_1"

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
    for tmp_git_name in `cat $current_source_code_top_dir`
    do
        if [ $tmp_git_name == "end_android_project" ];then
            echo "Skip $tmp_git_name ...."
        else

        tmp=${tmp_git_name} 
        echo "[group rk_sofia_3gr_5_1_${tmp}_rw_$loop]" >> $git_admin_config
        echo "writable = $android_top_dir/$tmp" >> $git_admin_config
        echo "members = $write_git_source_codei_list" >> $git_admin_config
        echo >> $git_admin_config
        
        echo "[group rk_sofia_3gr_5_1_${tmp}_ro_$loop]" >> $git_admin_config
        echo "readonly = $android_top_dir/$tmp" >> $git_admin_config
        echo "members = $read_git_source_code_list" >> $git_admin_config
        echo >> $git_admin_config
        echo >> $git_admin_config

        ((loop++))

        fi

    done

fi

