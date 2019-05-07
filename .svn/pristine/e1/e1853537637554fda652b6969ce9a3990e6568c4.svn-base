<%@page contentType="text/html;charset=GBK"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>查看历史流程</title>
		<style type="text/css">
			td {
				border: 1px solid #000000;
				border-collapse:collapse;
			}
			table {
				border: 1px solid #000000;
				border-collapse:collapse;
			}
			.STYLE1 {
				color: #FF0000;
				font-size: 13px;
			}
        </style>
		<%
			String id = "";
			if(request.getParameter("id")!=null){
				id = request.getParameter("id");
			}
			DBUtil dbUtil2 = new DBUtil();
			dbUtil2.executeSelect("select process_config_id,process_name from module_process_config where module_id='"+id+"'");
		%>
		<script language="javascript">
		
			var flow_id = "";
			
			function closeWindow(){
				window.returnValue = "-1";
				window.close();				
			}
			function dbClick(f_id){
			
				flow_id = f_id;
						
				req = newXMLHttpRequest();
				var url="editHistoryFlow.jsp";
				var paramString="process_config_id="+flow_id+"&id="+'<%=id%>';
				paramString=encodeURI(paramString);
				req.open("post", url, true);
				req.setRequestHeader("Content-type","application/x-www-form-urlencoded");
				req.send(paramString);
				req.onreadystatechange = callBack;
			}
			
			function callBack() {
				window.returnValue = flow_id;
				window.close();
			}				
			
			function submitFlow(){
				var d = document.getElementsByName("flowid");
				for(var i = 0; i < d.length; i++){
					if(d[i].checked){
						flow_id = d[i].value;
					}
				}
				if(flow_id==''){
					alert('请选择一个流程!');
				}else{
					dbClick(flow_id);
				}
			}
			
			
			function newXMLHttpRequest(){
				var xmlreq = false;
				if (window.XMLHttpRequest){
					xmlreq = new XMLHttpRequest();
				}else{
					if (window.ActiveXObject){
						try{
							xmlreq = new ActiveXObject("Msxml2.XMLHTTP");
						}catch (e1){
							try {
								xmlreq = new ActiveXObject("Microsoft.XMLHTTP");
							}catch (e2){
								xmlreq = false;
							}
						}
					}
				}
				return xmlreq;
			}
		</script>
	</head>
	<body>
		<div style="LEFT: 30px; POSITION: absolute; TOP: 12px; width: 416px;">
			<table width="410" border="1">
				<tr align="center">
					<td>流程名称</td>
					<td>流程定义名</td>
					<td>流程版本</td>
				</tr>
				<%
				
				String flow_id = "";
				String flow_name= "";
				String flow= "";
				String flow_arr[] = null;
				String flow_version = "";
				
				for (int i = 0; i < dbUtil2.size(); i++) {
					flow_id = dbUtil2.getString(i, "process_config_id");
					flow = dbUtil2.getString(i, "process_name");
					
					if(flow!=null&&!flow.equals("")){
						flow_arr = flow.split("#");
					}
					
					if(flow_arr!=null&&flow_arr.length>2){
						flow_name = flow_arr[2];
						flow_version = flow_arr[1];
					}
				%>
				<tr onKeyDown="" onMouseMove="this.style.background='#CCCCCC'" onMouseOut="this.style.background=''" align="center">
					<td><%=flow%></td>
					<td><%=flow_name%></td>
					<td><%=flow_version%></td>
				</tr>
				<%}%>
			</table>
			<br/><br/>
		  <center>
				<input name="button2" type="button" value="关闭页面" onClick="closeWindow();" />
		  </center>
		</div>
	</body>
</html>

