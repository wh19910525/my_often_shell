#! /bin/bash
#############################
#author:wanghai
#############################

Para0=$0
Para1=$1

if [ $# -eq 0 ]; then 
    echo "Usage: $Para0 version_name"
    exit 2
fi

loop=1
all_project_count=1
current_path=`pwd`
current_data=`date "+%Y_%m_%d_%H_%M_%S"`
if [ $# -eq 1 ]; then 
    from_manifest_get_ok_git_on_git_server_dir=$current_path/$Para1
else
    from_manifest_get_ok_git_on_git_server_dir=$current_path/old_git_log
fi
manifest_file=$current_path/.repo/manifest.xml
exist_git_repositories_top_dir=$current_path/.repo/projects
on_git_server_project_path=
on_git_server_project_name=
current_branch=master_2015_02_02
if [ $# -eq 1 ]; then 
    manifest_repositories_name=${Para1}_manifest
else
    manifest_repositories_name=sofia_3g_manifest
fi
manifest_def_xml=$from_manifest_get_ok_git_on_git_server_dir/$manifest_repositories_name/default.xml
origin_frank=origin_frank
if [ $# -eq 1 ]; then 
    manifest_fetch="git@192.168.2.5:$Para1"
else
    manifest_fetch="git@192.168.2.5:intel_sofia_3g_5_0"
fi

##################################3
commit_all_flag=0
commit_found_modify_flag=0
max_commit=100
author_name=archermind
modify_res_path=save_modify_res_path.txt

##################################3

create_all_child_project(){ #zgj_test

while read ev_line
do

    if [[ "$ev_line" =~ "<project " ]];then
   
        echo "$all_project_count : $ev_line"
        ((all_project_count++))

        for tmp_name in $ev_line
        do  
#            echo " $tmp_name"
            on_git_server_project_name=${tmp_name:0:5}
            on_git_server_project_path=${tmp_name:5}

            if [ $on_git_server_project_name = "path=" ]
            then
#                echo "first commit_all_flag=$commit_all_flag"
                #echo "git_project_path=$on_git_server_project_path"
                tmp1_project_name=${on_git_server_project_path%\"*}
                #echo "tmp1_project_name=$tmp1_project_name"
                tmp2_project_name=${tmp1_project_name:1}
                #echo "tmp2_project_name=$tmp2_project_name"
                tmp3_project_name=${tmp2_project_name%/*}
                #echo "tmp3_project_name=$tmp3_project_name"
                tmp4_project_name=${tmp2_project_name##*/}
                #echo "tmp4_project_name=$tmp4_project_name"
                #echo "flag1_save_on_git_server_path=$flag1_save_on_git_server_path"

#                echo mkdir -p $from_manifest_get_ok_git_on_git_server_dir/$tmp2_project_name
                mkdir -p $from_manifest_get_ok_git_on_git_server_dir/$tmp2_project_name

#                echo cd $current_path/$tmp2_project_name
                cd $current_path/$tmp2_project_name

                #echo "git log > $from_manifest_get_ok_git_on_git_server_dir/$tmp2_project_name/ok.log"
                save_log_path=$from_manifest_get_ok_git_on_git_server_dir/$tmp2_project_name/ok.log
                git log > $save_log_path


                ##################
                while read log_ev_line 
                do
                    ######## 计算 有多少个 commit ########
                    if [[ "$log_ev_line" =~ "commit " ]];then
                        ((commit_all_flag++))
                    fi

                    ######## 是否 有 我们的修改 ########
                    if [[ "$log_ev_line" =~ "$author_name" ]];then

                        commit_found_modify_flag=1
                        echo
                        echo $loop : $ev_line
                        ((loop++))

                        echo -en "\033[32m"
                        echo "[$tmp2_project_name] has modify by $author_name"
                        echo [$tmp2_project_name] >> $from_manifest_get_ok_git_on_git_server_dir/$modify_res_path
                        echo -en "\033[0m"

                        break
                    fi

                    ######## 前100个 commit 若是 没有我们的 commit, 那就 跳过 ########
                    if [ $commit_all_flag -eq $max_commit ];then
                        break
                    fi

                done < $save_log_path

                ####### not modify by us, so del this log #######
                if [ $commit_found_modify_flag -eq 0 ];then
                #    echo "d commit_all_flag=$commit_all_flag"
                #    echo rm $save_log_path
                    rm $save_log_path
                fi

                commit_found_modify_flag=0
                commit_all_flag=0

            fi

        done
 
    fi
 
done < $manifest_file

echo

}

######### main #########
create_all_child_project

