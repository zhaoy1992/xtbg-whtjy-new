<%@ include file="/sysmanager/include/global1.jsp"%>
<%@ include file="/sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page language="java" contentType="text/html; charset=GBK" 
			import="com.chinacreator.security.AccessControl,
			com.chinacreator.commonworkflow.dao.CommonWorkflowDao,			
			java.util.List,java.util.Iterator,
			com.chinacreator.commonworkflow.WorkflowConstants"%>
<%!
	int total;
	int index;
	String paramValue;
	List columnMap;
%>
<% 
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	index = 1;
	
	String tableName = "V_APP_WORK_LIST";
	CommonWorkflowDao dao = new CommonWorkflowDao();
	List thList = dao.getColumnComment(tableName, null);
	columnMap = dao.getColumnNameComment(tableName, null);

	String orderCondition = request.getParameter("ordercondition");
	String orderType = request.getParameter("ordertype");

	String isError = (String) request.getAttribute("isError");
	String message = (String) request.getAttribute("message");
	if (isError == null) {
		isError = "";
	}
%>

<html>
	<head>
		<title></title>
		<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/jobmanager/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/include/pager.js" type="text/javascript"></script>
		<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/scripts/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="<%=request.getContextPath()%>/public/datetime/calender_date.js" ></script>
		<script language="JavaScript">
<%if(isError.equals("true")){%>
	alert("<%=message%>");
<%}%>
	var jsAccessControl = new JSAccessControl("#ff0000","#ffffff","#eeeeee");
	function validateOnlyCheck(checkName)
	{
		 var o = document.all.item(checkName);
		 for (var i=0,j=0; o && o.length && i<o.length; i++){
	   	  	if(o[i].checked)
	   	  	{
	   	  		j++;
	   	   	}
	   	   	if(j == 2)
	   	   	{
	   	   		return false;
	   	   	}
	   	   }
		 return true;
	}
	function validatecheck(checkName)
	{
			 var o = document.all.item(checkName);
		for (var i=0; o && o.length && i<o.length; i++){
	   	  	  if(o[i].checked)
	   	  	  	return true;
	   	   }
	   	   if(o && !o.length )
			{
				if(o.checked)
					return true;
			}
			return false;
	}
	
	function checkAll(totalCheck,checkName){	//复选框全部选中
	   var selectAll = document.all.item(totalCheck);
	   
	   var o = document.all.item(checkName);
	   
	   if(selectAll.checked==true){
		   for (var i=0; o && o.length && i<o.length; i++){
	      	  if(!o[i].disabled){
	      	  	o[i].checked=true;
	      	  }
		   }
		   if(o && !o.length && !o.checked)
			{
				o.checked=true;
			}
		   
	   }else{
		   for (var i=0; o && o.length && i<o.length; i++){
	   	  	  o[i].checked=false;
	   	   }
	   	   if(o && !o.length && !o.checked)
			{
				o.checked=false;
			}
	   	   
	   }
	}
	//单个选中复选框
	function checkOne(totalCheck,checkName){
	   var selectAll = document.all.item(totalCheck);
	   var o = document.all.item(checkName);
		var cbs = true;
		
		for (var i=0;o && o.length && i < o.length;i++){
			if(!o[i].disabled){
				if (o[i].checked==false){
					cbs=false;
				}
			}
		}
		if(o && !o.length && !o.checked)
		{
			cbs = false;
		}
		if(cbs){
			selectAll.checked=true;
		}
		else{
			selectAll.checked=false;
		}
	}
	
	function handle(actInsId,busiId){
       document.location = "handle_form.jsp?actInsId="+actInsId+"&busiId="+busiId;
	}
	
	function orderList(ordercon) {
		var order = document.getElementById('order_' + ordercon).innerText;
		order = order.replace(/(^\s*)|(\s*$)/g, '');
		var orderType = '&ordertype=';
		if (order == '↑') {
			orderType += 'desc';
		} else if (order == '↓') {
			orderType += 'asc';
		} else {
			orderType += 'asc';
		}
		var url = "all_work_list.jsp?ordercondition=" + ordercon + orderType;
		document.location = url;
	}
	
	function resetForm(){
		var form = document.getElementById("work");
		var inputs = form.getElementsByTagName("input");
		
		for(var i=0;i<inputs.length;i++){
			var inputElement = inputs[i];
			if(inputElement.type=="text"){
				inputElement.value = "";
			}
		}
	}
	function search(){
		document.forms["work"].submit();
	}
</script>
<style>
body{margin:0; font-family:Arial, Helvetica, sans-serif; font-size:12px;}
td,div{line-height:170%}

.tab{border-collapse:collapse;font-size:12px;}
.tab th{background:url(<%=request.getContextPath()%>/epp/css/imagers/tab_bg.gif) repeat-x left; color:#666666;font-size:12px; font-weight:normal; height:25px;border:1px solid #ffffff; white-space:nowrap}
.tab td{border:1px solid #D1D5D8;white-space:nowrap; text-align:center; color:#666666}
.tab td a{color:#666666}
div{
 width:100%;
 height:100%;
 overflow-x:scroll;
 SCROLLBAR-HIGHLIGHT-COLOR: #ffffff;
 SCROLLBAR-SHADOW-COLOR: #D6E4F0;
 SCROLLBAR-3DLIGHT-COLOR: #D6E4F0;
 SCROLLBAR-ARROW-COLOR: #C1DAED;
 SCROLLBAR-TRACK-COLOR: #ffffff;
 SCROLLBAR-DARKSHADOW-COLOR: #ffffff;
 SCROLLBAR-BASE-COLOR: #ffffff;}
.inut_f{
	background:url(<%=request.getContextPath()%>/epp/css/imagers/input_bg.gif) 
	repeat-x left; 
	color:#ffffff; 
	border:1px solid #1A3BB7;
	padding-top:3px;
	padding-left:4px;
	padding-right:4px;}
</style>
</head>
	<body>
		<div>
			<FORM name="work" id="work" action="all_work_list.jsp" method="post">				
				<table width="100%" border="0" cellpadding="1" cellspacing="1"
					class="tab">
					<%
						Iterator ite = columnMap.iterator();
						total = columnMap.size();
						while (ite.hasNext()) {
							String entry = ite.next().toString();
							String[] entrys = entry.split(WorkflowConstants.ESPECIAL_SEPARATOR);							
					%>
					<%
					if (index % 2 == 1) {
					%>
					<tr>
						<%
						}
						%>
						<td width="10%" align=right>
							<%=entrys[1] %>
						</td>
						<td width="40%">
							<input type="text"
								name="WORK_LIST_<%=entrys[0] %>"
								style="width:70%" 
								<% if (entrys[1].indexOf("时间") != -1) { %>
									onclick="showdate(this)"
								<% }
								paramValue = request.getParameter("WORK_LIST_" + entrys[0]) == null ? "" : request.getParameter("WORK_LIST_" + entrys[0]);
								%>
								 maxlength="50" 
								value="<%=paramValue%>">
						</td>
						<%
						if (index % 2 == 1 && total == index) {
						%>
						<td></td>
						<td></td>
					</tr>
					<%
					} else if (index % 2 == 0) {
					%>
					</tr>
					<%
					}
					%>
					<%
						index++;
						}
					%>
					<tr>
						<td width="30%" align="right" colspan=4>
							<input name="Submit4" type="submit" class="input" value="查询">
							<input name="Submit22" type="button" class="input" value="重置" onclick="resetForm();search();">
							<!-- <input name="Submit23" type="button" class="input" value="清空" onclick="clearInputTextFormID('work')"> -->
						</td>
					</tr>
				</table>
				<hr width="100%">

				<TABLE width="100%" cellpadding="1" cellspacing="1" bordercolor="#EEEEEE" class="tab">
					<pg:listdata dataInfo="com.chinacreator.commonworkflow.list.SHKAllWorkList" keyName="SHKAllWorkList" />
					<pg:pager maxPageItems="20" scope="request" data="SHKAllWorkList" isList="false">
						<tr>
						<%
							ite = columnMap.iterator();
							while (ite.hasNext()) {
								String entry = ite.next().toString();
								String[] entrys = entry.split(WorkflowConstants.ESPECIAL_SEPARATOR);							
						%>
						<td nowrap class="headercolor">
							<a href="javascript:orderList('<%=entrys[0]%>')"><%=entrys[1]%>
								<span id="order_<%=entrys[0]%>" name="order">
								<% if (orderCondition != null && orderCondition.equals(entrys[0])) { %>
									<% if ("asc".equalsIgnoreCase(orderType)) { %>
									↑
									<% } else if ("desc".equalsIgnoreCase(orderType)) { %>
									↓
									<% } %>
								<% } %>
								</span>
							</a>
						 </td>
						 <%
						 }
						 %>
                         <td nowrap class="headercolor">
							操作
						</td>
                        </tr>
                        <%
							Iterator paramIte = columnMap.iterator();
							while (paramIte.hasNext()) {
									String entry = paramIte.next().toString();
									String[] entrys = entry.split(WorkflowConstants.ESPECIAL_SEPARATOR);
									String entryKey = "WORK_LIST_" + entrys[0];
						%>
						<pg:param name="<%=entryKey %>" />
						<%
							}
						%>
						<pg:param name="ordercondition" />
						<pg:param name="ordertype" />
						<!--检测当前页面是否有记录-->
						<pg:notify>
							<tr height='25' class="labeltable_middle_tr_01">
								<td colspan=100 align='center'>
									暂时没有待办信息
								</td>
							</tr>
						</pg:notify>
						<pg:list>
							<tr ondblclick="handle('<pg:cell colName="actInsId"/>','<pg:cell colName="busiId"/>')">
								 <%String datas = dataSet.getString("remark1");
                          		String [] arr = datas.split("@@");
								for( int i = 0;i < thList.size();i++){
									String tdData = "";
									String tdFullData = "";											
									if (i < arr.length) {
										int len = 0;
										if (((String) thList.get(i)).split("#").length > 1) {
											len = Integer.parseInt(((String) thList.get(i)).split("#")[1]);
										} else {
											len = 0;
										}
										arr[i] = (arr[i].equalsIgnoreCase("null"))?"":arr[i];
										tdFullData = arr[i];
										if (len == 0 || arr[i].length() <= len) {
											tdData = arr[i];
										} else {
											tdData = arr[i].substring(0, len) + "...";
										}												
									}
								%>
								<td nowrap class="tablecells" title="<%=tdFullData%>">
		                         	<%=tdData %>
		                          </td>
								<%}%>
								<td  width="15%" nowrap="nowrap">
									<INPUT type="button" name="handle_ass" class="inut_f" value="处理任务"
									 onclick="handle('<pg:cell colName="actInsId"/>','<pg:cell colName="busiId"/>')">
								</td>
							</tr>
						</pg:list>
						<tr height="18px" >
							<% int colSpanLength = thList.size() + 1; %>
							<td colspan=<%=colSpanLength %> align='center' nowrap="nowrap">
								共:<pg:rowcount />条记录 <pg:index />
							</td>
						</tr>
						<input name="queryString" value="<pg:querystring/>" type="hidden" >
					</pg:pager>
				</TABLE>
			</FORM>
		</div>
	</body>
</html>
