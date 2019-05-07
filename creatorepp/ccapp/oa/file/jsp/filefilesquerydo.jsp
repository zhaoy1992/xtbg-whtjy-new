<%--
描述：档案管理-档案查询处理jsp
作者：邹拓
版本：1.0
日期：2013-7-16
UTF-8
--%>
<%@page import="com.chinacreator.xtbg.core.file.dao.imploracle.FileDocDaoImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.MessageUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.file.entity.FileTypeBean"%>
<%@page import="com.chinacreator.xtbg.core.file.service.FileTypeServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileTypeServiceImpl"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="com.chinacreator.xtbg.core.file.service.FileFavoritesServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileFavoritesServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileLendingServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.file.service.FileLendingServiceIfc"%>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String userId = accesscontroler.getUserID();
String userName = accesscontroler.getUserName();
String responseCode="";//1:回调js,2:ajax
Object responseObj=null;
String responseObj_SUCCESS="操作成功";
String responseObj_FIAL="操作失败";

//1:分类处理请求
String action = request.getParameter("action");
//1.1:增 改收藏
if("addFileFavoritesBean".equals(action)){
	responseCode = "1";
	String docIds = request.getParameter("add");
	boolean flag = false;
	if(docIds!=null){
		FileFavoritesServiceIfc service = new FileFavoritesServiceImpl();
		flag = service.add(docIds.split(","),accesscontroler.getUserID());
	}
	
	if(flag){
		responseObj = responseObj_SUCCESS;
	}else{
		responseObj = responseObj_FIAL;
	}
}

//1.2:删收藏
if("deleteFileFavoritesBean".equals(action)){
	responseCode = "1";
	String favoritesIds = request.getParameter("delete");
	boolean flag = false;
	if(favoritesIds!=null){
		FileFavoritesServiceIfc service = new FileFavoritesServiceImpl();
		flag = service.delete(favoritesIds.split(","));
	}
	
	if(flag){
		responseObj = responseObj_SUCCESS;
	}else{
		responseObj = responseObj_FIAL;
	}
}
//1.3:加入订阅篮
if("addFileLendingDetailBean".equals(action)){
	responseCode = "1";
	String docIds = request.getParameter("add");
	boolean flag = false;
	if(docIds!=null){
		FileLendingServiceIfc service = new FileLendingServiceImpl();
		flag = service.addFileLendingDetailAfterQueryFileFiles(docIds.split(","),accesscontroler.getUserID());
	}
	
	if(flag){
		responseObj = responseObj_SUCCESS;
	}else{
		responseObj = responseObj_FIAL;
	}
}

//1.4:删订阅篮
if("deleteFileLendingDetailBean".equals(action)){
	responseCode = "1";
	String ids = request.getParameter("delete");
	boolean flag = false;
	if(ids!=null){
		FileLendingServiceIfc service = new FileLendingServiceImpl();
		flag = service.delete(ids.split(","));
	}
	
	if(flag){
		responseObj = responseObj_SUCCESS;
	}else{
		responseObj = responseObj_FIAL;
	}
}

//1.5:档案借阅管理--借出动作
if("borrowOut".equals(action)){
	responseCode = "1";
	String idList = request.getParameter("idList");
	String docList = request.getParameter("docList");
	String dateList = request.getParameter("dateList");
	String flagStr = "";
	if(idList!=null){
		FileLendingServiceIfc service = new FileLendingServiceImpl();
		flagStr = service.borrowOut(idList,docList,userId,userName,dateList);
	}else{
		flagStr = "获取参数失败";
	}
	if("".equals(flagStr)){
		responseObj = responseObj_SUCCESS;
	}else{
		responseObj = flagStr;
	}
}

//1.6:档案借阅管理--馆内阅读
if("borrowOutAndBack".equals(action)){
	responseCode = "1";
	String idList = request.getParameter("idList");
	String docList = request.getParameter("docList");
	String flagStr = "";
	if(idList!=null){
		FileLendingServiceIfc service = new FileLendingServiceImpl();
		flagStr = service.borrowOutAndBack(idList,docList,userId,userName);
	}else{
		flagStr = "获取参数失败";
	}
	if("".equals(flagStr)){
		responseObj = responseObj_SUCCESS;
	}else{
		responseObj = flagStr;
	}
}
//1.7:档案借阅管理--催还
if("fileBackCallUser".equals(action)){
	responseCode = "1";
	String message_info = request.getParameter("message_info"); //内容
	String f_detail_ids = request.getParameter("f_detail_ids");//接收短信 的借阅id
	String username = accesscontroler.getUserName();
	
	boolean flagA,flagB = false;
	String isType = request.getParameter("isType"); //短信
	if("y".equals(isType)){
		flagA = true;
	}else{
		flagA = false;
	}
	String isnow = request.getParameter("isnow"); //即时消息
	if("y".equals(isnow)){
		flagB = true;
	}else{
		flagB = false;
	}
	FileLendingServiceIfc service = new FileLendingServiceImpl();
	boolean flag = service.callUserForFileBackById(f_detail_ids,message_info,userId,username,flagA,flagB);
	if(flag){
		responseObj = responseObj_SUCCESS;
	}else{
		responseObj = responseObj_FIAL;
	}
}

if("filedoctodeptrollbackJSP".equals(action)){
	responseCode = "1";
	String message_info = request.getParameter("message_info"); //内容
	String message_content = request.getParameter("message_content"); //内容
	String f_detail_ids = request.getParameter("f_detail_ids");//接收短信 的借阅id
	String username = accesscontroler.getUserName();
	
	boolean flagA,flagB = false;
	String isType = request.getParameter("isType"); //短信
	if("y".equals(isType)){
		flagA = true;
	}else{
		flagA = false;
	}
	String isnow = request.getParameter("isnow"); //即时消息
	if("y".equals(isnow)){
		flagB = true;
	}else{
		flagB = false;
	}
	FileDocDaoImpl dao = new FileDocDaoImpl();
	boolean flag = false;
	if("files".equals(request.getParameter("filetype"))){
		flag = dao.tuihuifiles(f_detail_ids,message_info,userId,username,flagA,flagB,message_content);
	}else{
		flag = dao.tuihui(f_detail_ids,message_info,userId,username,flagA,flagB,message_content);
	}
	
	if(flag){
		responseObj = responseObj_SUCCESS;
	}else{
		responseObj = responseObj_FIAL;
	}
}
//2:
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
		}catch(e){alert(e.description+'or need afterSubmitFn');}
	</script>
	</body>
</html>
		<%
	}
}else if("2".equals(responseCode)){
	if(responseObj!=null){
		if(responseObj instanceof String){
			out.print(responseObj.toString());
		}else{
			out.write(JSON.toJSONString(responseObj,true));//输出list或者对象
		}
	}
}
%>