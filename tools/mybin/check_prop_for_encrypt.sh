#!/bin/bash

#######################################
# Author: hai.wang 
#######################################

################################################################
####################### Globle Variables #######################
################################################################

Currtet_Dir=`pwd`
Para1=$1
Para2=$2
Para3=$3
Para4=$4

intel_4_2_kernel_logo_name="4-2"
intel_4_4_kernel_logo_name="4-4"
Use_intel_android_version="wanghai"

Mosidfy_kernel_logo_top_dir="$Para1/Modify_system_img_dir/kernel_logo"
Modify_System_img_Top_dir="$Para1/Modify_system_img_dir/modify_system/"
read_prop_file=$Modify_System_img_Top_dir/build.prop
check_4_4_info="ro.zgj.no.use=whtool-4.4"
check_4_2_info="ro.zgj.no.use=whtool-4.2"

after_modify_system_img=before_system.img
after_modify_system_img_path=$Para1/Modify_system_img_dir/$after_modify_system_img

new_system_img_gz_name=system.img.gz
new_system_img_gz_path=$Para1/Modify_system_img_dir/$new_system_img_gz_name

new_system_img_name=system.img
new_system_img_path=$Para1/Modify_system_img_dir/$new_system_img_name

after_modify_intel_fw_path=$Para1/Customer_tools_FW
tmp_system_img_gz=$after_modify_intel_fw_path/new_system.img.gz
old_system_img_gz=$after_modify_intel_fw_path/system.img.gz
new_system_img_gz=$after_modify_intel_fw_path/system.img.gz

weibu_tools_install_path="/usr/local/wh/tools"
intel_sign_logo_path=$weibu_tools_install_path/sign
intel_tools_bin_path=$weibu_tools_install_path/mybin

#############################################

######### func1 #########
color_loop=5
prop_loop=1

#4.2 logo
convert_intel_4_2_kernel_logo(){

	echo -en "\033[36m"
            # here panduan logo is 4.2 or 4.4
            for i in `ls $Mosidfy_kernel_logo_top_dir`
            do

                if [[ "$i" =~ bmp ]];then
                    #echo cp $Mosidfy_kernel_logo_top_dir/$i $intel_sign_logo_path/logo.bmp
                    cp $Mosidfy_kernel_logo_top_dir/$i $intel_sign_logo_path/logo.bmp

                    $intel_sign_logo_path/sign.sh > /dev/null
               
                    #4.2
                    #echo cp $intel_sign_logo_path/logo.img $after_modify_intel_fw_path/logo.img
                    cp $intel_sign_logo_path/logo.img $after_modify_intel_fw_path/logo.img
                fi

            done
            

	echo -en "\033[0m"

}

#4.4 logo
convert_intel_4_4_kernel_logo(){

	echo -en "\033[36m"
            # here panduan logo is 4.2 or 4.4
            for i in `ls $Mosidfy_kernel_logo_top_dir`
            do
            
                if [[ "$i" =~ bmp ]];then

                    #echo cp $Mosidfy_kernel_logo_top_dir/$i $intel_sign_logo_path/logo.bmp
                    cp $Mosidfy_kernel_logo_top_dir/$i $intel_sign_logo_path/logo.bmp

                    $intel_sign_logo_path/sign.sh > /dev/null
               
                    #4.4
                    #echo cp $intel_sign_logo_path/logo.img $after_modify_intel_fw_path/splash.img
                    cp $intel_sign_logo_path/logo.img $after_modify_intel_fw_path/splash.img
                fi

            done
            

	echo -en "\033[0m"

}


Check_fw_is_weibu () {


if [ -f $read_prop_file ];then

	for read_prop in `cat $read_prop_file`
	do

		if [[ "$read_prop" =~ $check_4_2_info ]];then
        
            echo -en "\033[36m"
			echo 
			echo 
			echo "正在 创建 新的 4.2 升级固件, 需要 3分钟, 请稍等...!!"
			echo 
			echo 
			echo -en "\033[0m"

            #echo "$intel_tools_bin_path/mkuserimg.sh $Modify_System_img_Top_dir $new_system_img_path ext4 system 2147483648"
            $intel_tools_bin_path/mkuserimg.sh $Modify_System_img_Top_dir $new_system_img_path ext4 system 2147483648 > /dev/null

			#echo "gzip < $new_system_img_path > $new_system_img_gz_path"
			gzip < $new_system_img_path > $new_system_img_gz_path
			
            #echo "cp $new_system_img_gz_path $new_system_img_gz"
            cp $new_system_img_gz_path $new_system_img_gz

            #sign intel kernel logo
            convert_intel_4_2_kernel_logo

			umount $Modify_System_img_Top_dir -l

			echo 
			echo 

			exit 0

		elif [[ "$read_prop" =~ $check_4_4_info ]];then

            echo -en "\033[36m"
			echo 
			echo 
			echo "正在 创建 新的 4.4 升级固件, 需要 3分钟, 请稍等...!!"
			echo 
			echo 
			echo -en "\033[0m"

            echo "$intel_tools_bin_path/mkuserimg.sh -s $Modify_System_img_Top_dir $new_system_img_path ext4 system 2147483648 $intel_tools_bin_path/file_contexts > /dev/null"
            $intel_tools_bin_path/mkuserimg.sh -s $Modify_System_img_Top_dir $new_system_img_path ext4 system 2147483648 $intel_tools_bin_path/file_contexts > /dev/null
			
            echo cp $new_system_img_path $after_modify_intel_fw_path
            cp $new_system_img_path $after_modify_intel_fw_path

            #sign intel kernel logo
            convert_intel_4_4_kernel_logo

			umount $Modify_System_img_Top_dir -l

			echo 
			echo 

			exit 0

		fi

		((prop_loop++))
	done

	echo -en "\033[3${color_loop}m"
	echo 
	echo "此工具 只支持 微步代码 编译 出来的固件!!"
	echo 
	echo -en "\033[0m"

	exit 1

else

    echo -en "\033[36m"
	echo "Not mount in $Modify_System_img_Top_dir, 请 解压 原始固件, 修改后 再次 压缩!!"
	echo -en "\033[0m"
	echo 

	exit 1
fi

}

####### main func #########
Step2=1
if [ $Step2 -eq 1 ];then 
	#echo intel_fw_path=$Para1
	Check_fw_is_weibu $Para1
fi

