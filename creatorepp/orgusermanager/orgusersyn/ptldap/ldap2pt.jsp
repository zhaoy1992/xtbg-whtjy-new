
<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ page import="com.chinacreator.security.*"%>
<%@page import="com.chinacreator.epp.util.orgusertb.LdapManager"%>
<%AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	LdapManager ldap = new LdapManager();
	String isConnect = "";
	if(ldap.getCtx()!=null){
		isConnect = "true";
	}else{
		isConnect = "����LDAP���ݿ�ʧ�ܣ�����LDAP��������";
	}
%>
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="../../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../../css/treeview.css">
		<title>��֯��������</title>
		<script type="text/javascript">
		var isConnect = '<%=isConnect%>';
		if(isConnect!="true"){
			alert(isConnect);
		}
		</script>
	</head>
			<frameset name="userOrgFrame" cols="25%,*" border=0 framespacing="0">
				<frame frameborder=1 scrolling="yes" name="org_tree" src="ldap_tree.jsp" marginWidth=0 marginHeight=0 >
				</frame>
				<frame frameborder=0 scrolling="yes" name="ldapuser_list" src="ldapuser_list.jsp" marginWidth=0 marginHeight=0 >
				</frame>
			</frameset>
</html>
