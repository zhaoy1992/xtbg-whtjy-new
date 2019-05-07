<%@ page contentType="text/html; charset=GBK" %>
<%@page import="java.util.*"%>
<%@page import="com.frameworkset.util.StringUtil"%>
<%@page import="com.chinacreator.sysmgrcore.manager.UserManager"%>
<%@page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.sysmgrcore.entity.User,com.chinacreator.security.authentication.EncrpyPwd"%>
<%@page import="com.chinacreator.epp.applymanager.dbmanager.ApplyManager"%>

<%	
		//UserManager userManager = SecurityDatabase.getUserManager();       
		AccessControl accesscontroler = AccessControl.getInstance();
      	accesscontroler.checkAccess(request,response);     	
      	String userAccount = accesscontroler.getUserAccount();  
		
        //User user = userManager.getUserByName(userAccount);   
        
        ApplyManager applyManager = new ApplyManager();
        User user = applyManager.getEgpUserByUsername(userAccount);
        
      	String oldPassword = StringUtil.replaceNull(request.getParameter("oldPassword"));
      	String passWord    = StringUtil.replaceNull(request.getParameter("passWord")); 
      	if( !EncrpyPwd.encodePassword(oldPassword).equals(user.getUserPassword())){
        	%><script language="javascript" type="text/javascript">
                	parent.window.alert("您输入的原密码不正确！修改无法继续！");
                </script><%
                return;
      	}

        try{

            user.setUserPassword(passWord);
            //UserManager manager =SecurityDatabase.getUserManager();
            
           // manager.updateUserPassword(user); 
            applyManager.updateEgpUserPassword(user);
            accesscontroler.refreshPassword(passWord);
            accesscontroler.updateMailPassword(user.getUserEmail(),passWord);
            %>                 
            <script language="javascript" type="text/javascript">
                         	alert("您的密码已经成功修改!");
                         	               	                              
            </script>      	
                     
            
         <%}catch(Exception e){
         		e.printStackTrace();%>
             <script language="javascript" type="text/javascript">
                         	parent.window.alert("修改用户密码失败！\n可能是数据库联接失败，请您稍候重新登陆后重新修改！");
             </script>                 
	<% }
%>
