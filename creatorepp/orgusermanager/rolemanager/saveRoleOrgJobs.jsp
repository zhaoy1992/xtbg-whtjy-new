<%
/*
 * <p>Title: ��ɫ���������ĺ�̨����ҳ��</p>
 * <p>Description: ��ɫ���������ĺ�̨����ҳ��</p>
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
		
		//---------------START--��ɫ����д������־
		String operContent="";        
        String operSource=control.getMachinedID();
        String openModle="��ɫ����";
        String userName = control.getUserName();
        LogManager logManager = SecurityDatabase.getLogManager(); 	
		String roleName_log = LogGetNameById.getRoleNameByRoleId(roleId);
		operContent=userName+" �Խ�ɫ  "+ roleName_log+"  ��Ӧ�Ļ��������˲���"; 						
		logManager.log(control.getUserAccount() ,operContent,openModle,operSource,""); 
		
		String[] jobids = StringUtil.split(jobIds,",");
		
			         
		boolean flag = false;
		
		DBUtil db = new DBUtil();
		try
		{
			db.setAutoCommit(false);

			String sql ="";
			
			db.beginTransaction();
			
			//���������ӻ�ɾ������			
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
			alert("�����ɹ�!");
		}
		else
		{
			alert("����ʧ��!");
		}
		
       	parent.divProcessing.style.display="none";
        parent.document.all("button1").disabled = false;
		parent.document.all("button2").disabled = false;
		parent.document.all("button3").disabled = false;
		parent.document.all("button4").disabled = false;
		parent.document.all("back").disabled = false;
    }
</script>