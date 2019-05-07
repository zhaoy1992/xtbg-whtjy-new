<%@ include file="/sysmanager/include/global1.jsp"%>
<%@ include file="/sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page language="java" contentType="text/html; charset=GBK"
		import="com.chinacreator.security.AccessControl,
			com.chinacreator.commonworkflow.dao.CommonWorkflowDao,
			com.chinacreator.commonworkflow.WorkflowConstants,
			java.util.List,java.util.Iterator"%>
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
	
	String appName = accesscontroler.getCurrentSystemID();
	String tableName = "V_APP_WORKFLOW_OPERATE_LOG";
	CommonWorkflowDao dao = new CommonWorkflowDao();
	List thList = dao.getColumnComment(tableName,appName);
	columnMap = dao.getColumnNameComment(tableName, appName);
	
	String orderCondition = request.getParameter("ordercondition");
	String orderType = request.getParameter("ordertype");	
%>
<html>
	<head>
		<title></title>

		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
		<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/jobmanager/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/include/pager.js" type="text/javascript"></script>
		<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/scripts/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="<%=request.getContextPath()%>/public/datetime/calender_date.js" ></script>
		<script language="JavaScript">
	var jsAccessControl = new JSAccessControl("#ff0000","#ffffff","#eeeeee");
	var wfParameters = [];
	function getFromWfParameters(index, name){
		var json =wfParameters[index]; 
		if(json[name]!=null){
			return json[name].value;
		}
		return "";
	}
	function browseFormPage(index){
		var _json = wfParameters[index];		
        var pageURL = "";
        //此处必须加上encodeURIComponent，否则无法识别#号之类的，造成页面无法加载
        var parameters = "mgrName="+encodeURIComponent(getFromWfParameters(index,"mgrName"))+"&oid="+getFromWfParameters(index,"actDefId")+"&procInsId="+getFromWfParameters(index,"procInsId")+"&actInsId="+getFromWfParameters(index,"actInsId")+"&moduleId="+getFromWfParameters(index,"moduleId")
        if(_json["formDefId"].value.indexOf("/")!=-1){
        	pageURL = _json["formDefId"].value;
        	pageURL += (pageURL.indexOf("?")!=-1?"&":"?")+"cc_form_instanceid="+ getFromWfParameters(index,"busiId")+"&operType=readonly&"+parameters; 
        }else{
        	pageURL = "/eformsys/fceform/common/djframe.htm?djsn="+getFromWfParameters(index,"formDefId")+"&djtype=ZW&cc_form_instanceid="+ getFromWfParameters(index,"busiId")+"&operType=readonly&"+parameters;
        }
        
        //modify by minghua.guo 2010-03-09
        //window.open("<%=request.getContextPath()%>"+pageURL);
        document.location = "<%=request.getContextPath()%>"+pageURL;
	}
	
	function handle(logId){
		send_request("retryWorkflowOperate.jsp?logId="+logId);	
	}
	
	
	function send_request(url){
		http_request = false;
		if(window.XMLHttpRequest){//Mozilla
				http_request = new XMLHttpRequest();
				if(http_request.overrideMimeType){//??MIME??
					http_request.overrideMimeType("text/xml");						
				}
		}
		else if(window.ActiveXObject){//IE
			try{
				http_request = new ActiveXObject("Msxml2.XMLHTTP");
			}catch(e){
				try{
					http_request = new ActiveXObject("Microsoft.XMLHTTP");							
				}catch(e){}
			}
		}
		if(!http_request){
			return false;
		}
		http_request.onreadystatechange = processRequest;
		http_request.open("GET",url,true);
		http_request.send(null);
	}
				
	function processRequest(){
		if(http_request.readyState == 4){				
			if(http_request.status == 200){
				alert(http_request.responseText);
				window.location.reload();
			}else{
				alert("操作失败！");
			}
		}
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
		var url = "monitor_wftransaction_log_list.jsp?ordercondition=" + ordercon + orderType;
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
	<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin"  scrolling="no">
		<div id="contentborder" align="center">
			<FORM name="work" id="work" action="monitor_wftransaction_log_list.jsp" method="post">
				<table width="100%" border="0" cellpadding="1" cellspacing="1"
					class="thin">
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
						<td class="detailtitle" width="10%" align=right>
							<%=entrys[1] %>
						</td>
						<td class="detailcontent" width="40%">
							<input type="text"
								name="LOG_<%=entrys[0] %>"
								style="width:70%" 
								<% if (entrys[1].indexOf("时间") != -1) { %>
									onclick="showdate(this)"
								<% }
								paramValue = request.getParameter("LOG_" + entrys[0]) == null ? "" : request.getParameter("LOG_" + entrys[0]);
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
						<td class="detailcontent" width="30%" align="right" colspan=4>
						<input name="Submit4" type="submit" class="input" value="查询">
						<input name="Submit22" type="button" class="input" value="重置" onclick="resetForm();search();">
							<!-- <input name="Submit23" type="button" class="input" value="清空" onclick="clearInputTextFormID('work')"> -->						</td>
					</tr>
				</table>
				<hr width="100%">

				<TABLE width="100%" cellpadding="1" cellspacing="1" bordercolor="#EEEEEE" class="thin">
					<pg:listdata dataInfo="com.chinacreator.commonworkflow.list.SHKMonitorTransactionLogList" keyName="SHKMonitorTransactionLogList" />
					<pg:pager maxPageItems="10" scope="request" data="SHKMonitorTransactionLogList" isList="false">
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
									String entryKey = "LOG_" + entrys[0];
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
									暂时没有流程操作日志
								</td>
							</tr>
						</pg:notify>

						<pg:list>
							<tr class="labeltable_middle_tr_01" onMouseOver="this.className='mousestyle1'"
							 onMouseOut="this.className= 'mousestyle2'"
                             >
									 <%
								String datas = dataSet.getString("remark");
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
                                <td class="tablecells" width="15%" nowrap="nowrap">
                                <script language="javascript">
									wfParameters.push(<pg:cell colName="parameterSerializer" defaultValue=""/>);
								</script>
                                 <INPUT type="button" class="input" name="handle_ass" value="查看"
                                 onclick="browseFormPage('<pg:rowid/>')">
                                 <% if(!dataSet.getBoolean("operateSuccess")){%>
                                 <INPUT type="button" class="input" name="handle_ass" value="重试"
                                 onclick="handle('<pg:cell colName="logId" defaultValue=""/>')">
                                 <%} %>
                                </td>
							</tr>
						</pg:list>
						<tr height="18px" class="labeltable_middle_tr_01">
							<% int colSpanLength = thList.size() + 1; %>
							
							<td colspan=<%=colSpanLength %> align='center' nowrap="nowrap">
								总共:<pg:rowcount />条记录  <pg:index />
							</td>
						</tr>
						<input name="queryString" value="<pg:querystring/>" type="hidden">
					</pg:pager>
				</TABLE>
			</FORM>
		</div>
	</body>
</html>
