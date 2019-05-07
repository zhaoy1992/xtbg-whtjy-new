<%
/**
 * <p>Title: 角色类型修改页面</p>
 * <p>Description: 角色类型修改页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-19
 * @author baowen.liu
 * @version 1.0
 **/
 %>
<%@ page contentType="text/html; charset=GBK" language="java"  errorPage="" %>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.RoleType"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.RoleTypeManager
				,com.frameworkset.util.StringUtil"%>
<%
	String typeId = StringUtil.replaceNull(request.getParameter("typeId"));
	RoleTypeManager roleTypeManager = new RoleTypeManager();
	RoleType roleType = roleTypeManager.getRoleType(typeId);
	String typeName = StringUtil.replaceNull(roleType.getTypeName());
	String typeDesc = StringUtil.replaceNull(roleType.getTypeDesc());
%>
<html>
<head>
<title>修改角色类型</title>
<link rel="stylesheet" type="text/css" href="../css/windows.css">
<link rel="stylesheet" type="text/css" href="../css/treeview.css">
	
<SCRIPT language="javascript">
function save()
{
	if(roletypeform.typeName.value.replace(/\s/g,"")=="" || roletypeform.typeName.length==0)
	{
		alert("类型名称不能为空！");
		return false;
	}
	if(roletypeform.typeDesc.value.replace(/\s/g,"")=="" || roletypeform.typeDesc.length==0)
	{
		alert("类型描述不能为空！");
		return false;
	}
	document.all.Submit4.disabled=true;
	document.all.btn_close.disabled=true;
	document.all.divProcessing.style.display = "block";
	roletypeform.action = "roletype_modify_do.jsp"
	roletypeform.target = "hiddenFrame"
	roletypeform.submit();
}
</SCRIPT>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body >
<%
    AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkManagerAccess(request,response);
%>
<form method="post" name="roletypeform">
		<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0" class="thin"> 
			<input type=hidden name="typeId" value=<%=typeId%> >
		    <tr valign='top'>
           		<td height='20'valign='middle'>&nbsp;<strong>修改角色类型</strong></td>
         	</tr>	       
	   		<tr>
       	    	<td>角色类型*:
           		<input name="typeName" type="text" value="<%=typeName%>" readonly size="22" />
           		</td>					
       		</tr>
	       <tr>
	           <td>角色描述*:
	           	<textarea name="typeDesc" rows="5" style="width:400px;"><%=typeDesc%></textarea>
	           </td>					
	       </tr>
           <tr>
           	   <td>
               <div align="center">
               <input name="Submit4" type="button" value="保存"  class="input"  onclick="save()">
               <input style=" cursor:hand;" name="btn_close" type="button"  class="input"  onClick="window.close();window.returnValue=true;" value="关闭">
               </div>
               </td>
           </tr>    
      </table>
</form>
<div id=divProcessing style="width:200px;height:30px;position:absolute;left:150px;top:260px;display:none">
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
<iframe name="hiddenFrame" width="0" height="0" style="display:none"></iframe>
</html>