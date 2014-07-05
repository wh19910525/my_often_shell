#!/bin/bash

#######################################
# Author: hai.wang 
#######################################

################################################################
####################### Globle Variables #######################
################################################################
Para1=$1
Para2=$2
Para3=$3
Para4=$4


#Para1=/all_read_write
echo Para1=$Para1

weibu_tools_install_path="/usr/local/wh/tools"
intel_sign_logo_path=$weibu_tools_install_path/sign
intel_tools_bin_path=$weibu_tools_install_path/mybin
intel_tools_config_path=$weibu_tools_install_path/mybin/config


after_modify_intel_fw_path=$Para1/Customer_tools_FW
Modify_system_img_dir_path=$Para1/Modify_system_img_dir/before_system.img
FW_partition_tbl_path=$after_modify_intel_fw_path/partition.tbl

loop=1
system_partation_tbl_size=0
system_img_ext4_size=0

##############################################

######### func1 #########
color_loop=0
Program_has_func_list () {
	echo -en "\033[35m"
	echo 
	#cat /usr/local/wh/tools/mybin/version.txt
	echo 
	echo -en "\033[0m"

    

}


tmp_system_line="system"

######### func1 #########
Get_system_partation_tbl_size(){

cat $FW_partition_tbl_path | while read ev_line
do
    echo $loop : $ev_line

    if [[ "$ev_line" =~ "$tmp_system_line" ]];then
        
        #截取 system 分区大小
        need_value1=${ev_line%-t*} 
        need_value2=${need_value1#*-s} 


        #去除空格;
        no_space_value=${need_value2%\ *}
        no_space_value=${no_space_value#*\ }

        num1=$no_space_value
        ((num2=2*1024))
        num3=`expr $num1 / $num2` #unit : MB

        echo "partition.tbl ,this part is $num3 MB" 

        cat 11111111133333333333 $intel_tools_config_path
        sed -i '/^system_partation_tbl_size/ c\system_partation_tbl_size='"$num3"''  $intel_tools_config_path
        cat 222222222211111111133333333333 $intel_tools_config_path

    fi

    ((loop++))
done

}


Get_system_img_ext4_size(){

        tmp_system_img_ext4_size_info=`ls -l $Modify_system_img_dir_path`

        #删除左侧的空格;
        left_space=5
        for ((i=1; i<$left_space;i++))
        do
            tmp_system_img_ext4_size_info=${tmp_system_img_ext4_size_info#*\ } 
        done

        #删除右侧的空格;
        right_space=7
        for ((i=1; i<$right_space; i++))
        do
            tmp_system_img_ext4_size_info=${tmp_system_img_ext4_size_info%\ *} 
        done

        system_img_ext4_size=$tmp_system_img_ext4_size_info
        ((system_img_ext4_size=$system_img_ext4_size/(1024*1024))) 

        echo "system.img.ext4 ,this part is $system_img_ext4_size MB" 
        cat 55555555511111111133333333333 $intel_tools_config_path
        sed -i '/^system_img_ext4_size/ c\system_img_ext4_size='"$system_img_ext4_size"''  $intel_tools_config_path
        cat 666666666655555555511111111133333333333 $intel_tools_config_path
}


new_system_img_ext4_size(){


for tmp in `cat $intel_tools_config_path`
do
    if [[ "$tmp" =~ "system_img_ext4_size" ]];then
       tmp=${tmp#*=}
       system_img_ext4_size=$tmp 

    fi


    if [[ "$tmp" =~ "system_partation_tbl_size" ]];then
       tmp=${tmp#*=}
       system_partation_tbl_size=$tmp 

    fi


done


echo system_img_ext4_size=$system_img_ext4_size
echo system_partation_tbl_size=$system_partation_tbl_size

    if [ $system_img_ext4_size -gt $system_partation_tbl_size ];then
        echo "system.img.ext4 大于 分区!!"        
        exit 1
    else
        echo 33333333333 system_img_ext4_size=$system_img_ext4_size

        if [ $system_img_ext4_size -eq 1024 ];then
            #1G
            real_ext4_system_img_size=1073741824
        elif [ $system_img_ext4_size -eq 2048 ];then
            #2G
            real_ext4_system_img_size=2147483648
        elif [ $system_img_ext4_size -gt 1024 -a $system_img_ext4_size -le 1224 ];then
            #1.2G
            real_ext4_system_img_size=1283457024
        elif [ $system_img_ext4_size -gt 1224 -a $system_img_ext4_size -le 1536 ];then
            #1.6G
            real_ext4_system_img_size=1610612736
        else
            #def : 1G
            real_ext4_system_img_size=1073741824
        fi

        sed -i '/^real_ext4_system_img_size/ c\real_ext4_system_img_size='"$real_ext4_system_img_size"''  $intel_tools_config_path
        cat 333333333334444444444  $intel_tools_config_path
    fi

}




####### main func #########
Step2=1
if [ $Step2 -eq 1 ];then 
echo do get_system_img_size.sh
	Get_system_partation_tbl_size
	Get_system_img_ext4_size

    new_system_img_ext4_size

fi




