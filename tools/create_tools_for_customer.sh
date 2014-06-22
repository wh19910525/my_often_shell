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
current_path=`pwd`
core_program=wb_android_tools


######### func1 #########
color_loop=0
Program_has_func_list () {
	echo -en "\033[35m"

	mkdir $tools_bin -p
	git checkout mybin	

	for i in `ls mybin`
	do
		if [  x$i == xversion.txt ];then
			echo "skip version.txt"
		else
			gzexe mybin/$i	
		fi
	done



	rm mybin/*~
	cp mybin $tools_bin -rf
	gzexe add_for_customer.sh
	cp add_for_customer.sh $tools_bin/install.sh
	git checkout add_for_customer.sh
	rm *~
	cp readme.txt  $tools_bin
	
	make
	cp $core_program $tools_bin/
	make clean



	cd test
	tar cvzf WB-Customer-tools.tar.gz WB-Customer-tools
	mv WB-Customer-tools.tar.gz ../
	cd -	

	git checkout mybin	
	rm $tools_bin -rf

	echo -en "\033[0m"
}

####### main func #########
Step2=1
if [ $Step2 -eq 1 ];then 

	Program_has_func_list $Para1
fi


