
#include <stdio.h>
#include <string.h>
#include <malloc.h>

#define MAXBUFSIZE 1024


////////// func /////////////
void show_tools_info(char * shell_cmd);
int excu_shell_para_get_return_int(char * shell_cmd, char * para);
int excu_no_para_shell_get_return_int(char * shell_cmd);
int decompression_intel_upgrade_fw(char * d_file);
int decompression_system_img_gz_for_42(void);
int mount_system_img_for_ext4(void);
int chmod_modify_system_dir_777(void);
void show_version(void);

int compress_2_intel_fw(char * fw_name);

////////// Globle varible /////////////
char * Customer_tools_FW = "Customer_tools_FW";
char * intel_tools_set_file = "flash.xml";
char * Modify_system_img_dir = "Modify_system_img_dir";
char * System_img_mount_dir_name="modify_system";

char * shell_cmd1 = "./mybin/check_root.sh ";
char * shell_cmd2 = "./mybin/program_fuc_list.sh ";
char * shell_cmd3 = "./mybin/check_fw_zip.sh ";
char * shell_cmd4 = "./mybin/de_intel_zip.sh ";
char * shell_cmd5 = "./mybin/check_fw_is_weibu.sh ";
char * shell_cmd6 = "./mybin/check_prop_for_encrypt.sh ";
char * shell_cmd7 = "./mybin/show_finish_intel_fw.sh ";
char * shell_cmd8 = "./mybin/show_version.sh ";

char current_cmd_path[MAXBUFSIZE];
char tmp_cmd[MAXBUFSIZE];

char * intel_4_2_system_name="system.img.gz";
char * before_modify_intel_4_2_system_img_gz_name="before_system.img.gz";
char * before_modify_intel_4_2_system_img_name="before_system.img";

///////////////////////

int main(int argc, char **argv){

	///////////////////////

	int error = 0;
	char flag = 'd';

	///////////////////////

	//1.验证 是否是 root用户执行;
	error = excu_no_para_shell_get_return_int(shell_cmd1);
	if(error != 0)
	{
//		printf("%d : error: %d\n excu : [%s] failed!!\n\n", __LINE__, error, shell_cmd1);
		goto check_root_error1;
	}

	if(argc > 1){

		if(strncmp(argv[1], "-v", 2) == 0 || strncmp(argv[1], "-V", 2) == 0 || strncmp(argv[1], "--V", 3) || strncmp(argv[1], "--v", 3)){
			show_version();
			return 0;
		}
	}
	//2.验证 参数 有没有输入 固件名称;
	if(argc != 3){
		//2.1 显示 软件功能 和 使用 方法;	
		show_tools_info(shell_cmd2);
		goto check_root_error1;
	}

	if(strncmp(argv[1], "-d", 2) == 0){
		flag = 'd';
	}else if(strncmp(argv[1], "-D", 2) == 0){
		flag = 'D';
	}else if(strncmp(argv[1], "-c", 2) == 0){
		flag = 'c';
	}else if(strncmp(argv[1], "-C", 2) == 0){
		flag = 'C';
	}

	switch(flag){
		case 'D':
		case 'd':
		//	printf("Decompression Old_intel_tools.zip\n\n");	
			//3.解压 intel 升级包
			error = decompression_intel_upgrade_fw(argv[2]);
			if(error != 0)
			{
				goto check_root_error1;
			}


			//4.调用一个脚本，把 所有的 东西放到 顶层目录下，并且做 校验，是否为 weibu 固件; 
			memset(tmp_cmd, '\0', sizeof(tmp_cmd));
			getcwd(tmp_cmd, MAXBUFSIZE);//获取 当前路径，给到 shell;
			//	strcat(tmp_cmd, "/");
			//	strcat(tmp_cmd, intel_tools_set_file);
			//	printf("current path=%s\n", tmp_cmd);
			error = excu_shell_para_get_return_int(shell_cmd5, tmp_cmd);
			if(error != 0)
			{
				goto check_root_error1;
			}

			//5.解压 system.img.gz for 4.2
			error = decompression_system_img_gz_for_42();
			if(error != 0)
			{
				goto check_root_error1;
			}

			//6 挂载system.img;
			error = mount_system_img_for_ext4();
			if(error != 0)
			{
				printf("\n\n Mount failed!! \n\n");
				goto check_root_error1;
			}

			//wanghai
			//7.chmod 777 -R $Intel_android_top/$Tmp_Dir/m_system/ 修改 挂载点的 权限为 777
			error = chmod_modify_system_dir_777();
			if(error != 0)
			{
				goto check_root_error1;
			}

			break;

		case 'C':
		case 'c':
//			printf("Compression New_intel_tools.zip\n\n");	

			//1.检查 之前解压的 system.img 是不是 微步源码 编译出来的, 若是 卸载 system.img; 	
			memset(tmp_cmd, '\0', sizeof(tmp_cmd));
			getcwd(tmp_cmd, MAXBUFSIZE);//获取 当前路径，给到 shell;
			error = excu_shell_para_get_return_int(shell_cmd6, tmp_cmd);
			if(error != 0)
			{
//				printf("This FW is not weibu!!\n\n");	
				goto check_root_error1;
			}

			//2.重新 打包为 intel 升级工具 需要的 zip 包；
			//zip -r New_intel_fw.zip Customer_tools_FW/
			error = compress_2_intel_fw(argv[2]);
			if(error != 0)
			{
				goto check_root_error1;
			}

			//3.提示 打包完成;
			error = excu_shell_para_get_return_int(shell_cmd7, argv[2]);
			if(error != 0)
			{
				goto check_root_error1;
			}


///////////////////////////////

			break;

	}

	return 0;

check_root_error1:

	return 1;
}//end main;

///////////////////

void show_version(void){
	int error = 0;
	error = system(shell_cmd8);
	if(error != 0)
	{
		printf("\nExecute [%s] failed!!\n\n", shell_cmd8);
	}
}


//1. 显示 软件功能 和 使用方法
void show_tools_info(char * shell_cmd){
	int error = 0;
//	printf("%d : cmd = [%s]\n", __LINE__, shell_cmd);
	error = system(shell_cmd);
	if(error != 0)
	{
		printf("\nExecute [%s] failed!!\n\n", shell_cmd);
	}else{
//		printf("\nExecute [%s] successed!!\n\n", shell_cmd1);
	}
}

//7 修改 挂载点 的权限 为 -> 777
int chmod_modify_system_dir_777(void){

	int error = 0;

	memset(tmp_cmd, '\0', sizeof(tmp_cmd));
	strcat(tmp_cmd, "chmod 777 -R ");
	strcat(tmp_cmd, " ");
	strcat(tmp_cmd, Modify_system_img_dir);
	strcat(tmp_cmd, "/");
	strcat(tmp_cmd, System_img_mount_dir_name);
//	printf("%d : cmd = %s\n", __LINE__, tmp_cmd);
	error = excu_no_para_shell_get_return_int(tmp_cmd);
	if(error != 0)
	{
		return -1;
	}

	return error;
}


//6.执行 shell命令，并且 返回 shell的结果，以 字符串形式;
int mount_system_img_for_ext4(void){

	int error = 0;

	memset(tmp_cmd, '\0', sizeof(tmp_cmd));
	strcat(tmp_cmd, Modify_system_img_dir);
	strcat(tmp_cmd, "/");
	strcat(tmp_cmd, System_img_mount_dir_name);
//	printf("%d : cmd = %s\n", __LINE__, tmp_cmd);
	if(access(tmp_cmd, 0) == -1)//access函数是查看文件是不是存在, 不存在 走这里; 
	{  
		//6.1创建挂载 system.img 的目录;
		if (mkdir(tmp_cmd, 0777))
		{  
			printf("creat file  [%s] failed!!!\n", tmp_cmd);  
			return -1;
		}  

	} 

	//6.2 ext4 -o loop  Modify_system_img_dir/before_system.img Modify_system_img_dir/modify_system
	memset(tmp_cmd, '\0', sizeof(tmp_cmd));
	strcat(tmp_cmd, "mount -t ext4 -o loop  ");
	strcat(tmp_cmd, Modify_system_img_dir);
	strcat(tmp_cmd, "/");
	strcat(tmp_cmd, before_modify_intel_4_2_system_img_name);
	strcat(tmp_cmd, " ");
	strcat(tmp_cmd, Modify_system_img_dir);
	strcat(tmp_cmd, "/");
	strcat(tmp_cmd, System_img_mount_dir_name);
//	printf("%d : cmd = %s\n", __LINE__, tmp_cmd);
	error = excu_no_para_shell_get_return_int(tmp_cmd);
	if(error != 0)
	{
		return -1;
	}

	return error;
}

//5.解压 system.img.gz for android 4.2
int decompression_system_img_gz_for_42(void){

	int error = 0;
	//5.1 检查之前是不是 已经有过 解压动作，若有，那么需要 手动 删除之前的 解压文件;
	if(access(Modify_system_img_dir, 0) == -1)//access函数是查看文件是不是存在, 不存在 走这里; 
	{  
		//5.2 如果不存在就用mkdir函数来创建;  
		if (mkdir(Modify_system_img_dir, 0777))
		{  
			printf("creat file  [%s] failed!!!\n", Modify_system_img_dir);  
			return -1;
		}  
	} 
#if 0
	//5.2 拷贝 system.img.gz 为 before_system.img.gz
//cp Customer_tools_FW/system.img.gz Modify_system_img_dir/before_system.img
	memset(tmp_cmd, '\0', sizeof(tmp_cmd));
	strcat(tmp_cmd, "cp ");
	strcat(tmp_cmd, Customer_tools_FW);
	strcat(tmp_cmd, "/");
	strcat(tmp_cmd, intel_4_2_system_name);
	strcat(tmp_cmd, " ");
	strcat(tmp_cmd, Modify_system_img_dir);
	strcat(tmp_cmd, "/");
	strcat(tmp_cmd, before_modify_intel_4_2_system_img_gz_name);
//	printf("%d : cmd = %s\n", __LINE__, tmp_cmd);
	error = excu_no_para_shell_get_return_int(tmp_cmd);
	if(error != 0)
	{
		printf("%d : error: %d\n excu : [%s] failed!!\n\n", __LINE__, error, tmp_cmd);
		return -1;
	}
#endif


	//5.4 解压 4.2 system.img.gz
	memset(tmp_cmd, '\0', sizeof(tmp_cmd));
	strcat(tmp_cmd, "gunzip -c ");
	strcat(tmp_cmd, Customer_tools_FW);
	strcat(tmp_cmd, "/");
	strcat(tmp_cmd, intel_4_2_system_name);
	strcat(tmp_cmd, " > ");
	strcat(tmp_cmd, Modify_system_img_dir);
	strcat(tmp_cmd, "/");
	strcat(tmp_cmd, before_modify_intel_4_2_system_img_name);
//	printf("%d : cmd = %s\n", __LINE__, tmp_cmd);
	error = excu_no_para_shell_get_return_int(tmp_cmd);
	if(error != 0)
	{
		printf("%d : error: %d\n excu : [%s] failed!!\n\n", __LINE__, error, tmp_cmd);
		return 1;
	}
	
	return error;
}

//3.解压 intel 升级固件;
int decompression_intel_upgrade_fw(char * d_file){

	int error = 0;	
	//3.1 检查 参数里的固件 是不是存在; 
	if(access(d_file, 0) == -1)
	{  
		printf("\n%s no exits !!\n", d_file);
		goto check_fw_error3;
	}else{
		//3.2 检查 参数里的固件 是不是 intel 压缩包; 
		error = excu_shell_para_get_return_int(shell_cmd3, d_file);
		if(error != 0)
		{
			//				printf("%d : error: %d\n excu : [%s] failed!!\n\n", __LINE__, error, shell_cmd3);
			goto check_fw_error3;
		}	
	}
	
	//3.3 检查之前是不是 已经有过 解压动作，若有，那么需要 手动 删除 之前的 解压文件;
	if(access(Customer_tools_FW, 0) == -1)//access函数是查看文件是不是存在, 不存在 走这里; 
	{  

		//3.4 excu [unzip intel-4.2.zip -d tmpdir]
//		printf("unzip intel-4.2.zip cmd = [%s]\n\n", shell_cmd4);
		error = excu_shell_para_get_return_int(shell_cmd4, d_file);
		if(error != 0)
		{
			printf("%d : error: %d\n excu : [%s] failed!!\n\n", __LINE__, error, shell_cmd4);
			goto check_fw_error3;
		}	

	}else{
		printf("Dir [%s] exits, First: Please delete it  !!\n\n", Customer_tools_FW);  
		goto check_fw_error3;
	} 
	
	return error;

check_fw_error3:
	
	return 1;
}

//2.执行命令+参数， 获取 返回值;
int excu_shell_para_get_return_int(char * shell_cmd, char * para){
	int error = 0;
	char real_cmd[MAXBUFSIZE];

	memset(real_cmd,'\0', sizeof(real_cmd));
	strcat(real_cmd, shell_cmd);
	strcat(real_cmd, para);

//	printf("%d : cmd = [%s]\n", __LINE__, real_cmd);
	error = system(real_cmd);
	return error;
}

//1.执行命令 获取 返回值;
int excu_no_para_shell_get_return_int(char * shell_cmd){
	int error = 0;
//	printf("%d : cmd = [%s]\n", __LINE__, shell_cmd);
	error = system(shell_cmd);
#if 0
	if(error != 0)
	{
		printf("\n [%s] failed!!\n\n", shell_cmd);
	}
#endif
	return error;
}

///////////////// 以下 部分是 解压 函数 //////////////////

//1 修改 挂载点 的权限 为 -> 777
int compress_2_intel_fw(char * fw_name){

	int error = 0;

	memset(tmp_cmd, '\0', sizeof(tmp_cmd));
	memset(current_cmd_path, '\0', sizeof(tmp_cmd));
	strcat(tmp_cmd, "zip -rj ");
	//			getcwd(current_cmd_path, MAXBUFSIZE);//获取 当前路径;
	//			strcat(tmp_cmd, current_cmd_path);
	//			strcat(tmp_cmd, "/");
	strcat(tmp_cmd, fw_name);

	strcat(tmp_cmd, " ");

//	getcwd(current_cmd_path, MAXBUFSIZE);//获取 当前路径;
//	strcat(tmp_cmd, current_cmd_path);
//	strcat(tmp_cmd, "/");
	strcat(tmp_cmd, Customer_tools_FW);

//	printf("%d : cmd = %s\n", __LINE__, tmp_cmd);
	error = excu_no_para_shell_get_return_int(tmp_cmd);
	if(error != 0)
	{
		printf("----------------\n\n");	
		return -1;
	}

	return error;
}









