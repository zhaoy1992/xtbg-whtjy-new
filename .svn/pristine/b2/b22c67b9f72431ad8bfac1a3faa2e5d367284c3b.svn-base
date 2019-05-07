<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.epp.util.orgusertb.LdapSynchronization"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request,response);	
%>
<%
	String allDept_User = request.getParameter("allDept_User");//选择的ldap用户id
	if(allDept_User==null)allDept_User = "";
	String type = request.getParameter("type");
	if(type==null)type = "";

	LdapSynchronization lsz = new LdapSynchronization();
	boolean r = false;
	String message = "";
		String[] dept_users = allDept_User.split(";");
		int i = 0,duN = dept_users.length;
		for(i=0;i<duN;i++){
			lsz = new LdapSynchronization();
			String dept_user = dept_users[i];
			String deptId = dept_user.substring(0,dept_user.indexOf(":"));
			String ids = dept_user.substring(dept_user.indexOf(":")+1);
			
			if(type.equals("ptzl2ldap")){//平台增量同步到ldap
				r = lsz.increPTSyn2Ldap(ids);
			}
			if(type.equals("ptwq2ldap")){//平台完全同步到ldap
				r = lsz.compPTSyn2Ldap(ids);
			}
		}
	if(r)message = "同步成功";
	else message = "同步失败";
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