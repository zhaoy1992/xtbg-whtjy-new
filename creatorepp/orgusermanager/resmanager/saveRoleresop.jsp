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
	String[] roleIds = null;
	String[] un_roleIds = null;
	String[] opids = null;
	String[] un_opids = null;
	//ѡ�б���
	if(checks != null && !"".equals(checks)){
		String[] roleIdAndOpids = checks.split("\\^\\#\\^");
		int len = roleIdAndOpids.length;
		roleIds = new String[len];
		opids = new String[len];
		for(int i = 0; i < len; i++){
			roleIds[i] = roleIdAndOpids[i].split("\\#\\*\\#")[0];
			opids[i] = roleIdAndOpids[i].split("\\#\\*\\#")[1];
		}
	}
	//ûѡ�е�ɾ��
	if(un_checks != null && !"".equals(un_checks)){
		String[] un_roleIdAndOpids = un_checks.split("\\^\\#\\^");
		int un_len = un_roleIdAndOpids.length;
		un_roleIds = new String[un_len];
		un_opids = new String[un_len];
		for(int i = 0; i < un_len; i++){
			un_roleIds[i] = un_roleIdAndOpids[i].split("\\#\\*\\#")[0];
			un_opids[i] = un_roleIdAndOpids[i].split("\\#\\*\\#")[1]; 			
		}
	} 
	
	PurviewManager purviewManager = new PurviewManagerImpl();
	boolean state = false;
	if(isBatch.equals("false")){
		state = purviewManager.saveSelfDefineRoleresop(opids,roleIds,un_opids,un_roleIds,resIds,types,restypeId,resNames,false);
	}else{
		state = purviewManager.saveSelfDefineRoleresop(opids,roleIds,un_opids,un_roleIds,resIds,types,restypeId,resNames,true);
	}
	//if("1".equals(check)){
	//	roleManager.storeRoleresop(opid,resId,roleId,restypeId,resName,types);
	//}else{
	//	roleManager.deletePermissionOfRole(resId,restypeId,roleId,types);
	//}
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