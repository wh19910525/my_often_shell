#! /bin/bash

current_path=`pwd`
patch_path=$current_path/fbak-patch
#patch_path=fbak-patch

for tmp_p in `ls $patch_path`
do
    if [ -f $patch_path/$tmp_p ];then
        echo -e "\033[;35m$patch_path/$tmp_p  \033[0m"
        patch -p1 < $patch_path/$tmp_p

        if [ $? -ne 0 ];then
           echo -e "\033[;34m$patch_path/$tmp_p failed ...  \033[0m" 
            mv $patch_path/$tmp_p $patch_path/failed/$tmp_p
        else
            echo "mkdir -p $patch_path/finish/"
            mkdir -p $patch_path/finish/
            mv $patch_path/$tmp_p $patch_path/finish/$tmp_p
        fi

        git status  | grep .orig | xargs rm >> /dev/null 2>&1
#        rm *.orig >> /dev/null 2>&1
        echo -e "\033[;36mInput Enter continue ... \033[0m "
        read f_Confirm

    fi
done


