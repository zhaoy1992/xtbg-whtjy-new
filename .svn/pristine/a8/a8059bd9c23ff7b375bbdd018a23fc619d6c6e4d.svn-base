<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.dao.InfoReportManagerDao"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%><html>
<head>
<title>更新信息是否推荐页面</title>

<%

	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String userid = accesscontroler.getUserID();
	String username = accesscontroler.getUserName();
	String submittedinfo_id = request.getParameter("submittedinfo_id");
	String is_recommend = request.getParameter("is_recommend");

	boolean flag = true;
	InfoReportManagerDao infoReportdao = (InfoReportManagerDao)DaoImplClassUtil.getDaoImplClass("infoReportManagerDaoImpl");
	try{
		infoReportdao.saveInfoRecommend(submittedinfo_id,is_recommend,userid,username);
	}catch(Exception e){
		flag = false;
	}
%>
<script type="text/javascript">
var mes = "";
var bool = true;
if(<%=flag%>){
	mes = "操作成功";
	bool = false;
	<%if(StringUtil.nullOrBlank(request.getParameter("inputuser_id"))){%>
		parent.refreshGrid4WfactionInfo();
	<%}else{%>
		parent.backTo();
	<%}%>
}else{
	mes = "操作失败"	;
	bool = false;
	window.parent.JqueryDialog.SubmitCompleted(mes, true, bool);
}

</script>
<body>
</body> 
</html>