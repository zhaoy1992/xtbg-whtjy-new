<%
/**
 * <p>Title: ������Ϣ�鿴</p>
 * <p>Description: ������Ϣ�鿴</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-17
 * @author da.wei
 * @version 1.0
 **/
 %>
 <%     
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0); 
%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@page import="com.frameworkset.util.StringUtil"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@page import="com.chinacreator.sysmgrcore.manager.OrgManager,
				com.chinacreator.sysmgrcore.manager.OrgAdministrator,
				com.chinacreator.sysmgrcore.manager.db.OrgAdministratorImpl,
				com.chinacreator.sysmgrcore.manager.JobManager,
				com.chinacreator.sysmgrcore.manager.UserManager,
				com.chinacreator.config.ConfigManager"%>
<%@page import="com.chinacreator.sysmgrcore.entity.Organization,
				com.chinacreator.sysmgrcore.entity.Job,
				com.chinacreator.sysmgrcore.entity.User"%>
<%@ page import="com.chinacreator.security.*"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.ldap.OrgManagerImpl" %>

<%
		AccessControl accesscontroler = AccessControl.getInstance();
	    accesscontroler.checkManagerAccess(request,response);
		//�Ƿ����  "�Ƿ�˰��Ա" ��ѡ��
		boolean istaxmanager = ConfigManager.getInstance().getConfigBooleanValue("istaxmanager", false);
		String userId = accesscontroler.getUserID();
		String action = StringUtil.replaceNull(request.getParameter("action"),"");
		String orgId = StringUtil.replaceNull(request.getParameter("orgId"),"");
		String parentId = StringUtil.replaceNull(request.getParameter("parentId"),"0");
		if(parentId.equals(""))parentId="0";
		
		//�ж��Ƿ���cmsϵͳ
		String subSystemId = accesscontroler.getCurrentSystemID();
		
		OrgManager orgManager = SecurityDatabase.getOrgManager();
		session.setAttribute("Organization", orgManager.getOrgById(orgId));
		
		//�жϵ�ǰ��½�û��ܷ����ǰ����
		OrgAdministrator orgAdministrator = new OrgAdministratorImpl();
		boolean butFlag = orgAdministrator.userAdminOrg(userId,orgId);
				
		Organization org = orgManager.getOrgById(orgId);
		String remark1 = org.getChargeOrgId();
		String remark2 = org.getSatrapJobId();
		String orgname = "";
		String jobname = "";
		
		//��ȡ����������ID
		String orgCreator = org.getCreator();
		UserManager userManager = SecurityDatabase.getUserManager();
		User user = userManager.getUserById(orgCreator);
		String userName = user.getUserName();
		String userRealName = user.getUserRealname();
		
		userName = userName == null ? "����" : userName ;
		userRealName = userRealName == null ? "����" : userRealName;
		
		String creatorMessage = userName + "��" + userRealName + "��" ;
		
		
		if(remark1==null || "null".equals(remark1) || "".equalsIgnoreCase(remark1)){
			orgname = "����";
		}else{
			Organization org1 = orgManager.getOrgById(remark1);
			if(org1==null){
				orgname = "����";
			}else{
				orgname = org1.getOrgName();	
			}
		}
		if(remark2==null || remark2.equals("null")){
			jobname = "����";
		}else{
			JobManager jobManager = SecurityDatabase.getJobManager();
			Job job = jobManager.getJobById(remark2);
			if(job==null){
				jobname = "����";
			}else{
				jobname = job.getJobName();
			}
		}
		String ispartybussiness = "";
		ispartybussiness = org.getIspartybussiness();
		if("1".equals(ispartybussiness)){
			ispartybussiness = "��";
		}
		if("0".equals(ispartybussiness)){
			ispartybussiness = "��";
		}
		
		String remark3 = org.getRemark3();
		if(remark3==null)
		{
			remark3="0";
		}
		if(remark3.equals("1"))
		{
			remark3 = "��Ч";
		}
		else
		{
			remark3 = "��Ч";
		}
		
		String org_level = org.getOrg_level();
		
		String office = "";
		Organization myOrganization = (Organization)orgManager.orgBelongsOfficeDepartment(orgId);		
		if(myOrganization != null){office = myOrganization.getRemark5();}	
		String mini = "";
		myOrganization = (Organization)orgManager.orgBelongsMiniDepartment(orgId);		
		if(myOrganization != null){mini = myOrganization.getRemark5();}		
		String country = "";
		myOrganization = (Organization)orgManager.orgBelongsCountryDepartment(orgId);		
		if(myOrganization != null){country = myOrganization.getRemark5();}		
		String city = "";
		myOrganization = (Organization)orgManager.orgBelongsCityDepartment(orgId);		
		if(myOrganization != null){city = myOrganization.getRemark5();}		
		String province = "";
		myOrganization = (Organization)orgManager.orgBelongsProvinceDepartment(orgId);		
		if(myOrganization != null){province = myOrganization.getRemark5();}
				
		
		//�Ƿ�����ʡ�����Ź���Ա��Ȩ�Ŀ�ͨ����,������������true����ֻ��ʡ�������Ĺ���Ա��ӵ�е�ǰ���¼��������½���ת�ƺ�ɾ���ӻ�����Ȩ��
		//                              ������������false�����κμ���Ļ�������Ա��ӵ�е�ǰ���¼��������½���ת�ƺ�ɾ���ӻ�����Ȩ��
		boolean isProvinceAdminTag = false;
		if(ConfigManager.getInstance().getConfigBooleanValue("enableprovinceadmintequan", false))
		{
			if(myOrganization != null)
			{
				String provinceOrgId = myOrganization.getOrgId();
				isProvinceAdminTag = ( orgAdministrator.isOrgAdmin(userId, provinceOrgId) || accesscontroler.isAdmin());
			}
			else
			{
				isProvinceAdminTag = accesscontroler.isAdmin();
			}
		}	

		else
		{
			isProvinceAdminTag = true;
		}	
 
		if(org_level.equals("1")){org_level="ʡ��";}
		else if(org_level.equals("2")){org_level="���ݼ�";}
		else if(org_level.equals("3")){org_level="������";}
		else if(org_level.equals("4")){org_level="������";}
		else if(org_level.equals("0")){org_level="�������";}
		
		String isdirectlyparty = "";
		if(org.getIsdirectlyparty().equals("1")){	isdirectlyparty = "��";	}
		else{	isdirectlyparty = "��";	}
		String isforeignparty = "";
		if(org.getIsforeignparty().equals("1")){	isforeignparty = "��";	}
		else{	isforeignparty = "��";	}
		String isjichaparty = "";
		if(org.getIsjichaparty().equals("1")){	isjichaparty = "��";	}
		else{	isjichaparty = "��";	}
		String isdirectguanhu = "";
		if(org.getIsdirectguanhu().equals("1")){	isdirectguanhu = "��";	}
		else{	isdirectguanhu = "��";	}
%>
<html>
<head>     
  <title>������Ϣ�鿴</title> 
<script language="JavaScript" src="../../scripts/common.js" type="text/javascript"></script>		
<script language="javaScript" src="../../scripts/validateForm.js"></script> 
<link rel="stylesheet" type="text/css" href="../../css/windows.css">
<link rel="stylesheet" type="text/css" href="../../css/treeview.css">
</head>

<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" onLoad="<%=action.equals("update")?"updateAfter()":""%>">
<div id="contentborder">
<form name="form2" action="" method="post"  >	
<pg:beaninfo sessionKey="Organization">
	      
		 <input type="hidden"  name="orgId" value="<pg:cell colName="orgId"  defaultValue=""/>"/>
		 <input type="hidden"  name="parentId" value="<pg:cell colName="parentId"  defaultValue=""/>" />		
		 <input type="hidden"  name="children" value="<pg:cell colName="children"  defaultValue=""/>" />		 
		 <input type="hidden"  name="creator" value="<pg:cell colName="creator"  defaultValue=""/>" />
		 <input type="hidden"  name="creatingtime" value="<pg:cell colName="creatingtime" dateformat="yyyy-MM-dd"  defaultValue="<%=new java.util.Date()%>"/>">
		 <input type="hidden"  name="path" value="<pg:cell colName="path"  defaultValue=""/>" />
		 <input type="hidden"  name="code" value="<pg:cell colName="code"  defaultValue=""/>" />
		 
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
  <tr >    
    <td align="center" class="detailtitle">�������</td>
    <td class="detailcontent"><input name="orgnumber" type="text" readonly="true"
				 validator="string" cnname="�������" value="<pg:cell colName="orgnumber"  defaultValue=""/>"></td>	
	<td align="center" class="detailtitle">��������</td>
    <td class="detailcontent"><input name="orgName" type="text" readonly="true"
				 validator="string" cnname="��������" value="<pg:cell colName="orgName"  defaultValue=""/>"></td>	   
  </tr>
  <tr>
    <td align="center" class="detailtitle">���������</td>
    <td class="detailcontent"><input name="orgSn" type="text" readonly="true"
				  value="<pg:cell colName="orgSn"  defaultValue=""/>"></td>	
	<td align="center" class="detailtitle">��������</td>
    <td class="detailcontent"><input name="orgdesc" type="text" readonly="true"
				  value="<pg:cell colName="orgdesc"  defaultValue=""/>"></td>	   
  </tr>
  <tr  >
    <td align="center" class="detailtitle">��ƴ</td>
    <td class="detailcontent"><input name="jp" type="text" readonly="true"
				  value="<pg:cell colName="jp"  defaultValue=""/>"></td>	
	<td align="center" class="detailtitle">ȫƴ</td>
    <td class="detailcontent"><input name="qp" type="text" readonly="true"
				  value="<pg:cell colName="qp"  defaultValue=""/>"></td>	   
  </tr> 
 <tr>
    <td align="center" class="detailtitle">������Ч��־</td>
	<td class="detailcontent">
		<input name="remark3" type="text" readonly="true" value="<%=remark3%>">
	</td>
 	<td align="center" class="detailtitle">������ʾ����</td>
    <td class="detailcontent"><input name="remark5" type="text" readonly="true"
				 validator="string" cnname="������ʾ����" value="<pg:cell colName="remark5"  defaultValue=""/>"></td>	
	<input type=hidden name=ispartybussiness value=0>
 </tr>
 <%
 	if(!"cms".equals(subSystemId))
 	{
 %>
 <%if(istaxmanager){ %>
 <tr>
    <td align="center" class="detailtitle">�Ƿ�ֱ����</td>
    <td class="detailcontent"><input name="isdirectlyparty" type="text" readonly="true"
				  value="<%=isdirectlyparty%>"></td>	
	<td align="center" class="detailtitle">�Ƿ������</td>
    <td class="detailcontent"><input name="isforeignparty" type="text" readonly="true"
				  value="<%=isforeignparty%>"></td>	   
  </tr>
  <tr>
    <td align="center" class="detailtitle">�Ƿ�����</td>
    <td class="detailcontent"><input name="isjichaparty" type="text" readonly="true"
				  value="<%=isjichaparty%>"></td>	
	<td align="center" class="detailtitle">�Ƿ�ֱ�ӹܻ���λ</td>
    <td class="detailcontent"><input name="isdirectguanhu" type="text" readonly="true"
				  value="<%=isdirectguanhu%>"></td>	   
  </tr> 
  <%} %>
  
 <tr>	
<input type=hidden name=chargeOrgId value=1>
<input type=hidden name=chargejobName value=1>
	
	<td align="center" class="detailtitle">��������</td>
    <td class="detailcontent">
		<input name="org_level" type="text" readonly="true" value="<%=org_level%>">
	</td>  
 		
	          

<!-- ������ʾ���ܻ��� -->
		<%
		if(org.getOrg_level().equals("1"))
		{
		%>
	<td align="center" class="detailtitle">��������</td>
    <td class="detailcontent">
    	<input name="org_xzqm" type="text" readonly="true" value="<pg:cell colName="org_xzqm"  defaultValue=""/>">
    </td>	   
</tr>
		<%
		}
		else if(org.getOrg_level().equals("2"))
		{
%>  
	<td align="center" class="detailtitle">����ʡ��</td>
    <td class="detailcontent"><input type="text" readonly="true" value=<%=province%>></td>  
</tr>
<tr>
	<td align="center" class="detailtitle">��������</td>
    <td class="detailcontent">
    	<input name="org_xzqm" type="text" readonly="true" value="<pg:cell colName="org_xzqm"  defaultValue=""/>">
    </td>
    <td align="center" class="detailtitle"></td>
    <td class="detailcontent">
    </td>
</tr>
		<%
		}
		else if(org.getOrg_level().equals("3"))
		{
		%>
	<td align="center" class="detailtitle">����ʡ��</td>
    <td class="detailcontent"><input type="text" readonly="true" value=<%=province%>></td>
    </tr>
    <tr>
	<td align="center" class="detailtitle">�������ݾ�</td>
    <td class="detailcontent"><input type="text" readonly="true" value=<%=city%>></td>
    <td align="center" class="detailtitle">��������</td>
    <td class="detailcontent">
    	<input name="org_xzqm" type="text" readonly="true" value="<pg:cell colName="org_xzqm"  defaultValue=""/>">
    </td>	
</tr>
		<%
		}
		else if(org.getOrg_level().equals("4"))
		{
		%>
	<td align="center" class="detailtitle">����ʡ��</td>
    <td class="detailcontent"><input type="text" readonly="true" value=<%=province%>></td>
</tr>
<tr>
	<td align="center" class="detailtitle">�������ݾ�</td>
    <td class="detailcontent"><input type="text" readonly="true" value=<%=city%>></td> 
    <td align="center" class="detailtitle">����������</td>
    <td class="detailcontent"><input type="text" readonly="true" value=<%=country%>></td>
</tr>
<tr>
	<td align="center" class="detailtitle">��������</td>
    <td class="detailcontent">
    	<input name="org_xzqm" type="text" readonly="true" value="<pg:cell colName="org_xzqm"  defaultValue=""/>">
    </td>
    <td align="center" class="detailtitle"></td>
    <td class="detailcontent">
    </td>
</tr>
	<%
	}
	else if(org.getOrg_level().equals("0"))
	{
	%> 
	<td align="center" class="detailtitle">����ʡ��</td>
    <td class="detailcontent"><input type="text" readonly="true" value=<%=province%>></td>
    </tr>
    <tr>
	<td align="center" class="detailtitle">�������ݾ�</td>
    <td class="detailcontent"><input type="text" readonly="true" value=<%=city%>></td>   

 
    <td align="center" class="detailtitle">����������</td>
    <td class="detailcontent"><input type="text" readonly="true" value=<%=country%>></td>
    </tr>
    <tr>
    <td align="center" class="detailtitle">����������</td>
    <td class="detailcontent"><input type="text" readonly="true" value=<%=mini%>></td>
    <td align="center" class="detailtitle">��������</td>
    <td class="detailcontent">
    	<input name="org_xzqm" type="text" readonly="true" value="<pg:cell colName="org_xzqm"  defaultValue=""/>">
    </td>
</tr>
<%
	}
}
%>
	<tr>
		<td align="center" class="detailtitle">����������</td>
	    <td class="detailcontent" colspan="3"><input type="text" readonly="true" value="<%=creatorMessage%>"></td>   
    </tr>
  <tr>     
      <td align="center" colspan="4">
          	<input name="goback" type="button" class="input" value="����" onclick="window.close();">   
      </td> 
  </tr>
</table>	
</pg:beaninfo>
</form>
</div>
</body>
</html>