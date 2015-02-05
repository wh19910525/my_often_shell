#! /bin/bash
#############################
#author:wanghai
#############################


loop=1
current_path=`pwd`
current_data=`date "+%Y_%m_%d_%H_%M_%S"`
manifest_file=$current_path/.repo/manifest.xml
exist_git_repositories_top_dir=$current_path/.repo/projects
on_git_server_project_path=
on_git_server_project_name=
current_branch=master_2015_02_02
origin_frank=origin_frank
project_repo_list_name=baytrain_5_0_repo_res_list


create_all_child_project(){

cat $manifest_file | while read ev_line
do

    if [[ "$ev_line" =~ "<project" ]];then
        echo $loop : $ev_line
        for tmp_name in $ev_line
        do  
#            echo "  $tmp_name"
            on_git_server_project_name=${tmp_name:0:5}
            on_git_server_project_path=${tmp_name:5}

            if [ $on_git_server_project_name = "name=" ]
            then
                #echo "git_project_path=$on_git_server_project_path"
                tmp1_project_name=${on_git_server_project_path%\"*}
                #echo "tmp1_project_name=$tmp1_project_name"
                tmp2_project_name=${tmp1_project_name:1}
                #echo "tmp2_project_name=$tmp2_project_name"
                tmp3_project_name=${tmp2_project_name%/*}
                #echo "tmp3_project_name=$tmp3_project_name"
                tmp4_project_name=${tmp2_project_name##*/}
                #echo "tmp4_project_name=$tmp4_project_name"

                if [ $loop -eq 1 ]; then 
                    echo "$tmp2_project_name" > $project_repo_list_name
                else
                    echo "$tmp2_project_name" >> $project_repo_list_name
                fi
                ((loop++))

            fi

        done
    fi


Stept=0 
if [ $Stept -eq 1 ]; then 
    if [ $loop -eq 3 ]; then 
        exit
    fi
fi
 
done

}

create_manifest_res(){
    echo "baytrain_5_0_manifest" >> $project_repo_list_name
}

######### main #########
create_all_child_project
create_manifest_res


