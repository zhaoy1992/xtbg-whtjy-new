<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.epp.util.orgusertb.DBTableXmlManager"%>

<%@page import="com.frameworkset.orm.transaction.TransactionManager"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request,response);	
%>
<%
	String xmlfile = request.getParameter("xmlfile");
	String userFileUrl = request.getParameter("userUrl");
	if(userFileUrl==null)userFileUrl = "";
	String orgFileUrl = request.getParameter("orgUrl");
	if(orgFileUrl==null)orgFileUrl = "";
	String orgUserFileUrl = request.getParameter("orgUserUrl");
	if(orgUserFileUrl==null)orgUserFileUrl = "";
	String userJobFileUrl = request.getParameter("userJobUrl");
	if(userJobFileUrl==null)userJobFileUrl = "";
	String type = request.getParameter("type");
	if(type==null)type = "";
	String allDept_User = request.getParameter("allDept_User");
	if(allDept_User==null)allDept_User = "";
	String dir = request.getParameter("dir");
	if(dir==null)dir = "";
	String queryString2 = request.getParameter("queryString2");
	if(queryString2==null)queryString2 = "";
		TransactionManager tm = new TransactionManager();
		boolean r = false;
		String message = "";
	try{
		tm.begin();
		DBTableXmlManager dm = new DBTableXmlManager();
		if(type.equals("imp")){//导入
			r = dm.xmlTbPt(xmlfile,userJobFileUrl,queryString2);
			if(r)message = "导入成功";
			else message = "导入失败";
		}
		
		tm.commit();
	}catch(Exception e){
		tm.rollback();
		e.printStackTrace();
	}
%>
<script language="javascript">
	var mes = '<%=message%>';
	if(mes!=""){
		alert(mes);
	}
  	parent.document.getElementById("divProcessing").style.display="none";
	parent.document.body.disabled = false;
  	parent.parent.org_tree.document.body.disabled = false;
</script>