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
		<title>��������</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/tab.winclassic.css">
		<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
		<script language="JavaScript">
		function checkAll(totalCheck,checkName){	//��ѡ��ȫ��ѡ��
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
	//����ѡ�и�ѡ��
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
	//�Լ�¼���и���
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
	  	alert("��ѡ��һ����¼�����޸�");
	  }
	}
	*/
	//�Լ�¼���и���
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
	  	alert("��ѡ��һ����¼�����޸�");
	  }
	}
	
	//����ģ̬�Ի��༭��
	function showDialog(idValue,actiontype)
	{
	  var obj=window.showModalDialog('inputTypeEdit.jsp?actiontype='+ actiontype + '&id='+idValue,window,'dialogwidth:500px;dialogheight:400px;');
	  if(obj!=null)
	  {
	  	window.location.href = window.location.href;
	  }
	}
	function dealRecord() {//ɾ��
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
	    		var msg = "��ȷ��Ҫɾ����(ɾ�����ǲ������ٻָ���)";
	        	if(confirm(msg))
	        	{
		            InputTypeForm.action="inputTypeSubmit.jsp?flag=3&inputTypeId="+inputTypeIds.substring(1,inputTypeIds.length);
		            InputTypeForm.target = "deleteContainer";                     
		            InputTypeForm.submit();
				} 
	    }else{
	    	alert("����Ҫѡ��һ����¼��");
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
			<input name="button" type="button" class="input" onclick="showDialog('','add')" value="����">
			<input name="button" type="button" class="input" onclick="updateRecord()" value="�޸�">
			<input name="button" type="button" class="input" onclick="dealRecord()" value="ɾ��">
			<% 
				}
			%>
		</div>
		<table id="inputTypeList" width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
			<pg:listdata dataInfo="com.chinacreator.dictionary.tag.InputTypeList" keyName="InputTypeList" />
				<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
				<pg:pager maxPageItems="12" scope="request" data="InputTypeList" isList="false">
				<tr class="labeltable_middle_td">
						<!--���÷�ҳ��ͷ-->
						<td class="headercolor" align=center><input type="checkBox" name="checkBoxAll" onClick="checkAll('checkBoxAll','ID')"></td>
				    	<td height='20' class="headercolor">������������
				    	<input class="text" type="hidden" name="selectId">
				    	</td>
						<td height='20' class="headercolor">������������</td>
						<td height='20' class="headercolor">����Դѡ��ҳ���ַ</td>
				</tr>
				<pg:param name="inputTypeName"/>
				<pg:param name="inputTypeId"/>
				<pg:param name="inputTypeDesc"/>
				<pg:param name="dataSourcePath"/>
				<!--��⵱ǰҳ���Ƿ��м�¼-->
				<pg:notify>
				<tr height='25' class="labeltable_middle_tr_01">
					<td colspan=100 align='center'>��ʱû����־��¼</td>
				</tr>
				</pg:notify>
				<!--list��ǩѭ�����ÿ����¼-->
				<pg:list>
				<tr onMouseOver="this.className='mouseover'" onMouseOut="this.className= 'mouseout'">
					<td class="tablecells" align=center>
					    <%
					        //�ı�����  ѡ���ֵ�  ѡ��ʱ��  ��������  ѡ�����  ѡ����Ա
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
					<td colspan=100 align='center'>��<pg:rowcount/>����¼&nbsp;&nbsp;<pg:index />
					<input type="hidden" name="querystring" value="<pg:querystring/>"></td>
				</tr>
				</pg:pager>
		</table>
	    <div align="center"></div>
		</form>
	</body>
	<iframe src="" name="deleteContainer" width=0 height=0 style="display:none"></iframe>
</html>
