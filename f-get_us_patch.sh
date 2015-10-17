
patch_dir=fbak-patch


if [ $# -ne 1 ];then
    echo
    echo "Please input commit id "
    echo
    exit
fi

mkdir -p $patch_dir

git format-patch $1 -o $patch_dir
first_patch_name=`git format-patch -n1 $1`
#echo "first_patch_name=${first_patch_name#*-}"
echo mv $first_patch_name $patch_dir/0000-${first_patch_name#*-}
mv $first_patch_name $patch_dir/0000-${first_patch_name#*-}


