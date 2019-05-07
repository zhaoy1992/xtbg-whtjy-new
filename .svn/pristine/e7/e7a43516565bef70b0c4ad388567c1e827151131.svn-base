<%@ include file="/sysmanager/include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	String basePath = request.getContextPath()+"/";
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	request.setAttribute("bedelegateId",control.getUserAccount());
	
		String app_id=(String)session.getAttribute("subsystem_id");
	
	if(app_id==null || "module".equals(app_id)){
	//out.print("<script language='JavaScript'>");
  	//out.print("window.location.href='"+request.getContextPath()+"/delegate/alert.html';");
  	//out.print("</script>");
	}
	
	String rr = request.getParameter("rowcount");
	String qt = request.getParameter("queryType");
	int rowcount = (rr == null || rr.equals("") ? 10 : Integer.parseInt(rr));
	String queryType = qt == null ||qt.equals("") ? "0" : qt;

	String designator = request.getParameter("designator");
	designator = designator == null ? "" : designator;

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
%>
<html>
	<head>
		<title>委托给我的任务</title>

		<link rel="stylesheet" type="text/css" href="<%=basePath%>sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="<%=basePath%>sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="<%=basePath%>sysmanager/css/tab.winclassic.css">
		<script type="text/javascript" src="<%=basePath%>delegate/prototype-1.4.0.js"></script>
	<script language="JavaScript" src="<%=request.getContextPath()%>/public/datetime/calender_date.js"></script>
		<script type="text/javascript">
		var mid;
		function accept123(p)
		{
		mid=p;
		var url = '<%=basePath%>delegate/acceptorreject.jsp';
		var pars = 'id=' + p +'&flag=accept&nowtime=' + new Date().getTime();
		var myAjax = new Ajax.Request(
		url,
		{
		method: 'get',
		parameters: pars,    //Loading, Loaded, Interactive
		onComplete: showResponse
		});
		}
		function showResponse(originalRequest)
		{
		//put returned XML in the textarea
		var restr=originalRequest.responseText;
		if(restr.replace(/\s+/g,"")=="success"){
		$(mid+'accept').innerHTML='已接受';
		$(mid+'input').innerHTML='已接受';
		$(mid+'reject').innerHTML='已接受';
		}else{
		alert(restr);
		}
		}
		
		</script>
		
		<script>
		var mid2;
		function reject123(p)
		{
		mid2=p;
		var url = '<%=basePath%>delegate/acceptorreject.jsp';
		var pars = 'id=' + p +'&flag=reject&nowtime=' + new Date().getTime();
		var myAjax = new Ajax.Request(
		url,
		{
		method: 'get',
		parameters: pars,    //Loading, Loaded, Interactive
		onComplete: showResponse2
		});
		}
		function showResponse2(originalRequest)
		{
		//put returned XML in the textarea
		var restr=originalRequest.responseText;
		if(restr.replace(/\s+/g,"")=="success"){
		$(mid2+'accept').innerHTML='已拒绝';
		$(mid2+'input').innerHTML='已拒绝';
		$(mid2+'reject').innerHTML='已拒绝';
		}else{
		alert(restr);
		}
		}
	
		function clearInput(){
			document.getElementById("designator").value="";
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
		
		function do1(type){
			var arr = document.getElementsByName("idStr");
			var count = 0;
			var ids = "";
			for(var i=0;i<arr.length;i++){
				if(arr[i].checked){
					ids = arr[i].value;
					count++;
				}
			}
			if(count < 1){
				alert("请选择一条记录！");
				return false;
			}else if(count > 1){
				alert("只能选择一条记录！");
				return false;
			}
			if(type == "1"){
				accept123(ids);
			}else if(type == "2"){
				reject123(ids);
			}
		}
		</script>

		<%@ include file="/epp/css/cssControl.jsp"%>
		<body class="contentbodymargin" scroll="no">
			<table width="95%" align="center" cellspacing="1" cellpadding="1" border="0" class="thin">
				<tr><td><img src="<%=basePath%>sysmanager/images/actions.gif" align="absMiddle">&nbsp;&nbsp;被委托授权</td><tr>
			</table>
			<form name="ApplyForm" action="" method="post">
			  	<table width="95%" align="center" cellspacing="1" cellpadding="1" border="0" bordercolor="#EEEEEE" class="thin">
					<tr>
						<td class="detailtitle" width="10%" align=right>
							委托人名：
						</td>
						<td class="detailcontent" colspan="3" width="40%">
							<input type="text" name="designator" style="width:26%" value="<%=designator %>">
						</td>
					</tr>
					<tr id="timeId" style="display:none">
						<td class="detailtitle" width="10%" align=right>
							委托开始时间从：
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
							到：
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
							委派结束时间从：
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
							到：
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
						<input id="acceptb" type="button" value="接受委托" class="input" onclick="do1('1');"/>
						<input id="rejectb" type="button" value="拒绝委托" class="input" onclick="do1('2');"/>
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
					<pg:listdata dataInfo="com.chinacreator.epp.delegate.BeDelegateList" keyName="BeDelegateList" />
					<!--分页显示开始,分页标签初始化-->
					<pg:pager maxPageItems="<%=rowcount %>" scope="request" data="BeDelegateList" isList="false">
						<tr class="labeltable_middle_td">
							<td class="headercolor" width="3%">
								<input type="checkbox" name="checkBoxAll" onclick="checkAll('checkBoxAll','idStr')">
							</td>
							<!--设置分页表头-->
							<td height='20' class="headercolor">
								委托人名
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
								业务类别名
							</td> -->
							<td height='20' class="headercolor">
								查看详细
							</td>
						</tr>

						<!--检测当前页面是否有记录-->
						<pg:notify>
							<tr height='25' class="labeltable_middle_tr_01">
								<td colspan=100 align='center'>
									暂时没有被委托任务
								</td>
							</tr>
						</pg:notify>

						<!--list标签循环输出每条记录-->
						<pg:list>
							<tr class="labeltable_middle_tr_01" onMouseOver="this.style.backgroundColor = '#DAE0E9'" onMouseOut="this.style.backgroundColor = '#ffffff'">
								<td class="tablecells" style="word-break:break-all;word-wrap: break-word">
									<P align="left">
										<pg:equal colName="delegateStat" value="1">
										<input type="checkbox" name="idStr" onclick="checkOne('checkBoxAll','idStr')"
												value='<pg:cell colName="delegateId" defaultValue=""/>'>
										</pg:equal>
									</P>
								</td>
							
								<td height='20' width="100" align=left class="tablecells" style="word-wrap:break-word;">
									<pg:cell colName="designator" defaultValue="" />
								</td>
								<td height='20' width="200" align=left class="tablecells" style="word-wrap:break-word;" onMouseOver="">
									<pg:cell colName="delegateTime" defaultValue="" dateformat="yyyy-MM-dd HH:mm"/>
								</td>
								<td height='20' width="200" align=left class="tablecells" style="word-wrap:break-word;">
									<pg:cell colName="delegateEndTime" defaultValue="" dateformat="yyyy-MM-dd HH:mm"/>
								</td>
								
								<td height='20' width="200" align=left class="tablecells" style="word-wrap:break-word;">
									<div id="<pg:cell colName='delegateId'/>input">
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
									</div>
								</td>
								<!-- <td height='20' width="200" align=left class="tablecells" style="word-wrap:break-word;">
									<pg:cell colName="ecName" defaultValue="" maxlength="7" replace="..."/>
								</td> -->
								<!--<td height='20' width="80" align=left class="tablecells" style="word-wrap:break-word;">
									<div id="<pg:cell colName='delegateId'/>accept" align="center">
											<pg:equal colName="delegateStat" value="1">	
											<input id="<pg:cell colName='delegateId'/>acceptb" type="button" value="接受委托" class="input" onclick="accept123(<pg:cell colName='delegateId'/>);"/>
											</pg:equal>
									</div>
								</td>
								<td height='20' width="80" align=left class="tablecells" style="word-wrap:break-word;">
									<pg:equal colName="delegateStat" value="1">	
									<div id="<pg:cell colName='delegateId'/>reject" align="center">
									<input id="<pg:cell colName='delegateId'/>rejectb" type="button" value="拒绝委托" class="input" onclick="reject123(<pg:cell colName='delegateId'/>);"/>
									</div>
									</pg:equal>
								</td>-->
								<td height='20' width="80" align=left class="tablecells" style="word-wrap:break-word;">
									<input type="button" value="查看" class="input" onclick="javascript:window.showModalDialog('mydetail.jsp?id=<pg:cell colName="delegateId"/>','window','dialogHeight=500px;dialogWidth=500px;center=yes');"/>
								</td>
								
						</pg:list>
						<tr>
							<td colspan="100" align="center">
								总共:
								<pg:rowcount />
								条记录&nbsp;&nbsp;
								<pg:index />
								<input type="hidden" name="queryString" value="<pg:querystring/>" />
								<input type="hidden" name="rcount" id="rcount"
									value="<pg:rowcount />" />
							</td>
						</tr>
				</pg:pager>

				</table>
			</form>
	</body>
</html>
<script type="text/javascript">
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
</script>