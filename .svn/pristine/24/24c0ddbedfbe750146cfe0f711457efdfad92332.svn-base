
<%@page import="com.chinacreator.sysmgrcore.manager.db.OrgCacheManager"%><%
/**
 * <p>Title: 机构转移页面</p>
 * <p>Description: 机构转移处理页面</p>
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
		String notice = "转移失败，请联系管理员！";
		
		String parentId = request.getParameter("parentId");
		String orgId = request.getParameter("orgId");
		Organization org = OrgCacheManager.getInstance().getOrganization(orgId);
		
		String remark5 = org==null?"":org.getRemark5();
		OrgManager orgManger = SecurityDatabase.getOrgManager();
		//机构转移时判断是否有显示名称同名的机构
		//baowen.liu
		DBUtil db=new DBUtil();
		db.executeSelect("select remark5 from TD_SM_ORGANIZATION org where PARENT_ID='"+parentId+"' and remark5='"+remark5+"'");
		if( db.size()> 0 ){
		  notice = "此机构下已存在相同的机构显示名称";
		  flag=false;
		}
		
		if(flag){
			
			
			flag = orgManger.tranOrg(orgId,parentId);
			
			if(flag){
				tag = "2";
				//记录日志
				//---------------START--
				
				String operContent="";        
		        String operSource=control.getMachinedID();
		        String openModle="机构管理";
		        String userName = control.getUserName();
		        LogManager logManager = SecurityDatabase.getLogManager(); 
		        operContent=userName+"  将机构："+LogGetNameById.getOrgNameByOrgId(orgId)+" 转移到机构："+LogGetNameById.getOrgNameByOrgId(parentId)+" 下"; 
		        logManager.log(control.getUserAccount() ,operContent,openModle,operSource,""); 
				//---------------END
			}
        
		}	
		if(tag.equals("1"))
		{
			%>
			<script>
			    alert("不能将机构转移给本机构!");
			</script>
			<%
		}
		else if(tag.equals("2"))
		{
		%>
			<script>
			    alert("转移成功!");
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