<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ page import="com.chinacreator.security.AccessControl,
				com.chinacreator.sysmgrcore.purviewmanager.PurviewManager,
				com.chinacreator.sysmgrcore.purviewmanager.db.PurviewManagerImpl" %>
<%@ page import="com.chinacreator.config.ConfigManager"%>				
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	PurviewManager purviewManager = new PurviewManagerImpl();
	
	//����Ȩ�޸������û����û�ID
	String userId = request.getParameter("userId");
	// ����Ȩ�޸������û�����������ID
	String userOrgId = request.getParameter("userOrgId");
	//����userId�û�������Դ
	String userSelf = request.getParameter("userSelf");
	//����userId�û���ɫ��Դ
	String userRole = request.getParameter("userRole");
	//������Ȩ�޵��û�ID
	String checks = request.getParameter("checks");
	//��ѡ����Ȩ���û�����������ID
	String curOrgId = request.getParameter("curOrgId");
	//�Ƿ��Ƹ�λ��Դ
	String userJob = request.getParameter("userJob");
	
	String[] checkUserIds = checks.split(",");
	
	//�û�Ȩ�޸��ƣ�flag=1ʱ����ǰ�û���Ȩ�޸��Ƹ���ѡ�û���flag=2ʱ����ѡ�û���Ȩ�޸��Ƹ���ǰ�û�
	String flag = request.getParameter("flag");
	
	// Ȩ���Ƿ��������
	// ��ʢ 2011-3-15 
	boolean isrolerelatedorg = ConfigManager.getInstance().getConfigBooleanValue("isrolerelatedorg", false);
	
	boolean state = false;
	if("1".equals(flag)){
		if(isrolerelatedorg){
			state = purviewManager.userResCopy(userId,userOrgId ,checkUserIds, userSelf, userRole, userJob, curOrgId);
		}else{
			state = purviewManager.userResCopy(userId, checkUserIds, userSelf, userRole, userJob, curOrgId);
		}
	}
	if("2".equals(flag)){
		if(isrolerelatedorg){
			state = purviewManager.userResCopySelf(userId,userOrgId, checkUserIds, userSelf, userRole, userJob, curOrgId);
		}else{
			state = purviewManager.userResCopySelf(userId, checkUserIds, userSelf, userRole, userJob, curOrgId);
		}
	}
	
%>			
<script languge="javascript">
<%
	if(state){
%>
	alert("Ȩ�޸��Ƴɹ���");
<%	}else{%>
	alert("Ȩ�޸���ʧ�ܣ�");
<%	}%>
</script>