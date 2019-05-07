<%@ page contentType="text/html; charset=GBK" %>
<%@page import="java.util.*"%>
<%@page import="com.frameworkset.util.StringUtil"%>
<%@page import="com.chinacreator.sysmgrcore.manager.UserManager"%>
<%@page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.sysmgrcore.entity.User"%>
<%@page import="com.chinacreator.sysmgrcore.exception.ManagerException,com.chinacreator.security.authentication.EncrpyPwd"%>
<%@ page import="com.chinacreator.sysmgrcore.web.tag.UserSearchList" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.db.OrgAdministratorImpl,
				com.chinacreator.sysmgrcore.entity.Organization,
				com.chinacreator.sysmgrcore.manager.OrgManager" %>
<%	   
		System.out.println("hello");
      	String loginName = StringUtil.replaceNull(request.getParameter("loginName"));
      	String passWord    = StringUtil.replaceNull(request.getParameter("passWord"));
      	AccessControl accesscontroler = AccessControl.getInstance();
      	accesscontroler.checkManagerAccess(request,response);
      	
      	
		
		UserManager userManager = SecurityDatabase.getUserManager();
		
        try{
            User user = userManager.getUserByName(loginName);
            String orgAdmin = null;
            if(user==null){
	            %>
	            <script language="javascript" type="text/javascript">
	             	parent.window.alert("修改用户密码失败！\系统不存在该用户！");
	            </script>  
	            <%
	            return;
            }
            OrgManager orgManager = SecurityDatabase.getOrgManager();
	        Organization org = orgManager.getMainOrganizationOfUser(loginName);
	      	String orgId = org.getOrgId();
	      	List  secondOrgs = null;
	      	 if(!accesscontroler.isAdmin())
	      	 {
		      	if(org == null)
		      	{
					secondOrgs = orgManager.getSecondOrganizationsOfUser(loginName);
					boolean flag = false;
					for(int i = 0; secondOrgs !=null && i < secondOrgs.size(); i ++)
					{
						Organization secondOrg = (Organization)secondOrgs.get(i);
						if( new OrgAdministratorImpl().userAdminOrg(accesscontroler.getUserID(),secondOrg.getOrgId()))	      		
						{
						
							flag = true;
							break;
						}
			      	}
			      	
			      	if(!flag){
			      			orgAdmin = "对不起,您不是系统管理员也不是用户'" + loginName + "'所在机构及其上级机构的管理员,不能修改该用户的密码!";
			      			 %>
			            	<script language="javascript" type="text/javascript">
			             			parent.window.alert("<%=orgAdmin%>");
			            	</script> 
		            		<%
		            		return;
			      		}	
		      	}
		      	else
		      	{
		           
	            	if(! new OrgAdministratorImpl().userAdminOrg(accesscontroler.getUserID(),orgId)){
		      			orgAdmin = "对不起,您不是系统管理员也不是用户'" + loginName + "'所在机构及其上级机构的管理员,不能修改该用户的密码!";
		      			 %>
		            	<script language="javascript" type="text/javascript">
		             			parent.window.alert("<%=orgAdmin%>");
		            	</script> 
	            		<%
	            		return;
		      		}
		      		            
		      	}
		      }
            user.setUserPassword(passWord);
            UserManager manager =SecurityDatabase.getUserManager();
            manager.updateUserPassword(user);
            //如果是系统帐户修改自己的密码,则将刷新session中的密码
            if(loginName.equals(accesscontroler.getUserAccount())) 
            accesscontroler.refreshPassword(EncrpyPwd.encodePassword(passWord));
            accesscontroler.updateMailPassword(user.getUserEmail(),passWord);
            System.out.println("hello");
             %>                 
            <script language="javascript" type="text/javascript">
                         	alert("该用户的密码已经成功修改，用户需要用新的密码登陆！");
            </script>      	
                     
         <%}
         catch(Exception e){
         		e.printStackTrace();%>
             <script language="javascript" type="text/javascript">
                         	parent.window.alert("修改用户密码失败！\n可能是数据库联接失败，请您稍候重新登陆后重新修改！");
             </script>                 
	<% }
%>
