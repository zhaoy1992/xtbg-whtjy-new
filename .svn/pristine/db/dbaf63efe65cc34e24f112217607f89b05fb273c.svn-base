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
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>



<%		
		AccessControl control = AccessControl.getInstance();
		control.checkManagerAccess(request,response);
		
		String userId = control.getUserID();			
	
		String roleId = request.getParameter("roleId");
		String orgId = request.getParameter("orgId");
		String jobIds = request.getParameter("jobIds");
		
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
		
		String[] jobids = StringUtil.split(jobIds,",");
		
			         
		boolean flag = false;
		
		DBUtil db = new DBUtil();
		try
		{
			db.setAutoCommit(false);

			String sql ="";
			
			db.beginTransaction();
			
			//批处理增加或删除数据			
			if(tag.equals("add"))
			{
				for(int i=0; i< jobids.length; i++)
				{
					sql = "insert into TD_SM_ORGJOBROLE values('" + 
							orgId + "','" + jobids[i] + "','" + roleId + "','" + userId + "')";
					db.addBatch(sql);
				}
				db.executeBatch();
				flag = true;
			}
			
			if(tag.equals("delete"))
			{
				for(int j=0 ; j< jobids.length; j++)
				{
					sql = "delete from TD_SM_ORGJOBROLE o where o.ORG_ID = '" + orgId +
										"' and o.JOB_ID = '" + jobids[j] + "' and o.ROLE_ID = '" + roleId + "'"; 
					db.addBatch(sql);					
				}
				db.executeBatch();
				flag = true;
			}	
			db.commitTransaction();		
		}
		catch(Exception e)
		{
			flag = false;
			
			db.rollbackTransaction();
			
			e.printStackTrace();
		}
		finally
		{
			db.setAutoCommit(true);
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