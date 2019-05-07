<%
/**
 * <p>Title: 角色类型管理页面</p>
 * <p>Description: 角色类型管理页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-19
 * @author baowen.liu
 * @version 1.0
 **/
 %>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl" %>
<%
		AccessControl accesscontroler = AccessControl.getInstance();
        accesscontroler.checkManagerAccess(request,response);
        String typeName = ""; 
		typeName = request.getParameter("typeName");
		if(typeName == null)
		{
			typeName = "";
		} 
		String typeDesc = ""; 
		typeDesc = request.getParameter("typeDesc");
		if(typeDesc == null)
		{
			typeDesc = "";
		}        
%>

<html >
<head>				
	<tab:tabConfig/>
	<title>角色类型管理</title>
	<link rel="stylesheet" type="text/css" href="../css/windows.css">
	<link rel="stylesheet" type="text/css" href="../css/treeview.css">

	<script language="JavaScript" src="../scripts/func.js" type="text/javascript"></script>
	<SCRIPT language="javascript">
	function resetQuery()
	{
		document.all("typeName").value="";
		document.all("typeDesc").value="";
	}
	function queryRoleType()
	{
		var typeName = document.all("typeName").value;
		var typeDesc = document.all("typeDesc").value;
		document.all.roletypelist.src = 'roletypelist.jsp?typeName='+typeName+'&typeDesc='+typeDesc;
	}
	function newRoleType()
	{
		var url = "roletype_add.jsp";
		var winValue = window.showModalDialog(url,window,"dialogWidth:"+(500)+"px;dialogHeight:"+(440)+"px;help:no;scroll:auto;status:no");
		if(winValue)
		{
			var typeName = document.all("typeName").value;
			var typeDesc = document.all("typeDesc").value;
			document.all.roletypelist.src = 'roletypelist.jsp?typeName='+typeName+'&typeDesc='+typeDesc;
		}
	}
	function delRoleType()
	{
		var all = window.frames['roletypelist'].document.getElementsByName("ID");
		var docidStr="";
		for(var i=0;i<all.length;i++)
		{
			if(all[i].checked == true)
			{
				if(all[i].value==1)
				{
					alert("通用角色类型不能被删除！");
					return false;			
				}
				docidStr = docidStr + all[i].value + ";";
			}
		}
		if(docidStr!="")
		{		
			if(confirm('您确定要删除所选的角色类型?删除前请对该类型下的角色进行处理！'))
			{
				document.all.divProcessing.style.display = "block";
			  	searchForm.action = "roletype_delete.jsp?roletype_id=" + docidStr;
				searchForm.target = "hiddenFrame";
				searchForm.submit();
			}
			else
			{
			  return false;
			}
		}else{
	    	alert("请选择要求删除的记录！");
	    	return false;
	   	}	
    }	
	</SCRIPT>	
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body >
	<form name='searchForm' method='post'>
		<table cellspacing="1" cellpadding="0" border="0" width=100% class="thin">
			<tr style="align:left">
				<td height='30' style="align:left" colspan=6>
					<div align="left">
						<a href="#" onclick="newRoleType()"><u>新增角色类型</u></a> | <a href="#" onclick="delRoleType()"><u>删除角色类型</u></a>
					</div>
				</td>
			</tr>
			<tr >           
				<td height='20' class="tablecells" align=right>
					 角色类型：
				</td>
				<td height='20' class="tablecells" align=left>	
					<input type="text" name="typeName" value="<%=typeName%>">
				</td>
				<td height='20' class="tablecells" align=right>
					 类型描述：
					</td>
				<td height='20' class="tablecells" align=left>
					<input type="text" name="typeDesc" value="<%=typeDesc%>">	
				</td>
				<td height='20' class="tablecells" align=center>
					<input name="search" type="button" class="input" value="查询" onClick='queryRoleType()'> 
					<input name="search" type="button" class="input" value="清空" onClick='resetQuery()'> 
					<input name="search" type="button" class="input" value="返回" onClick="window.close();window.returnValue=true;"> 
				</td>
			</tr>
        </table>
    	</form>     				
        <table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
			<iframe width="100%" height=410px frameborder=0 noResize scrolling="false" marginWidth=0 name="roletypelist" src="roletypelist.jsp"></iframe>
		</table>
		<div id=divProcessing style="width:200px;height:30px;position:absolute;left:250px;top:260px;display:none">
			<table border=0 cellpadding=0 cellspacing=1 bgcolor="#000000" width="100%" height="100%">
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
<iframe name="hiddenFrame" width="0" height="0"></iframe>
</html>
