
//2004-03-03 用户自定义的全局函数,用于放一些在某个模块中(比如CRM JXC)常用的全局函数.
function getuser() {
	return "fc";
}
function getusername() {
	return "fc";
}

/**
* 控制打开eform设计的表单的权限
* 在此函数中用parent.Request.QueryString("djsn").toString() 形式接收?后的参数.
*@return 空 表示无权打开.
*@date 2006-02-11
**/
function EformEnterStatus() {
/*
	var djtype = parent.Request.QueryString("djtype").toString();  //表单分类号
	var djsn = parent.Request.QueryString("djsn").toString();	//表单djsn

	if(djsn == "application_sub"){
		var name = GetSession('username=')['username'];
		if(name == "liuxm"){
			return "";
		}
	
	}
*/
	return "OK";
}
/**
* 从表的另一种保存模式时的从键字段的生成函数
*@param iRowNo 行号，从0开始的,整型
*@param sSubKeyFieldName 从键的字段名
**/
function IGetSubTableKeyValue(iRowNo,sSubKeyFieldName) {
	return iRowNo + 1 ;
}