<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.dictionary.input.InputTypeManager"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkAccess(pageContext);
%>
<html>
	<head>
		<title>属性容器</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/tab.winclassic.css">
		<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
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
	//对记录进行更新
	/*
	function updateRecord()
	{
	  var tableObj=document.all.inputTypeList;
	  
	  var n=0,index=0;
	  for(var i=1;i<tableObj.rows.length;i++)
	  {
	    if(tableObj.rows[i].cells[0].children[0].checked)
	    {
	   	    n++; 
	   	    index=i;
	        if(n>2)break;
	  	}
	  }	
	  if(n==1)
	  {
	  	var parameterObj=new Object();
	  	parameterObj.inputTypeId=tableObj.rows[index].cells[0].children[0].value;
	  	parameterObj.typeName=tableObj.rows[index].cells[1].innerText;
	  	parameterObj.typeDesc=tableObj.rows[index].cells[2].innerText;
	  	parameterObj.sourcePath=tableObj.rows[index].cells[3].innerText;
	  	showDialog(parameterObj,"update");
	  }
	  else
	  {
	  	alert("请选择一条记录进行修改");
	  }
	}
	*/
	//对记录进行更新
	function updateRecord()
	{
	  var id = document.getElementsByName("ID")
	  var n=0;
	  var idValue;
	  for(var i=0;i<id.length;i++)
	  {
	    if(id[i].checked)
	    {
	   	    n++; 
	   	    idValue = id[i].value;
	   	    if(n>1){
	   	    	break;
	   	    }
	  	}
	  }	
	  if(n==1)
	  {
	  	showDialog(idValue,"update");
	  }
	  else
	  {
	  	alert("请选择一条记录进行修改");
	  }
	}
	
	//开启模态对话编辑框
	function showDialog(idValue,actiontype)
	{
	  var obj=window.showModalDialog('inputTypeEdit.jsp?actiontype='+ actiontype + '&id='+idValue,window,'dialogwidth:500px;dialogheight:400px;');
	  if(obj!=null)
	  {
	  	window.location.href = window.location.href;
	  }
	}
	function dealRecord() {//删除
	    var isSelect = false;
	    var inputTypeIds="";	    
	    for (var i=0;i<InputTypeForm.elements.length;i++) {
			var e = InputTypeForm.elements[i];
			if (e.name == 'ID'){
				if (e.checked){
					inputTypeIds+=","+e.value;
			    }
			}
	    }	    
	    if (inputTypeIds!="")
	    {
	    		var msg = "你确定要删除吗？(删除后是不可以再恢复的)";
	        	if(confirm(msg))
	        	{
		            InputTypeForm.action="inputTypeSubmit.jsp?flag=3&inputTypeId="+inputTypeIds.substring(1,inputTypeIds.length);
		            InputTypeForm.target = "deleteContainer";                     
		            InputTypeForm.submit();
				} 
	    }else{
	    	alert("至少要选择一条记录！");
	    	return false;
	   }
	}
	</script>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin">
		
		<form name="InputTypeForm" action="" method="post">
		<div align="left">
			<%
				if(accessControl.getUserID().equals("1")){
			 %>
			<input name="button" type="button" class="input" onclick="showDialog('','add')" value="新增">
			<input name="button" type="button" class="input" onclick="updateRecord()" value="修改">
			<input name="button" type="button" class="input" onclick="dealRecord()" value="删除">
			<% 
				}
			%>
		</div>
		<table id="inputTypeList" width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
			<pg:listdata dataInfo="com.chinacreator.dictionary.tag.InputTypeList" keyName="InputTypeList" />
				<!--分页显示开始,分页标签初始化-->
				<pg:pager maxPageItems="12" scope="request" data="InputTypeList" isList="false">
				<tr class="labeltable_middle_td">
						<!--设置分页表头-->
						<td class="headercolor" align=center><input type="checkBox" name="checkBoxAll" onClick="checkAll('checkBoxAll','ID')"></td>
				    	<td height='20' class="headercolor">输入类型名称
				    	<input class="text" type="hidden" name="selectId">
				    	</td>
						<td height='20' class="headercolor">输入类型描述</td>
						<td height='20' class="headercolor">数据源选择页面地址</td>
				</tr>
				<pg:param name="inputTypeName"/>
				<pg:param name="inputTypeId"/>
				<pg:param name="inputTypeDesc"/>
				<pg:param name="dataSourcePath"/>
				<!--检测当前页面是否有记录-->
				<pg:notify>
				<tr height='25' class="labeltable_middle_tr_01">
					<td colspan=100 align='center'>暂时没有日志记录</td>
				</tr>
				</pg:notify>
				<!--list标签循环输出每条记录-->
				<pg:list>
				<tr onMouseOver="this.className='mouseover'" onMouseOut="this.className= 'mouseout'">
					<td class="tablecells" align=center>
					    <%
					        //文本类型  选择字典  选择时间  主键生成  选择机构  选择人员
					        String inputTypeName = dataSet.getString("inputTypeName");
					        if(InputTypeManager.BASE_INPUTTYPE_TEXT.equals(inputTypeName) || InputTypeManager.BASE_INPUTTYPE_DICT.equals(inputTypeName) || 
					           InputTypeManager.BASE_INPUTTYPE_DATE.equals(inputTypeName) || InputTypeManager.BASE_INPUTTYPE_PK.equals(inputTypeName)|| 
					           InputTypeManager.BASE_INPUTTYPE_ORG.equals(inputTypeName) || InputTypeManager.BASE_INPUTTYPE_USER.equals(inputTypeName) ||
					           InputTypeManager.BASE_INPUTTYPE_CURRENT_USER.equals(inputTypeName) || InputTypeManager.BASE_INPUTTYPE_CURRENT_ORG.equals(inputTypeName) ||
					           InputTypeManager.BASE_INPUTTYPE_CURRENT_DATE.equals(inputTypeName)
					        ){
					    %>
					    <input onClick="checkOne('checkBoxAll','ID')" type="checkbox" disabled="true" name="ID" value="<pg:cell colName="inputTypeId" defaultValue=""/>">
					    <%    
					        }else{
					    %>
					    <input onClick="checkOne('checkBoxAll','ID')" type="checkbox" name="ID" value="<pg:cell colName="inputTypeId" defaultValue=""/>">
					    <%
					        }
					    %>
					</td>						      				
					<td height='20' align=left class="tablecells"><pg:cell colName="inputTypeName" defaultValue="" /></td>
					<td height='20' align=left class="tablecells"><pg:cell colName="inputTypeDesc" defaultValue="" /></td>
					<td height='20' align=left class="tablecells"><pg:cell colName="dataSourcePath" defaultValue="" /></td>			
				</tr>
				</pg:list>
				<tr height="30" class="labeltable_middle_tr_01">
					<td colspan=100 align='center'>共<pg:rowcount/>条记录&nbsp;&nbsp;<pg:index />
					<input type="hidden" name="querystring" value="<pg:querystring/>"></td>
				</tr>
				</pg:pager>
		</table>
	    <div align="center"></div>
		</form>
	</body>
	<iframe src="" name="deleteContainer" width=0 height=0 style="display:none"></iframe>
</html>
