<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@page import="com.frameworkset.util.StringUtil"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@page import="com.chinacreator.sysmgrcore.manager.OrgManager,com.chinacreator.sysmgrcore.manager.JobManager"%>
<%@page import="com.chinacreator.sysmgrcore.entity.Organization,com.chinacreator.sysmgrcore.entity.Job"%>
<%@page import="com.chinacreator.sysmgrcore.purviewmanager.GenerateServiceFactory"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
		AccessControl control = AccessControl.getInstance();
		control.checkAccess(request,response);
		String isExist = "false";
		if ( request.getAttribute("isExist") != null){
			isExist = "true";
		}
		String orgId = StringUtil.replaceNull(request.getParameter("orgId"),"");
		OrgManager orgManager = SecurityDatabase.getOrgManager();
		Organization org = orgManager.getOrgById(orgId);
		String orgNumber = org.getOrgnumber();
		
		String remark1 = org.getChargeOrgId();
		String remark2 = org.getSatrapJobId();
		String orgname;
		String ispartybussiness = org.getIspartybussiness();
		String jobname ;//
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
		
		String errorMsg = "";
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
				try{
					orgnumber = GenerateServiceFactory.getOrgNumberGenerateService().generateOrgNumber(parentOrg);
				}catch(Exception e){
					errorMsg = control.formatErrorMsg(e.getMessage());
				}
			}else{
				orgnumber = parentOrgNumber;
			}
			//��������ų���
			parentOrgNumberLength = parentOrgNumber.length();
			maxOrgNumberLength = parentOrgNumberLength + len;
		}
		if(!errorMsg.equals("")){
		%>
			<script>
				alert('�޸�ʧ�ܣ��������£�\n<%=errorMsg%>');
			</script>
		<%	
			return;
		}
%>
<html>
<head>     
<title>��������</title>
<script language="javaScript" src="<%=request.getContextPath()%>/sysmanager/scripts/validateForm.js"></script> 
<script language="JavaScript">
//������ڵ�һ��text
function init(){
		form2.orgnumber.focus();
	}
	
function back(){
		//document.forms[0].action="<%=rootpath%>/orgmanager/org.do?method=getOrgInfo&orgId=<%=orgId%>";
		//document.forms[0].submit();
		history.go(-1);
	}

var isExist = "<%=isExist%>";
	if ( isExist == "true" ){
		alert("��������Ѵ��ڣ�����������!");
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
function modifyorg(){
	var orgnumber = form2.orgnumber.value;
	var orgName = form2.orgName.value;
	var orgSn = form2.orgSn.value;
	var orgdesc = form2.orgdesc.value;
	var jp = form2.jp.value;
	var qp = form2.qp.value;		
	var remark5 = form2.remark5.value;
	var layer = form2.layer.value;
	var org_xzqm = form2.org_xzqm.value;
		if (trim(orgnumber).length == 0 ){
	    alert("������Ų���Ϊ�գ�"); 
		return false;
		}
		//orgnumber.search(/[^0-9A-Za-z]/g)
		if(orgnumber.search(/[^0-9]/g) !=-1){
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
		if (trim(org_xzqm).length == 0 ){
	    alert("�������벻��Ϊ�գ�"); 
		return false;
		}
		if(org_xzqm.search(/[^0-9]/g) !=-1){
		alert("��������ֻ��������!");
		form1.org_xzqm.focus();
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
		if(org_xzqm.length>10)
		{
			alert("�����������,������10�ַ�����!");
			return;
		}
	 
	var orgId= document.forms[0].orgId.value;	
	
	document.forms[0].action="<%=rootpath%>/orgmanager/org.do?method=updateOrg";
	document.forms[0].submit();
	}
	
	function addorg(){
		window.open('../sysmanager/orgmanager/chargeOrg.jsp?displayNameInput=chargeName&displayValueInput=chargeOrgId&displayNameInput1=chargejobName&displayValueInput1=satrapJobId','newWin','scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250')

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
<link href="../sysmanager/css/tab.winclassic.css" rel="stylesheet" type="text/css">
<link href="../sysmanager/css/windows.css" rel="stylesheet" type="text/css">
<link href="../sysmanager/css/contentpage.css" rel="stylesheet" type="text/css">

</head>

<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" onload="init()">
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
		<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
  <tr >    
    <td align="center" class="detailtitle">�������*</td>
    <td class="detailcontent"><input name="orgnumber" type="text" 
				  cnname="�������" value="<pg:cell colName="orgnumber"  defaultValue=""/>"
				  <%if(orgNumberHiberarchy && parentOrgId.equals("0")){
				  		out.print("readonly='true' ");
				  	}else if(orgNumberHiberarchy){
				  		out.print("onblur='checkOrgNumber(this)'");
				  	}
				   %>></td>	
	<td align="center" class="detailtitle">��������*</td>
    <td class="detailcontent"><input name="orgName" type="text" 
				 validator="string" cnname="��������" value="<pg:cell colName="orgName"  defaultValue=""/>"></td></tr>
  <tr>
    <td align="center" class="detailtitle">���������*</td>
    <td class="detailcontent"><input name="orgSn" type="text" 
				  value="<pg:cell colName="orgSn"  defaultValue=""/>" readonly></td>	
	<td align="center" class="detailtitle">��������</td>
    <td class="detailcontent"><input name="orgdesc" type="text" 
				  value="<pg:cell colName="orgdesc"  defaultValue=""/>"></td></tr>
  <tr>
    <td align="center" class="detailtitle">��ƴ</td>
    <td class="detailcontent"><input name="jp" type="text" 
				  value="<pg:cell colName="jp"  defaultValue=""/>"></td>	
	<td align="center" class="detailtitle">ȫƴ</td>
    <td class="detailcontent"><input name="qp" type="text" 
				  value="<pg:cell colName="qp"  defaultValue=""/>"></td>
 </tr>
	<tr>
    <td align="center" class="detailtitle">������Ч��־</td>
	<td class="detailcontent">
		<select name="remark3">
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
	
	<tr>
    <td align="center" class="detailtitle">�Ƿ�ֱ����</td>
    <td class="detailcontent">
    	<select name="isdirectlyparty">
    		<option label="" value="0" <pg:equal colName="isdirectlyparty" value="0">selected</pg:equal> >��
    		<option label="" value="1" <pg:equal colName="isdirectlyparty" value="1">selected</pg:equal> >��
    	</select>
	</td>	
	<td align="center" class="detailtitle">�Ƿ������</td>
    <td class="detailcontent">
    	<select name="isforeignparty">
    		<option label="" value="0" <pg:equal colName="isforeignparty" value="0">selected</pg:equal> >��
    		<option label="" value="1" <pg:equal colName="isforeignparty" value="1">selected</pg:equal> >��
    	</select>
	</td>	   
  </tr>
  <tr>
    <td align="center" class="detailtitle">�Ƿ�����</td>
    <td class="detailcontent">
    	<select name="isjichaparty">
    		<option label="" value="0" <pg:equal colName="isjichaparty" value="0">selected</pg:equal> >��
    		<option label="" value="1" <pg:equal colName="isjichaparty" value="1">selected</pg:equal> >��
    	</select>
	</td>	
	<td align="center" class="detailtitle">�Ƿ�ֱ�ӹܻ���λ</td>
    <td class="detailcontent">
    	<select name="isdirectguanhu">
    		<option label="" value="0" <pg:equal colName="isdirectguanhu" value="0">selected</pg:equal> >��
    		<option label="" value="1" <pg:equal colName="isdirectguanhu" value="1">selected</pg:equal> >��
    	</select>
	</td>	   
  </tr>
	
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
  <input type=hidden name=chargeOrgId value=1>
<input type=hidden name=chargejobName value=1>
	   
 	<!-- <td align="center" class="detailtitle">����</td>
    <td class="detailcontent"><input name="layer" type="text" readonly="true"
				  value="<pg:cell colName="layer"  defaultValue=""/>"></td>	-->
	<input type=hidden name=layer value=<pg:cell colName="layer"  defaultValue=""/>>
	
	<td align="center" class="detailtitle">��������</td>
    <td class="detailcontent">
    	<select name="org_level">
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
    	<input name="org_xzqm" type="text" value="<pg:cell colName="org_xzqm"  defaultValue=""/>">
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
    	<input name="org_xzqm" validator="int" cnname="��������" type="text" value="<pg:cell colName="org_xzqm"  defaultValue=""/>">
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
    	<input name="org_xzqm"  cnname="��������" type="text" value="<pg:cell colName="org_xzqm"  defaultValue=""/>">
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
    	<input name="org_xzqm" type="text" validator="int" cnname="��������" value="<pg:cell colName="org_xzqm"  defaultValue=""/>">
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
    	<input name="org_xzqm" type="text" validator="int" cnname="��������" value="<pg:cell colName="org_xzqm"  defaultValue=""/>">
    </td>
</tr>
<%
}
%>
  
  <tr>     
          <td align="center" colspan="4">               	
      <input name="Submit1" type="button" class="input" value="����" onclick="modifyorg()"> 
      <input name="Submit2" type="button" class="input" value="����" onclick="back()">
      </td></tr></table></pg:beaninfo>
</form>
</center></div>


</body>
</html>