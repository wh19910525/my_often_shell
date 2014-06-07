
para1=$1
loop=1
current_path=`pwd`
current_source_code_top_dir=$current_path/$para1
current_data=`date "+%Y_%m_%d_%H_%M_%S"`


#############################

android_top_dir=android_source_code_$current_data
git_server_addr=192.168.2.5
on_git_server_android_source_code_name=all_sub_dir_git_init_2014_06_07

####### funtion1 ########
usage () {
    echo -en "\033[32m"
    echo "  $1  "
    echo -en "\033[0m"
}


####### funtion2 ########
git_status (){
    pwd
    git status 
    echo
}

if [ -d frameworks ]; then

    ###### git status ######
    if [ x$para1 = x"status" ];then

        for tmp in `ls` 
        do
            if [ -d $tmp -a $tmp != .git ]; then
                echo repositories : $loop
                cd $tmp >> /dev/null
                git_status 
                cd - >> /dev/null
                ((loop++))
            fi        

        done

        echo repositories : $loop
        git_status           
    fi

else

    usage "Please in android 4.4 top dir ,Using this cmd!!"
    exit 1

fi










###############################

Step1=0
if [ $Step1 -eq 1 ]; then
if [ $# -eq 1 ]; then

mkdir $android_top_dir -p
cd $android_top_dir


    echo -en "\033[32m"

    date "+%Y-%m-%d %H:%M:%S"
    echo "Start get android source code from $git_server_addr:$on_git_server_android_source_code_name "

    echo -en "\033[0m"


for tmp_git_name in `cat $current_source_code_top_dir`
do

    #echo git clone  git@$git_server_addr:$on_git_server_android_source_code_name/$tmp_git_name
    git clone  git@$git_server_addr:$on_git_server_android_source_code_name/$tmp_git_name
    echo "$loop : Clone all_sub_dir_git_init_2014_06_07/$tmp_git_name successed!!"

    echo 
    echo 

    ((loop++))
done

if [ -e android_top ]; then
    pwd
    mv android_top/* .
    rm android_top -rf
fi

    echo -en "\033[35m"

    echo "Finshed : get android source code from $git_server_addr:$on_git_server_android_source_code_name !!"
    date "+%Y-%m-%d %H:%M:%S"

    echo -en "\033[0m"
fi
fi

################################


