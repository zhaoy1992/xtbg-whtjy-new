
<%@page import="com.chinacreator.config.ConfigManager"%>
<%
	 /**
	 * <p>Title: 新增子机构</p>
	 * <p>Description: 新增子机构</p>
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
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@page import="com.frameworkset.util.StringUtil"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.sysmgrcore.manager.OrgManager"%>
<%@page import="com.chinacreator.sysmgrcore.entity.Organization"%>
<%@page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.epp.applymanager.dbmanager.ApplyManager"%>
<%@ page import="com.chinacreator.epp.applymanager.vo.Apply"%>
<%@page
	import="com.chinacreator.sysmgrcore.purviewmanager.GenerateServiceFactory"%>
<%@page import="java.util.List"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkManagerAccess(request, response);

	//判断是否是cms系统
	String subSystemId = control.getCurrentSystemID();

	//得到上个页面传来的机构名称 2008-3-20 baowen.liu
	String orgName = request.getParameter("orgName");

	String orgId = request.getParameter("orgId");
	String parentId = orgId;
	OrgManager orgManager = SecurityDatabase.getOrgManager();
	Organization parentOrg = orgManager.getOrgById(parentId);

	List sublist = orgManager.getChildOrgList(parentOrg);
	String suborgstr = "";
	if (sublist != null && sublist.size() > 0) {
		for (int i = 0; i < sublist.size(); i++) {
			Organization suborg = (Organization) sublist.get(i);
			suborgstr += suborg.getRemark5() + ",";
		}
	}

	if (!suborgstr.equals(""))
		suborgstr = suborgstr.substring(0, suborgstr.length() - 1);

	if ((parentId == null) || parentId.equals("")) {
		parentId = "0";
	}
	Organization org1 = orgManager.getOrgById(orgId);

	String layer = org1.getLayer();
	//如果父机构的layer为空，默认指定为2
	if ((layer == null) || layer.equals("")) {
		layer = "2";
	} else {
		layer = String.valueOf(Integer.parseInt(layer) + 1);
	}

	Organization org = new Organization();
	// 吴卫雄修改：为了同步机构到LDAP中去
	org.setParentId(parentId);
	org.setParentOrg(parentOrg);
	// 吴卫雄修改结束

	org.setLayer(layer);

	String isExist = "false";
	if (request.getAttribute("isExist") != null) {
		isExist = "true";
	}
	String parentOrgLevel = parentOrg.getOrg_level();
	String parentOrgXzqm = parentOrg.getOrg_xzqm();
	String parentOrgNumber = parentOrg.getOrgnumber();

	session.setAttribute("suborgstr", suborgstr);
	request.setAttribute("Organization", org);

	//父机构编号
	//String parentOrgNumber = parentOrg.getOrgnumber();
	//默认生成的机构编码
	String orgnumber = "";
	int len = GenerateServiceFactory.getOrgNumberGenerateService()
			.getOrgNumberLen();
	boolean orgNumberHiberarchy = GenerateServiceFactory
			.getOrgNumberGenerateService().enableOrgNumberGenerate();
	if (orgNumberHiberarchy) {
		orgnumber = GenerateServiceFactory
		.getOrgNumberGenerateService().generateOrgNumber(
				parentOrg);
	} else {
		orgnumber = parentOrgNumber;
	}
	//父机构编号长度
	int parentOrgNumberLength = parentOrgNumber.length();
	int maxOrgNumberLength = parentOrgNumberLength + len;

	//是否出现  "是否税管员" 复选框
	boolean istaxmanager = ConfigManager.getInstance()
			.getConfigBooleanValue("istaxmanager", false);
	
	// 添加同步应用功能
	// 彭盛 2011-7-12		
	// 获取所有应用对象
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

		<title>机构【<%=orgName%>】新增子机构</title>
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
	{
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
		alert("机构编号只能是数字和字母!");
		form1.orgnumber.focus();
		return false;
		}
		if(orgSn.search(/[^0-9]/g) !=-1){
		alert("机构排序号只能是数字!");
		form1.orgSn.focus();
		return false;
		}
		if(jp.search(/[^A-Za-z]/g) !=-1){
		alert("简拼只能包含字母!");
		form1.jp.focus();
		return false;
		}
		if(qp.search(/[^A-Za-z]/g) !=-1){
		alert("全拼只能包含字母!");
		form1.qp.focus();
		return false;
		}
		
		
		if(widthCheck(orgnumber,100))
		{
			alert("机构编号过长,限制在100字符以内!");
			form1.orgnumber.focus();
			return false;
		}
		if(widthCheck(orgName,40))
		{
			alert("机构名称过长,限制在40字符以内!");
			form1.orgName.focus();
			return false;
		}
		if(widthCheck(orgdesc,300))
		{
			alert("机构描述过长,限制在300字符以内!");
			form1.orgdesc.focus();
			return false;
		}
		if(widthCheck(jp,40))
		{
			alert("简拼过长,限制在40字符以内!");
			form1.jp.focus();
			return false;
		}
		if(widthCheck(qp,40))
		{
			alert("全拼过长,限制在40字符以内!");
			form1.qp.focus();
			return false;
		}
		if(widthCheck(remark5,100))
		{
			alert("主管岗位过长,限制在100字符以内!");
			form1.remark5.focus();
			return false;
		}
		if(widthCheck(layer,200))
		{
			alert("级次过长,限制在200字符以内!");
			form1.layer.focus();
			return false;
		}
		
		var org_xzqm_obj = form1.org_xzqm ;
		if(org_xzqm_obj != null)
		{
			var org_xzqm = org_xzqm_obj.value ;
			if(org_xzqm.search(/[^0-9]/g) !=-1)
			{
				alert("行政区码只能是数字!");
				form1.org_xzqm_obj.focus();
			return false;
			}
			if(widthCheck(org_xzqm,10))
			{
				alert("行政区码过长,限制在10字符以内!");
				org_xzqm_obj.focus();
				return false;
			}
		}		
		
		var suborgstr = document.forms[0].suborgstr.value;
		var suborgs = suborgstr.split(",");
		if(validateForm(form1)){
		    var orgName = document.forms[0].remark5.value;
	
		    for(var i=0;i<suborgs.length;i++){
		    
		    	if(orgName==suborgs[i]){
		    		alert("子机构已存在相同的机构显示名称,请重新命名");
		    		return;
		    	}
		    }
			if(validateForm(form1)){	
			document.all.divProcessing.style.display = "block";
			document.all.saveButton.disabled = true;
			document.all.resetButton.disabled = true;
			document.all.backButton.disabled = true;
		  	document.form1.sel_appid.value = getSelAppid();
		  	document.forms[0].action = "new_sonorg_do.jsp";
			document.forms[0].target = "hiddenFrame";
			document.forms[0].submit();
		   }
	    }
	}
	
	function checkOrgNumber(obj){
		var val = obj.value;
		var cruLength = val.length;
		var maxLength = "<%=maxOrgNumberLength%>";
		var subOrg = val.substring(0,<%=parentOrgNumberLength%>);
		if(subOrg != "<%=parentOrgNumber%>"){
			alert("机构编码前几位必须与父机构编码相同\n父机构编码为：<%=parentOrgNumber%>");
			obj.value = "<%=orgnumber%>";
			obj.focus();
			return;
		}
		if(cruLength != maxLength){
			alert("机构编码长度只能是父机构编码长度加<%=len%>位！\n该机构编码长度只能是"+maxLength+"位数字");
			obj.value = val.substring(0,maxLength);
			obj.focus();
			return;
		}
		
	}
	//判断长度是否合格
	//s   传入的字符串 
	//n   限制的长度n以下
	//返回true：长度合格
	function widthCheck(s, n){ 
		var w = 0; 
		for (var i=0; i<s.length; i++) { 
		   var c = s.charCodeAt(i); 
		   //单字节加1 
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
	// 获取选择同步的应用ID
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
	<body class="contentbodymargin">
		<div id="contentborder">
			<form name="form1" action="" method="post">
				<pg:beaninfo requestKey="Organization">
					<input type="hidden" name="suborgstr" value="<%=suborgstr%>" />
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
					<input type=hidden name=chargeOrgId value=1>
					<input type=hidden name=chargejobName value=1>
					<input type=hidden name=layer value=1>
					<input type="hidden" name="sel_appid" value=""/>
					<table width="100%" border="0" cellpadding="0" cellspacing="1"
						class="thin">
						<tr>
							<td align="center" class="detailtitle">
								机构编号*
							</td>
							<td class="detailcontent">
								<input name="orgnumber" type="text" validator="string"
									cnname="机构编号" value="<%=orgnumber%>"
									<%if(orgNumberHiberarchy)out.print("onblur='checkOrgNumber(this)'"); %>>
							</td>
							<td align="center" class="detailtitle">
								机构名称*
							</td>
							<td class="detailcontent">
								<input name="orgName" type="text" validator="string"
									cnname="机构名称" value="">
							</td>
						</tr>
						<tr>
							<!--  
    <td align="center"  class="detailtitle">机构排序号*</td>
    <td class="detailcontent"><input name="orgSn" type="text" 
				  validator="int" cnname="机构排序号" value=""></td>
  -->
							<input name="orgSn" type="hidden" validator="int" cnname="机构排序号"
								value="1">
							<td align="center" class="detailtitle">
								机构描述
							</td>
							<td class="detailcontent">
								<input name="orgdesc" type="text"
									value="<pg:cell colName="orgdesc"  defaultValue=""/>">
							</td>
						</tr>
						<tr>
							<td align="center" class="detailtitle">
								简拼
							</td>
							<td class="detailcontent">
								<input name="jp" type="text"
									value="<pg:cell colName="jp"  defaultValue=""/>">
							</td>
							<td align="center" class="detailtitle">
								全拼
							</td>
							<td class="detailcontent">
								<input name="qp" type="text"
									value="<pg:cell colName="qp"  defaultValue=""/>">
							</td>
						</tr>
						<tr>
							<td align="center" class="detailtitle">
								机构有效标志
							</td>
							<td class="detailcontent">
								<select name="remark3">
									<option label="" value="1">
										有效
									<option label="" value="0">
										无效
								</select>
							</td>
							<td align="center" class="detailtitle">
								机构显示名称*
							</td>
							<td class="detailcontent">
								<input name="remark5" type="text" validator="string"
									cnname="机构显示名称"
									value="<pg:cell colName="remark5"  defaultValue=""/>">
							</td>
							<input type=hidden name=ispartybussiness value=0>
						</tr>

						<!-- 内容管理系统中不需要的字段 -->
						<%
						if (!"cms".equals(subSystemId)) {
						%>
						<%
						if (istaxmanager) {
						%>
						<tr>
							<td align="center" class="detailtitle">
								是否直属局
							</td>
							<td class="detailcontent">
								<select name="isdirectlyparty">
									<option label="" value="0">
										否
									<option label="" value="1">
										是
								</select>
							</td>
							<td align="center" class="detailtitle">
								是否涉外局
							</td>
							<td class="detailcontent">
								<select name="isforeignparty">
									<option label="" value="0">
										否
									<option label="" value="1">
										是
								</select>
							</td>
						</tr>
						<tr>
							<td align="center" class="detailtitle">
								是否稽查局
							</td>
							<td class="detailcontent">
								<select name="isjichaparty">
									<option label="" value="0">
										否
									<option label="" value="1">
										是
								</select>
							</td>
							<td align="center" class="detailtitle">
								是否直接管户单位
							</td>
							<td class="detailcontent">
								<select name="isdirectguanhu">
									<option label="" value="0">
										否
									<option label="" value="1">
										是
								</select>
							</td>
						</tr>
						<%
						}
						%>
						<tr>


							<td align="center" class="detailtitle">
								机构级别
							</td>
							<td class="detailcontent">
								<select name="org_level">
									<%
									if (parentOrgLevel.equals("1")) {
									%>
									<option label="" value="2">
										市州级
									<option label="" value="3">
										县区级
									<option label="" value="4">
										科所级
										<%
									} else if (parentOrgLevel.equals("2")) {
									%>
									
									<option label="" value="3">
										县区级
									<option label="" value="4">
										科所级
										<%
																		} else if (parentOrgLevel.equals("3")) {
																		%>
									
									<option label="" value="4">
										科所级
										<%
																		}
																		%>
									
									<option label="" value="0">
										内设科室
								</select>
							</td>
							<td align="center" class="detailtitle">
								行政区码*
							</td>
							<td class="detailcontent">
								<input name="org_xzqm" validator="string" cnname="行政区码"
									type="text" value="<%=parentOrgXzqm%>">
							</td>
						</tr>
						<%
						}
						%>

						<%
							// 添加同步应用功能
							// 彭盛 2011-7-12
							if (isApply) {
						%>
						<tr>
							<td align="center" class="detailtitle">
								同步应用
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
									<input name="saveButton" type="button" class="input" value="保存"
										onclick="saveorg()">
									<input name="resetButton" type="button" class="input"
										value="重置" onclick="reset()">
									<input name="backButton" type="button" class="input" value="返回"
										onclick="window.close()">
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
							<font color=#FFFFFF>...处理中...请等待...</font>
						</marquee>
					</td>
				</tr>
			</table>
		</div>
	</body>
	<iframe name="hiddenFrame" width=0 height=0></iframe>
</html>
