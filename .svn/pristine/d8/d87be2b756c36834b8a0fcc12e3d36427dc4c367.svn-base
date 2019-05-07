<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoReportBaseInfoBean"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.service.InfoReportServiceIfc"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.service.impl.InfoReportServiceImpl"%>
<%@page import="com.chinacreator.security.AccessControl"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>信息批量上报保存页面</title>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String inputuser_id = accesscontroler.getUserID();
	String inputuser_name = accesscontroler.getUserName();
	String submittedinfo_typecode = request.getParameter("submittedinfo_typecode");
	String submittedinfo_typecode4getinfouser = request.getParameter("submittedinfo_typecode4getinfouser");
	String submittedinfo_typecode2delete = request.getParameter("submittedinfo_typecode2delete");
	String reportunits = request.getParameter("reportunits");
	String submittedinfoIds = request.getParameter("submittedinfoIds");

	InfoReportBaseInfoBean infoReportBaseInfoBean = new InfoReportBaseInfoBean();
	
	infoReportBaseInfoBean.setInputuser_name(inputuser_name);
	infoReportBaseInfoBean.setInputuser_id(inputuser_id);
	infoReportBaseInfoBean.setReportunits(reportunits);
	infoReportBaseInfoBean.setSubmittedinfo_typecode(submittedinfo_typecode);
	infoReportBaseInfoBean.setSubmittedinfo_typecode4getinfouser(submittedinfo_typecode4getinfouser);
	infoReportBaseInfoBean.setSubmittedinfo_typecode2delete(submittedinfo_typecode2delete);
	
	boolean flag = true;
	
	try{
		InfoReportServiceIfc infoReportServiceIfc = new InfoReportServiceImpl();
		infoReportServiceIfc.InfoListReport(submittedinfoIds,infoReportBaseInfoBean);
	}catch(Exception e){
		flag = false;
	}
%>
</head>
<body>
<script type="text/javascript">
var mes = "";
var bool = true;
if(<%=flag%>){
	mes = "操作成功";
	bool = false;
	parent.refreshGrid4WfactionInfo();
}else{
	mes = "操作失败"	;
	bool = false;
}
//window.parent.JqueryDialog.SubmitCompleted(mes, true, bool);
</script>
</body>
</html>