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
current_path=`pwd`
current_data=`date "+%Y_%m_%d_%H_%M_%S"`
if [ $# -eq 1 ]; then 
    from_manifest_get_ok_git_on_git_server_dir=$current_path/$Para1
else
    from_manifest_get_ok_git_on_git_server_dir=$current_path/intel_sofia_3g_5_0
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


create_all_child_project(){
Step1=1 
if [ $Step1 -eq 1 ]; then 
    mkdir -p $from_manifest_get_ok_git_on_git_server_dir
fi

cat $manifest_file | while read ev_line
do

    if [[ "$ev_line" =~ "<project" ]];then
        echo $loop : $ev_line
        ((loop++))
   
        for tmp_name in $ev_line
        do  
#            echo "  $tmp_name"
            on_git_server_project_name=${tmp_name:0:5}
            on_git_server_project_path=${tmp_name:5}

            if [ $on_git_server_project_name = "name=" ]
            then
                #echo "on_server_project_path=$on_git_server_project_path"
                tmp1_project_name=${on_git_server_project_path%/*}
                #echo "tmp1_project_name=$tmp1_project_name"
                tmp2_project_name=${tmp1_project_name:1}
                #echo "tmp2_project_name=$tmp2_project_name"
                tmp3_project_name=${on_git_server_project_path##*/}
                #echo "tmp3_project_name=$tmp3_project_name"
                tmp4_project_name=${tmp3_project_name//\"/}
                #echo "tmp4_project_name=$tmp4_project_name"
                mkdir -p $from_manifest_get_ok_git_on_git_server_dir/$tmp2_project_name
                flag1_save_on_git_server_path=$tmp2_project_name
                flag2_save_on_git_server_name=$tmp4_project_name

            fi

            if [ $on_git_server_project_name = "path=" ]
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
                #echo "flag1_save_on_git_server_path=$flag1_save_on_git_server_path"
                cd $current_path/$tmp2_project_name
                git checkout -b $current_branch
                git clone --bare $current_path/$tmp2_project_name $from_manifest_get_ok_git_on_git_server_dir/$flag1_save_on_git_server_path/$flag2_save_on_git_server_name.git

            fi

        done
 
        echo 
    fi

 
done
}

#    if [ $loop -eq 3 ]; then 
#        exit
#    fi


create_manifest_res(){
    replace_default_lable="  <default revision=\"$current_branch\" remote=\"$origin_frank\" />"
    replace_remote_lable="  <remote name=\"$origin_frank\" fetch=\"$manifest_fetch\" />"
    mkdir -p $from_manifest_get_ok_git_on_git_server_dir/$manifest_repositories_name
    cp $manifest_file $manifest_def_xml
    sed -i '/<default/c\'"${replace_default_lable}"'' $manifest_def_xml
    sed -i '/<remote/c\'"${replace_remote_lable}"'' $manifest_def_xml
    cd $from_manifest_get_ok_git_on_git_server_dir/$manifest_repositories_name
    git init . 
    git add .
    git commit -m"first init manifest"
    #git checkout -b $current_branch
    #git branch -d master
    
    git clone --bare $from_manifest_get_ok_git_on_git_server_dir/$manifest_repositories_name $from_manifest_get_ok_git_on_git_server_dir/$manifest_repositories_name.git
    rm $from_manifest_get_ok_git_on_git_server_dir/$manifest_repositories_name -rf

}

######### main #########
create_all_child_project
create_manifest_res


