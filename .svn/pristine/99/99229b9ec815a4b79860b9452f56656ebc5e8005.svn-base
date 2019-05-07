<%@ page language="java" pageEncoding="GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.sysmgrcoreext.manager.SecurityDatabaseExt"%>
<%@page import="com.chinacreator.sysmgrcoreext.manager.bean.UserOrgStatusBean"%>
<%
AccessControl control = AccessControl.getInstance();
control.checkAccess(request, response);
response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires", 0);
String user_id1 = request.getParameter("userId1");
String user_id = request.getParameter("userId");
String designatorOrgId = request.getParameter("designatorOrgId");
String designeeOrgId = request.getParameter("designeeOrgId");
try{
	//根据用户id获取器有效任职机构
	List list1 =  SecurityDatabaseExt.getIOrgManagerExt().getActivityOrg(user_id1);
	if(list1 != null){
		int i = 0, size = list1.size();
		for(; i < size; i++){
			UserOrgStatusBean userOrgStatus = (UserOrgStatusBean)list1.get(i);
			String org_id = userOrgStatus.getOrgID();
			String orgName = SecurityDatabaseExt.getIOrgManagerExt().getOrgById(org_id).getOrgName();
			String checked = "";
			if(designatorOrgId != null && designatorOrgId.equals(org_id)){
				checked = "checked";
			}else{
				if(i == 0){
					checked = "checked";
				}
			}
			String radioHtml = "<input type='radio' name='orgs1' "+checked+" value='"+org_id+"'>"+orgName+"</input>";
			%>
			<script type="text/javascript">
			<!--
				parent.document.getElementById('orgsTd1').innerHTML += "<%=radioHtml %> ";
				parent.document.getElementById("orgsTr1").style.display="";
			//-->
			</script>
			<%
		}
	}
	//根据用户id获取器有效任职机构
	List list =  SecurityDatabaseExt.getIOrgManagerExt().getActivityOrg(user_id);
	if(list != null){
		int i = 0, size = list.size();
		for(; i < size; i++){
			UserOrgStatusBean userOrgStatus = (UserOrgStatusBean)list.get(i);
			String org_id = userOrgStatus.getOrgID();
			String orgName = SecurityDatabaseExt.getIOrgManagerExt().getOrgById(org_id).getOrgName();
			String checked = "";
			if(designeeOrgId != null && designeeOrgId.equals(org_id)){
				checked = "checked";
			}else{
				if(i == 0){
					checked = "checked";
				}
			}
			String radioHtml = "<input type='radio' name='orgs' "+checked+" value='"+org_id+"'>"+orgName+"</input>";
			%>
			<script type="text/javascript">
			<!--
				parent.document.getElementById('orgsTd').innerHTML += "<%=radioHtml %> ";
				parent.document.getElementById("orgsTr").style.display="";
			//-->
			</script>
			<%
		}
	}
}catch(Exception e){
	e.printStackTrace();
}
%>
