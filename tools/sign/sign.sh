#!/bin/bash

#./isu -i droidboot.unsigned -o signed_droidboot.img -l key/key.pem -t 4
#./xfstk-stitcher -c xfstk_droidboot_config.txt -k xfstk_fastboot.xml
#./isu -i boot.unsigned -o signed_boot.bin -l key/key.pem -t 4
#./xfstk-stitcher -c xfstk_boot_config.txt -k xfstk_boot.xml
#./isu -i recovery.unsigned -o signed_recovery.img -l key/key.pem -t 4
#./xfstk-stitcher -c xfstk_recovery_config.txt -k xfstk_recovery.xml
#./isu -i droidboot.unsigned -o signed_droidboot.img.POS.bin -l key/key.pem -t 4
#./xfstk-stitcher -c xfstk_droidbootpos_config.txt -k xfstk_fastbootpos.xml
#./isu -i logo.bmp -o signed_logo.img -l key/key.pem -t 4
#./xfstk-stitcher -c xfstk_logo_config.txt -k xfstk_splash.xml

##############################

sign_fils_path="/usr/local/wh/tools/sign"

$sign_fils_path/isu -i $sign_fils_path/logo.bmp -o $sign_fils_path/signed_logo.img -l $sign_fils_path/key/key.pem -t 4
$sign_fils_path/xfstk-stitcher -c $sign_fils_path/xfstk_logo_config.txt -k $sign_fils_path/xfstk_splash.xml

