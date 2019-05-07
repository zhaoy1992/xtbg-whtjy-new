<% 
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0); 
%>
<%@page import="com.chinacreator.config.ConfigManager"%><%
/**
 * <p>Title: �޸Ļ�����Ϣҳ��</p>
 * <p>Description: �޸Ļ�����Ϣҳ��</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-17
 * @author da.wei
 * @version 1.0
 **/
 %>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@page import="com.frameworkset.util.StringUtil"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@page import="com.chinacreator.sysmgrcore.manager.OrgManager,com.chinacreator.sysmgrcore.manager.JobManager"%>
<%@page import="com.chinacreator.sysmgrcore.entity.Organization,com.chinacreator.sysmgrcore.entity.Job"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.sysmgrcore.manager.db.OrgManagerImpl"%>
<%@page import="com.chinacreator.sysmgrcore.manager.UserManager"%>
<%@page import= "com.chinacreator.sysmgrcore.entity.User"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.chinacreator.sysmgrcore.purviewmanager.GenerateServiceFactory"%>

   
	
<%
		AccessControl control = AccessControl.getInstance();
		control.checkManagerAccess(request,response);
		
		//�Ƿ����  "�Ƿ�˰��Ա" ��ѡ��
		boolean istaxmanager = ConfigManager.getInstance().getConfigBooleanValue("istaxmanager", false);
		String isExist = "false";
		if ( request.getAttribute("isExist") != null){
			isExist = "true";
		}
		
		//�ж��Ƿ���cmsϵͳ
		String subSystemId  = control.getCurrentSystemID();
		
		String orgId = StringUtil.replaceNull(request.getParameter("orgId"),"");
	      
	     //�жϵ�½�û��Ƿ����ڵ�ǰ����,�����ֹ�޸Ļ�����Ϣ(��������ʾ������)
	     //2008-4-8 baowen.liu
		OrgManager orgManager1 = new OrgManagerImpl();
		String isDisabled = "";
		
		List orgs = orgManager1.getOrgListOfUser(control.getUserID());
		if(!control.isAdmin() && orgs.size()>0){
			for (Iterator iter = orgs.iterator(); iter.hasNext();){
			      Organization org1= (Organization) iter.next();
				    if(org1.getOrgId().equals(orgId)){
				    	isDisabled = "disabled='true'";
				    	
				    }
			 }		
		}
		OrgManager orgManager = SecurityDatabase.getOrgManager();
		Organization org = orgManager.getOrgById(orgId);
		request.setAttribute("updateOrgInfo", org);
			
		String orgNumber = org.getOrgnumber();
		
		String remark1 = org.getChargeOrgId();
		String remark2 = org.getSatrapJobId();
		String orgname;
		String ispartybussiness = org.getIspartybussiness();
		String jobname ;//
		
		//��ȡ����������ID
		String orgCreator = org.getCreator();
		UserManager userManager = SecurityDatabase.getUserManager();
		User user = userManager.getUserById(orgCreator);
		String userName = user.getUserName();
		String userRealName = user.getUserRealname();
		
		userName = userName == null ? "����" : userName ;
		userRealName = userRealName == null ? "����" : userRealName;
		String creatorMessage = userName + "��" + userRealName + "��" ;
		
		
		
		if(remark1==null || "null".equals(remark1) || "".equals(remark1)){
			orgname = "����";
		}else{
			Organization org1 = orgManager.getOrgById(remark1);
			if(org1==null){
				orgname = "����";
			}else{
				orgname = org1.getOrgName();	
			}
		}
	
		if(remark2==null || "null".equals(remark2) || "".equals(remark2)){
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
		String parentOrgId = org.getParentId();
		String parent_org_level = "666";
		Organization parentOrg = orgManager.getOrgById(parentOrgId);
		if(parentOrg!=null)
		{
			parent_org_level = parentOrg.getOrg_level();
		}
		if(parent_org_level == null)
		{
			parent_org_level = "666";
		}
		
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
		
		
		//Ĭ�����ɵĻ�������
		String orgnumber = "";
		int len = GenerateServiceFactory.getOrgNumberGenerateService().getOrgNumberLen();
		//�����Ƿ���ڲ㼶��ϵ
		boolean orgNumberHiberarchy = GenerateServiceFactory.getOrgNumberGenerateService().enableOrgNumberGenerate();
		int parentOrgNumberLength = 0;
		int maxOrgNumberLength = 0;
		String parentOrgNumber = "";  
		if(!parentOrgId.equals("0")){
			parentOrgNumber = parentOrg.getOrgnumber();
			if(orgNumberHiberarchy){
				orgnumber = GenerateServiceFactory.getOrgNumberGenerateService().generateOrgNumber(parentOrg);
			}else{
				orgnumber = parentOrgNumber;
			}
			//��������ų���
			parentOrgNumberLength = parentOrgNumber.length();
			maxOrgNumberLength = parentOrgNumberLength + len;
		}
%>
<html>
<head>     
<title>������Ϣ�޸�</title>
<style type="text/css">
			<!--
			.style1 {color: #CC0000}
			-->
		</style>
<script language="javaScript" src="../../scripts/validateForm.js"></script> 
<script language="JavaScript">
	//������ڵ�һ��text
	function init(){
	   
		form2.orgnumber.focus();
	}
	
	function trim(string){
		  var temp="";
		  string = ''+string;
		  splitstring = string.split(" ");
		  for(i=0;i<splitstring.length;i++){
		    temp += splitstring[i];
		  } 
		  return temp;
	}
	
	function enable(){
		form2.isjichaparty.disabled = true ;
		form2.remark3.disabled = true ;
		form2.isforeignparty.disabled = true ;
		form2.isdirectlyparty.disabled = true;
		form2.isdirectguanhu.disabled = true;
		form2.org_level.disabled = true;
		
		form2.orgnumber.disabled = true;
		form2.orgName.disabled = true;
		form2.orgSn.disabled = true;
		form2.orgdesc.disabled = true;
		form2.jp.disabled = true;
		form2.qp.disabled = true;
		form2.org_xzqm.disabled = true;
	}
	
	function modifyorg(){
	
		//form2.isjichaparty.disabled = false ;
		//form2.remark3.disabled = false ;
		//form2.isforeignparty.disabled = false ;
		//form2.isdirectlyparty.disabled = false ;
		//form2.isdirectguanhu.disabled = false ;
		//form2.org_level.disabled = false ;
		
		//form2.orgnumber.disabled = false ;
		//form2.orgName.disabled = false ;
		//form2.orgSn.disabled = false ;
		//form2.orgdesc.disabled = false ;
		//form2.jp.disabled = false ;
		//form2.qp.disabled = false ;
		//form2.org_xzqm.disabled = false ;
		
		var orgnumber = form2.orgnumber.value;
		var orgName = form2.orgName.value;
		var orgSn = form2.orgSn.value;
		var orgdesc = form2.orgdesc.value;
		var jp = form2.jp.value;
		var qp = form2.qp.value;		
		var remark5 = form2.remark5.value;
		var layer = form2.layer.value;
		
		if (trim(orgnumber).length == 0 ){
	    alert("������Ų���Ϊ�գ�"); 
		return false;
		}
		if(orgnumber.search(/[^0-9A-Za-z]/g) !=-1){
		alert("�������ֻ�������ֺ���ĸ!");
		form2.orgnumber.focus();
		return false;
		}
		if (trim(orgName).length == 0 ){
	    alert("�������Ʋ���Ϊ�գ�"); 
		return false;
		} 
		if (trim(orgSn).length == 0 ){
	    alert("��������Ų���Ϊ�գ�"); 
		return false;
		}
		if(orgSn.search(/[^0-9]/g) !=-1){
		alert("���������ֻ��������!");
		form2.orgSn.focus();
		return false;
		}
		if (trim(remark5).length == 0 ){
	    alert("������ʾ���Ʋ���Ϊ�գ�"); 
		return false;
		}
		if(jp.search(/[^A-Za-z]/g) !=-1){
		alert("��ƴֻ�ܰ�����ĸ!");
		form2.jp.focus();
		return false;
		}
		if(qp.search(/[^A-Za-z]/g) !=-1){
		alert("ȫƴֻ�ܰ�����ĸ!");
		form2.qp.focus();
		return false;
		}   
		if(orgnumber.length>100)
		{
			alert("������Ź���,������100�ַ�����!");
			return;
		}
		if(orgName.length>40)
		{
			alert("�������ƹ���,������40�ַ�����!");
			return;
		}
		if(orgdesc.length>300)
		{
			alert("������������,������300�ַ�����!");
			return;
		}
		if(jp.length>40)
		{
			alert("��ƴ����,������40�ַ�����!");
			return;
		}
		if(qp.length>40)
		{
			alert("ȫƴ����,������40�ַ�����!");
			return;
		}
		if(remark5.length>100)
		{
			alert("���ܸ�λ����,������100�ַ�����!");
			return;
		}
		if(layer.length>200)
		{
			alert("���ι���,������200�ַ�����!");
			return;
		}
		
		
		var org_xzqm_obj = form2.org_xzqm;
		if(org_xzqm_obj != null)
		{
			var org_xzqm = org_xzqm_obj.value ;
			if (trim(org_xzqm).length == 0 )
			{
		    	alert("�������벻��Ϊ�գ�"); 
				return false;
			}
			if(org_xzqm.search(/[^0-9]/g) !=-1)
			{
				alert("��������ֻ��������!");
				org_xzqm_obj.focus();
				return false;
			}
			if(org_xzqm.length>10)
			{
				alert("�����������,������10�ַ�����!");
				return;
			}
		}
		 
		var orgId= document.forms[0].orgId.value;
		
		document.all.divProcessing.style.display = "block";
		document.all.saveButton.disabled = true;
		document.all.resetButton.disabled = true;
		document.all.backButton.disabled = true;
	  	document.forms[0].action = "modifyorg_do.jsp";
		document.forms[0].target = "hiddenFrame";
		document.forms[0].submit();
		
	}
	
	function checkOrgNumber(obj){
		var val = obj.value;
		var cruLength = val.length;
		var maxLength = "<%=maxOrgNumberLength%>";
		var subOrg = val.substring(0,<%=parentOrgNumberLength%>);
		if(subOrg != "<%=parentOrgNumber%>"){
			alert("��������ǰ��λ�����븸����������ͬ\n����������Ϊ��<%=parentOrgNumber%>");
			obj.value = "<%=orgnumber%>";
			obj.focus();
			return;
		}
		if(cruLength != maxLength){
			alert("�������볤��ֻ���Ǹ��������볤�ȼ�<%=len%>λ��\n�û������볤��ֻ����"+maxLength+"λ����");
			obj.value = val.substring(0,maxLength);
			obj.focus();
			return;
		}
		
	}
</script>
<%
	

%>
<link rel="stylesheet" type="text/css" href="../../css/windows.css">
<link rel="stylesheet" type="text/css" href="../../css/treeview.css">
</head>

<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" <%if(isDisabled.equals("")) {%> onload="init()" <%}%>>
<div id="contentborder" >
<center>
<form name="form2" action="" method="post"  >	
<pg:beaninfo requestKey="updateOrgInfo">
	      
		 <input type="hidden"  name="orgId" value="<pg:cell colName="orgId"  defaultValue=""/>"/> 
		 <input type="hidden"  name="parentId" value="<pg:cell colName="parentId"  defaultValue=""/>" />
		 <input type="hidden"  name="orgNumber" value="<%=orgNumber%>" /> 
		 <input type="hidden"  name="children" value="<pg:cell colName="children"  defaultValue=""/>" /> 
		 <input type="hidden"  name="creator" value="<pg:cell colName="creator"  defaultValue=""/>" /> 
		 <input type="hidden"  name="creatingtime" value="<pg:cell colName="creatingtime" dateformat="yyyy-MM-dd"  defaultValue="<%=new java.util.Date()%>"/>"> 
		 <input type="hidden"  name="remark1" value="<pg:cell colName="remark1"  defaultValue=""/>" /> 
		 <input type="hidden"  name="remark2" value="<pg:cell colName="remark2"  defaultValue=""/>" /> 
		 <input type="hidden"  name="path" value="<pg:cell colName="path"  defaultValue=""/>" /> 
		 <input type="hidden"  name="code" value="<pg:cell colName="code"  defaultValue=""/>" /> 
		 <input type="hidden"  name="oldOrgname" value="<pg:cell colName="orgName"  defaultValue=""/>" />
		 <input type="hidden"  name="oldremark5" value="<pg:cell colName="remark5"  defaultValue=""/>" />
		 <input type=hidden name=layer value=<pg:cell colName="layer"  defaultValue=""/>>
		 <input type=hidden name=chargeOrgId value=1>
		 <input type=hidden name=chargejobName value=1>
		<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
  <tr >    
    <td align="center" class="detailtitle">�������*</td>
    <td class="detailcontent"><input name="orgnumber" <%=isDisabled%> type="text" 
				 validator="string" cnname="�������" value="<pg:cell colName="orgnumber"  defaultValue=""/>"
				 <%if(orgNumberHiberarchy && parentOrgId.equals("0")){
				  		out.print("readonly='true' ");
				  	}else if(orgNumberHiberarchy){
				  		out.print("onblur='checkOrgNumber(this)'");
				  	}
				   %>></td>	
	<td align="center" class="detailtitle">��������*</td>
    <td class="detailcontent"><input name="orgName" <%=isDisabled%> type="text" 
				 validator="string" cnname="��������" value="<pg:cell colName="orgName"  defaultValue=""/>"></td></tr>
  <tr>
    <td align="center" class="detailtitle">���������*</td>
    <td class="detailcontent"><input name="orgSn" <%=isDisabled%> type="text"  readonly
				  value="<pg:cell colName="orgSn"  defaultValue=""/>"></td>	
	<td align="center" class="detailtitle">��������</td>
    <td class="detailcontent"><input name="orgdesc" <%=isDisabled%> type="text" 
				  value="<pg:cell colName="orgdesc"  defaultValue=""/>"></td></tr>
  <tr>
    <td align="center" class="detailtitle">��ƴ</td>
    <td class="detailcontent"><input name="jp" <%=isDisabled%> type="text" 
				  value="<pg:cell colName="jp"  defaultValue=""/>"></td>	
	<td align="center" class="detailtitle">ȫƴ</td>
    <td class="detailcontent"><input name="qp" <%=isDisabled%> type="text" 
				  value="<pg:cell colName="qp"  defaultValue=""/>"></td>
 </tr>
	<tr>
    <td align="center" class="detailtitle">������Ч��־</td>
	<td class="detailcontent">
		<select name="remark3" <%=isDisabled%> >
			<option label="" value="0" 
			<pg:equal colName="remark3" value="0">selected </pg:equal>>��Ч
			<option label="" value="1" 
			<pg:equal colName="remark3" value="1">selected </pg:equal>>��Ч
    	</select>
	</td>
	<td align="center" class="detailtitle">������ʾ����*</td>
    <td class="detailcontent"><input name="remark5" type="text" 
				 validator="string" cnname="������ʾ����" value="<pg:cell colName="remark5"  defaultValue=""/>"></td>
	</tr>
	<input type=hidden name=ispartybussiness value=0>
	<%
		if(!"cms".equals(subSystemId))
		{
	%>
	<%if(istaxmanager){ %>
	<tr>
    <td align="center" class="detailtitle">�Ƿ�ֱ����</td>
    <td class="detailcontent">
    	<select name="isdirectlyparty" <%=isDisabled%> >
    		<option label="" value="0" <pg:equal colName="isdirectlyparty" value="0">selected</pg:equal> >��
    		<option label="" value="1" <pg:equal colName="isdirectlyparty" value="1">selected</pg:equal> >��
    	</select>
	</td>	
	<td align="center" class="detailtitle">�Ƿ������</td>
    <td class="detailcontent">
    	<select name="isforeignparty" <%=isDisabled%> >
    		<option label="" value="0" <pg:equal colName="isforeignparty" value="0">selected</pg:equal> >��
    		<option label="" value="1" <pg:equal colName="isforeignparty" value="1">selected</pg:equal> >��
    	</select>
	</td>	   
  </tr>
  <tr>
    <td align="center" class="detailtitle">�Ƿ�����</td>
    <td class="detailcontent">
    	<select name="isjichaparty" <%=isDisabled%> >
    		<option label="" value="0" <pg:equal colName="isjichaparty" value="0">selected</pg:equal> >��
    		<option label="" value="1" <pg:equal colName="isjichaparty" value="1">selected</pg:equal> >��
    	</select>
	</td>	
	<td align="center" class="detailtitle">�Ƿ�ֱ�ӹܻ���λ</td>
    <td class="detailcontent">
    	<select name="isdirectguanhu" <%=isDisabled%> >
    		<option label="" value="0" <pg:equal colName="isdirectguanhu" value="0">selected</pg:equal> >��
    		<option label="" value="1" <pg:equal colName="isdirectguanhu" value="1">selected</pg:equal> >��
    	</select>
	</td>	   
  </tr>
  <%} %>
	<tr>
	<!-- <td align="center" class="detailtitle">ҵ�����</td>
    <td class="detailcontent">
	<dict:select type="ispartybussiness" name="ispartybussiness" expression="{ispartybussiness}"/>
	</td> -->
   
   <!-- <tr>
    <td align="center" class="detailtitle">���ܴ���</td>
    <td class="detailcontent">
			<input name="chargeOrgId" type="hidden" readonly="true" onClick="addorg()" value="<pg:cell colName="chargeOrgId"  defaultValue=""/>">
			<input name="chargeName" type="text" readonly="true" width="30%" onClick="addorg()" value="<%=orgname%>" >
			
    </td>	
	<td align="center" class="detailtitle">���ܸ�λ</td>
    <td class="detailcontent">
			<input name="satrapJobId" type="hidden" readonly="true" onClick="addorg()" value="<pg:cell colName="satrapJobId"  defaultValue=""/>">
			<input name="chargejobName" type="text" readonly="true" width="30%"  onClick="addorg()" value="<%=jobname%>" >
			
	</td>
  </tr> -->
 	<!-- <td align="center" class="detailtitle">����</td>
    <td class="detailcontent"><input name="layer" type="text" readonly="true"
				  value="<pg:cell colName="layer"  defaultValue=""/>"></td>	-->
	
	<td align="center" class="detailtitle">��������</td>
    <td class="detailcontent">
    	<select name="org_level" <%=isDisabled%> >
    		<%
    		if(parent_org_level.equals("666"))
    		{
    		%>
    			<option label="" value="1" <pg:equal colName="org_level" value="1">selected</pg:equal> >ʡ��
	    		<option label="" value="2" <pg:equal colName="org_level" value="2">selected</pg:equal>>���ݼ�
	    		<option label="" value="3" <pg:equal colName="org_level" value="3">selected</pg:equal>>������
	    		<option label="" value="4" <pg:equal colName="org_level" value="4">selected</pg:equal>>������
	    		<option label="" value="0" <pg:equal colName="org_level" value="0">selected</pg:equal>>�������
    		<%
    		}
    		else if(parent_org_level.equals("1"))
    		{
    		%>
    		<pg:equal colName="org_level" value="1">
    			<option label="" value="1" selected>ʡ��
    		</pg:equal>
    		<option label="" value="2" <pg:equal colName="org_level" value="2">selected</pg:equal>>���ݼ�
    		<option label="" value="3" <pg:equal colName="org_level" value="3">selected</pg:equal>>������
    		<option label="" value="4" <pg:equal colName="org_level" value="4">selected</pg:equal>>������
    		<option label="" value="0" <pg:equal colName="org_level" value="0">selected</pg:equal>>�������
    		<%
    		}
    		else if(parent_org_level.equals("2"))
    		{
    		%>
    		<pg:equal colName="org_level" value="1">
    			<option label="" value="1" selected>ʡ��
    		</pg:equal>
    		<pg:equal colName="org_level" value="2">
    			<option label="" value="2" selected>���ݼ�
    		</pg:equal>
    		<option label="" value="3" <pg:equal colName="org_level" value="3">selected</pg:equal>>������
    		<option label="" value="4" <pg:equal colName="org_level" value="4">selected</pg:equal>>������
    		<option label="" value="0" <pg:equal colName="org_level" value="0">selected</pg:equal>>�������
    		<%
    		}
    		else if(parent_org_level.equals("3"))
    		{
    		%>
    		
    		<pg:equal colName="org_level" value="1">
    			<option label="" value="1" selected>ʡ��
    		</pg:equal>
    		<pg:equal colName="org_level" value="2">
    			<option label="" value="2" selected>���ݼ�
    		</pg:equal>
    		
    		<pg:equal colName="org_level" value="3">
    			<option label="" value="3" selected>������
    		</pg:equal>
    		<option label="" value="4" <pg:equal colName="org_level" value="4">selected</pg:equal>>������
    		<option label="" value="0" <pg:equal colName="org_level" value="0">selected</pg:equal>>�������
    		<%
    		}
    		else if(parent_org_level.equals("4"))
    		{
    		%>
    		
    		<pg:equal colName="org_level" value="1">
    			<option label="" value="1" selected>ʡ��
    		</pg:equal>
    		<pg:equal colName="org_level" value="2">
    			<option label="" value="2" selected>���ݼ�
    		</pg:equal>
    		
    		<pg:equal colName="org_level" value="3">
    			<option label="" value="3" selected>������
    		</pg:equal>
    		
    		<pg:equal colName="org_level" value="4">
    			<option label="" value="4" selected>������
    		</pg:equal>
    		<option label="" value="0" <pg:equal colName="org_level" value="0">selected</pg:equal>>�������
    		<%
    		}
    		else
    		{
    		%>
    		
    		<pg:equal colName="org_level" value="1">
    			<option label="" value="1" selected>ʡ��
    		</pg:equal>
    		<pg:equal colName="org_level" value="2">
    			<option label="" value="2" selected>���ݼ�
    		</pg:equal>
    		
    		<pg:equal colName="org_level" value="3">
    			<option label="" value="3" selected>������
    		</pg:equal>
    		
    		<pg:equal colName="org_level" value="4">
    			<option label="" value="4" selected>������
    		</pg:equal>
    		<option label="" value="0" <pg:equal colName="org_level" value="0">selected</pg:equal>>�������
    		<%
    		}
    		%>
    		
    	</select>
	</td>   
	
		<!-- ������ʾ���ܻ��� -->
		<%
		if(org.getOrg_level().equals("1"))
		{
		%>
	<td align="center" class="detailtitle">��������*</td>
    <td class="detailcontent">
    	<input name="org_xzqm" <%=isDisabled%> type="text" value="<pg:cell colName="org_xzqm"  defaultValue=""/>">
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
	<td align="center" class="detailtitle">��������*</td>
    <td class="detailcontent">
    	<input name="org_xzqm"  <%=isDisabled%>  type="text" value="<pg:cell colName="org_xzqm"  defaultValue=""/>">
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
    <td align="center" class="detailtitle">��������*</td>
    <td class="detailcontent">
    	<input name="org_xzqm"  <%=isDisabled%>  <%=isDisabled%> type="text" value="<pg:cell colName="org_xzqm"  defaultValue=""/>">
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
	<td align="center" class="detailtitle">��������*</td>
    <td class="detailcontent">
    	<input name="org_xzqm" type="text" <%=isDisabled%> validator="int" cnname="��������" value="<pg:cell colName="org_xzqm"  defaultValue=""/>">
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
    <td align="center" class="detailtitle">��������*</td>
    <td class="detailcontent">
    	<input name="org_xzqm" type="text" <%=isDisabled%> validator="int" cnname="��������" value="<pg:cell colName="org_xzqm"  defaultValue=""/>">
    </td>
</tr>
	<%
		}
	}
	else
	{
	%>
		<input type="hidden" name="isdirectlyparty" value="<pg:cell colName="isdirectlyparty" defaultValue=""/>"/>
		<input type="hidden" name="isforeignparty" value="<pg:cell colName="isforeignparty" defaultValue=""/>"/>
		<input type="hidden" name="isjichaparty" value="<pg:cell colName="isjichaparty" defaultValue=""/>"/>
		<input type="hidden" name="isdirectguanhu" value="<pg:cell colName="isdirectguanhu" defaultValue=""/>"/>
		<input type="hidden" name="org_level" value="<pg:cell colName="org_level" defaultValue=""/>"/>
		<input type="hidden" name="org_xzqm" value="<pg:cell colName="org_xzqm" defaultValue=""/>"/>
	<%
	}
	%>
  <tr>
		<td align="center" class="detailtitle">����������</td>
	    <td class="detailcontent" colspan="3">
	    	<input type="text" readonly="true" value="<%=creatorMessage%>">
	    </td>   
   </tr>
  <tr>     
          <td align="center" colspan="4">               	
      <input name="saveButton" type="button" class="input" value="����" onclick="modifyorg()"> 
      <input name="resetButton" type="button" class="input" value="����" onclick="reset()">
      <input name="backButton" type="button" class="input" value="����" onclick="window.close()">
      </td></tr></table></pg:beaninfo>
</form>
</center></div>
<div id=divProcessing style="width:200px;height:30px;position:absolute;left:200px;top:260px;display:none">
			<table border=0 cellpadding=0 cellspacing=1 bgcolor="#000000" width="100%" height="100%">
				<tr>
					<td bgcolor=#3A6EA5>
						<marquee align="middle" behavior="alternate" scrollamount="5">
							<font color=#FFFFFF>...������...��ȴ�...</font>
						</marquee>
					</td>
				</tr>
			</table>
		</div>
</body>
<iframe name="hiddenFrame" width=0 height=0></iframe>
</html>