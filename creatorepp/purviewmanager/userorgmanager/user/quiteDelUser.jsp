<%
/*
 * <p>Title: ɾ���û�</p>
 * <p>Description: ɾ���û�</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-20
 * @author liangbing.tao
 * @version 1.0
 */
%>


<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>

<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager,
				com.chinacreator.sysmgrcore.manager.LogManager,
				com.chinacreator.sysmgrcore.manager.OrgManager,
				com.chinacreator.sysmgrcore.entity.Organization,
				com.chinacreator.security.AccessControl,
				com.chinacreator.sysmgrcore.entity.User,
				com.chinacreator.sysmgrcore.manager.SecurityDatabase,
				com.chinacreator.sysmgrcore.manager.db.GroupCacheManager,
				com.chinacreator.sysmgrcore.manager.db.RoleCacheManager,
				com.chinacreator.sysmgrcore.manager.db.OrgCacheManager,
				com.chinacreator.security.authorization.impl.AppSecurityCollaborator"%>

<%
	//System.out.println("����ɾ����������");
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	
	UserManager userManager = SecurityDatabase.getUserManager();
	
	String userId = request.getParameter("checks");
	String orgId = request.getParameter("orgId");
	
	String[] userIds = userId.split(",");
	String delUserIds = "";

	String userNamesNo = "";
	
		
	//��־��¼start
	String curUserName = accesscontroler.getUserName();
	String operContent = "";        
    String operSource = accesscontroler.getMachinedID();
    String openModle = "�û�����";
    
    LogManager logManager = SecurityDatabase.getLogManager(); 
    OrgManager orgManager = SecurityDatabase.getOrgManager();
    
    String orgname = orgManager.getOrgById(orgId).getRemark5();
    
    //added by С�� 20100824
    //�������
    AppSecurityCollaborator appSecurityCollaborator = AppSecurityCollaborator
	.getInstance();
    GroupCacheManager groupCacheManager = GroupCacheManager.getInstance();
    RoleCacheManager roleCacheManager =RoleCacheManager.getInstance();
    OrgCacheManager orgCacheManager=OrgCacheManager.getInstance();
    //add end
    long startdate = System.currentTimeMillis();
    for(int i = 0; i < userIds.length; i++){
    	User user = userManager.getUserById(userIds[i]);
    	String userOrgInfo = userManager.userOrgInfo(accesscontroler,userIds[i]);
    	if("".equals(userOrgInfo)){
    		
    		Organization userMainOrg = orgManager.getMainOrganizationOfUser(user.getUserName());
    		if(null!=userMainOrg && orgId.equals(userMainOrg.getOrgId())){    	
    		operContent=curUserName +" �ӻ����� "+ orgname +" �г���ɾ�����û�: "+user.getUserName(); 
    		
			logManager.log(accesscontroler.getUserAccount() ,operContent,openModle,operSource,""); 
			
			if("".equals(delUserIds)){
				delUserIds = userIds[i];
			}else{
				delUserIds += "," + userIds[i];
			}
			}else{
				userNamesNo = "ɾ��ʧ�ܣ�����û�("+user.getUserName()+")��������ɾ�����û���";
				break;
			}
		}else{
			if("".equals(userNamesNo)){
				userNamesNo = "�����û�ɾ��ʧ��:\\n" + user.getUserRealname() + ":" + userOrgInfo;
			}else{
				userNamesNo += "\\n" +  user.getUserRealname() + ":" + userOrgInfo;
			}
		}
	}
    //������� added by С�� 20100824
	// �û���ˢ�»���
	groupCacheManager.reset();
	// ��ɫ����ˢ��
	roleCacheManager.reset();
	// ��������ˢ��
	orgCacheManager.reset();
	// �����ɫ����Դ�����Ļ����ϵ
	appSecurityCollaborator.resetPermissionCache();
	// ����û��ͽ�ɫ�Ļ����ϵ
	appSecurityCollaborator.resetAuthCache();
    //add end 
	long enddate = System.currentTimeMillis();
	//��־��¼end
	//System.out.println((enddate - startdate)/1000);
	String[] delUserId = delUserIds.split(",");
	boolean state = false;
	if("".equals(userNamesNo.trim())){
		state = userManager.deleteBatchUser(delUserId);
	}
	
%>

<script language="javascript">
	<%
	if("".equals(userNamesNo)){
	if(state){%>
		alert("ɾ���û��ɹ���");
		parent.parent.win.close();
		parent.window.location.reload();
	<%}else{%>
		alert("ɾ��ʧ�ܣ�");
		parent.parent.win.close();
		parent.window.location.reload();
	<%}}else{%>
		alert("<%=userNamesNo%>");
		parent.parent.win.close();
		parent.window.location.reload();
	<%}%>
</script>