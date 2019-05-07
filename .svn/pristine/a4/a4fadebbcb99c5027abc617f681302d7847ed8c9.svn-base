<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.ContextMenu"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.ContextMenuImpl"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.Menu"%>

<% 
	String rootpath = request.getContextPath();
%>
<html>
	<head>
		<title>日志管理</title>
		
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/tab.winclassic.css">

<script language="JavaScript">
	function checkAll(totalCheck,checkName){	//复选框全部选中
	   var selectAll = document.getElementsByName(totalCheck);
	   var o = document.getElementsByName(checkName);
	   if(selectAll[0].checked==true){
		   for (var i=0; i<o.length; i++){
	      	  if(!o[i].disabled){
	      	  	o[i].checked=true;
	      	  }
		   }
	   }else{
		   for (var i=0; i<o.length; i++){
	   	  	  o[i].checked=false;
	   	   }
	   }
	}
	//单个选中复选框
	function checkOne(totalCheck,checkName){
	   var selectAll = document.getElementsByName(totalCheck);
	   var o = document.getElementsByName(checkName);
		var cbs = true;
		for (var i=0;i<o.length;i++){
			if(!o[i].disabled){
				if (o[i].checked==false){
					cbs=false;
				}
			}
		}
		if(cbs){
			selectAll[0].checked=true;
		}else{
			selectAll[0].checked=false;
		}
	}	
	
		
	
	function dealRecord(dealType) {//删除日志
	    var isSelect = false;	    
	    for (var i=0;i<LogForm.elements.length;i++) {
			var e = LogForm.elements[i];
			if (e.name == 'ID'){
				if (e.checked){
		       		isSelect=true;
		       		break;
			    }
			}
	    }	    
	    if (isSelect){
	    	if (dealType==1){
	    		var msg = "你确定要删除吗？(删除后是不可以再恢复的)";
	        	if(confirm(msg)){    
		            LogForm.action="deleteLog.jsp";
		            LogForm.target = "deleteLogs"; 
		            document.all("deleteLogs").src = "deleteLog.jsp";                      
		            LogForm.submit();
		        }
			} 
	    }else{
	    	alert("至少要选择一条记录！");
	    	return false;
	   }
	}
	
	
		function dealAllRecord() {//删除日志
	    var hasLitems = false;	  
	    
	    for (var i=0;i<LogForm.elements.length;i++) {
			if(LogForm.elements[i].name == 'ID')
			{
				hasLitems = true;
				break;
			}
	    }
		
		if(hasLitems)
		{
			if(confirm("确定删除所有项？(删除后是不可以再恢复的)。"))
			{
				LogForm.action="<%=rootpath%>/sysmanager/logmanager/submitLog_do.jsp?flag=2";
				LogForm.submit();
			}
		}else{
	    	alert("当前无可以删除的记录。");
	    	return false;
	   }
  		   
	}		
	function dealRangeRecord(){
        var operUser = parent.document.all("operUser").value;
       if(operUser=="") operUser = "所有操作人";
        var oper = parent.document.all("oper").value;
        if(oper=="") oper = "所有类型";
        var type = parent.document.all("type").value;
        if(type=="") type = "所有内容";
        var startDate = parent.document.all("startDate").value;
        var endDate = parent.document.all("endDate").value;
        if(startDate!="" && endDate!="")
        {
        var msg = "您确定删除 \n" ;
        msg += "操作人帐号:"+operUser+"\n";
        msg += "日志类型:"+oper+"\n";
        msg += "日志内容:"+type+"\n";
        msg += "时间从"+startDate+"到"+endDate+"之间的日志吗?";
        if(confirm(msg)){
            LogForm.action="deleteRangeLogs.jsp?operUser="+operUser+"&&oper="+oper+"&&type="+type+"&&startDate="+startDate+"&&endDate="+endDate;
            LogForm.target = "deleteLogs";
            LogForm.submit();
        }
        }
        else
        {
        	alert('请指定要删除的操作起止时间');
        }
    
    }
    
    function logDetailQuery(logId){
    	window.showModalDialog("logDetailList.jsp?logId="+logId,window,"dialogWidth:"+(800)+"px;dialogHeight:"+(600)+"px;scroll=yes;status=no;titlebar=no;toolbar=no;maximize=yes;minimize=0;");
    	
    }
</script>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin">
		<div id="contentborder" align="center">
		 	<iframe src="" name="deleteLogs" width=0 height=0 style="display:none"></iframe>
			<!-- 这些功能不需要提供
			<div align="left">
<input name="button" type="button" class="input"
								onclick="dealRecord(1)" value="删除选中项">
                              &nbsp;<input name="button" type="button" class="input"
                                onclick="dealRangeRecord()" value="按时间段删除">
							  &nbsp;<input type="button" value="删除所有" class="input"
								onclick="dealAllRecord()">
							    </div>
				 -->		    
				<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">

					
					<pg:listdata dataInfo="com.chinacreator.sysmgrcore.web.tag.LogSearchList" keyName="LogSearchList" />
					<!--分页显示开始,分页标签初始化-->
					<pg:pager maxPageItems="12" scope="request" data="LogSearchList" isList="false">
						<tr class="labeltable_middle_td">
							<!--设置分页表头-->
							<td class="headercolor" align="center">
				  			<input type="checkBox" name="checkBoxAll" onClick="checkAll('checkBoxAll','ID')">
				  			</td>
				  			<input class="text" type="hidden" name="selectId">
				  			
				  			<td height='20' class="headercolor">操作模块</td>
				    		<td height='20' class="headercolor">操作人帐号</td>
				    		<td height='20' class="headercolor">操作人机构</td>				    		
							<td height='20' class="headercolor">日志内容</td>
							<td height='20' class="headercolor">操作类型</td>
							<td height='20' class="headercolor">日志来源</td>
							<td height='20' class="headercolor">操作时间</td>
					</tr>
						<pg:param name="operUser"/>
						<pg:param name="logModuel"/>
						<pg:param name="type"/>
						<pg:param name="oper"/>
						<pg:param name="logId"/>
						<pg:param name="startDate"/>
						<pg:param name="endDate"/>
						<pg:param name="curUserId"/>
						<pg:param name="isHis"/>
						<pg:param name="opOrgid"/>
						<pg:param name="logVisitorial"/>
						<pg:param name="isRecursion"/>
						
						
						<!--检测当前页面是否有记录-->
						<pg:notify>
							<tr height='25' class="labeltable_middle_tr_01">
								<td colspan="100" align='center'>
									暂时没有日志记录
								</td>
							</tr>
						</pg:notify>
						<%
							//右键菜单
						//	ContextMenu contextmenu = new ContextMenuImpl();
					 	%>
						<!--list标签循环输出每条记录-->
						<pg:list>
						<% 
							String logId = dataSet.getString("logId");
						//	Menu menu = new Menu();
						//	menu.setIdentity("opuser_"+logId);
						//	Menu.ContextMenuItem menuitem2 = new Menu.ContextMenuItem();
						//	menuitem2.setName("日志明细查看");
						//	menuitem2.setLink("javascript:logDetailQuery("+logId+")");
						//	menuitem2.setIcon(request.getContextPath() +"/sysmanager/images/new.gif");
						//	menu.addContextMenuItem(menuitem2);
							
						//	contextmenu.addContextMenu(menu);
						//	request.setAttribute("opuser",contextmenu);
						%>
						<pg:contextmenu enablecontextmenu="true" context="opuser" scope="request"/> 
							<tr onMouseOver="this.className='mouseover'" onMouseOut="this.className= 'mouseout'">
								
								<td nowrap class="tablecells" align="center"><input onClick="checkOne('checkBoxAll','ID')" type="checkbox" name="ID" value="<pg:cell colName="logId" defaultValue=""/>"></td>	
								
								<td nowrap height='20' align=left class="tablecells"><pg:cell colName="logModule" defaultValue="" /></td>													      				
								<td id="opuser_<%=logId%>" nowrap height='20' align=left class="tablecells"  ><pg:cell colName="operUser" defaultValue="" /></td>
								<td height='20' align=left class="tablecells"><pg:cell colName="operOrg" defaultValue="" /></td>
								<td height='20' align=left class="tablecells"><pg:cell colName="oper" defaultValue="" /></td>
								<td nowrap height='20' align=left class="tablecells">
								<pg:equal colName="operType" value="0">无操作</pg:equal>
								<pg:equal colName="operType" value="1">新增</pg:equal>
								<pg:equal colName="operType" value="2">删除</pg:equal>
								<pg:equal colName="operType" value="3">修改</pg:equal>
								<pg:equal colName="operType" value="4">其他</pg:equal>								
								</td>
								<td nowrap height='20' align="left" class="tablecells"><pg:cell colName="visitorial" defaultValue="" /></td>
								<td nowrap height='20' align="left" class="tablecells"><pg:cell colName="operTime" defaultValue="" dateformat="yyyy-MM-dd HH:mm:ss"/></td>
								
							</tr>
						</pg:list>
						<tr height="30" class="labeltable_middle_tr_01">
							<td colspan="100" align='center'>
							  共<pg:rowcount/>条记录&nbsp;&nbsp;<pg:index />
							<input type="hidden" name="querystring" value="<pg:querystring/>"></td>
						</tr>
					</pg:pager>
 
				</table>

	          <div align="center"></div>
		</div>
			</body>
</html>
