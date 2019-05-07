<%@ page language="java" pageEncoding="GBK"%>
<%@ page import="java.util.List,
                 com.chinacreator.security.AccessControl,
                 com.chinacreator.epp.businessClassManager.vo.FormClass,
                 com.chinacreator.epp.businessClassManager.businessManager.FormClassManager"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>        
<%
AccessControl control = AccessControl.getInstance();
control.checkAccess(request, response);
String app_id = control.getCurrentSystemID();
FormClassManager formClassManager = new FormClassManager();
FormClass formClass = new FormClass();
List list = formClassManager.getEformClassList(app_id,"0");
//if(list!=null && list.size()>0){
//	formClass = (FormClass)list.get(0);
//}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head> 
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
    <title></title>
    <script language="JavaScript">		
	function createFormClass()
	{
		//location.href="<%=request.getContextPath()%>/eformsys/fceform/addFormClass.jsp";
		var ret=window.showModalDialog('<%=request.getContextPath()%>/eformsys/fceform/addFormClass.jsp?action=add&ec_id=0',window);
		if(ret) window.location.reload();
	}
	
	function editFormClass(){	    
	    var ret=window.showModalDialog('<%=request.getContextPath()%>/eformsys/fceform/addFormClass.jsp?action=edit&ec_id='+<%=formClass.getEc_id()%>,window);
		if(ret) window.location.reload();
	}
	</script> 
  </head>
  <%@ include file="/epp/css/cssControl.jsp"%>
  <body>
  <div align="center">
  <form name="ApplyForm" action="" method="post">		
  <hr width="100%">
 
  		<table width="95%" border="0" cellpadding="0" cellspacing="1"
					class="thin">
      		<tr>
      		    <td height='30' class="detailtitle" align=center>
				    <b>业务类别信息</b>
				</td>
			</tr>
			<%if(list!=null && list.size()>0){ %>
			<tr>				 
				<td height='30' class="tablecells" align=center>
					请选择左边的业务类别查看详细信息			
				</td>
			</tr>
			<%}else{ %>
			<tr>				 
				<td height='30' class="tablecells" align=center>
					当前还没有建立类别			
				</td>
			</tr>
			<%} %>
			<%if (control.checkPermission(AccessControl.BIZ_TYPE_RESOURCE,
								AccessControl.NEW_BIZTYPE_GLOBAL_PERMISSION,
								AccessControl.BIZ_TYPE_RESOURCE)) { %>
      		<tr height="30" class="labeltable_middle_tr_01">
				<td align='right'>
					<input name="xinzeng" type="button" class="input" value="新增一级类别" onClick="createFormClass()">															
				</td>
			</tr>
			<%} %>
   	 	</table>
 
  </form>
  </div>
  </body>
</html>
