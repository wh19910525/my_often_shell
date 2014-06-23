#!/bin/bash -x
#
# To call this script, make sure make_ext4fs is somewhere in PATH

function usage() {
cat<<EOT
Usage:
mkuserimg.sh [-s] SRC_DIR OUTPUT_FILE EXT_VARIANT MOUNT_POINT SIZE [FILE_CONTEXTS]
EOT
}

echo "in mkuserimg.sh PATH=$PATH"

ENABLE_SPARSE_IMAGE=
if [ "$1" = "-s" ]; then
  ENABLE_SPARSE_IMAGE="-s"
  shift
fi

if [ $# -ne 4 -a $# -ne 5 -a $# -ne 6 ]; then
  usage
  exit 1
fi

SRC_DIR=$1
if [ ! -d $SRC_DIR ]; then
  echo "Can not find directory $SRC_DIR!"
  exit 2
fi

OUTPUT_FILE=$2
EXT_VARIANT=$3
MOUNT_POINT=$4
SIZE=$5
FC=$6

case $EXT_VARIANT in
  ext4) ;;
  *) echo "Only ext4 is supported!"; exit 3 ;;
esac

if [ -z $MOUNT_POINT ]; then
  echo "Mount point is required"
  exit 2
fi

if [ -z $SIZE ]; then
    SIZE=128M
fi

if [ -n "$FC" ]; then
    FCOPT="-S $FC"
fi

absolute_path_make_ext4fs="/usr/local/wh/tools/mybin"
echo
echo
echo ============ start ===================
MAKE_EXT4FS_CMD="$absolute_path_make_ext4fs/make_ext4fs $ENABLE_SPARSE_IMAGE $FCOPT -l $SIZE -a $MOUNT_POINT $OUTPUT_FILE $SRC_DIR"
echo "zgj=$MAKE_EXT4FS_CMD"
echo ============ end ===================
echo
echo
MAKE_EXT4FS_CMD="$absolute_path_make_ext4fs/make_ext4fs $ENABLE_SPARSE_IMAGE $FCOPT -l $SIZE -a $MOUNT_POINT $OUTPUT_FILE $SRC_DIR"

$MAKE_EXT4FS_CMD
if [ $? -ne 0 ]; then
  exit 4
fi
