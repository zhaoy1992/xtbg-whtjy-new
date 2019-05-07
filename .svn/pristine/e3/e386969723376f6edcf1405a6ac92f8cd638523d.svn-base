<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../include/global1.jsp"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.dictionary.input.InputTypeManager"%>
<%@ page import="com.chinacreator.dictionary.input.InputTypeManagerImpl"%>
<%@ page import="com.chinacreator.dictionary.input.InputType"%>
<%

		AccessControl control = AccessControl.getInstance();
		control.checkAccess(request,response);
		String queryString = request.getParameter("querystring");
		String currentId=request.getParameter("inputTypeId");
		int flag =Integer.parseInt(request.getParameter("flag"));
		String typeName = request.getParameter("typeName");
		String typeDesc = request.getParameter("typeDesc");
		String typeScript = request.getParameter("typeScript");
		String sourcePath = request.getParameter("sourcePath");
		InputTypeManager inputTypeManager = new InputTypeManagerImpl();		
		InputType inputType=new InputType();
		boolean success=false;
		int deleteFlag = 0;
		//对操作状态进行判断	
		switch(flag)
		{
			//新增
			case 1:
			inputType.setInputTypeDesc(typeDesc);
			inputType.setInputTypeName(typeName);
			inputType.setInputScript(typeScript);
			inputType.setDataSourcePath(sourcePath);	
			success=inputTypeManager.insertInputType(inputType);			
			break;
			//修改
			case 2:
			inputType.setInputTypeId(Integer.valueOf(currentId));
			inputType.setInputTypeDesc(typeDesc);
			inputType.setInputTypeName(typeName);
			inputType.setInputScript(typeScript);
			inputType.setDataSourcePath(sourcePath);	
			success=inputTypeManager.updateInputType(inputType);			
			break;
			//删除 如果该输入类型被引用, 不允许删除
			case 3:
			String[] currentIds = currentId.split(",");
			deleteFlag=inputTypeManager.deleteInputType(currentIds);
			break;
		}
%>
<html>
<head>
<title></title>
<script language="javascript">
//判断新增是否成功
if('<%=flag%>'=='1'){
	if(<%=success%>){
		alert("新增类型成功！");
		window.close();
		window.returnValue="ok";
	}else{
		alert("输入类型名称重复,新增类型失败！");
	}
}

//判断修改是否成功
if('<%=flag%>'=='2'){
	if(<%=success%>){
		alert("修改类型成功！");
		window.close();
		window.returnValue="ok";
	}else{
		alert("输入类型名称重复,修改类型失败！");
	}
}

//判断删除操作
if(!<%=success%> && '<%=flag%>'!='1' && '<%=flag%>'!='2')
{
	if('<%=flag%>'=='3')
	{
	    if(<%=deleteFlag%>==0){
	    	//全部删除成功
			alert("删除类型成功！");
			window.parent.location.href = "inputTypeList.jsp?<%=queryString%>";
	    }else if(<%=deleteFlag%>==1){
	    	//部分删除成功
	        alert("部分输入类型删除不成功,因为部分输入类型正在被引用");
	        window.parent.location.href = "inputTypeList.jsp?<%=queryString%>";
	    }else{
	    	//全部删除不成功
	        alert("输入类型删除不成功,因为输入类型正在被引用");
	    }
	    
	}else{
		//对删除意外的其他操作
		alert("操作失败");
		window.close();
	}
}

</script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body >
</body>
</html>

