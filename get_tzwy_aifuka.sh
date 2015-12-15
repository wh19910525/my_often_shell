#! /bin/bash
#############################
#author:wanghai
#############################

current_user=`whoami`

################################

    echo -en "\033[32m"
    echo
    date "+%Y-%m-%d %H:%M:%S"
    echo "Start get android source code ... "
    echo
    echo -en "\033[0m"

    if [ x$current_user == xcompileserver ];then
        git clone /disk2/my_project/tzwy_aifuka.git
    else
        git clone compileserver@10.91.11.183:/disk2/my_project/tzwy_aifuka.git
    fi

    echo -en "\033[32m"
    echo
    date "+%Y-%m-%d %H:%M:%S"
    echo "Finish get android source code ... "
    echo
    echo -en "\033[0m"

