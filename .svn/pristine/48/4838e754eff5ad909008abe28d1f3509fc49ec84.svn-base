<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.epp.util.orgusertb.RtxSynchronization"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request,response);	
%>
<%
	String allDept_User = request.getParameter("allDept_User");//选择的ldap用户id
	if(allDept_User==null)allDept_User = "";
	String type = request.getParameter("type");
	if(type==null)type = "";
	String message = "";
	boolean r = false;
	RtxSynchronization rsz = new RtxSynchronization();
	try{
		String[] dept_users = allDept_User.split(";");
		int i = 0,duN = dept_users.length;
		for(i=0;i<duN;i++){
			rsz = new RtxSynchronization();
			String dept_user = dept_users[i];
			String deptId = dept_user.substring(0,dept_user.indexOf(":"));
			String ids = dept_user.substring(dept_user.indexOf(":")+1);
			
			if(type.equals("ptzl2rtx")){//平台增量同步到rtx
				deptId = "";//增量同步将不修改用户机构所属关系,以平台为基础
				r = rsz.increPTSyn2RTX(ids,deptId);
			}
			if(type.equals("ptwq2rtx")){//平台完全同步到rtx
				r = rsz.compPTSyn2RTX(ids,deptId);
			}
		}
		if(r)message = "同步成功";
		else message = "同步失败";
	}catch(Exception e){
		message = "同步失败";
		e.printStackTrace();
	}
%>
<script language="javascript">
	var mes = '<%=message%>';
	if(mes!=""){
		alert(mes);
	}
	parent.document.getElementById("divProcessing").style.display = "none";
	parent.document.body.disabled = false;
  	parent.parent.org_tree.document.body.disabled = false;
</script>
