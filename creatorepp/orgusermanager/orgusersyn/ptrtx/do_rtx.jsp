<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.epp.util.orgusertb.RtxSynchronization"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request,response);	
%>
<%
	String allDept_User = request.getParameter("allDept_User");//ѡ���ldap�û�id
	if(allDept_User==null)allDept_User = "";
	String type = request.getParameter("type");
	if(type==null)type = "";

	RtxSynchronization rsz = new RtxSynchronization();
	String message = "";
	if(allDept_User.equals("all_select")){//ȫ��ͬ��
		if(type.equals("rtxzl2pt")){//rtx����ͬ����ƽ̨
			rsz.increRTXSyn2PT("all_select","");
		}
		if(type.equals("rtxwq2pt")){//rtx��ȫͬ����ƽ̨
			rsz.compRTXSyn2PT("all_select","");
		}
	}else{
		String[] dept_users = allDept_User.split(";");
		int i = 0,duN = dept_users.length;
		for(i=0;i<duN;i++){
			rsz = new RtxSynchronization();
			String dept_user = dept_users[i];
			String deptId = dept_user.substring(0,dept_user.indexOf(":"));
			String ids = dept_user.substring(dept_user.indexOf(":")+1);
			if(type.equals("rtxzl2pt")){//rtx����ͬ����ƽ̨
				message = rsz.increRTXSyn2PT(ids,deptId);
			}
			if(type.equals("rtxwq2pt")){//rtx��ȫͬ����ƽ̨
				//if(!deptId.equals("")){
					message = rsz.compRTXSyn2PT(ids,deptId);
				//}
			}
		}
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