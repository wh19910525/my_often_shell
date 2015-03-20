
para1=$1
loop=1
current_path=`pwd`
current_source_code_top_dir=$current_path/$para1
current_data=`date "+%Y_%m_%d_%H_%M_%S"`
current_source_code_all_top_dir_list=$current_path/top_dir_list$current_data





echo "
###################################
##### 1.Create all sub dir git ####
###################################"

echo Aosp_project_name=$#

Step1=1
if [ $Step1 -eq 1 ]; then
if [ $# -eq 1 ]; then

    for tmp in `ls $current_source_code_top_dir`
    do
        if [ -d $current_source_code_top_dir/$tmp ]; then

            echo Starting init [$loop : $tmp] , waiting ....

            cd $current_source_code_top_dir/$tmp
            #ls 
            echo git init .
            git init .

            echo git add .
            git add .

            #echo git commit -m"first init $tmp "
            git commit -m" first init $tmp " >> /dev/null

            echo "init $tmp finish !!"
            echo 

#############


            ((loop++))
            
            #save current_source_code_all_top_dir
            echo $tmp >> $current_source_code_all_top_dir_list
        fi

    done

    echo mv $current_source_code_all_top_dir_list $current_source_code_top_dir/.gitignore
    mv $current_source_code_all_top_dir_list $current_source_code_top_dir/.gitignore

    echo Starting init [$loop : $current_source_code_top_dir] , waiting ....
    cd $current_source_code_top_dir

    echo git init .
    git init .

    echo git add .
    git add .

    echo git commit -m" init android top dir !! "
    git commit -m"init android top dir !! " >> /dev/null

    echo finish all init for android source code !! 
    echo

echo "
###################################
##### end 1.Create all sub dir git ######
###################################"

    echo

fi
fi

##### end 1.Create all sub dir git ######

echo "
###################################
##### 2.Get all sub dir git ######
###################################"

if [ $Step1 -ne 1 ]; then
para1=$1
current_path=`pwd`
current_source_code_top_dir=$current_path/$para1
current_data=`date "+%Y-%m-%d-%H-%M-%S"`
current_source_code_all_top_dir_list=$current_path/top_dir_list$current_data
fi

loop=1
save_top_all_sub_dir_git=$current_path/all_sub_dir_git_init_$current_data


###################################
Step2=1
if [ $Step2 -eq 1 ]; then
if [ $# -eq 1 ]; then

echo mkdir $save_top_all_sub_dir_git -p
mkdir $save_top_all_sub_dir_git -p

    for tmp in `ls $current_source_code_top_dir`
    do
        if [ -d $current_source_code_top_dir/$tmp ]; then

            echo $loop : $tmp

            cd $current_source_code_top_dir/
            ls 
            echo git clone --bare $tmp $save_top_all_sub_dir_git/$tmp.git
            git clone --bare $tmp $save_top_all_sub_dir_git/$tmp.git

            echo 

#############

            ((loop++))
            
        fi

    done

    echo echo $loop : $current_source_code_top_dir

    echo git clone --bare $current_source_code_top_dir $save_top_all_sub_dir_git/android_top.git
    git clone --bare $current_source_code_top_dir $save_top_all_sub_dir_git/android_top.git

    echo
    echo finish all init for android source code !! 


fi

fi



