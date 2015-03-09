
echo "Unzip system.img to modify it"

./x86_bin/simg2img system.img system.img.ext4

mkdir modify_system_img
sudo mount -t ext4 -o loop system.img.ext4 modify_system_img/
sudo chmod 777 -R modify_system_img/

echo "Compressed files modify_system_img to new_system.img"


