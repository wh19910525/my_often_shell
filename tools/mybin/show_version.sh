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

##############################################

######### func1 #########
color_loop=0
Program_has_func_list () {
	echo -en "\033[35m"

	echo 
	echo "wb_android_tools : Version 1.0.0 !!"
	cat mybin/version.txt
	echo 
	echo -en "\033[0m"
}


####### main func #########
Step2=1
if [ $Step2 -eq 1 ];then 

	Program_has_func_list $Para1
fi




