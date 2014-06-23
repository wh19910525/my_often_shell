#!/bin/bash

#######################################
# Author: hai.wang 
#######################################

para1=$1
para2=$2
para3=$3
para4=$4

loop=1
globle_loop=1
current_path=`pwd`
current_data=`date "+%Y_%m_%d_%H_%M_%S"`
manifest_file=$current_path/manifest_$current_data
dir_has_git=".git/config"

#############################

android_top_dir=android_source_code_$current_data
git_server_addr=192.168.2.5
on_git_server_android_source_code_name=all_sub_dir_git_init_2014_06_07

####### funtion1 ########
usage_color () {
    echo -en "\033[32m"
    echo "  $1  "
    echo -en "\033[0m"
}

####### funtion2 ########
usage_help () {
    echo -en "\033[31m
wb_repo.sh [options]
    options:
        -- status
        -- checkout
        -- branch
        -- pull
        -- push
        -- clean
	-- manifest

"
    echo -en "\033[0m"
}

####### funtion3 ########
git_status (){
    echo repositories : $globle_loop
    if [ $# -eq 1 ]; then
        cd $1 >> /dev/null
        pwd
        git status 
        cd - >> /dev/null
    else
    
        pwd
        git status

    fi
    ((globle_loop++))
    echo
}

####### funtion4 ########
git_branch (){
    echo repositories : $globle_loop
    if [ $# -eq 1 ]; then
        cd $1 >> /dev/null
        pwd
        echo git branch $para2
        git branch $para2
        cd - >> /dev/null
    else
    
        pwd
        echo git branch $para2
        git branch $para2

    fi
    ((globle_loop++))
    echo
}

####### funtion5 ########
git_checkout (){
    echo repositories : $globle_loop
    if [ $# -eq 1 ]; then
        if [ -d $current_path/$1 ]; then
            cd $1 >> /dev/null
            pwd
            git checkout .
            cd - >> /dev/null
        else
            ## git checkout other_branch
            pwd
            git checkout $1
        fi

    elif [ $# -eq 2 ];then
        #git checkout other_branch
        if [ -d $current_path/$1 ]; then
            cd $1 >> /dev/null
            pwd
            git checkout $2
            cd - >> /dev/null
        #git checkout -t other_branch
        elif [ "-t" = $1 ]; then
            pwd
            git checkout $1 $2

        fi

    elif [ $# -eq 0 ];then
    
        pwd
        git checkout .
    
    elif [ $# -eq 3 ];then

        cd $1 >> /dev/null
        pwd

        if [ $2 = "-b" ];then
            git checkout $2 $3
        elif [ $2 = "-t" ];then
            git checkout $2 $3
        fi

        cd - >> /dev/null

    elif [ $# -eq 2 ];then

        pwd
        if [ $1 = "-b" ];then
            git checkout $1 $2
        elif [ $1 = "-t" ];then
            git checkout $1 $2
        fi

    fi

    ((globle_loop++))
    echo
}

####### funtion6 ########
git_pull (){
    echo repositories : $globle_loop
    if [ $# -eq 1 ]; then
        cd $1 >> /dev/null
        pwd
        git branch $para2
        git pull 
        cd - >> /dev/null
    else
    
        pwd
        git branch $para2
        git pull

    fi
    ((globle_loop++))
    echo
}

####### funtion7 ########
git_push (){
    echo repositories : $globle_loop
    if [ $# -eq 1 ]; then
        cd $1 >> /dev/null
        pwd
        git branch 
        git push 
        cd - >> /dev/null
    elif [ $# -eq 0 ]; then
    
        pwd
        git branch 
        git push

    elif [ $# -eq 3 ]; then
        cd $1 >> /dev/null
        pwd
        git branch
        if [ $2 = origin ];then
            git push $2 $3
        fi
        cd - >> /dev/null
    elif [ $# -eq 2 ]; then
        pwd
        git branch
        if [ $1 = origin ];then
            git push $1 $2
        fi
    fi

    ((globle_loop++))
    echo
}


####### funtion8 ########
git_clean (){
    echo repositories : $globle_loop
    if [ $# -eq 2 ]; then
        cd $1 >> /dev/null
        pwd
        echo git clean $2
        git clean $2
        cd - >> /dev/null
    elif [ $# -eq 1 ]; then
    
        pwd
        echo git clean $1
        git clean $1

    fi

    ((globle_loop++))
    echo
}

####### funtion9 ########
manifest (){
	for tmp in `ls`
	do
		if [ -f $current_path/$tmp/$dir_has_git ];then
			
			cd $current_path/$tmp > /dev/null
			
			tmp_current_branch=`git branch -a | sed -n '/'*'/p'`
			current_git_branch=${tmp_current_branch##*\ }		
			first_commit_value=`git log . | head -n 1`
			echo "$tmp:$current_git_branch:${first_commit_value#* }" >> $manifest_file	

			cd - > /dev/null

		fi



	done

	if [ -f $current_path/$dir_has_git ];then
		tmp_current_branch=`git branch -a | sed -n '/'*'/p'`
		current_git_branch=${tmp_current_branch##*\ }		
		first_commit_value=`git log . | head -n 1`
		echo "android_top_dir:$current_git_branch:${first_commit_value#* }" >> $manifest_file	
			
	fi	
}

############# main func ##############
if [ $# -ne 0 ]; then

    if [ -d frameworks ]; then

        ###### git status ######
        if [ x$para1 = x"status" ];then

            for tmp in `ls` 
            do
                if [ -d $tmp -a $tmp != .git -a $tmp != out -a $tmp != pub ]; then
                    git_status $tmp
                fi        

            done

            git_status           

        ###### git branch ######
        elif [ x$para1 = x"branch" ]; then

            for tmp in `ls` 
            do
                if [ -d $tmp -a $tmp != .git -a $tmp != out -a $tmp != pub ]; then
                    git_branch $tmp
                fi        

            done

            git_branch

        ###### git checkout ######
        elif [ x$para1 = x"checkout" ]; then
           
            ## git checkout . ##
            if [ $# -eq 1 ];then

                for tmp in `ls` 
                do
                    if [ -d $tmp -a $tmp != .git -a $tmp != out -a $tmp != pub ]; then
                        git_checkout $tmp
                    fi        

                done

                git_checkout
            
            ## git checkout other_branch ##
            elif [ $# -eq 2 ];then

                for tmp in `ls` 
                do
                    if [ -d $tmp -a $tmp != .git -a $tmp != out -a $tmp != pub ]; then
                        git_checkout $tmp $para2 
                    fi        

                done

                git_checkout $para2 

            ## git checkout -b/-t new_branch ##
            elif [ $# -eq 3 ];then

                for tmp in `ls` 
                do
                    if [ -d $tmp -a $tmp != .git -a $tmp != out -a $tmp != pub ]; then
                        git_checkout $tmp $para2 $para3
                    fi        

                done

                git_checkout $para2 $para3
            fi

        ###### git pull ######
        elif [ x$para1 = x"pull" ]; then

            for tmp in `ls` 
            do
                if [ -d $tmp -a $tmp != .git -a $tmp != out -a $tmp != pub ]; then
                    git_pull $tmp
                fi        

            done

            git_pull

        ###### git push ######
        elif [ x$para1 = x"push" ]; then

            if [ $# -eq 1 ];then

                for tmp in `ls` 
                do
                    if [ -d $tmp -a $tmp != .git -a $tmp != out -a $tmp != pub ]; then
                        git_push $tmp
                    fi        

                done

                git_push
            elif [ $# -eq 3 ];then
                for tmp in `ls` 
                do
                    if [ -d $tmp -a $tmp != .git -a $tmp != out -a $tmp != pub ]; then
                        git_push $tmp $para2 $para3
                    fi        

                done

                git_push $para2 $para3

            fi
        ###### git clean ######
        elif [ x$para1 = x"clean" ]; then

            if [ $# -eq 2 ];then

                for tmp in `ls` 
                do
                    if [ -d $tmp -a $tmp != .git -a $tmp != out -a $tmp != pub ]; then
                        git_clean $tmp $para2
                    fi        

                done

                git_clean $para2

            else
                echo "Please input [git clean -df] !!"
                exit 2

            fi

        ###### manifest ######
        elif [ x$para1 = x"manifest" ]; then

		manifest

        else
            echo
            usage_color "No [$para1] cmd!!"
            echo
            echo "-----------------------------------------------"
            usage_help
            
        fi

    else

        usage_color "Please in android 4.4 top dir ,Using this cmd!!"
        exit 1

    fi

else

    usage_help

fi









###############################
