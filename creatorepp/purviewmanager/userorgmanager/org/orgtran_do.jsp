
<%@page import="com.chinacreator.sysmgrcore.manager.db.OrgCacheManager"%><%
/**
 * <p>Title: ����ת��ҳ��</p>
 * <p>Description: ����ת�ƴ���ҳ��</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-17
 * @author da.wei
 * @version 1.0
 **/
 %>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl
				,com.chinacreator.sysmgrcore.entity.Organization
				,com.frameworkset.common.poolman.DBUtil
				,com.chinacreator.sysmgrcore.manager.OrgManager
				,com.chinacreator.sysmgrcore.manager.LogManager
				,com.chinacreator.sysmgrcore.manager.SecurityDatabase
				,com.chinacreator.sysmgrcore.manager.LogGetNameById"%>
<%
		//boolean tag = false;
		AccessControl control = AccessControl.getInstance();
				control.checkManagerAccess(request,response);
		String tag = "0";
		boolean flag=true;
		String notice = "ת��ʧ�ܣ�����ϵ����Ա��";
		
		String parentId = request.getParameter("parentId");
		String orgId = request.getParameter("orgId");
		Organization org = OrgCacheManager.getInstance().getOrganization(orgId);
		
		String remark5 = org==null?"":org.getRemark5();
		OrgManager orgManger = SecurityDatabase.getOrgManager();
		//����ת��ʱ�ж��Ƿ�����ʾ����ͬ���Ļ���
		//baowen.liu
		DBUtil db=new DBUtil();
		db.executeSelect("select remark5 from TD_SM_ORGANIZATION org where PARENT_ID='"+parentId+"' and remark5='"+remark5+"'");
		if( db.size()> 0 ){
		  notice = "�˻������Ѵ�����ͬ�Ļ�����ʾ����";
		  flag=false;
		}
		
		if(flag){
			
			
			flag = orgManger.tranOrg(orgId,parentId);
			
			if(flag){
				tag = "2";
				//��¼��־
				//---------------START--
				
				String operContent="";        
		        String operSource=control.getMachinedID();
		        String openModle="��������";
		        String userName = control.getUserName();
		        LogManager logManager = SecurityDatabase.getLogManager(); 
		        operContent=userName+"  ��������"+LogGetNameById.getOrgNameByOrgId(orgId)+" ת�Ƶ�������"+LogGetNameById.getOrgNameByOrgId(parentId)+" ��"; 
		        logManager.log(control.getUserAccount() ,operContent,openModle,operSource,""); 
				//---------------END
			}
        
		}	
		if(tag.equals("1"))
		{
			%>
			<script>
			    alert("���ܽ�����ת�Ƹ�������!");
			</script>
			<%
		}
		else if(tag.equals("2"))
		{
		%>
			<script>
			    alert("ת�Ƴɹ�!");
			    //parent.flashSelf("<%=orgId%>","<%=parentId%>");
			</script>
		<%
		}
		else
		{
		%>
			<script>
			    alert("<%=notice%>");
			</script>
		<%
		}
	%>
<script>
    window.onload = function prompt(){
		//parent.document.getElementById("tranSaveButton").disabled = false;
		//parent.document.getElementById("tranBackButton").disabled = false;
    }
</script>