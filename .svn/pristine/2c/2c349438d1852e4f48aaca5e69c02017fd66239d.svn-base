<%--
描述：档案管理-归档处理
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
<%@page import="com.chinacreator.xtbg.core.file.service.FileFavoritesServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileFavoritesServiceImpl"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DbManager"%>
<%@page import="com.chinacreator.xtbg.core.dssave.service.DsCRUDService"%>
<%@page import="com.chinacreator.xtbg.core.dssave.service.impl.DsCRUDServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.file.entity.FileDocBeforeArchiveBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="com.chinacreator.xtbg.core.file.dao.FileDocDao"%>
<%@page import="com.chinacreator.xtbg.core.file.dao.imploracle.FileDocDaoImpl"%>
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
//1.1:公文归档成文
if("saveFileDocAndFileDocForArchiveMess".equals(action)){
	
	String contenttype = request.getParameter("contenttype");
	String a = request.getParameter("OA_FILE_DOC__F_FLOW_STATE");
	if("2".equals(contenttype)){
		//copy filedocdetaildo.jsp
		responseCode = "1";
		boolean flag = false;
		//copy from filedocdetaildo.jsp
		DsCRUDService  dsCRUDService = new DsCRUDServiceImpl();
		Connection conn = null;
		try{
		conn = DbManager.getInstance().getTransactionConnection();
		flag=dsCRUDService.dsUpdate(request, conn);
		conn.commit();
		}catch(Exception e){
			DbManager.rollBackNoThrow(conn);
			e.printStackTrace();
		}finally{
			DbManager.closeConnection(conn);
		}
		if(flag){
			responseObj = responseObj_SUCCESS;
		}else{
			responseObj = responseObj_FIAL;
		}
	}else{
		responseCode = "1";
		boolean flag = false;
		//copy from filedocdetaildo.jsp
		Connection conn = null;
		try{
			conn = DbManager.getInstance().getTransactionConnection();
			DsCRUDService dsCRUDService = new DsCRUDServiceImpl();
			//1.1.1添加FileDoc
			flag=dsCRUDService.dsSave(request, conn);
			//1.1.2修改待归档信息的状态
			FileDocBeforeArchiveBean bean = new FileDocBeforeArchiveBean();
			bean.setF_is_archived(FileDocBeforeArchiveBean.F_IS_ARCHIVED_YES);
			bean.setF_archive_user_id(userId);
			bean.setF_archive_date(DateUtil.getCurrentDateTime());
			String f_id = request.getParameter("fileDocBeforeArchiveBeanId");
			bean.setF_id(f_id);
			FileDocDao dao = new FileDocDaoImpl();
			dao.updateFileDocBeforeArchiveBeanByBean(bean,conn);
			conn.commit();
		}catch(Exception e){
			DbManager.rollBackNoThrow(conn);
			e.printStackTrace();
		}finally{
			DbManager.closeConnection(conn);
		}
		
		
		if(flag){
			responseObj = responseObj_SUCCESS;
		}else{
			responseObj = responseObj_FIAL;
		}
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
<html>
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