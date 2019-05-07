<%
/*
 * <p>Title: 删除用户</p>
 * <p>Description: 删除用户</p>
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
	//System.out.println("彻底删除！！！！");
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	
	UserManager userManager = SecurityDatabase.getUserManager();
	
	String userId = request.getParameter("checks");
	String orgId = request.getParameter("orgId");
	
	String[] userIds = userId.split(",");
	String delUserIds = "";

	String userNamesNo = "";
	
		
	//日志记录start
	String curUserName = accesscontroler.getUserName();
	String operContent = "";        
    String operSource = accesscontroler.getMachinedID();
    String openModle = "用户管理";
    
    LogManager logManager = SecurityDatabase.getLogManager(); 
    OrgManager orgManager = SecurityDatabase.getOrgManager();
    
    String orgname = orgManager.getOrgById(orgId).getRemark5();
    
    //added by 小猪 20100824
    //清除缓冲
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
    		operContent=curUserName +" 从机构： "+ orgname +" 中彻底删除了用户: "+user.getUserName(); 
    		
			logManager.log(accesscontroler.getUserAccount() ,operContent,openModle,operSource,""); 
			
			if("".equals(delUserIds)){
				delUserIds = userIds[i];
			}else{
				delUserIds += "," + userIds[i];
			}
			}else{
				userNamesNo = "删除失败！请从用户("+user.getUserName()+")的主机构删除该用户！";
				break;
			}
		}else{
			if("".equals(userNamesNo)){
				userNamesNo = "以下用户删除失败:\\n" + user.getUserRealname() + ":" + userOrgInfo;
			}else{
				userNamesNo += "\\n" +  user.getUserRealname() + ":" + userOrgInfo;
			}
		}
	}
    //清除缓冲 added by 小猪 20100824
	// 用户组刷新缓冲
	groupCacheManager.reset();
	// 角色缓冲刷新
	roleCacheManager.reset();
	// 机构缓冲刷新
	orgCacheManager.reset();
	// 清除角色和资源操作的缓冲关系
	appSecurityCollaborator.resetPermissionCache();
	// 清除用户和角色的缓冲关系
	appSecurityCollaborator.resetAuthCache();
    //add end 
	long enddate = System.currentTimeMillis();
	//日志记录end
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
		alert("删除用户成功！");
		parent.parent.win.close();
		parent.window.location.reload();
	<%}else{%>
		alert("删除失败！");
		parent.parent.win.close();
		parent.window.location.reload();
	<%}}else{%>
		alert("<%=userNamesNo%>");
		parent.parent.win.close();
		parent.window.location.reload();
	<%}%>
</script>