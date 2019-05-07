<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String selected_dbname = request.getParameter("dbname");
	selected_dbname = selected_dbname==null?"":selected_dbname;
	List poollist = new ArrayList();
	DBUtil dbUtil = new DBUtil();
	Enumeration enum_ = dbUtil.getAllPoolnames();
	while(enum_.hasMoreElements()){
		String poolname = (String)enum_.nextElement();
		poollist.add(poolname);
	}
%>
<html>
    <title>选择数据源</title>
    <head>
        <link href="<%=rootpath%>/cms/inc/css/cms.css" rel="stylesheet" type="text/css">		
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
		<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
		<script language="JavaScript" src="../user/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
    </head>
    <%@ include file="/epp/css/cssControl.jsp"%><body >
		<form name="dictList" method="post" >
			<table cellspacing="1" cellpadding="0" border="0" width=98%  class="thin">
 				<tr valign='top'>
   					<td height='30'valign='middle' colspan="5"><img src='../images/edit.gif' width="16" height="16" border=0 align='absmiddle'>&nbsp;<strong>选择数据源</strong></td>
 				</tr>
 				<tr>
					<td class="headercolor" width="50">
						
					</td>
					<td class="headercolor" >选择数据源</td>
				</tr>
 			<%
 			    for(int i=0;i<poollist.size();i++){
 			%>	
	 			<tr>	
	 				<td class="tablecells" nowrap="nowrap">
						<input type="radio" name="dbname" onClick="selectOne('dbname',this)" value="<%=poollist.get(i)%>" width="10">
					</td>
					<td class="tablecells" nowrap="nowrap">
					    <%=poollist.get(i)%>
					</td>
				</tr>
			<%
			    }
			%>
			</table>
			<table cellspacing="1" cellpadding="0" border="0" width=98%  >
			    <tr height="18px" class="labeltable_middle_tr_01">
			        <td align='center'></td>
					<td align='right'></td>
			    </tr>
			    <tr height="18px" class="labeltable_middle_tr_01">
					<td align='center'></td>
					<td  align="center" colspan="1" nowrap>
					    <input type="button" value="确定" class="input" onclick="save();">
						<input name="new" type="button" class="input" value="清除" onclick="removeValue('dbname')">
						<input name="new" type="button" class="input" value="关闭" onclick="winclose();">
					</td>
				</tr>
		    </table>		    
		</form>
 	</body>
 	<script>
 		function save(){
 			setValue();
 			window.close();
 		}
 		
 		function winclose(){
 			window.returnValue =  "<%=selected_dbname%>";
 			window.close();
 		}
 	 	    
 	    function setValue(){
 	        var select_value = "";
 	        var arr = new Array();
 	        arr = document.getElementsByName("dbname");
 	        for(var i=0;i<arr.length;i++){
 	            if(arr[i].checked==true){
 	                select_value = arr[i].value;
 	                break;
 	            }
 	        }
 	        if(select_value!="<%=selected_dbname%>"){
 	            window.dialogArguments.createTypeForm.table_name.value = "";
 	            window.dialogArguments.createTypeForm.field_name.value = "";
				window.dialogArguments.createTypeForm.field_value.value = "";
				window.dialogArguments.createTypeForm.field_order.value = ""; 
				window.dialogArguments.createTypeForm.field_typeid.value = ""; 
 	        }
 	        window.returnValue = select_value;
 	    }
 	    window.onload = function autoRun(){
 	        var selected_value = "<%=selected_dbname%>";
 	        arr = document.getElementsByName("dbname");
 	        for(var i=0;i<arr.length;i++){
 	            if(arr[i].value==selected_value){
 	                arr[i].checked = true;
 	                break;
 	            }
 	        }
 	    }
 	    function selectOne(checkbox_name,e){
 	        arr = document.getElementsByName(checkbox_name);
 	        for(var i=0;i<arr.length;i++){
 	            if(arr[i].value==e.value){
 	                arr[i].checked = true;
 	            }else{
 	                arr[i].checked = false;
 	            }
 	        }
 	    }
 	    function removeValue(checkbox_name){
 	        arr = document.getElementsByName(checkbox_name);
 	        for(var i=0;i<arr.length;i++){ 	            
 	            arr[i].checked = false; 	            
 	        }
 	    }
 	</script>
 </html>