#! /bin/bash

#######################################
# Author: hai.wang 
#######################################

current_path=`pwd`

###### 1. main func ######
my_bin_path_loop=0
MY_SHELL_BIN_PATH=$current_path

for my_bin_dir in `ls $current_path`
do
	if [ -d $my_bin_dir ]
	then
		((my_bin_path_loop++))
		tmp_my_bin_path=$current_path/$my_bin_dir
		MY_SHELL_BIN_PATH=$MY_SHELL_BIN_PATH:$tmp_my_bin_path
		#echo $MY_SHELL_BIN_PATH
	fi
 
done
################
#has_set_my_shell_bin_path=1
GLOBLE_ENV_FILE="/etc/bash.bashrc"
has_add_globle_env=0

##### if set flag, the following code will not be executed #####

for read_my_shell_bin_path in `cat $GLOBLE_ENV_FILE`
do

	if [[ "$read_my_shell_bin_path" =~ "has_set_my_shell_bin_path=1" ]];then
	#   echo has_add_globle_env=1
	   has_add_globle_env=1
	fi

done

if [ $has_add_globle_env -eq 1 ]
then
	sed -i '/^MY_SHELL_PATH/ c\MY_SHELL_PATH='"${MY_SHELL_BIN_PATH}"'' $GLOBLE_ENV_FILE
else
	echo "###### add by wanghai, add my often use shell scrupt ###### " >> $GLOBLE_ENV_FILE
#	echo "set my often use shell scrupt path : has_set_my_shell_bin_path=1"
#	echo "has_set_my_shell_bin_path=1 >>  $GLOBLE_ENV_FILE"
	echo "has_set_my_shell_bin_path=1" >>  $GLOBLE_ENV_FILE
	
#	echo "set my often use shell bin path!"
#	echo "export PATH=$PATH:$MY_SHELL_BIN_PATH >> $GLOBLE_ENV_FILE"
	echo "MY_SHELL_PATH=$MY_SHELL_BIN_PATH" >> $GLOBLE_ENV_FILE
    echo "export PATH=\$PATH:\$MY_SHELL_PATH" >> $GLOBLE_ENV_FILE
	echo >> $GLOBLE_ENV_FILE
	echo >> $GLOBLE_ENV_FILE
	echo >> $GLOBLE_ENV_FILE
fi

	echo "set often use shell scrupt path success!!"
	echo "you need do '. $GLOBLE_ENV_FILE' , let you add all commands to take effect !!"


