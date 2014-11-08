#!/bin/bash

#######################################
# Author: hai.wang 
#######################################

################################################################
####################### Globle Variables #######################
################################################################
WB_Customer_tools=Modify_system_img_tools
my_bin=x86_bin
main_bin="android_tools.sh"

current_date=`date "+%Y-%m-%d-%H-%M"`
Publishing_software_name="WB_Modify_system_img_tools-${current_date}.tar.gz"

################################################################

######### func1 #########
color_loop=0
Program_has_func_list () {

	mkdir $WB_Customer_tools -p
	cp $my_bin $WB_Customer_tools -rf
    cp $main_bin $WB_Customer_tools -rf
	tar cvzf $Publishing_software_name $WB_Customer_tools
    rm $WB_Customer_tools -rf

	echo -en "\033[35m"
    echo "finished $Publishing_software_name"
	echo -en "\033[0m"
}

####### main func #########
Step2=1
if [ $Step2 -eq 1 ];then 
	Program_has_func_list
fi


