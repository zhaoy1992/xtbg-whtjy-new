<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.sysmgrcore.purviewmanager.PurviewManager"%>
<%@page import="com.chinacreator.sysmgrcore.purviewmanager.db.PurviewManagerImpl"%>

<%

	//String check = request.getParameter("check");
	//String opid = request.getParameter("opid");
	//�Ƿ�����������Դ
	String isBatch = request.getParameter("isBatch");
	String types = request.getParameter("types");
	String resId = request.getParameter("resId");
	String orgId = request.getParameter("roleid");
	//�Ƿ�ݹ�
	boolean isRecursion = false;
	String recursion = request.getParameter("isRecursion");
	if("true".equals(recursion)){
		isRecursion = true;
	}
	String[] resIds = null;
	if(resId != null && !"".equals(resId)){
		resIds = resId.split("\\^\\^"); 
	}
	//String roleId = request.getParameter("roleId");
	String restypeId = request.getParameter("restypeId");
	String resName = request.getParameter("resName2");
	String[] resNames = null;
	if(resName != null && !"".equals(resName)){
		resNames = resName.split("\\^\\^");
	}
	String checks = request.getParameter("checks");
	String un_checks = request.getParameter("un_checks");
	String[] opids = null;
	String[] un_opids = null;
	if(checks != null && !"".equals(checks)){
		opids = checks.split("\\^\\#\\^");
		//int len = checkOpid.length;
		//opids = new String[len];
		//for(int opCount = 0; opCount < len; opCount++){
		//	opids[opCount] = checkOpid[opCount];  
		//}
	}
	if(un_checks != null && !"".equals(un_checks)){
		un_opids = un_checks.split("\\^\\#\\^");
		//int un_len = un_checkOpid.length;
		//un_opids = new String[un_len];
		//for(int un_opCount = 0; un_opCount < un_len; un_opCount++){
		//	un_opids[un_opCount] = un_checkOpid[un_opCount]; 
		//}
	}
	
	PurviewManager purviewManager = new PurviewManagerImpl();
	boolean state = false;
	if("false".equals(isBatch)){
		state = purviewManager.saveSelfDefineOrgRoleresop(opids,orgId,un_opids,resIds,types,restypeId,resNames,isRecursion);
	}else{
		state = purviewManager.saveSelfDefineBatchOrgRoleresop(opids,orgId,un_opids,resIds,types,restypeId,resNames,isRecursion);
	}
	if(state){
%>
<script language="Javascript">
	alert("�����ɹ���");
</script>
<%
	}else{
%>
<script language="Javascript">
	alert("����ʧ�ܣ�");
</script>
<%
	}
%>