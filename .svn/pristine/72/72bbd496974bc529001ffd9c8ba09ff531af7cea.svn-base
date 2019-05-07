<%@ include file="../../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	//用户信息（用户真实名称：用户帐号[用户ID]）
	String userInfo = control.getUserAttribute("userAccount") + ":"
			+ control.getUserAttribute("userName") + "["
			+ control.getUserAttribute("userID") + "]  ";
	//操作的ip地址
	String remoteAddr = request.getRemoteAddr();

	String action = (String) request.getAttribute("action");

	String app_name = request.getParameter("app_name") != null ? request
			.getParameter("app_name")
			: "";
	String remark = request.getParameter("remark") != null ? request
			.getParameter("remark") : "";
%>
<html>
	<head>
		<title>属性容器</title>

		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
		<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/applymanager/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="../../include/pager.js" type="text/javascript"></script>
		<script language="JavaScript" src="<%=request.getContextPath()%>/purviewmanager/scripts/func.js" type="text/javascript"></script>

		<!-- dwr begin-->
		<script language="javascript" type="text/javascript" src='<%=request.getContextPath()%>/dwr/engine.js'> </script>
		<script language="javascript" type="text/javascript" src='<%=request.getContextPath()%>/dwr/util.js'> </script>
		<script language="javascript" type="text/javascript" src='<%=request.getContextPath()%>/dwr/interface/applyChange.js'></script>
		<!-- dwr end -->

		<script language="JavaScript">

	function updateAfter(){
		getNavigatorContent().location.href ="../sysmanager/applymanager/navigator_content.jsp?anchor=0&expand=0&request_scope=session"; 
	}

	var jsAccessControl = new JSAccessControl("#DAE0E9","#F6F8FB","#F6F8FB");
	function getApplyInfo(e,app_id){
	jsAccessControl.setBackColor(e);
	document.all("selectId").value = app_id;	
	}
	function createApply()
	{
		var ww = openWin('<%=request.getContextPath()%>/sysmanager/applymanager/applywork/addapplymain.jsp?isCancel=true',screen.availWidth-320,screen.availHeight-200);
			if(ww)
			{
				parent.location.reload();
				getNavigatorContent().location.reload();
			}		
	}
	
	function dealRecord(dealType) {
    var isSelect = false;
    var outMsg;
	    
    for (var i=0;i<ApplyForm.elements.length;i++) {
		var e = ApplyForm.elements[i];
			
		if (e.name == 'checkBoxOne'){
			if (e.checked){
	       		isSelect=true;
	       		
	       		break;
		    }
		}
    }
    if (isSelect){
    		if(dealType==0){    			
    			outMsg = "请确认注销!";
    		}else if(dealType==1){
    			outMsg = "请确认激活!";
    		}
        	if (confirm(outMsg)){
        		var inputObjects = document.getElementsByName("checkBoxOne");
				var arrayValues = new Array;
				for(var i = 0;i < inputObjects.length;i ++){
					if(false != inputObjects[i].checked) {
						// modify by yaohui.luo	2008-8-22
						// 已注销的点击注销给予提示
						if (document.getElementById('app_' + inputObjects[i].value).getAttribute('enablestatus')==0 &&
								dealType==0) {
							alert('请选择应用状态为已激活的记录');
							return;
						}
						// 已激活的点击注销给予提示
						if (document.getElementById('app_' + inputObjects[i].value).getAttribute('enablestatus')==1 &&
								dealType==1) {
							alert('请选择应用状态为已注销的记录');
							return;
						}
						arrayValues[arrayValues.length] = inputObjects[i].value;
					}
				}        	
				applyChange.updateApplyStatus(arrayValues,dealType,"<%=userInfo%>","<%=remoteAddr%>",refresh);			
			
		} 
    }else{
    	alert("至少要选择一条记录！");
    	return false;
    }
	return false;
}

	function refresh(){		
		window.parent.location.reload();		
		getNavigatorContent().location.reload();
	 	return true;
	}
	function editApply(){
		var app_id = document.all("selectId").value;
		var ww = openWin('<%=request.getContextPath()%>/sysmanager/applymanager/applywork/editapplymain.jsp?isEdit=true&&app_id='+app_id,screen.availWidth-320,screen.availHeight-200);
			if(ww)
			{
				parent.location.reload();
				getNavigatorContent().location.reload();
			}
	}	
	
	function delApply(){
		var isSelect = false;    	 
	    for (var i=0;i<ApplyForm.elements.length;i++) {
			var e = ApplyForm.elements[i];				
			if (e.name == 'checkBoxOne'){
				if (e.checked){
		       		isSelect=true;		       		
		       		break;
			    }
			}
	    }
	    if (isSelect){	        	
        		var inputObjects = document.getElementsByName("checkBoxOne");
				var arrayValues = new Array;				
				for(var i = 0;i < inputObjects.length;i ++){
					if(false != inputObjects[i].checked) {						
						arrayValues[arrayValues.length] = inputObjects[i].value;
					}
				}        										
					var ww = openWin('delApply.jsp?app_id='+arrayValues,screen.availWidth-320,screen.availHeight-200);			
					if(ww)
					{
						parent.location.reload();
						getNavigatorContent().location.reload();
					}					
				
				 
	    }else{
	    	alert("至少要选择一条记录！");
	    	return false;
	    }
	    return;
	}
	
	function resetcss(){
		applyChange.resetCss();
		alert("样式重置完成！");
	}
</script>
		<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin" scroll="no" onLoad="<%if(action!=null)out.print("updateAfter()");%>">
		<div id="contentborder" align="center">
			<form name="ApplyForm" action="applyinfo.jsp" method="post">

				<table width="100%" border="0" cellpadding="1" cellspacing="1" class="thin">
					<tr>
						<td class="detailtitle" width="10%" align=right>
							应用名称：
						</td>
						<td class="detailcontent" width="90%">
							<input type="text" name="app_name" value="<%=app_name%>" style="width:70%">
						</td>
					</tr>
					<tr>
						<td class="detailtitle" width="10%" align=right>
							应用描述：
						</td>
						<td class="detailcontent" width="90%">
							<input type="text" name="remark" value="<%=remark%>" style="width:70%">
						</td>
					</tr>
					<tr>
						<td width="16%">
						</td>
						<td class="detailcontent" width="30%" align="right">

							<input name="Submit4" type="submit" class="input" value="查询">
							<input name="Submit22" type="button" class="input" value="重置" onclick="app_name.value=remark.value=''">
						</td>
					</tr>
				</table>
				<hr width="100%">

				<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">

					<tr>
						<td height='30' class="detailtitle" align=center colspan=10>
							<b>应用列表</b>
						</td>
					</tr>
					<pg:listdata dataInfo="com.chinacreator.epp.applymanager.menu.ApplySearchList" keyName="ApplyList" />
					<!--分页显示开始,分页标签初始化-->
					<pg:pager maxPageItems="10" scope="request" data="ApplyList" isList="false">
						<pg:param name="app_name" />
						<pg:param name="remark" />
						<tr class="labeltable_middle_td">
							<!--设置分页表头-->
							<td class="headercolor" width="6%">
								<P align="left">
									<INPUT type="checkbox" name="checkBoxAll" onclick="checkAll('checkBoxAll','checkBoxOne')" value="on">
								</P>
							</td>
							<td height='20' class="headercolor">
								应用名称
							</td>
							<input class="text" type="hidden" name="selectId">
							<input name="delSingle" type="hidden" validator="string" maxlength="100" value="false">
							<td height='20' class="headercolor">
								应用数据源名称
							</td>														
							<td height='20' class="headercolor">
								描述
							</td>
							<td height='20' class="headercolor">
								状态
							</td>
						</tr>
						<!--检测当前页面是否有记录-->
						<pg:notify>
							<tr height='25' class="labeltable_middle_tr_01">
								<td colspan=100 align='center'>
									暂时没有应用
								</td>
							</tr>
						</pg:notify>

						<!--list标签循环输出每条记录-->
						<pg:list>
							<tr class="labeltable_middle_tr_01" onMouseOver="this.className='mousestyle1'" onMouseOut="this.className= 'mousestyle2'" onclick="getApplyInfo(this,'<pg:cell colName="app_id" defaultValue=""/>')" onDBLclick="editApply()" id="app_<pg:cell colName="app_id" defaultValue=""/>"
								enablestatus="<pg:cell colName="enablestatus" defaultValue=""/>">
								<td class="tablecells" nowrap="true">
									<P align="left">
										<INPUT type="checkbox" name="checkBoxOne" onclick="checkOne('checkBoxAll','checkBoxOne')" value='<pg:cell colName="app_id" defaultValue=""/>'>
									</P>
								</td>
								<td height='20' align=left class="tablecells">
									<pg:cell colName="app_name" defaultValue="" />
								</td>
								<td height='20' align=left class="tablecells">
									<pg:cell colName="dbuser" defaultValue="" />
								</td>								
								<td height='20' align=left class="tablecells">
									<pg:cell colName="remark" defaultValue="" />
								</td>
								<td height='20' align=left class="tablecells">
									<pg:equal colName="enablestatus" expressionValue="0">已注销</pg:equal>
									<pg:equal colName="enablestatus" expressionValue="1">已激活</pg:equal>
								</td>
						</pg:list>
						<tr height="30" class="labeltable_middle_tr_01">
							<td colspan=100 align='right'>
								共
								<pg:rowcount />
								条记录
								<pg:index />
								<%
								if (control.isAdmin()) {
								%>
								<br />								
								<input type="button" class="input" value="新增" onClick="createApply();">
								<!-- <input type="button" class="input" value="删除" onClick="delApply();"> -->
								<input type="button" value="注销" class="input" onclick="javascript:dealRecord(0); return false;">
								<input type="button" value="激活" class="input" onclick="javascript:dealRecord(1); return false;">
								<input type="button" value="样式重置" class="input" onclick="javascript:resetcss(); return false;">
								<%
								}
								%>
							</td>
						</tr>
					</pg:pager>

				</table>
			</form>

				<div align="center">
				</div>
		</div>

	</body>
</html>
