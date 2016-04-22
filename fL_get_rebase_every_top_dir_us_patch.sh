#! /bin/bash
#############################
#author:wanghai
#############################


Para0=$0
Para1=$1
Para2=$2


has_git_repostory=".git"
loop=1
current_path=`pwd`
current_data=`date "+%Y_%m_%d_%H_%M_%S"`

filter_dir_flag=0

################ need modify part start #################
modify_patch_author_name=archermind
save_modify_aosp_all_patch_dir=save_modify_aosp_all_patch_dir
save_modify_aosp_our_patch_dir=save_modify_aosp_our_patch_dir
save_modify_aosp_other_patch_dir=save_modify_aosp_other_patch_dir

#不处理的 仓库
filter_dir_list="wb_project zaddpart"
################ need modify part end #################

if [ $# -eq 1 ]; then 
    from_every_top_dir_get_all_modify_patch=$current_path/$Para1/$save_modify_aosp_all_patch_dir
    from_every_top_dir_get_us_modify_patch=$current_path/$Para1/$save_modify_aosp_our_patch_dir
    from_every_top_dir_get_other_modify_patch=$current_path/$Para1/$save_modify_aosp_other_patch_dir
else
    from_every_top_dir_get_all_modify_patch=$current_path/$save_modify_aosp_all_patch_dir
    from_every_top_dir_get_us_modify_patch=$current_path/$save_modify_aosp_our_patch_dir
    from_every_top_dir_get_other_modify_patch=$current_path/$save_modify_aosp_other_patch_dir
fi




################ func1 ##################2016-04-21
get_all_modify_patch(){

    #Deal with every top-level directory
    cd $current_path/$Para1
    for every_file in `ls`
    do
        cd $current_path/$Para1
        
        if [ -d $every_file/$has_git_repostory ];then

            for need_filter_dir in `echo "$filter_dir_list"`
            do
                filter_dir_flag=0
                #跳过 不需要处理的目录
                if [ $every_file == $need_filter_dir ];then
                    echo "skip [$every_file]"
                    filter_dir_flag=1
                    break
                fi

            done

            if [ $filter_dir_flag -eq 1 ];then
                continue
            fi

            echo "dir $loop : $every_file"
            ((loop++))

            #create save patch dir
            save_path_path=$from_every_top_dir_get_all_modify_patch/$every_file
            mkdir -p $save_path_path

            cd $current_path/$Para1/$every_file
            save_log_path=$save_path_path/current_all_modify_log
            git log | tac > $save_log_path

            ##################
            while read log_ev_line 
            do
                ######## 获取 第一个commit ########
                if [[ "$log_ev_line" =~ "commit " ]];then
                    first_commit=${log_ev_line#*\ } 
                    #echo "git format-patch $first_commit -o $save_path_path"
                    git format-patch $first_commit -o $save_path_path  >> /dev/null 2>&1
                    break
                fi

            done < $save_log_path

        fi

    done
}

################ func1 ##################2016-04-21
get_us_modify_patch(){

    cp $from_every_top_dir_get_all_modify_patch $from_every_top_dir_get_us_modify_patch -rf

    mkdir $from_every_top_dir_get_other_modify_patch -p

    cd $from_every_top_dir_get_us_modify_patch
    for every_file in `find | grep .patch` 
    do
        #echo "patch : $every_file" 
        only_file=`basename $every_file`
        #echo "patch : $only_file" 
        if [[ "$only_file" =~ "$modify_patch_author_name" ]];then
            echo ""
        else
            #echo "cp $every_file $from_every_top_dir_get_other_modify_patch --parents -rf"
            cp $every_file $from_every_top_dir_get_other_modify_patch --parents -rf
            rm $every_file
        fi

    done


}

######### main #########
get_all_modify_patch

get_us_modify_patch



