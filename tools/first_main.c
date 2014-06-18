
#include <stdio.h>

int main(int argc, char **argv){

	char * i_am_the_delimiter1 = 	"###########################################";
	char * sw_has_func_list = 	"# 本软件具有两大功能:                     #";
	char * sw_has_func1 = 		"#     功能1 : 解压 微步 4.2升级固件！！   #";
	char * sw_has_func2 = 		"#     功能2 : 压缩 微步 4.2升级固件！！   #";
	char * i_am_the_delimiter2 = 	"###########################################";


	///////////////////////

	printf("\n%s\n", i_am_the_delimiter1);
	printf("%s\n", sw_has_func_list);
	//printf("本软件具有两大功能: \n");
	printf("%s\n", sw_has_func1);
	printf("%s\n", sw_has_func2);
	printf("%s\n\n", i_am_the_delimiter2);

	return 0;
}
