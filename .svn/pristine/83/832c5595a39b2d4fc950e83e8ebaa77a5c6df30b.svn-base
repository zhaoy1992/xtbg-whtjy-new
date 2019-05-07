<%@ include file="/sysmanager/include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
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
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/purviewmanager/scripts/func.js"
			type="text/javascript"></script>
		<base target="_self">
		<!-- dwr begin-->
		<script language="javascript" type="text/javascript"
			src='<%=request.getContextPath()%>/dwr/engine.js'> </script>
		<script language="javascript" type="text/javascript"
			src='<%=request.getContextPath()%>/dwr/util.js'> </script>
		<script language="javascript" type="text/javascript"
			src='<%=request.getContextPath()%>/dwr/interface/menuissueChange.js'></script>
		<!-- dwr end -->

		<!-- 提交后页面变灰 -->
		<script language="javascript" type="text/javascript"
			src="../pageGrey.js">
			</script>
		<script language="JavaScript">
	
	var jsAccessControl = new JSAccessControl("#DAE0E9","#F6F8FB","#F6F8FB");
	function getApplyInfo(e,app_id){
	jsAccessControl.setBackColor(e);
	document.all("selectId").value = app_id;	
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
    		
        	if (confirm("确认删除吗!")){
        		var inputObjects = document.getElementsByName("checkBoxOne");
				var arrayValues = new Array;
				for(var i = 0;i < inputObjects.length;i ++){
					if(false != inputObjects[i].checked)
						arrayValues[arrayValues.length] = inputObjects[i].value;
				}       
				
				//提交后页面变灰
				popSignFlow(1);
				 	
				menuissueChange.delMenuupdateFile(arrayValues,refresh);
		} 
    }else{
    	alert("至少要选择一条记录！");
    	return false;
    }
	return false;
}

	function refresh(obj){
		document.URL=location.href;
		//页面变灰恢复正常
		//cancelSign();		
		
		alert(obj);
		
	 	return true;
	}
	
	//页面跳转
	function jumpPage(){
		
		//提交后页面变灰
		popSignFlow(1);		
		document.ApplyForm.action="expmenuselect.jsp";
		document.ApplyForm.submit();
	}
	
	function showExpRecord(filename){
		openWin('showexprecord.jsp?filename='+filename,screen.availWidth-320,screen.availHeight-200);			
	}
	
</script>
		<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin" scroll="no">
		<div id="contentborder" align="center">
			<form name="ApplyForm" action="" method="post">
				<input type="hidden" name="isFill" value="true">


				<br />
				<br />
				<fieldset style="width: 90%;">
					<LEGEND align=center>
						<FONT size="2">模块更新包下载</FONT>
					</LEGEND>
					<br />
					<table width="95%" border="0" cellpadding="0" cellspacing="1"
						class="thin">
						<pg:listdata
							dataInfo="com.chinacreator.eppissue.menuissue.expmenu.menu.ExpmenuList"
							keyName="ApplyList" />
						<!--分页显示开始,分页标签初始化-->
						<pg:pager maxPageItems="10" scope="request" data="ApplyList"
							isList="false">
							<pg:param name="appid" />
							<tr class="labeltable_middle_td">
								<!--设置分页表头-->
								<td class="headercolor" width="6%">
									<P align="left">
										<INPUT type="checkbox" name="checkBoxAll"
											onclick="checkAll('checkBoxAll','checkBoxOne')" value="on">
									</P>
								</td>
								<td height='20' class="headercolor">
									更新包名称
								</td>
								<input class="text" type="hidden" name="selectId">
								<input name="delSingle" type="hidden" validator="string"
									maxlength="100" value="false">

								<td height='20' class="headercolor">
									创建时间
								</td>
								<td height='20' class="headercolor">
									操作
								</td>
								<td height='20' class="headercolor">
									更新包下载
								</td>
							</tr>

							<!--检测当前页面是否有记录-->
							<pg:notify>
								<tr height='25' class="labeltable_middle_tr_01">
									<td colspan=100 align='center'>
										暂时没有发布应用更新
									</td>
								</tr>
							</pg:notify>

							<!--list标签循环输出每条记录-->
							<pg:list>
								<tr class="labeltable_middle_tr_01"
									onMouseOver="this.className='mousestyle1'"
									onMouseOut="this.className= 'mousestyle2'"
									onclick="getApplyInfo(this,'<pg:cell colName="fileName" defaultValue=""/>')">
									<td class="tablecells" nowrap="true">
										<P align="left">
											<INPUT type="checkbox" name="checkBoxOne"
												onclick="checkOne('checkBoxAll','checkBoxOne')"
												value='<pg:cell colName="fileDrivePath" defaultValue=""/>'>
										</P>
									</td>
									<td height='20' align=left class="tablecells">
										<pg:cell colName="fileName" defaultValue="" />
									</td>

									<td height='20' align=left class="tablecells">
										<pg:cell colName="fileLastModified" defaultValue=""
											dateformat="yyyy-MM-dd HH:mm" />
									</td>
									<td height='20' align=left class="tablecells">
										<input type="button" name="button" value="查看导出记录" class="input" onclick="showExpRecord('<%=dataSet.getString("fileName") %>');">
									</td>
									<td height='20' align=left class="tablecells">

										<a href=<pg:cell colName="filePath" defaultValue="" />
											target="download">下载更新包</a>

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
									<input name="Submit" type="button" class="input" value="删除"
										onclick="javascript:dealRecord(0); return false;">
									<%
									}
									%>
								</td>
							</tr>
						</pg:pager>
					</table>
				</fieldset>
				<div align="center">
					<table width="15%" border="0" align="right" cellpadding="0"
						cellspacing="0">
						<tr>
							<td>
								<div align="left">
									<input name="Submit" type="button" class="input" value="返  回"
										onClick="jumpPage()">
								</div>
							</td>
						</tr>
					</table>
				</div>
			</form>
		</div>
	</body>
	<iframe name="download" style="display: none;"></iframe>
</html>
