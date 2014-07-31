#! /bin/bash

#######################################
# Author: hai.wang 
#######################################

current_path=`pwd`
core_program=wb_android_tools
kernel_logo_bin=kernel_logo_wb.sh
Will_save_all_program_path=/usr/local/wh/tools
GLOBLE_ENV_FILE="/etc/bash.bashrc"
has_add_globle_env=0

Step2=1
if [ $Step2 -eq 1 ];then

	echo -en "\033[32m"
	
    if [ "$(id -u)" == "0" ]; then

        for read_my_shell_bin_path in `cat $GLOBLE_ENV_FILE`
        do

            if [[ "$read_my_shell_bin_path" =~ "has_set_wb_intel_tools_for_intel=1" ]];then
               has_add_globle_env=1
            fi

        done

        if [ $has_add_globle_env -eq 1 ]
        then
            wanghai_no_use=1
        else
            echo
            echo "###### add by wanghai, add weibu intel tools shell scrupt ###### " >> $GLOBLE_ENV_FILE
            echo "has_set_wb_intel_tools_for_intel=1" >>  $GLOBLE_ENV_FILE
            
            echo "MY_WeiBu_Tools_PATH=$Will_save_all_program_path" >> $GLOBLE_ENV_FILE
            echo "export PATH=\$PATH:\$MY_WeiBu_Tools_PATH" >> $GLOBLE_ENV_FILE
            echo >> $GLOBLE_ENV_FILE
            echo >> $GLOBLE_ENV_FILE
        fi

        
        
        
        mkdir -p $Will_save_all_program_path
        rm $Will_save_all_program_path/* -rf
        mv $current_path/mybin $Will_save_all_program_path/ -f
        mv $current_path/sign $Will_save_all_program_path/ -f
        mv $current_path/$core_program $Will_save_all_program_path/weibu_tools -f
        mv $current_path/$kernel_logo_bin $Will_save_all_program_path/ -f
        #################
        rm ./install.sh
        #################
        
        
        
        echo
        echo "请 打开一个 新的 终端, 使用 weibu_tools 命令!!"
        date "+%Y-%m-%d %H:%M:%S"
        echo "Install WeiBu tools success!!"
        echo
        echo "if you are Root, please Execute [source /etc/bash.bashrc], 
                or Open a new Terminal, Switch to the root user!!"
        echo

        echo -en "\033[0m"

        echo -en "\033[33m"
        echo "If you have completed the above steps, 
                you can use [weibu_tools] at any place!!"
        echo
        echo
    else
    
        echo -en "\033[33m"
        echo
        echo
        echo "Please Switch to the root user!, then Execute ./install.sh"
        echo
        echo

    fi

	echo -en "\033[0m"


fi







