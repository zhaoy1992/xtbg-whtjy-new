<%@ include file="/sysmanager/include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
String basePath = request.getContextPath()+"/";
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	
	request.setAttribute("myid",control.getUserAccount());
	String app_id=(String)session.getAttribute("subsystem_id");
	
	String rr = request.getParameter("rowcount");
	String qt = request.getParameter("queryType");
	int rowcount = (rr == null || rr.equals("") ? 10 : Integer.parseInt(rr));
	String queryType = qt == null ||qt.equals("") ? "0" : qt;
	
	if(app_id==null || "module".equals(app_id)){
	//out.print("<script language='JavaScript'>");
  	//out.print("window.location.href='"+request.getContextPath()+"/delegate/alert.html';");
  	//out.print("</script>");
	}
	
String designeeId = request.getParameter("designeeId");
designeeId = designeeId == null ? "" : designeeId;
String designeeName = request.getParameter("designeeName");
designeeName = designeeName == null ? "" : designeeName;

String startHH1 = request.getParameter("startHH1");
startHH1 = startHH1 == null ? "0" :startHH1;
String startHH2 = request.getParameter("startHH2");
startHH2 = startHH2 == null ? "23" :startHH2;
String endHH1 = request.getParameter("endHH1");
endHH1 = endHH1 == null ? "0" :endHH1;
String endHH2 = request.getParameter("endHH2");
endHH2 = endHH2 == null ? "23" :endHH2;

String startDate1 = request.getParameter("startDate1");
startDate1 = startDate1 == null ? "" : startDate1;
String startDate2 = request.getParameter("startDate2");
startDate2 = startDate2 == null ? "" : startDate2;
String endDate1 = request.getParameter("endDate1");
endDate1 = endDate1 == null ? "" : endDate1;
String endDate2 = request.getParameter("endDate2");
endDate2 = endDate2 == null ? "" : endDate2;

String s=request.getParameter("flag");
String id=request.getParameter("id");
String s2 = "";
if("2".equals(s)) {
	s2= com.chinacreator.epp.delegate.DelegateService.getInstance().delDelegate(id);
}
%>
<html>
	<head>
		<title>委托授权</title>

		<link rel="stylesheet" type="text/css" href="<%=basePath%>sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="<%=basePath%>sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="<%=basePath%>sysmanager/css/tab.winclassic.css">
	<script language="JavaScript" src="<%=request.getContextPath()%>/public/datetime/calender_date.js"></script>

	
		
		<script type="text/javascript">
		function openwin(p){
		window.showModalDialog('delegatedetail.jsp?id='+p,'window',"dialogHeight=500px;dialogWidth=500px;center=yes");
		}
		
		function openwidnadd(p){
		//window.showModalDialog('add.jsp?flag='+p,'window',"dialogHeight=500px;dialogWidth=500px;center=yes");
		window.location.href('add.jsp?flag='+p);
		}
		
		function editorjob(p,s){
			if(3==s || 4==s || 5==s){
			alert('该任务委派已取消或结束或拒绝！');
			return;
			}
			if(1==s){
			//等待确认状态才能修改
			window.location.href('editor.jsp?id='+p);
			}else{
			//其他状态
			window.location.href='cancel.jsp?id='+p;
			}
		}
		
		function delDelegate(id){
			//if(confirm("确定删除？")){
			    document.getElementById("id").value = id;
			    document.getElementById("flag").value = "2";
				ApplyForm.submit();
			//}
		}
		function clearInput(){
			document.getElementById("designeeId").value="";
			document.getElementById("designeeName").value="";
			document.getElementById("startDate1").value="";
			document.getElementById("startDate2").value="";
			document.getElementById("endDate1").value="";
			document.getElementById("endDate2").value="";
			document.getElementById("startHH1").value="0";
			document.getElementById("startHH2").value="23";
			document.getElementById("endHH1").value="0";
			document.getElementById("endHH2").value="23";
			document.getElementById("sHH1").value="0";
			document.getElementById("sHH2").value="23";
			document.getElementById("eHH1").value="0";
			document.getElementById("eHH2").value="23";
		}
		
		function changeQuery(){
			var butName = document.getElementById("buttonxx").value;
			if(butName == "高级查询"){
				document.getElementById("timeId").style.display="";
				document.getElementById("timeId1").style.display="";
				document.getElementById("buttonxx").value="简单查询";
				document.getElementById("queryType").value="1";
			}else if(butName == "简单查询"){
				document.getElementById("timeId").style.display="none";
				document.getElementById("timeId1").style.display="none";
				document.getElementById("buttonxx").value="高级查询";
				document.getElementById("queryType").value="0";
			}
		}
		
		function del(){
			var arr = document.getElementsByName("idStr");
			var count = 0;
			var ids = "";
			for(var i=0;i<arr.length;i++){
				if(arr[i].checked){
					if(ids == ""){
						ids = arr[i].value;
					}else{
						ids += ","+arr[i].value;
					}
					count++;
				}
			}
			if(count < 1){
				alert("请选择要删除记录！");
				return false;
			}
			if(confirm("您确认要删除吗？")){
				delDelegate(ids);
			}
		}
		
		function cancel(){
			var arr = document.getElementsByName("idStr");
			var count = 0;
			var ids = "";
			for(var i=0;i<arr.length;i++){
				if(arr[i].checked){
					if(ids == ""){
						ids = arr[i].value;
					}else{
						ids += ","+arr[i].value;
					}
					count++;
				}
			}
			if(count < 1){
				alert("请选择要取消委托的记录！");
				return false;
			}
			if(confirm("您确认要取消委托吗？")){
				alert(ids);
				docancel(ids);
			}
		}
		
		function docancel(p)
		{
		var url = '<%=basePath%>delegate/docancel.jsp';
		var pars = 'id=' + p + '&nowtime=' + new Date().getTime();
		var myAjax = new Ajax.Request(
		url,
		{
			method: 'get',
			parameters: pars,    //Loading, Loaded, Interactive
			onComplete: showResponse
		});
	}
		</script>
	
		<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin" scroll="no">
			<table width="95%" align="center"  cellpadding="1" cellspacing="1" border="0" class="thin">
				<tr><td><img src="<%=basePath%>sysmanager/images/actions.gif" align="absMiddle">&nbsp;&nbsp;委托授权</td><tr>
			</table>
			<form name="ApplyForm" action="showdelegate.jsp" method="post">
			  <table width="95%" align="center"  cellpadding="1" cellspacing="1" border="0" bordercolor="#EEEEEE" class="thin">
              <!--<table width="100%" border="0" cellpadding="1" cellspacing="1" class="thin">
					--><tr>
						<!--<td class="detailtitle" width="10%" align=right>
							被委托人ID
						</td>
						<td class="detailcontent" width="20%">
							<input type="text" name="designeeId" style="width:70%" value="<%=designeeId %>">
						</td>
						--><td class="detailtitle" width="10%" align=right>
							被委托人名
						</td>
						<td class="detailcontent" colspan="3" width="40%">
							<input type="text" name="designeeName" style="width:26%" value="<%=designeeName %>">
						</td>
					</tr>
					<tr id="timeId" style="display:none">
						<td class="detailtitle" width="10%" align=right>
							委托开始时间从
						</td>
						<td class="detailcontent" width="20%">
							<input type="text" name="startDate1" style="width:70%" readonly value="<%=startDate1 %>" onclick="showdate(this);">
							<input type="hidden" name = "startHH1" value="<%=startHH1 %>">
							<select id="sHH1" value="<%=startHH1 %>" onchange="document.getElementById('startHH1').value = this.value">
								<% 
								for(int i = 0; i < 24; i++){
								%>
									<option value="<%=i %>"><%=i %></option>
								<%
								}
								%>
							</select>
								点
						</td>
						<td class="detailtitle" width="10%" align=right>
							到
						</td>
						<td class="detailcontent" width="20%">
							<input type="text" name="startDate2" style="width:70%" readonly value="<%=startDate2 %>" onclick="showdate(this);">
							<input type="hidden" name = "startHH2" value="<%=startHH2 %>">
							<select id="sHH2" value="<%=startHH2 %>" onchange="document.getElementById('startHH2').value = this.value">
								<% 
								for(int i = 23; i >= 0; i--){
								%>
									<option value="<%=i %>"><%=i %></option>
								<%
								}
								%>
							</select>
								点
						</td>
					</tr>
					<tr id="timeId1" style="display:none">
						<td class="detailtitle" width="10%" align=right>
							委托结束时间从
						</td>
						<td class="detailcontent" width="20%">
							<input type="text" name="endDate1" style="width:70%" readonly value="<%=endDate1 %>" onclick="showdate(this);">
							<input type="hidden" name = "endHH1" value="<%=endHH1 %>">
							<select id="eHH1" value="<%=endHH1 %>" onchange="document.getElementById('endHH1').value = this.value">
								<% 
								for(int i = 0; i < 24; i++){
								%>
									<option value="<%=i %>"><%=i %></option>
								<%
								}
								%>
							</select>
								点
						</td>
						<td class="detailtitle" width="10%" align=right>
							到
						</td>
						<td class="detailcontent" width="20%">
							<input type="text" name="endDate2" style="width:70%" readonly value="<%=endDate2 %>" onclick="showdate(this);">
							<input type="hidden" name = "endHH2" value="<%=endHH2 %>">
							<select id="eHH2" value="<%=endHH2 %>" onchange="document.getElementById('endHH2').value = this.value">
								<% 
								for(int i = 23; i >= 0; i--){
								%>
									<option value="<%=i %>"><%=i %></option>
								<%
								}
								%>
							</select>
								点
						</td>
					</tr>
					<tr>
						<td class="detailcontent" width="*" colspan="4" align="right">                           
							<input name="Submit4" type="submit" class="input" value="查询">
							<input type="button" id="buttonxx" class="input" onclick="changeQuery();" value="高级查询">
							<input name="Submit22" type="button" class="input" value="重置" onClick="clearInput()">
						</td>
					</tr>
				</table>
				<!-- --------------------------------------内容部分------------------------------------------- -->
				<table width="95%" align="center" cellpadding="0" cellspacing="0" border="0" class="toolbar">
					<tr><td>
						<input type="button" value="新增委托" onclick="openwidnadd(1);" class="input" style="cursor:hand"/>
						<input type="button" value="新增上级委托" onclick="openwidnadd(2)" class="input" style="cursor:hand"/>
						<input type="button" class="input" onclick="del()" value="删除">
						<input type="hidden" name="rowcount" id="rowcount" value="<%=rowcount %>">
						<input type="hidden" name="queryType" id="queryType" value="<%=queryType %>">
					</td><td style="text-align:right">
						<div float="right">
						列表最大行数：<input type="text" id="inputRow" value="<%=rowcount%>" size="5"	onkeydown="if(event.keyCode==13){$('rowcount').value=$('inputRow').value;commit();}"/>
						<input type="button" value="应用" onclick="document.getElementById('rowcount').value=document.getElementById('inputRow').value;document.ApplyForm.submit();" />
						<input type="button" value="复位" onclick="document.getElementById('rowcount').value=10;document.ApplyForm.submit();" />
						</div>
					</td></tr>
				</table>
				<table width="95%" align="center" cellpadding="1" cellspacing="1" class="thin">
					<input type="hidden" name="flag"/>
					<input type="hidden" name="id"/>
					<pg:listdata dataInfo="com.chinacreator.epp.delegate.DelegateList" keyName="DelegateList" />
					<!--分页显示开始,分页标签初始化-->
					<pg:pager maxPageItems="<%=rowcount%>" scope="request" data="DelegateList" isList="false">
						<tr class="labeltable_middle_td">
							<td class="headercolor" width="3%">
								<input type="checkbox" name="checkBoxAll" onclick="checkAll('checkBoxAll','idStr')">
							</td>
							<!--设置分页表头-->
							<td height='20' class="headercolor">
								委托人名
							</td>
							<td height='20' class="headercolor">
								被委托人名
							</td>
							<td height='20' class="headercolor">
								委托开始时间
							</td>
							
							<td height='20' class="headercolor">
								委托结束时间
							</td>
							<td height='20' class="headercolor">
								委托状态
							</td>
							
							<!-- <td height='20' class="headercolor">
								业务类别名字
							</td> -->
							
							<td height='20' class="headercolor">
								操作
							</td>
						</tr>

						<!--检测当前页面是否有记录-->
						<pg:notify>
							<tr height='25' class="labeltable_middle_tr_01">
								<td colspan=100 align='center'>
									暂时没有委托任务
								</td>
							</tr>
						</pg:notify>

						<!--list标签循环输出每条记录-->
						<pg:list>
							<tr class="labeltable_middle_tr_01" onMouseOver="this.style.backgroundColor = '#DAE0E9'" onMouseOut="this.style.backgroundColor = '#ffffff'" style="cursor:hand">
								<td class="tablecells" style="word-break:break-all;word-wrap: break-word">
									<P align="left">
										<pg:notequal colName="delegateStat" value="2">
										<input type="checkbox" name="idStr" onclick="checkOne('checkBoxAll','idStr')"
												value='<pg:cell colName="delegateId" defaultValue=""/>'>
										</pg:notequal>
									</P>
								</td>
							
								<td height='10' width="100" align=left class="tablecells" style="word-wrap:break-word;" onClick="editorjob(<pg:cell colName='delegateId'/>,<pg:cell colName='delegateStat'/>);" >
									<pg:cell colName="designator" defaultValue="" />
								</td>
								
								<td height='10' width="110" align=left class="tablecells" style="word-wrap:break-word;" onClick="editorjob(<pg:cell colName='delegateId'/>,<pg:cell colName='delegateStat'/>);" >
									<pg:cell colName="designeeName" defaultValue="" />
								</td>
								<td height='10' width="100" align=left class="tablecells" style="word-wrap:break-word;" onMouseOver="" onClick="editorjob(<pg:cell colName='delegateId'/>,<pg:cell colName='delegateStat'/>);" >
									<pg:cell colName="delegateTime" defaultValue="" dateformat="yyyy-MM-dd HH:mm"/>
								</td>
								<td height='10' width="100" align=left class="tablecells" style="word-wrap:break-word;" onClick="editorjob(<pg:cell colName='delegateId'/>,<pg:cell colName='delegateStat'/>);" >
									<pg:cell colName="delegateEndTime" defaultValue="" dateformat="yyyy-MM-dd HH:mm"/>
								</td>
								
								<td height='10' width="100" align=left class="tablecells" style="word-wrap:break-word;" onClick="editorjob(<pg:cell colName='delegateId'/>,<pg:cell colName='delegateStat'/>);" >
									<pg:equal colName="delegateStat" value="1">
										等待确认
									</pg:equal>
									
									<pg:equal colName="delegateStat" value="2">
										委托中	
									</pg:equal>
									
									<pg:equal colName="delegateStat" value="3">
										委托结束
									</pg:equal>
									<pg:equal colName="delegateStat" value="4">
										委托取消
									</pg:equal>
									
									<pg:equal colName="delegateStat" value="5">
										拒绝委托
									</pg:equal>
									
								</td>
								<!-- <td height='10' width="100" align=left class="tablecells" style="word-wrap:break-word;">
									<pg:cell colName="ecName" defaultValue="" maxlength="7" replace="..."/>
								</td> -->
								
								<td height='10' width="100" align=center class="tablecells" style="word-wrap:break-word;">
									<input type="button" value="查看" onclick="openwin(<pg:cell colName='delegateId'/>);" class="input" style="cursor:hand"/>
								</td>
								
						</pg:list>
						
					<tr><td colspan="100" align="center">总共:<pg:rowcount />条记录&nbsp;&nbsp;<pg:index /><input type="hidden" name="queryString" value="<pg:querystring/>"/>
					<input type="hidden" name="rcount" id="rcount" value="<pg:rowcount />"/></td></tr>
						<!--<tr height="30" class="labeltable_middle_tr_01">
							<td colspan=100 align='right'>
							双击记录可修改
							<input type="button" value="新增委托" onclick="openwidnadd(1);" class="input" style="cursor:hand"/>
							<input type="button" value="新增上级委托" onclick="openwidnadd(2)" class="input" style="cursor:hand"/>
								共
								<pg:rowcount />
								条记录
								<pg:index />
							</td>
						</tr>
					--></pg:pager>

				</table>

			</form>
		<iframe id="hiddenIfr" width="0" height="0" border="0"></iframe>

	</body>
</html>
<script type="text/javascript">
<!--
var s2 = "<%=s2 %>";
if(s2 != ""){
	alert(s2);
}
document.getElementById("sHH1").value="<%=startHH1 %>";
document.getElementById("sHH2").value="<%=startHH2 %>";
document.getElementById("eHH1").value="<%=endHH1 %>";
document.getElementById("eHH2").value="<%=endHH2 %>";

var queryType = "<%=queryType %>";
if(queryType == "0"){
	document.getElementById("timeId").style.display="none";
	document.getElementById("timeId1").style.display="none";
	document.getElementById("buttonxx").value="高级查询";
}else{
	document.getElementById("timeId").style.display="";
	document.getElementById("timeId1").style.display="";
	document.getElementById("buttonxx").value="简单查询";
}
//-->
</script>
