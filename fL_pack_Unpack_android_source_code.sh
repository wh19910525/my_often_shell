#!/bin/bash

#######################################
# Author: hai.wang 
#######################################

para0=$0
para1=$1
para2=$2
para3=$3
para4=$4


################### Para ####################

aosp_dir_path=

#def value
every_tarFile_size=1024m 

current_path="`pwd`"
pack_aosp_dir="pack_aosp_`date "+%Y-%m-%d"`"
save_pack_aosp_file_path="$current_path/$pack_aosp_dir"

Unpack_aosp_dir="Unpack_aosp_`date "+%Y-%m-%d"`"
save_Unpack_aosp_file_path="$current_path/$Unpack_aosp_dir"

top_dir_other_file=top_dir_other_file


####### funtion1 ########
start_color_value=31
end_color_value=36

color_value=$start_color_value
usage_color () {
    echo -en "\033[${color_value}m"
    echo "$1"
    echo -en "\033[0m"
    if [ $color_value -eq $end_color_value ];then
        color_value=31
    else
        ((color_value++))
    fi
}

####### funtion2 ########
Usage(){
    usage_color "Usage :"
    usage_color "   `basename $para0` Pack -d Aosp_dir [-s Size]"
    usage_color "   `basename $para0` Unpack Has_Pack_aosp_dir"
}

####### funtion3 ########
Pack_Split_File(){
    #tar cvzf - lisa_test_project/ |split -b 1024m -d - logs.tar.gz.
    #echo "tar cvzf - $1/ |split -b $2 -d - $1.tar.gz."
    echo "Start pack $1 ..."
    tar czf - $1/ |split -b $2 -d - $1.tar.gz.
}

####### funtion4 ########
Pack_aosp_sourc_code (){

    while getopts ":d:s:" opt
    do 
        case $opt in
            d ) aosp_dir_path=$OPTARG
                echo aosp_dir_path=$aosp_dir_path;;
            s ) every_tarFile_size=$OPTARG
                echo every_tarFile_size=$every_tarFile_size;;
            ? ) echo "error " ;;

        esac
    done

    if [ -z $aosp_dir_path ];then
        usage_color "Usage : `basename $para0` [Pack] -d Aosp_dir -s Size"
        exit 1
    fi

    if [ ! -d $aosp_dir_path ];then

        echo $aosp_dir_path no exits 
        exit 2

    fi

    #1. Pack all top dir
    usage_color "You Will pack [$aosp_dir_path], size=[$every_tarFile_size]"
    cd $current_path/$aosp_dir_path
    
    for every_file in `ls -A` 
    do
        if [ -d $every_file/ ];then
            mkdir -p $save_pack_aosp_file_path/$every_file
            Pack_Split_File $every_file $every_tarFile_size
            mv $every_file.tar.gz* $save_pack_aosp_file_path/$every_file
        else # top file
            mkdir -p $save_pack_aosp_file_path/$top_dir_other_file
            cp $every_file $save_pack_aosp_file_path/$top_dir_other_file
        fi

        cd $current_path/$aosp_dir_path
    done

}

####### funtion5 ########
Unpack_aosp_sourc_code (){

    if [ $# != 1 ];then
        usage_color "Usage : `basename $para0` [Unpack] Has_Pack_aosp_dir"
        exit 1
    fi
    
    if [ ! -d $1 ];then
        echo $1 no exits ...
        exit 2
    fi

    #1. Uppack all top dir
    usage_color "You Will Unpack [$1] ..."
    cd $current_path/$1
    
    mkdir -p $save_Unpack_aosp_file_path

    for every_file in `ls -A` 
    do
        if [ -d $every_file/ ];then
            echo "Unpacking $every_file"
            if [ $every_file != $top_dir_other_file ];then
                cd $every_file
                #cat logs.tar.gz.0* | tar xvz
                cat $every_file.tar.gz.* | tar xz -C $save_Unpack_aosp_file_path
            else # top file
                cp $every_file/. -a $save_Unpack_aosp_file_path
            fi
        fi

        cd $current_path/$1
    done

}


################## Main func #####################
if [ $# -lt 1 ];then
    Usage
    exit 1
elif [ $para1 == "Pack" ];then
    # del "Pack"
    shift
    Pack_aosp_sourc_code $@
    exit 0
elif [ $para1 == "Unpack" ];then
    # del "Pack"
    shift
    Unpack_aosp_sourc_code $@
    exit 0
else
    Usage
    exit 2
fi

