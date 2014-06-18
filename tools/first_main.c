
#include <stdio.h>
#include <string.h>

//1. 显示 软件功能 和 使用方法
void show_tools_info(){
	int error = 0;
	char shell_cmd1[300] = "./mybin/program_fuc_list.sh";
	error = system(shell_cmd1);
	if(error != 0)
	{
		printf("\nExecute [%s] failed!!\n\n", shell_cmd1);
	}else{

		printf("\nExecute [%s] successed!!\n\n", shell_cmd1);
	}
}











int main(int argc, char **argv){

	///////////////////////
	int error = 0;
	int i = 0;

	char * Customer_tools_FW = "Customer_tools_FW";









	///////////////////////
#if 0
	printf("\n%s\n", i_am_the_delimiter1);
	printf("%s\n", sw_has_func_list);
	//printf("本软件具有两大功能: \n");
	printf("%s\n", sw_has_func1);
	printf("%s\n", sw_has_func2);
	printf("%s\n\n", i_am_the_delimiter2);
#endif

	//1.显示 软件功能 和 使用 方法;	
	show_tools_info();

	//2.解压 intel 工具固件升级包
	if(access(Customer_tools_FW, 0) == -1)//access函数是查看文件是不是存在; 
	{  
		printf("Dir [%s] no exits, so Creat it !!\n", Customer_tools_FW);  
		if (mkdir(Customer_tools_FW, 0777))//如果不存在就用mkdir函数来创建;  
		{  
			printf("creat file  [%s] failed!!!\n", Customer_tools_FW);  
			return -1;
		}  
	}else{
		printf("Dir [%s] exits !!\n", Customer_tools_FW);  
	} 

	//解压
	//zip -d arg
	//解析 参数;








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
	return 0;
}
