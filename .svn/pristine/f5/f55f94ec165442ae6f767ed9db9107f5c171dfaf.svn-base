<%--
描述：档案管理-档案文件请求处理
作者：邹拓
版本：1.0
日期：2013-7-16
UTF-8
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="com.chinacreator.xtbg.core.file.service.FileDocService"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileDocServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.file.entity.FileDocBean"%>
<%@page import="java.util.Map"%>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String responseCode="";//1:回调js,2:ajax
Object responseObj=null;
String responseObj_SUCCESS="操作成功";
String responseObj_FIAL="操作失败";

//1:分类处理请求
String action = request.getParameter("action");

//1.1:复制文件
if("filedoclist.copyDoc".equals(action)){
	responseCode = "2";
	FileDocService service = new FileDocServiceImpl();
	String oldId = request.getParameter("f_doc_id");//from filedoclist.js
	String newId = service.copyFileById(oldId);
	if(newId!=null){
		responseObj = newId;
	}else{
		responseObj = "";
	}
}
//1.2:复制照片信息
if("filedoclist.copyDocPhotoMess".equals(action)){
	responseCode = "2";
	FileDocService service = new FileDocServiceImpl();
	String oldId = request.getParameter("f_id");//from filedoclist.js
	String newId = service.copyDocPhotoMessById(oldId);
	if(newId!=null){
		responseObj = newId;
	}else{
		responseObj = "";
	}
}
//1.3:
if("aaa".equals(action)){
	responseCode = "2";
	FileDocService service = new FileDocServiceImpl();
	
	Map<String,String> b = service.getNewMessForInsert(request.getParameter("userId")
													  ,request.getParameter("fileType")
													  ,request.getParameter("deptId")
													  ,request.getParameter("f_files_id"));
	responseObj = b;
}

//2:响应页面
if("1".equals(responseCode)){
	if(responseObj!=null){
		String result = "";
		if(responseObj instanceof String){
			result = responseObj.toString();
		}else{
			result = JSON.toJSONString(responseObj,true);
			Pattern p = Pattern.compile("\\s*|\t|\r|\n");
			Matcher m = p.matcher(result);
			result= m.replaceAll("");
		}
		%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
	<head></head>
	<body>
	<script>
		try{
			var result='<%=result%>';
			eval("parent.afterSubmitFn('"+result+"');");
		}catch(e){alert(e.description);}
	</script>
	</body>
</html>
		<%
	}
}else if("2".equals(responseCode)){
	if(responseObj!=null){
		if(responseObj instanceof String){
			out.write(responseObj.toString());
		}else{
			out.write(JSON.toJSONString(responseObj,true));//输出list或者对象
		}
	}
}
%>