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
	String flag = "";
	if(allDept_User.equals("[$ALL$]")){//全部同步
		if(type.equals("ldapzl2pt")){//LDAP增量同步到平台
			lsz.increLdapSyn2PT("[$ALL$]","");
		}
		if(type.equals("ldapwq2pt")){//LDAP完全同步到平台
			lsz.compLdapSyn2PT("[$ALL$]","");
		}
		flag = "none";
	}else{
		String[] dept_users = allDept_User.split(";");
		int i = 0,duN = dept_users.length;
		for(i=0;i<duN;i++){
			lsz = new LdapSynchronization();
			String dept_user = dept_users[i];
			String deptId = dept_user.substring(0,dept_user.indexOf(":"));
			String ids = dept_user.substring(dept_user.indexOf(":")+1);
			if(type.equals("ldapzl2pt")){//LDAP增量同步到平台
				r = lsz.increLdapSyn2PT(ids,deptId);
			}
			if(type.equals("ldapwq2pt")){//LDAP完全同步到平台
				r = lsz.compLdapSyn2PT(ids,deptId);
			}
		}
		flag = "none";
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