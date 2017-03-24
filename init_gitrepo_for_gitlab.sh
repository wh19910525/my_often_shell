#! /bin/bash
#############################
#author:wanghai
#############################

para0=$0
para1=$1
para2=$2
para3=$3
para4=$4

#########################
Debug_flag="false"
init_aosp_repo_config_file="/disk2/works/my_often_shell/config_git_init_aosp_for_gitlab"
#########################
filter_files="--exclude=.git* --exclude=.repo --exclude=.gitignore"
has_filter_files_zip_name="has_filter_aosp"
current_date=`date "+%Y-%m-%d-%H-%M-%S"`
current_path=`pwd`
tmp_dir="${current_path}/has_filter_tmp_dir_$current_date"
tmp_manifest=manifest_tmp
get_repo_bare_for_aosp=$tmp_dir/get_all_repo_bare_for_aosp
#########################


####### funtion1 ########
usage_color () {
    echo -en "\033[32m"
    echo "$1"
    echo -en "\033[0m"
}

####### funtion2 ########
Usage(){
    usage_color "Please use [`basename $para0` aosp_dir]"
}

####### funtion3 ########
debug_print (){
    if [ x$Debug_flag != xfalse ]; then
        echo "$1"
    fi
}

####### funtion4 ########
init_git_repo() {
    debug_print "git init .;git add .;git commit -m\"Init $1\""
    git init .
    git add .
    git commit -m"Init $1 ." >> /dev/null 2>&1

    echo "Init $1 success."
}

####### funtion5 ########
create_tmp_manifest(){
#  <project path="tools" name="tools" />
#  <project path="vendor/qcom" name="vendor_qcom" />
    name_string=${1}
    name_string=${name_string//\//\_}
    echo "<project path=\"$1\" name=\"$name_string\" />" >> $tmp_dir/$tmp_manifest
}

####### funtion6 ########
get_repo_bare_for_gitRepo(){
    mkdir -p $get_repo_bare_for_aosp

    debug_print "git clone --bare $1 $get_repo_bare_for_aosp/${2}.git"
    git clone --bare $1 $get_repo_bare_for_aosp/${2}.git
}

####### funtion7 ########
top_file_count=0
Analysis_config_for_clone_repo (){

    ################# para ##################
    init_dir_level=1
    ###################################

    # go to aosp/
    cd $tmp_dir/$para1
    for top_file_tmp in `ls`
    do
        ((top_file_count++))
        echo
        ######### git init top level #########
        while read ev_line
        do
            if [[ "$ev_line" =~ "=" ]];then # every line is or not contain '=';

                if [ $top_file_tmp = ${ev_line%=*} ];then #get the "=" left part;
                    debug_print "--------Init this part,---------level=${ev_line#*=}"
                    init_dir_level=${ev_line#*=} #get the "=" right part, real level;
                    break
                else
                    init_dir_level=1
                fi
            else #get def part
                init_dir_level=1
            fi
        done < $init_aosp_repo_config_file

        echo "Count=$top_file_count, Top_file=[$top_file_tmp], init dir_level=[$init_dir_level]"

        if [ $init_dir_level == 2 ];then #init 2 level
            # go to aosp/first_top_dir
            cd $tmp_dir/$para1/$top_file_tmp/

            for second_level_tmp_file in `ls`
            do
                #go to aosp/first_top_dir/second_top_dir/
                cd $tmp_dir/$para1/$top_file_tmp/$second_level_tmp_file
                need_init_dir="$tmp_dir/$para1/$top_file_tmp/$second_level_tmp_file"

                debug_print "    --------- second_level file=$second_level_tmp_file ---------"
                debug_print "`pwd`"

                #1.
                init_git_repo $second_level_tmp_file

                #2.
                create_tmp_manifest "$top_file_tmp/$second_level_tmp_file"

                #3.
                get_repo_bare_for_gitRepo $need_init_dir ${top_file_tmp}_${second_level_tmp_file}
            done

        elif [ $init_dir_level == 1 ];then #init 1 level
            #go to aosp/first_top_dir/
            cd $tmp_dir/$para1/$top_file_tmp/
            need_init_dir="$tmp_dir/$para1/$top_file_tmp/"

            debug_print "`pwd`"

            #1.
            init_git_repo $top_file_tmp

            #2.
            create_tmp_manifest "$top_file_tmp"

            #3.
            get_repo_bare_for_gitRepo $need_init_dir ${top_file_tmp}

        fi

    done
}


############### main ###############
if [ $# -ne 1 ];then
    Usage
elif [ -e $para1 ];then

    #del the "/" for dir ...
    para1=${para1//\//}
    usage_color "[${para1}] exists ..."

    usage_color "1.Filter some files, such as .git .gitignore .repo ..."
    tar -czf ${has_filter_files_zip_name}.tar.gz ./${para1} $filter_files

    usage_color "2.Unzip previous step zip file ..."
    mkdir -p $tmp_dir
    tar -xf ${has_filter_files_zip_name}.tar.gz -C $tmp_dir

    usage_color "3.Git init all top dir, get clone all dir ..."
    Analysis_config_for_clone_repo
    
    mv $tmp_dir/$para1 $tmp_dir/aosp_has_init

else
    usage_color "[$para1] dir does not exists ..."
    Usage
fi

############### main end ###############

