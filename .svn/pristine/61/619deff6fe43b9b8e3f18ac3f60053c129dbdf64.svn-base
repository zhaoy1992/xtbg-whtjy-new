<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl,
                 com.chinacreator.epp.businessClassManager.vo.FormClass,
                 com.chinacreator.epp.businessClassManager.businessManager.FormClassManager"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>                 
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	
	String class_id = request.getParameter("class_id");
	
	FormClassManager formClassManager = new FormClassManager();
	FormClass formClass = new FormClass();
    formClass = formClassManager.getFormClassByClassId(class_id);

	String ec_upName ="";
	if(!formClass.getEc_upid().equals("0")){
		ec_upName = formClassManager.getFormClassByClassId(formClass.getEc_upid()).getEc_name();
	}else{
	    ec_upName = "业务类别";
	}
%>
<html>
	<head>
		<title>属性容器</title>
		
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/sysmanager/applymanager/common.js"
			type="text/javascript"></script>
		<script language="JavaScript" src="../../include/pager.js"
			type="text/javascript"></script>
			
		<script src="js/fcpub.js"></script>
		<script language="JavaScript">	
	function createFormClass()
	{
		//location.href="<%=request.getContextPath()%>/eformsys/fceform/addFormClass.jsp";
		var ret=window.showModalDialog('<%=request.getContextPath()%>/eformsys/fceform/addFormClass.jsp?action=add&ec_id=<%=formClass.getEc_id()%>',window);
		if(ret) window.location.reload();
	}
	
	function editFormClass(){	    
	    var ret=window.showModalDialog('<%=request.getContextPath()%>/eformsys/fceform/addFormClass.jsp?action=edit&ec_id=<%=formClass.getEc_id()%>',window);
		if(ret) window.location.reload();
	}
	
	//function deleteFormClass()
	//{
	//	var retX=SendHttp(location.protocol+"//"+location.host + fcpubdata.servletPath +"/FormTools?op=classDelete&ec_id="+<%=formClass.getEc_id()%>);
	//	alert(retX);		
	//}
</script>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin" scroll="no">
		
		<div id="contentborder" align="center">
			
			<form name="ApplyForm" action="" method="post">
				
				<hr width="100%">

				<table width="95%" border="0" cellpadding="0" cellspacing="1"
					class="thin">

					    <tr>
						    <td height='30' class="detailtitle" align=center colspan=2>
							    <b>业务类别信息</b>
						    </td>
					    </tr>
					
						<tr class="labeltable_middle_td">
							<td height='30' align=center class="tablecells">
								类别ID
							</td>
							<td class="tablecells" align=center><%=formClass.getEc_id()%></td>
						</tr>
						<tr>
							<td height='30' class="tablecells" align=center>
								类别名称
							</td>
							<td height='30' class="tablecells" align=center>
							    <%=formClass.getEc_name()%>
							</td>
						</tr>
						<tr>
							<td height='30' class="tablecells" align=center>
								父类别名称
							</td>
							<td class="tablecells" align=center>
							    <%=ec_upName%>
							</td>
						</tr>
						<tr>
							<td height='30' class="tablecells" align=center>
								类别说明
							</td>
							<td height='30' class="tablecells" align=center>
								<%=formClass.getRemark()%>
							</td>
						</tr>
						<tr>
							<td height='30' class="tablecells" align=center>
								排序编号
							</td>
							<td class="tablecells" align=center>
							    <%=formClass.getEc_sn()%>
							</td>
						</tr>
                        
                        <tr height="30" class="labeltable_middle_tr_01">
							<td colspan=2 align='right'>
								<%if (control.checkPermission(AccessControl.BIZ_TYPE_RESOURCE,
								AccessControl.NEW_BIZTYPE_GLOBAL_PERMISSION,
								AccessControl.BIZ_TYPE_RESOURCE)) { %>
								<input name="xinzeng" type="button" class="input" value="新增子类别"
									onClick="createFormClass()">
								<%} %>
								<%if (control.checkPermission(AccessControl.BIZ_TYPE_RESOURCE,
								AccessControl.UPDATE_BIZTYPE_GLOBAL_PERMISSION,
								AccessControl.BIZ_TYPE_RESOURCE)) { %>
								<input name="xiugai" type="button" class="input" value="修改"
									onClick="editFormClass()">
								<%} %>
								<!--input type="submit" value="删除" class="input"
									onclick="deleteFormClass()"-->
							</td>
						</tr>	
				</table>
			</form>
		</div>
	</body>
</html>