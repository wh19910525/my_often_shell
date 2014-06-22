#!/bin/bash

#######################################
# Author: hai.wang 
#######################################

################################################################
####################### Globle Variables #######################
################################################################
WB_Customer_tools=WB-Customer-tools
tools_bin=test/$WB_Customer_tools
my_bin=mybin


######### func1 #########
color_loop=0
Program_has_func_list () {
	echo -en "\033[35m"

	mkdir $tools_bin -p
	git checkout mybin	
	for i in `ls mybin`
	do
		gzexe mybin/$i	
	done

	rm mybin/*~
	cp mybin $tools_bin -rf
	
	make
	cp wb_android_tools $tools_bin
	make clean

	cd test
	tar cvzf WB-Customer-tools.tar.gz WB-Customer-tools
	mv WB-Customer-tools.tar.gz ../
	cd -	

	git checkout mybin	

	echo -en "\033[0m"
}

####### main func #########
Step2=1
if [ $Step2 -eq 1 ];then 

	Program_has_func_list $Para1
fi


