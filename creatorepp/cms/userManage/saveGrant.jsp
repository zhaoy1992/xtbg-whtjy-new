<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.db.RoleManagerImpl,
				com.chinacreator.security.AccessControl"%>

<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request,response);	
	String userId = control.getUserID();
	String currRoleId = (String)session.getAttribute("currRoleId");
	String idString = request.getParameter("resIds");//��ԴID
	//System.out.println("idString = " + idString);
	List resIds = null;
	if(idString!=null && !idString.equals("")){
		String[] res = idString.trim().split(":");
		resIds = new ArrayList();
		for(int i=0;i<res.length;i++){
			String[] temps = res[i].split(";");
			resIds.add(temps);
		}
	}
	String resTypeId = request.getParameter("resTypeId");
	String roleType = request.getParameter("roleType");
	
	String[] opids = new String[]{"visible"};
	String[] roleids = new String[]{currRoleId};
	
	boolean state = new RoleManagerImpl().saveResGrant(opids,resIds,roleids,resTypeId,roleType,userId);
	
	if(state){
%>
	<SCRIPT language="javascript">
		alert("�����ɹ�");
		parent.location = parent.location;
	</script>
<%	}else{%>
	<SCRIPT language="javascript">
	alert("����ʧ��");
	</script>
<%	}%>
