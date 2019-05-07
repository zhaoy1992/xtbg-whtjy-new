
<%@page import="com.chinacreator.config.ConfigManager"%>
<%
	 /**
	 * <p>Title: ����һ������</p>
	 * <p>Description: ����һ������ҳ��</p>
	 * <p>Copyright: Copyright (c) 2008</p>
	 * <p>Company: chinacreator</p>
	 * @Date 2008-3-17
	 * @author da.wei
	 * @version 1.0
	 **/
%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.epp.applymanager.dbmanager.ApplyManager"%>
<%@ page import="com.chinacreator.epp.applymanager.vo.Apply"%>
<%@ page import="java.util.List"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkManagerAccess(request, response);

	//�ж��Ƿ���cms
	String subSystemId = control.getCurrentSystemID();

	//�Ƿ����  "�Ƿ�˰��Ա" ��ѡ��
	boolean istaxmanager = ConfigManager.getInstance()
			.getConfigBooleanValue("istaxmanager", false);
	
	// ���ͬ��Ӧ�ù���
	// ��ʢ 2011-7-12		
	// ��ȡ����Ӧ�ö���
	ApplyManager applyManager = new ApplyManager();
	List applyList = null;
	try{
		applyList = applyManager.getApplyList();
	}catch(Exception e){
	}
	boolean isApply = null!=applyList && !applyList.isEmpty();
%>
<html>
	<head>
		<title>��������</title>
		<link rel="stylesheet" type="text/css" href="../../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../../css/treeview.css">
	</head>

	<script language="javaScript" src="../../scripts/validateForm.js"></script>
	<script language="JavaScript">
	
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
	{		//alert("dfasd");
		var orgnumber = form1.orgnumber.value;
		var orgName = form1.orgName.value;
		var orgSn = form1.orgSn.value;
		var orgdesc = form1.orgdesc.value;
		var jp = form1.jp.value;
		var qp = form1.qp.value;		
		var remark5 = form1.remark5.value;
		var layer = form1.layer.value;
		//orgnumber.search(/[^0-9A-Za-z]/g)
		if(orgnumber.search(/[^0-9A-Za-z]/g) !=-1){
		alert("�������ֻ�������ֺ���ĸ!");
		form1.orgnumber.focus();
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
		if(widthCheck(orgnumber,100))
		{
			alert("������Ź���,������100�ַ�����!");
			form1.orgnumber.focus();
			return false;
		}
		if(widthCheck(orgName,40))
		{
			alert("�������ƹ���,������40�ַ�����!");
			form1.orgName.focus();
			return false;
		}
		if(widthCheck(orgdesc,300))
		{
			alert("������������,������300�ַ�����!");
			form1.orgdesc.focus();
			return false;
		}
		if(widthCheck(jp,40))
		{
			alert("��ƴ����,������40�ַ�����!");
			form1.jp.focus();
			return false;
		}
		if(widthCheck(qp,40))
		{
			alert("ȫƴ����,������40�ַ�����!");
			form1.qp.focus();
			return false;
		}
		if(widthCheck(remark5,100))
		{
			alert("���ܸ�λ����,������100�ַ�����!");
			form1.remark5.focus();
			return false;
		}
		if(widthCheck(layer,200))
		{
			alert("���ι���,������200�ַ�����!");
			form1.layer.focus();
			return false;
		}
		
		var org_xzqm_obj = form1.org_xzqm ;
		if(org_xzqm_obj != null)
		{
			
			var org_xzqm = org_xzqm_obj.value;
			
			if(org_xzqm.search(/[^0-9]/g) !=-1){
			alert("��������ֻ��������!");
			org_xzqm_obj.focus();
			return false;
			}
			if(widthCheck(org_xzqm,10))
			{
				alert("�����������,������10�ַ�����!");
				org_xzqm_obj.focus();
				return false;
			}
		}
		
	if(validateForm(form1)){	
		
		    document.all.divProcessing.style.display = "block";
		    document.all.saveButton.disabled = true;
		    document.all.resetButton.disabled = true;
		    document.all.backButton.disabled = true;
		  	document.form1.sel_appid.value = getSelAppid();
		  	document.form1.action = "new_org_do.jsp";
			document.form1.target = "hiddenFrame";
			document.form1.submit();
	    }
	}
	function addorg(){
		window.open('../orgmanager/chargeOrg.jsp?displayNameInput=chargeName&displayValueInput=chargeOrgId&displayNameInput1=chargejobName&displayValueInput1=satrapJobId','newWin','scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250')

	}
	function back(){
		window.returnValue = true;
		window.close();
	}
	//�жϳ����Ƿ�ϸ�
	//s   ������ַ��� 
	//n   ���Ƶĳ���n����
	//����true�����Ⱥϸ�
	function widthCheck(s, n){ 
		var w = 0; 
		for (var i=0; i<s.length; i++) { 
		   var c = s.charCodeAt(i); 
		   //���ֽڼ�1 
		   if ((c >= 0x0001 && c <= 0x007e) || (0xff60<=c && c<=0xff9f)) { 
		    w++; 
		   } 
		   else { 
		    w+=2; 
		   } 
		} 
		if (n > w) { 
		   return false; 
		} 
		return true; 
	}
	// ��ȡѡ��ͬ����Ӧ��ID
	function getSelAppid(){
		var selappid = "";
		if("true"=="<%=isApply%>"){
			var checkboxselappid = document.getElementsByName("checkbox_sel_appid");
			for(var i=0;i<checkboxselappid.length;i++)
			{
				if(checkboxselappid[i].checked)
				{
					selappid += checkboxselappid[i].value+",";
				}
			}	
		}
		return selappid;
	}
</script>
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin" scroll="no">
		<div id="contentborder" align="center">
			<form name="form1" action="" method="post">
				<pg:beaninfo requestKey="Organization">

					<input type="hidden" name="orgId"
						value="<pg:cell colName="orgId"  defaultValue=""/>" />
					<input type="hidden" name="parentId"
						value="<pg:cell colName="parentId"  defaultValue=""/>" />
					<input type="hidden" name="children"
						value="<pg:cell colName="children"  defaultValue=""/>" />

					<input type="hidden" name="creator"
						value="<%=control.getUserID()%>" />
					<input type="hidden" name="creatingtime"
						value="<pg:cell colName="creatingtime" dateformat="yyyy-MM-dd"  defaultValue="<%=new java.util.Date()%>"/>">

					<input type="hidden" name="path"
						value="<pg:cell colName="path"  defaultValue=""/>" />
					<input type="hidden" name="code"
						value="<pg:cell colName="code"  defaultValue=""/>" />
					<input type="hidden" name="remark1"
						value="<pg:cell colName="remark1"  defaultValue=""/>" />
					<input type="hidden" name="remark2"
						value="<pg:cell colName="remark2"  defaultValue=""/>" />

					<table cellspacing="1" cellpadding="0" border="0"
						bordercolor="#EEEEEE" width=100% class="thin">
						<tr>
							<td align="center" class="detailtitle">
								�������*
							</td>
							<td class="detailcontent">
								<input name="orgnumber" type="text" validator="string"
									cnname="�������"
									value="<pg:cell colName="orgnumber"  defaultValue=""/>">
							</td>
							<td align="center" class="detailtitle">
								��������*
							</td>
							<td class="detailcontent">
								<input name="orgName" type="text" validator="string"
									cnname="��������"
									value="<pg:cell colName="orgName"  defaultValue=""/>">
							</td>
						</tr>
						<tr>
							<!-- 
    <td align="center"  class="detailtitle">���������*</td>
    <td class="detailcontent"></td>
				   -->
							<input name="orgSn" type="hidden" value="1">
							<td align="center" class="detailtitle">
								��������
							</td>
							<td class="detailcontent">
								<input name="orgdesc" type="text"
									value="<pg:cell colName="orgdesc"  defaultValue=""/>">
							</td>
						</tr>
						<tr>
							<td align="center" class="detailtitle">
								��ƴ
							</td>
							<td class="detailcontent">
								<input name="jp" type="text"
									value="<pg:cell colName="jp"  defaultValue=""/>">
							</td>
							<td align="center" class="detailtitle">
								ȫƴ
							</td>
							<td class="detailcontent">
								<input name="qp" type="text"
									value="<pg:cell colName="qp"  defaultValue=""/>">
							</td>
						</tr>
						<tr>
							<td align="center" class="detailtitle">
								������Ч��־
							</td>
							<td class="detailcontent">
								<select name="remark3">
									<option label="" value="1">
										��Ч
									<option label="" value="0">
										��Ч
								</select>
							</td>
							<td align="center" class="detailtitle">
								������ʾ����*
							</td>
							<td class="detailcontent">
								<input name="remark5" type="text" validator="string"
									cnname="������ʾ����"
									value="<pg:cell colName="remark5"  defaultValue=""/>">
							</td>
							<input type=hidden name=layer value=1>
							<input type=hidden name=ispartybussiness value=0>
							<input type=hidden name=chargeOrgId value=1>
							<input type=hidden name=chargejobName value=1>
							<input type="hidden" name="sel_appid" value=""/>
						</tr>

						<%
								//���ݹ���ϵͳ�в���Ҫ���ֶ�
								//liangbing.tao 2008-5-27 
								if (!"cms".equals(subSystemId)) {
						%>
						<%
						if (istaxmanager) {
						%>
						<tr>
							<td align="center" class="detailtitle">
								�Ƿ�ֱ����
							</td>
							<td class="detailcontent">
								<select name="isdirectlyparty">
									<option label="" value="0">
										��
									<option label="" value="1">
										��
								</select>
							</td>
							<td align="center" class="detailtitle">
								�Ƿ������
							</td>
							<td class="detailcontent">
								<select name="isforeignparty">
									<option label="" value="0">
										��
									<option label="" value="1">
										��
								</select>
							</td>
						</tr>
						<tr>
							<td align="center" class="detailtitle">
								�Ƿ�����
							</td>
							<td class="detailcontent">
								<select name="isjichaparty">
									<option label="" value="0">
										��
									<option label="" value="1">
										��
								</select>
							</td>
							<td align="center" class="detailtitle">
								�Ƿ�ֱ�ӹܻ���λ
							</td>
							<td class="detailcontent">
								<select name="isdirectguanhu">
									<option label="" value="0">
										��
									<option label="" value="1">
										��
								</select>
							</td>
						</tr>
						<%
						}
						%>
						<tr>

							<td align="center" class="detailtitle">
								��������
							</td>
							<td class="detailcontent">
								<select name="org_level">
									<option label="" value="1">
										ʡ��
									<option label="" value="2">
										���ݼ�
									<option label="" value="3">
										������
									<option label="" value="4">
										������
									<option label="" value="0">
										�������
								</select>
							</td>
							<td align="center" class="detailtitle">
								��������*
							</td>
							<td class="detailcontent">
								<input name="org_xzqm" type="text" validator="num" cnname="��������"
									value="<pg:cell colName="org_xzqm"  defaultValue=""/>">
							</td>
						</tr>
						<%
						}
						%>
						<%
							// ���ͬ��Ӧ�ù���
							// ��ʢ 2011-7-12
							if (isApply) {
						%>
						<tr>
							<td align="center" class="detailtitle">
								ͬ��Ӧ��
							</td>
							<td class="detailcontent" colspan="3">
							<table align="center">
						<%
									Apply apply = null;
									String app_id = null;
									String app_name = null;
									int enablestatus = 0;
									int sum = 0;
									for (int i = 0; i < applyList.size(); i++) {
										apply = (Apply)applyList.get(i);
										if(null!=apply){
											app_id = apply.getApp_id();
											app_name = apply.getApp_name();
											enablestatus = apply.getEnablestatus();
											if(null==app_id || 
												"".equals(app_id.trim()) || 
												"module".equalsIgnoreCase(app_id.trim()) ||
												0==enablestatus){
												continue;
											}else{
											sum++;
											if(sum%3==1){
						%>	
							<tr>	
						<%} %>
								<td style="border: 0px;">
									<input type="checkbox" value="<%=app_id %>" id="checkbox_sel_appid" name="checkbox_sel_appid"><%=app_name %>
								</td>
						<%					if(sum%3==0){
						%>
							</tr>
						<%}
											}											
										}
									}
						%></table>
							</td>
						</tr>
						<%		
								}
						%>
						<tr>
							<td align="center" colspan="4">
								<div align="center">
									<input name="saveButton" type="button" class="input" value="����"
										onclick="saveorg()">
									<input name="resetButton" type="button" class="input"
										value="����" onclick="reset();">
									<input name="backButton" type="button" class="input" value="����"
										onclick="back()">
							</td>
						</tr>
					</table>
				</pg:beaninfo>
			</form>
		</div>
		<div id=divProcessing
			style="width:200px;height:30px;position:absolute;left:200px;top:260px;display:none">
			<table border=0 cellpadding=0 cellspacing=1 bgcolor="#000000"
				width="100%" height="100%">
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
