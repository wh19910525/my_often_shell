
patch_dir=fbak-patch

mkdir -p $patch_dir

git format-patch $1 -o $patch_dir

