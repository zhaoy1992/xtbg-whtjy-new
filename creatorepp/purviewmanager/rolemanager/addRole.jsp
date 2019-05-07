<%
/**
 * <p>Title: 添加角色页面</p>
 * <p>Description: 添加角色页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-19
 * @author baowen.liu
 * @version 1.0
 **/
 %>
<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.List"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/tabpane-taglib.tld" prefix="tab"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.RoleTypeManager"%>
<%
	String isRoleExist = "false";
	if ( request.getAttribute("isRoleExist") != null){
		isRoleExist = "true";
	}
	//add by ge.tao
	//date 2008-01-25
	//新增角色, 角色类别没有回写的问题
	String roleTypeid = String.valueOf(session.getAttribute("roleTypeid"));
	session.removeAttribute("roleTypeid");
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>新增角色</title>
			<link rel="stylesheet" type="text/css" href="../css/windows.css">
			<link rel="stylesheet" type="text/css" href="../css/treeview.css">
		<SCRIPT LANGUAGE="JavaScript"> 
			var isRoleExist = "<%=isRoleExist%>";
			if ( isRoleExist == "true" ){
			alert("角色名称已存在，请重新输入!");
			}
	
			function loadPage() {
				
				var form = document.forms[0];
				var act = form.action.value;
				if(form.roleName.value =="administrator"){					
					form.roleName.disabled = "true";
					form.roleDesc.disabled = "true";
					form.delete1.disabled = "true";
					form.update.disabled = "true";					
				}
				if (act == 2) {
					form.roleId.value = "";
					form.roleName.value = "";
					form.roleDesc.value = "";
				}
				
				if(isRoleExist != "true")
				{
					if (act == 1 || act == 2) 
					{
						alert("操作成功！");
											
					}
				}
				
				form.action.value = 0;
			}
			
			
			
			function updateRole() {
				
				var form = document.forms[0];
				if (form.roleName.value.length < 1 || form.roleName.value.replace(/\s/g,"")=="") {			
					alert("角色名称必须填写");
					return;
				}
				if (form.roleDesc.value.length < 1 || form.roleDesc.value.replace(/\s/g,"")=="") {			
					alert("角色描述必须填写");
					return;
				}				
				if (form.roleName.value.length == "adminstrator") {			
					alert("系统管理员不能修改。谢谢合作:)");
					return;
				}
				
				var rn = form.roleName.value;
				var rd = form.roleDesc.value;
				if(rn.search(/[\\\/\|:\*\?<>"']/g)!=-1){
					alert("角色名称不能有\\/|:*?<>\"'!等特殊字符");
					return;
				}	
				if(rd.search(/[\\\/\|:\*\?<>"']/g)!=-1){
					alert("角色描述不能有\\/|:*?<>\"'!等特殊字符");
					return;
				}
				
				if(rn.length>100)
				{
					alert("角色名称过长,限制在100字符以内!");
					return;
				}
				if(rd.length>100)
				{
					alert("角色描述过长,限制在100字符以内!");
					return;
				}
				if ((form.roleType.value==""))
  	  			{
		  	  	    alert("请选择角色类别");		  	  	
		  	  	    return;
  	  	        }
				document.all.update.disabled=true;
				document.all.calc[0].disabled=true;
				document.all.calc[1].disabled=true;
				document.all.divProcessing.style.display = "block";
			  	form.action = "addRole_do.jsp";
				form.target = "hiddenFrame";
				form.submit();
			}
			
			function checkLength(e)
			{
				var elength = e.value.length;
				var v = e.value;				
				if(elength>=100)
				{
					e.value = v.substring(0,100);
				}
			}
			
</SCRIPT>
	</head>

	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" onload="loadPage();" scroll="no">
		<div id="contentborder" align="center">
			<form method="post" name="roleform">
				<table width="100%" height="25" border="0" cellpadding="0" cellspacing="1" class="thin">
					<tr class="tr">
						<td width="20%" height="25" class="detailtitle" align="right">角色名称*：</td>
						<td height="25">
							<input type=text name="roleName" style="width=50%" maxlength="100"/>
						</td>
					</tr>
					<tr class="tr">					                   	
						<td width="20%" height="25" class="detailtitle" align="right">角色类型*：</td>						
					    <td>
					    <select name="roleType" class="cms_select">
						<option value="">--请选择角色类别--</option>
						<%
						List typenamelist = null;
						RoleTypeManager rtm = new RoleTypeManager();
						typenamelist = rtm.getTypeNameList();
						request.setAttribute("typenamelist",typenamelist);
						%>
						<pg:list requestKey="typenamelist">
						<option value="<pg:cell colName="roleTypeID"/>"
						    <pg:equal colName="roleTypeID" value="<%=roleTypeid%>">
								selected
								</pg:equal>
						>
						<pg:cell colName="typeName"/> 
						</pg:list>
						</select>		
					    </td>
					</tr>
					<tr class="tr">
						<td height="25" width="20%" class="detailtitle" align="right">描述*：</td>
						<td height="25">
							<textarea name="roleDesc" rows="4" cols="40" rows="5" onkeyup="checkLength(this)"></textarea>
						</td>
					</tr>
			</table>
            <hr width="100%">				
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="table">
				<tr class="tr">
					<td class="td">
						<div align="center">								
							<input name="update" type="button" onClick="updateRole()" class="input" value="保存">
							<input name="calc" type="reset" class="input" value="清空">
							<input name="calc" type="button" class="input" value="返回" onClick="window.close();window.returnValue=true;">
					    </div>
					</td>
				</tr>
			  </table>
			</form>
		</div>
		<div id=divProcessing style="width:200px;height:30px;position:absolute;left:100px;top:260px;display:none">
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