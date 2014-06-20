
#include <stdio.h>
#include <string.h>
#include <malloc.h>

#define MAXBUFSIZE 1024

//1. 显示 软件功能 和 使用方法
void show_tools_info();
void cmd_system(const char* command, char ** save_result);

int main(int argc, char **argv){

	//验证 是否是 root用户执行
	if(argc < 2){
		printf("Please use wb_android_tools XXX.zip\n\n");
		return -1;
	}

	///////////////////////
	int error = 0;
	int i = 0;
	char * buffer = NULL;
	char * Customer_tools_FW = "Customer_tools_FW";
	char * Modify_system_img_dir = "Modify_system_img_dir";
	char unzip_intel_all_fw_cmd[MAXBUFSIZE];
	char * intel_4_2_system_name="system.img.gz";
	char * before_modify_intel_4_2_system_name="before_system.img";
	char * mount_dir_name="modify_system";
	char * intel_4_4_system_name="system.img";
	char * fw_dir_name = "Customer_tools_FW";

	///////////////////////
	//1.显示 软件功能 和 使用 方法;	
	show_tools_info();

	
	//2.解压 intel 工具固件升级包
	if(access(Customer_tools_FW, 0) == -1)//access函数是查看文件是不是存在, 不存在 走这里; 
	{  
		if(access(argv[1], 0) == -1)//access函数是查看文件是不是存在; 
		{  
			printf("%s no exits !!\n", argv[1]);
			return -3;
		}else{
			error = check_fw_is_zip(argv[1]);
			if(error != 0)
			{
				return -2;
			}	
		}

		buffer = malloc(MAXBUFSIZE*sizeof(char));
		memset(unzip_intel_all_fw_cmd, '\0', sizeof(unzip_intel_all_fw_cmd));
		strcat(unzip_intel_all_fw_cmd, "unzip ");
		strcat(unzip_intel_all_fw_cmd, argv[1]);
		strcat(unzip_intel_all_fw_cmd, " -d ");
		strcat(unzip_intel_all_fw_cmd, fw_dir_name);
		//printf("fw_dir_name = %s\n", unzip_intel_all_fw_cmd);
		cmd_system(unzip_intel_all_fw_cmd, &buffer);
		//printf("buffer = %s\n", buffer);
#if 0
		printf("Dir [%s] no exits, so Creat it !!\n", Customer_tools_FW);  
		if (mkdir(Customer_tools_FW, 0777))//如果不存在就用mkdir函数来创建;  
		{  
			printf("creat file  [%s] failed!!!\n", Customer_tools_FW);  
			return -1;
		}  
#endif

//printf("------ line num = %d \n", __LINE__);
	}else{
		printf("Dir [%s] exits !!\n", Customer_tools_FW);  
	} 
	
	//3.调用一个脚本，把 所有的 东西放到 顶层目录下，并且做 校验，是否为 weibu 固件; 

	//4.解压 system.img.gz for 4.2
	if(access(Modify_system_img_dir, 0) == -1)//access函数是查看文件是不是存在, 不存在 走这里; 
	{  
	
		if (mkdir(Modify_system_img_dir, 0777))//如果不存在就用mkdir函数来创建;  
		{  
			printf("creat file  [%s] failed!!!\n", Modify_system_img_dir);  
			return -1;
		}  

	}else{
		printf("Dir [%s] exits !!\n", Modify_system_img_dir);  
	} 

	memset(unzip_intel_all_fw_cmd, '\0', sizeof(unzip_intel_all_fw_cmd));
	strcat(unzip_intel_all_fw_cmd, "cp ");
	strcat(unzip_intel_all_fw_cmd, Customer_tools_FW);
	strcat(unzip_intel_all_fw_cmd, "/");
	strcat(unzip_intel_all_fw_cmd, intel_4_2_system_name);
	strcat(unzip_intel_all_fw_cmd, " ");
	strcat(unzip_intel_all_fw_cmd, Modify_system_img_dir);
	strcat(unzip_intel_all_fw_cmd, "/");
	strcat(unzip_intel_all_fw_cmd, before_modify_intel_4_2_system_name);
//	printf("%d : cmd = %s\n", __LINE__, unzip_intel_all_fw_cmd);
//	cmd_system(unzip_intel_all_fw_cmd, &buffer);	

	
	//5.需要在 shell里 做一个卸载动作: umount $Intel_android_top/$Tmp_Dir/m_system -l > /dev/null

	memset(unzip_intel_all_fw_cmd, '\0', sizeof(unzip_intel_all_fw_cmd));
	strcat(unzip_intel_all_fw_cmd, "gunzip -c ");
	strcat(unzip_intel_all_fw_cmd, Customer_tools_FW);
	strcat(unzip_intel_all_fw_cmd, "/");
	strcat(unzip_intel_all_fw_cmd, intel_4_2_system_name);
	strcat(unzip_intel_all_fw_cmd, " > ");
	strcat(unzip_intel_all_fw_cmd, Modify_system_img_dir);
	strcat(unzip_intel_all_fw_cmd, "/");
	strcat(unzip_intel_all_fw_cmd, before_modify_intel_4_2_system_name);
//	printf("%d : cmd = %s\n", __LINE__, unzip_intel_all_fw_cmd);
	//这里做一次容错处理，请客户输入，以防 把之前的覆盖掉;
	//cmd_system(unzip_intel_all_fw_cmd, &buffer);	

//printf("------ line num = %d \n", __LINE__);


	//6.创建设备 的挂载目录;
	memset(unzip_intel_all_fw_cmd, '\0', sizeof(unzip_intel_all_fw_cmd));
	strcat(unzip_intel_all_fw_cmd, Modify_system_img_dir);
	strcat(unzip_intel_all_fw_cmd, "/");
	strcat(unzip_intel_all_fw_cmd, mount_dir_name);
	printf("%d : cmd = %s\n", __LINE__, unzip_intel_all_fw_cmd);
	if(access(unzip_intel_all_fw_cmd, 0) == -1)//access函数是查看文件是不是存在, 不存在 走这里; 
	{  
	
		if (mkdir(unzip_intel_all_fw_cmd, 0777))//如果不存在就用mkdir函数来创建;  
		{  
			printf("creat file  [%s] failed!!!\n", unzip_intel_all_fw_cmd);  
			return -1;
		}  

	}else{
		printf("Dir [%s] exits !!\n", unzip_intel_all_fw_cmd);  
	} 

	//7.mount -t ext4 -o loop $android_top/$Tmp_Dir/system_tmp.img $Intel_android_top/$Tmp_Dir/m_system/
	memset(unzip_intel_all_fw_cmd, '\0', sizeof(unzip_intel_all_fw_cmd));
	strcat(unzip_intel_all_fw_cmd, "mount -t ext4 -o loop  ");
	strcat(unzip_intel_all_fw_cmd, Modify_system_img_dir);
	strcat(unzip_intel_all_fw_cmd, "/");
	strcat(unzip_intel_all_fw_cmd, before_modify_intel_4_2_system_name);
	strcat(unzip_intel_all_fw_cmd, " ");
	strcat(unzip_intel_all_fw_cmd, Modify_system_img_dir);
	strcat(unzip_intel_all_fw_cmd, "/");
	strcat(unzip_intel_all_fw_cmd, mount_dir_name);
//	printf("%d : cmd = %s\n", __LINE__, unzip_intel_all_fw_cmd);
	cmd_system(unzip_intel_all_fw_cmd, &buffer);	

	//8.chmod 777 -R $Intel_android_top/$Tmp_Dir/m_system/ 修改 挂载点的 权限为 777
	memset(unzip_intel_all_fw_cmd, '\0', sizeof(unzip_intel_all_fw_cmd));
	strcat(unzip_intel_all_fw_cmd, "chmod 777 -R ");
	strcat(unzip_intel_all_fw_cmd, " ");
	strcat(unzip_intel_all_fw_cmd, Modify_system_img_dir);
	strcat(unzip_intel_all_fw_cmd, "/");
	strcat(unzip_intel_all_fw_cmd, mount_dir_name);
	printf("%d : cmd = %s\n", __LINE__, unzip_intel_all_fw_cmd);
	cmd_system(unzip_intel_all_fw_cmd, &buffer);	


#if 0
	//给命令后 添加一个 空格;
	strcat(shell_cmd1, " ");

	//解析 参数;
	for(i=1; i < argc; i++){
	//	printf("argv[%d] = %s\n", i, argv[i]);
		strcat(shell_cmd1, argv[i]);
		strcat(shell_cmd1, " ");
	}

	//
	
	error = system(shell_cmd1);
	if(error != 0)
	{
		printf("\nExecute [%s] failed!!\n\n", shell_cmd1);
	}else{

		printf("\nExecute [%s] successed!!\n\n", shell_cmd1);
	}
#endif
	free(buffer);

	return 0;
}//end main;

/*
char buf[MAXBUFSIZE];
getcwd(buf, MAXBUFSIZE);
printf("current path=%s\n", buf);
readlink( "program_fuc_list.sh", buf, MAXBUFSIZE ); 
printf("shell path=%s\n", buf);
*/

//1. 显示 软件功能 和 使用方法
void show_tools_info(){
	int error = 0;
	char shell_cmd1[300] = "./mybin/program_fuc_list.sh";
	printf("%d : cmd = [%s]\n", __LINE__, shell_cmd1);
	error = system(shell_cmd1);
	if(error != 0)
	{
		printf("\nExecute [%s] failed!!\n\n", shell_cmd1);
	}else{

		printf("\nExecute [%s] successed!!\n\n", shell_cmd1);
	}
}

//2. 验证 升级FW 是不是 XXX.zip 文件;
int check_fw_is_zip(char * zip){
	int error = 0;
	char shell_cmd1[300] = "./mybin/check_fw_zip.sh ";
	strcat(shell_cmd1, zip);
//	printf("%d : cmd = [%s]\n", __LINE__, shell_cmd1);
	error = system(shell_cmd1);
	if(error != 0)
	{
		printf("\n [%s] failed!!\n\n", shell_cmd1);
	}else{

//		printf("\nExecute [%s] successed!!\n\n", shell_cmd1);
	}
	return error;
}

//3.执行 shell命令，并且 返回 shell的结果，以 字符串形式;
void cmd_system(const char* command, char ** save_result)
{
    FILE *fpRead;
    fpRead = popen(command, "r");
    char buf[MAXBUFSIZE];
    memset(buf,'\0', sizeof(buf));
    while(fgets(buf, MAXBUFSIZE-1, fpRead)!=NULL)
    { 
	 strncpy(*save_result, buf, sizeof(buf)) ;
    }
    if(fpRead!=NULL)
        pclose(fpRead);
    return;
}








