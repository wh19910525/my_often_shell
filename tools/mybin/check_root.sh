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

Currtet_Dir=`pwd`
color_loop=2

######### func1 #########
check_root()
{

        if [ "$(id -u)" != "0" ]; then
            echo -en "\033[32m"
            echo 
            echo "!!! This Program must be run as root !!!" 1>&2
            echo "Usage: [sudo -i] - change to account root " 1>&2
            echo 
            echo -en "\033[0m"
            exit 2
            else
            echo -en "\033[33m"
            echo 
    #		echo "OK.... you are running by root.. system will keep going..."
            echo 
            echo -en "\033[0m"
        fi  

}


####### main func #########
Step2=1
if [ $Step2 -eq 1 ];then 

	check_root	
	#exit 0
fi

