<%
/*
 * <p>Title: 角色授予用户组的保存数据页面</p>
 * <p>Description: 角色授予用户组的保存数据页面</p>
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
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>


<%
		AccessControl control = AccessControl.getInstance();
		control.checkManagerAccess(request,response);
		
		String userId = control.getUserID();
		
		String roleId = request.getParameter("roleId");
		
		String groupId = request.getParameter("groupId");
		String[] groupIds = null ;
		
		if(groupId != null && !groupId.equals(""))
		{
			groupIds = groupId.split(",");
		}
		
		String tag = request.getParameter("tag");
		
		
		//---------------START--角色管理写操作日志
		String operContent="";        
        String operSource=control.getMachinedID();
        String openModle="角色管理";
        String userName = control.getUserName();
        LogManager logManager = SecurityDatabase.getLogManager(); 	
		String roleName_log = LogGetNameById.getRoleNameByRoleId(roleId);
		operContent=userName+" 对角色  "+ roleName_log+"  对应的用户组进行了操作"; 						
		logManager.log(control.getUserAccount(),operContent,openModle,operSource,"");          
		//---------------END
		
		
		boolean flag = false;
		
		if(tag !=null && !tag.equals("") && (tag.equals("add")))
		{
			DBUtil dBUtil = new DBUtil();
			try
			{
				for(int i=0; i< groupIds.length; i++)
				{
					String sql = "insert into td_sm_grouprole values(" + groupIds[i] + ", '" + roleId + "','" + userId + "')";
					dBUtil.executeInsert(sql);				
				}
				
				flag = true;
			}
			catch(Exception e)
			{
				flag = false;
				e.printStackTrace();
			}
		}
		
		if(tag !=null  && !tag.equals("") &&  tag.equals("delete"))
		{
			
			DBUtil dBUtil = new DBUtil();
			
			try
			{
				for(int i=0 ; i<groupIds.length ; i++)
				{
					String sql = "delete from td_sm_grouprole f where f.group_id=" + groupIds[i] + " and f.role_id='" + roleId + "'";
					dBUtil.executeDelete(sql);			
				}
				flag = true;
			}
			catch(Exception e)
			{
				e.printStackTrace();
				flag = false;
			}
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