<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@page import="com.frameworkset.util.StringUtil"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request,response);
	String suborgstr = (String) session.getAttribute("suborgstr");
	String isExist = "false";
	if ( request.getAttribute("isExist") != null){
		isExist = "true";
	}
%>
<html>
<head>

<title>ϵͳ����</title>
  <link rel="stylesheet" type="text/css" href="../css/windows.css">
  <link rel="stylesheet" type="text/css" href="../css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
  <link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
  <link rel="stylesheet" type="text/css" href="../sysmanager/css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../sysmanager/css/tab.winclassic.css">
<style type="text/css">
<!--
.style1 {color: #CC0000}
-->
</style>
</head>

<script language="javaScript" src="<%=request.getContextPath()%>/sysmanager/scripts/validateForm.js"></script>
<script language="JavaScript">
	var isExist = "<%=isExist%>";
	if ( isExist == "true" ){
		alert("��������Ѵ��ڣ�����������!");
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
	function saveorg()
	{		
		var orgnumber = form1.orgnumber.value;
		var orgName = form1.orgName.value;
		var orgSn = form1.orgSn.value;
		var orgdesc = form1.orgdesc.value;
		var jp = form1.jp.value;
		var qp = form1.qp.value;		
		var remark5 = form1.remark5.value;
		var layer = form1.layer.value;
		var org_xzqm = form1.org_xzqm.value;
		
		//if(orgnumber.search(/[^0-9]/g) !=-1){
		//alert("�������ֻ��������!");
		//form1.orgnumber.focus();
		//return false;
		//}
		//(orgnumber.search(/[^0-9A-Za-z]/g)
		if(orgnumber.search(/[^0-9]/g) !=-1){
		alert("�������ֻ��������!");
		form2.orgnumber.focus();
		return false;
		}
		if(orgSn.search(/[^0-9]/g) !=-1){
		alert("���������ֻ��������!");
		form1.orgSn.focus();
		return false;
		}
		if(jp.search(/[^A-Za-z]/g) !=-1){
		alert("��ƴֻ�ܰ�����ĸ!");
		form1.jp.focus();
		return false;
		}
		if(qp.search(/[^A-Za-z]/g) !=-1){
		alert("ȫƴֻ�ܰ�����ĸ!");
		form1.qp.focus();
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
		
		var suborgstr = document.forms[0].suborgstr.value;
		var suborgs = suborgstr.split(",");
		if(validateForm(form1)){
			
		    var orgName = document.forms[0].orgName.value;
		  
		    for(var i=0;i<suborgs.length;i++){
		    
		    	if(orgName==suborgs[i]){
		    		alert("�ӻ����Ѵ�����ͬ������,����������");
		    		return;
		    	}
		    }
		  	document.forms[0].action="<%=request.getContextPath()%>/orgmanager/org.do?method=saveOrg";
			document.forms[0].submit();
		
	    }
	}
	function addorg(){
		window.open('../orgmanager/chargeOrg.jsp?displayNameInput=chargeName&displayValueInput=chargeOrgId&displayNameInput1=chargejobName&displayValueInput1=satrapJobId','newWin','scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250')

	}
	function back(){
		document.forms[0].action="../orgmanager/organsearch.jsp";
		document.forms[0].submit();
	}
</script>
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
<div id="contentborder" align="center">

<!-- <center>�½��ӻ���</center> -->
<form name="form1" action="" method="post"  >	
<pg:beaninfo requestKey="Organization">
	      <input type="hidden"  name="suborgstr" value="<%=suborgstr%>" />
		 <input type="hidden"  name="orgId" value="<pg:cell colName="orgId"  defaultValue=""/>" />
		 <input type="hidden"  name="parentId" value="<pg:cell colName="parentId"  defaultValue=""/>" />		
		 <input type="hidden"  name="children" value="<pg:cell colName="children"  defaultValue=""/>" />		 
		 
		 <input type="hidden"  name="creator" value="<pg:cell colName="creator"  defaultValue=""/>" />
		 <input type="hidden"  name="creatingtime" value="<pg:cell colName="creatingtime" dateformat="yyyy-MM-dd"  defaultValue="<%=new java.util.Date()%>"/>">

		<input type="hidden"  name="path" value="<pg:cell colName="path"  defaultValue=""/>" />
		<input type="hidden"  name="code" value="<pg:cell colName="code"  defaultValue=""/>" />
		<input type="hidden"  name="remark1" value="<pg:cell colName="remark1"  defaultValue=""/>" />
		<input type="hidden"  name="remark2" value="<pg:cell colName="remark2"  defaultValue=""/>" />
					
 <table cellspacing="1" cellpadding="0" border="0" bordercolor="#EEEEEE" width=100% class="thin">
  <tr>    
    <td align="center" class="detailtitle">�������*</td>
    <td class="detailcontent"><input name="orgnumber" type="text" 
				  cnname="�������" value="<pg:cell colName="orgnumber"  defaultValue=""/>"></td>	
	<td align="center" class="detailtitle">��������*</td>
    <td class="detailcontent"><input name="orgName" type="text" 
				 validator="string" cnname="��������" value="<pg:cell colName="orgName"  defaultValue=""/>"></td>	   
  </tr>
  <tr >
  <!--  
    <td align="center"  class="detailtitle">���������*</td>
    <td class="detailcontent"><input name="orgSn" type="text" 
				  validator="int" cnname="���������" value="<pg:cell colName="orgSn"  defaultValue=""/>"></td>
  -->	
  <input name="orgSn" type="hidden" 
				  validator="int" cnname="���������" value="1">
	<td align="center" class="detailtitle">��������</td>
    <td class="detailcontent"><input name="orgdesc" type="text" 
				  value="<pg:cell colName="orgdesc"  defaultValue=""/>"></td>	   
  </tr>
  <tr  >
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
			<option label="" value="1">��Ч
			<option label="" value="0">��Ч
		</select>
	</td>
	<td align="center" class="detailtitle">������ʾ����*</td> 
    <td class="detailcontent"><input name="remark5" type="text" 
				 validator="string" cnname="������ʾ����" value="<pg:cell colName="remark5"  defaultValue=""/>"></td>	
	<input type=hidden name=layer value=1>
	<input type=hidden name=ispartybussiness value=0>
  </tr>
  
  <tr>
    <td align="center" class="detailtitle">�Ƿ�ֱ����</td>
    <td class="detailcontent">
    	<select name="isdirectlyparty">
    		<option label="" value="0">��
    		<option label="" value="1">��
    	</select>
	</td>	
	<td align="center" class="detailtitle">�Ƿ������</td>
    <td class="detailcontent">
    	<select name="isforeignparty">
    		<option label="" value="0">��
    		<option label="" value="1">��
    	</select>
	</td>	   
  </tr>
  <tr>
    <td align="center" class="detailtitle">�Ƿ�����</td>
    <td class="detailcontent">
    	<select name="isjichaparty">
    		<option label="" value="0">��
    		<option label="" value="1">��
    	</select>
	</td>	
	<td align="center" class="detailtitle">�Ƿ�ֱ�ӹܻ���λ</td>
    <td class="detailcontent">
    	<select name="isdirectguanhu">
    		<option label="" value="0">��
    		<option label="" value="1">��
    	</select>
	</td>	   
  </tr>
  
  <tr>
	<!-- <td align="center" class="detailtitle">ҵ�����</td>
    <td class="detailcontent">
	<dict:select type="ispartybussiness" name="ispartybussiness" defaultValue="0"/>
	</td> -->
    <!-- <tr>     
 	<td align="center" class="detailtitle">���ܴ���</td>
    <td class="detailcontent">
			<input name="chargeOrgId" type="hidden" readonly="true" onClick="addorg()" value="<pg:cell colName="chargeOrgId"  defaultValue=""/>" >
			<input name="chargeName" type="text" readonly="true" width="30%"  onClick="addorg()" value="<pg:cell colName="chargeName"  defaultValue=""/>" >
			
	</td>	
	<td align="center" class="detailtitle">���ܸ�λ</td>
    <td class="detailcontent">
			<input name="satrapJobId" type="hidden"  readonly="true" onClick="addorg()" value="<pg:cell colName="satrapJobId"  defaultValue=""/>" >
			<input name="chargejobName" type="text" readonly="true" width="30%" onClick="addorg()"  value="<pg:cell colName="chargejobName"  defaultValue=""/>" >
	</td>	   
	</tr> -->
	<input type=hidden name=chargeOrgId value=1>
	<input type=hidden name=chargejobName value=1>
 	<!-- <td align="center" class="detailtitle">����</td>
    <td class="detailcontent"><input name="layer" type="text" readonly="true"
				  value="1"></td>	-->
     
	<td align="center" class="detailtitle">��������</td>
    <td class="detailcontent">
    	<select name="org_level">
    		<option label="" value="1">ʡ��
    		<option label="" value="2">���ݼ�
    		<option label="" value="3">������
    		<option label="" value="4">������
    		<option label="" value="0">�������
    	</select>
	</td> 
	<td align="center" class="detailtitle">��������*</td>
    <td class="detailcontent">
    	<input name="org_xzqm"  cnname="��������" type="text" value="<pg:cell colName="org_xzqm"  defaultValue=""/>">
    </td>
   </tr>      
   <tr>     
          <td align="center" colspan="4"><div align="center">
             <input name="Submit" type="button" class="input" value="����" onclick="saveorg()">        	
             <input name="Submit" type="button" class="input" value="����" onclick="back()">                  
                     
           	    </td>
                     
  </tr>
</table>					
</pg:beaninfo>
</form>
</div>
</body>

</html>