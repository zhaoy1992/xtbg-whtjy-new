
/**
 * 
 * <p>Title: ��ɢ�û�ɾ������ҳ��</p>
 *
 * <p>Description: ��ɢ�û�ɾ������ҳ��</p>
 *
 * <p>Copyright: Copyright (c) 2007</p>
 *
 * <p>Company: chinacreator</p>
 * @Date 2006-9-15
 * @author biaoping.yin
 * @version 1.0
 */
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="java.util.*,com.chinacreator.sysmgrcore.entity.*,com.chinacreator.sysmgrcore.web.struts.form.*"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager
				,com.chinacreator.sysmgrcore.manager.LogManager,com.chinacreator.sysmgrcore.manager.OrgManager,com.chinacreator.sysmgrcore.purviewmanager.db.PurviewManagerImpl" %>
<%@ page import="com.frameworkset.util.StringUtil,com.chinacreator.security.*,java.sql.Date,com.chinacreator.config.ConfigManager,com.chinacreator.security.event.ACLEventType"%>


<%	
String msg= null;
List allMessage = new ArrayList();
int flag = 0;
try
{
	//action start
			
			AccessControl control = AccessControl.getInstance();
			control.checkManagerAccess(request,response);
			//��ȡҪɾ�����û�
			String[] ids = request.getParameterValues("checkBoxOne");
			//System.out.println(ids);
			//System.out.println(ids.length);
			UserManager userManager = SecurityDatabase.getUserManager();
			
			
			User user = null;
			
			
			
			
			for(int i = 0;  i < ids.length; i ++)
			{
				
				user = userManager.getUserById(ids[i]);
				if(user == null)
				{
					allMessage.add("�û���" + ids[i] + "��������,����ɾ����");
					continue;
				}
				//��ȡ�û��Ƿ���Ա�ɾ��,����ϵͳУ��ӿڣ���֤�û��Ƿ���Ա�ɾ��
				List message = PurviewManagerImpl.getBussinessCheck().userDeleteCheck(control,ids[i]);
				if(message != null && message.size()> 0)
				{
					allMessage.addAll(message);
					continue;
				}
				
				
				userManager.deleteUser(user);
				flag ++;
				//--�ӻ�����ɾ���û���¼��־
				String operContent="";        
		        String operSource=control.getMachinedID();
		        String openModle="�û�����";
		        LogManager logManager = SecurityDatabase.getLogManager(); 
				operContent=control.getUserAccount() +" ɾ������ɢ�û�: "+user.getUserName(); 
		        logManager.log(control.getUserAccount(),operContent,openModle,operSource);       
		        //-------------
		        //ɾ���û����µ��û������û������������´���---�������ϵ��td_sm_userjoborg,td_sm_orgmanager��
			}
			if(flag > 0) //������ɢ�û�ɾ���¼�
			{
				ConfigManager.getEventHandle().change("ɾ����ɢ�û�",ACLEventType.USER_INFO_DELETE);
			}
			
			
			
	//action end
	}
	catch(Exception e)
	{
			//e.printStackTrace();
			allMessage.add(e.getMessage());
	}
	
	if(allMessage != null)
	{
		if(flag > 0)
		{		
			allMessage.add("ʵ��ɾ���û�[" + flag + "]����");
		}
		if(allMessage.size() > 0)
		{
			//System.out.println("allMessage.size():" + allMessage.size());
			
			StringBuffer str = new StringBuffer();
			
			msg =  StringUtil.buildStringMessage(allMessage);
			
			//System.out.println("allMessage:" + msg);
			%>
		<script language="javascript">
			alert("������ɣ�\n<%=msg%>");			
			parent.resetwindow();
		</script>
		<%
		}
		else
		{
			%>
		<script language="javascript">
			alert("�������");			
			//parent.resetbutton();
		</script>
		<%
		}	
		
	
	}
	
	
%>
