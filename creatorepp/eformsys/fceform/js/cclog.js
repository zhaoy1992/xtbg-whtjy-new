//20080904新增，用于记录日志
//operModule  记录的日志模块
//operContent 记录的日志内容
function creator_log(operModule,operContent){
	var retX = "";
	var sXml = "<No>"+operModule+"</No><No>"+operContent+"</No>";
	retX = SendHttp(location.protocol+"//"+location.host+ fcpubdata.servletPath 
		+ "/DbTools"+fcpubdata.dotnetVersion+"?creator_log",sXml);
	return retX;
}