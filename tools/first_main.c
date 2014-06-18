
#include <stdio.h>
#include <string.h>

///////////////////////
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











int main(int shell_cmd1c, char **argv){

	char * i_am_the_delimiter1 = 	"###########################################";
	char * sw_has_func_list = 	"# 本软件具有两大功能:                     #";
	char * sw_has_func1 = 		"#     功能1 : 解压 微步 4.2升级固件！！   #";
	char * sw_has_func2 = 		"#     功能2 : 压缩 微步 4.2升级固件！！   #";
	char * i_am_the_delimiter2 = 	"###########################################";

	///////////////////////
	int error = 0;
	int i = 0;











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


	//3.








#if 0
	//给命令后 添加一个 空格;
	strcat(shell_cmd1, " ");

	//解析 参数;
	for(i=1; i < shell_cmd1c; i++){
	//	printf("shell_cmd1v[%d] = %s\n", i, argv[i]);
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
