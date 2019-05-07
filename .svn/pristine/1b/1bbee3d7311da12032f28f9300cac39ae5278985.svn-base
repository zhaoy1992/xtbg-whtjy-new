<%@ include file="/sysmanager/include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/sysmanager/base/scripts/panes.jsp"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Enumeration,
				com.frameworkset.common.poolman.util.JDBCPoolMetaData"%>
<%@page import="com.chinacreator.remote.Utils"%>
<%@page import="org.jgroups.blocks.GroupRequest"%>
<%@page import="java.util.Iterator"%>

<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
 	<!-- dwr begin-->
		<script language="javascript" type="text/javascript" src='<%=request.getContextPath()%>/dwr/engine.js'> </script>
		<script language="javascript" type="text/javascript" src='<%=request.getContextPath()%>/dwr/util.js'> </script>
		<script language="javascript" type="text/javascript" src='<%=request.getContextPath()%>/dwr/interface/datasourceChange.js'></script>
	<!-- dwr end -->
    <title>datasourceList</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
				<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/applymanager/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="../../include/pager.js" type="text/javascript"></script>
		<script language="JavaScript" src="<%=request.getContextPath()%>/purviewmanager/scripts/func.js" type="text/javascript"></script>
	<script type="text/javascript">
	
	function modifyRecord(dealType) {
	    var outMsg;
		var count=0;   
	    for (var i=0;i<datasourceform.elements.length;i++) {
			var e = datasourceform.elements[i];
							
			if (e.name == 'checkBoxOne'){
				if (e.checked){
		       		count++;
			    }
			}
	    }
	    if (count==1){
			editApply();
	    }else{
	    	alert("请选择你要修改的一条(仅一条)记录！");
	    	return false;
	    }
		return false;
	}
	
	function editApply(){
		var value = document.getElementsByName("selectId").value;
		var ww = openWin('<%=basePath%>epp/datasourcemanage/datasourceInfo.jsp?isEdit=modify&&dbname='+value,screen.availWidth-320,screen.availHeight-80);
		if(ww)
			{
				location.reload();
			}
	}
	
	function getApplyInfo(datasource_name){
		document.getElementsByName("selectId").value=datasource_name;
	}
	
	function createDatasource(){
		var ww=openWin('<%=basePath%>epp/datasourcemanage/datasourceInfo.jsp?isEdit=add',screen.availWidth-320,screen.availHeight-80);
		if(ww){
			location.reload();
		}
	}
	//删除数据源
	function delRecord(dealType){
		var isSelect = false;
    	var outMsg;
	    for (var i=0;i<datasourceform.elements.length;i++) {
			var e = datasourceform.elements[i];						
			if (e.name == 'checkBoxOne'){
				if (e.checked){
		       		isSelect=true;    		
		       		break;
			    }
			}
	    }
	    if (isSelect){    		
	        	if (confirm("确认删除吗？")){
	        		var inputObjects = document.getElementsByName("checkBoxOne");
					var arrayValues = new Array;
					for(var i = 0;i < inputObjects.length;i ++){
						if(false != inputObjects[i].checked)
							//alert("value="+inputObjects[i].value);
							arrayValues[arrayValues.length] = inputObjects[i].value;
					}
					datasourceChange.delDatasource(arrayValues,returnValue);
			} 
	    }else{
	    	alert("至少要选择一条记录！");
	    	return false;
	    }
		return false;
	}
	//根据返回值来输出成功or失败
	function returnValue(obj){
		if(obj){
			alert("删除成功,请重启服务器生效!");
		}else{
			alert("删除失败");
		}
		
		window.parent.location.reload();
	}
	</script>
  </head>
  <%@ include file="/epp/css/cssControl.jsp"%> 
  <body class="contentbodymargin" scroll="no">
    <form name="datasourceform" action="" method="post">
    	<table width="100%" border="0" cellpadding="1" cellspacing="1" class="thin">
   			<tr>
				<td height='30' class="detailtitle" align=center colspan=10>
					<h4><b>数据源列表</b></h4>
				</td>
			</tr>
    		<pg:listdata dataInfo="com.chinacreator.epp.datasourcemanage.menu.DatasourceList" keyName="DatasourceList" />
			<!--分页显示开始,分页标签初始化-->
			<pg:pager maxPageItems="10" scope="request" data="DatasourceList" isList="false">
			
			<tr class="labeltable_middle_td">
							<!--设置分页表头-->
							<td class="headercolor" width="6%">
								<P align="left">
									<INPUT type="checkbox" name="checkBoxAll" onClick="checkAll('checkBoxAll','checkBoxOne')" value="on">
								</P>
							</td>
							<td height='20' class="headercolor">
								数据源名字
							</td>
							<input class="text" type="hidden" name="selectId">
							<input class="text" type="hidden" name="selectBusinessEntity">
							<input class="text" type="hidden" name="selectUddiUrl">
							<input name="delSingle" type="hidden" validator="string" maxlength="100" value="false">
							<td height='20' class="headercolor">
								数据库驱动
							</td>
							<td height='20' class="headercolor">
								数据库链接地址
							</td>
							<td height='20' class="headercolor">
								数据库用户名
							</td>
							<!-- 
							<td height='20' class="headercolor">
								技术模型
							</td>
							<td height='20' class="headercolor">
								注册服务路径
							</td>
							<td height='20' class="headercolor">
								查询服务路径
							</td>
							 -->
						</tr>

						<!--检测当前页面是否有记录-->
						<pg:notify>
							<tr height='25' class="labeltable_middle_tr_01">
								<td colspan=100 align='center'>
									暂时没有数据源配置
								</td>
							</tr>
						</pg:notify>

						<!--list标签循环输出每条记录-->
						<pg:list>
							<tr class="labeltable_middle_tr_01" onMouseOver="this.className='mousestyle1'" onMouseOut="this.className= 'mousestyle2'" onClick="getApplyInfo('<pg:cell colName="dbname" defaultValue="" />')" onDBLclick="editApply()">
								<td class="tablecells" nowrap="true">
									<P align="left">
										<INPUT type="checkbox" name="checkBoxOne" onClick="checkOne('checkBoxAll','checkBoxOne')" value='<pg:cell colName="dbname" defaultValue=""/>'>
									</P>
								</td>
								<td height='20' width="100" align=left class="tablecells" style="word-wrap:break-word;">
									<pg:cell colName="dbname" defaultValue="" />
								</td>
								<td height='20' width="150" align=left class="tablecells" style="word-wrap:break-word;">
									<pg:cell colName="driver" defaultValue="" />
								</td>
								<td height='20' width="150" align=left class="tablecells" style="word-wrap:break-word;">
									<pg:cell colName="url" defaultValue="" />
								</td>
								<td height='20' width="100" align=left class="tablecells" style="word-wrap:break-word;" onMouseOver="">
									<pg:cell colName="username" defaultValue="" maxlength="30" replace="..." />
								</td>
				<!-- 				<td height='20' width="200" align=left class="tablecells" style="word-wrap:break-word;">
									<pg:cell colName="tmodelkey" defaultValue="" maxlength="30" replace="..."/>
								</td>
								 -->
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
								<input name="Submit" type="button" class="input" value="新增" onClick="createDatasource()">
								<input name="Submit" type="button" class="input" value="修改" onClick="javascript:modifyRecord(0); return false;">
								<input type="button" value="删除" class="input" onClick="javascript:delRecord(0); return false;">
								<%
								}
								%>
							</td>
						</tr>
			
			</pg:pager>
    	</table>
    </form>
  </body>
</html>
