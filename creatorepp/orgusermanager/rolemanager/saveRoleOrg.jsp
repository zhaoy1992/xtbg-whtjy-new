<%
/*
 * <p>Title: 角色隶属机构的后台处理页面</p>
 * <p>Description: 角色隶属机构的后台处理页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-25
 * @author liangbing.tao
 * @version 1.0
 */
%>


<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogGetNameById"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.*"%>
<%@ page import="com.frameworkset.util.StringUtil"%>



<%		
		AccessControl control = AccessControl.getInstance();
		control.checkManagerAccess(request,response);
	
		String roleId = request.getParameter("roleId");
		String orgId = request.getParameter("orgids");
		String tag = request.getParameter("tag");		
		
		//---------------START--角色管理写操作日志
		String operContent="";        
        String operSource=control.getMachinedID();
        String openModle="角色管理";
        String userName = control.getUserName();
        LogManager logManager = SecurityDatabase.getLogManager(); 	
		String roleName_log = LogGetNameById.getRoleNameByRoleId(roleId);
		operContent=userName+" 对角色  "+ roleName_log+"  对应的机构进行了操作"; 						
		logManager.log(control.getUserAccount() ,operContent,openModle,operSource,""); 
		
		String[] roleids = StringUtil.split(roleId,",");
		String orgids[] = StringUtil.split(orgId,",");
			         
	
		boolean flag = false;
		
		OrgManager orgManager = SecurityDatabase.getOrgManager();
		
		if(tag != null  && !tag.equals("")  && tag.equals("add"))
		{
			flag = orgManager.storeOrgRole(orgids,roleids);
		}
		
		if(tag != null && !tag.equals("") && tag.equals("delete"))
		{
			flag = orgManager.deleteOrgrole(orgids, roleids);
		}
	
%>

<script>
    window.onload = function prompt()
    {    
		if(<%=flag%>)
		{
			alert("操作成功!");
		}
		else
		{
			alert("操作失败!");
		}
		
       	parent.divProcessing.style.display="none";
        parent.document.all("button1").disabled = false;
		parent.document.all("button2").disabled = false;
		parent.document.all("button3").disabled = false;
		parent.document.all("button4").disabled = false;
		parent.document.all("back").disabled = false;
    }
</script>