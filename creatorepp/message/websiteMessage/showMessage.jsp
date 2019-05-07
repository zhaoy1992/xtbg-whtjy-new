<%@ page language="java" pageEncoding="GBK" import="com.chinacreator.security.AccessControl"%>
<%@ taglib uri="pager-taglib" prefix="pg"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request,response);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>  
    <title></title>
    <link href="<%=request.getContextPath()%>/sysmanager/css/windows.css" rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css" rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css" rel="stylesheet" type="text/css">
  <script type="text/javascript" language="javascript">
  
  function checkAll(totalCheck,checkName){	
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
	
	// ����ѡ�и�ѡ��
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
	
	function checkBox(checkName){    //����Ƿ���������ѡ�򣬼��Ƿ�ѡ�˸ø�ѡ��
		var o = document.getElementsByName(checkName);
		for(var i=0;i<o.length;i++){
			if(!o[i].disabled){
				if(o[i].checked==true){
					return true;
				}
			}
		}
		alert("����ѡ��Ҫɾ���ļ�¼��");
		return false;	
	}
	
	function goNewMessage(){
		var url = "newMessage.jsp";
		window.location.href = url;
		//window.open(url,"_blank","height=500,width=650,scrollbars,status=yes");/
	}
	
	function goDeleteMessage(){
		if(checkBox('checkBoxOne')){
			document.showForm.action = "deleteMessage.jsp";
			document.showForm.submit();
		}
	}
	
	function goLookMessage(id,box){
		var url = "lookMessage.jsp?id="+id+"&box="+box;
		//window.open(url,"_blank","height=500,width=650,scrollbars,status=yes");
		window.location.href = url;
	}
  </script>
  <%
  	String box = StringUtils.defaultString(request.getParameter("box"));
  	if(box.equals("")){
  		box = "receive_box";
  	}
  	String box_name = "";
  	if(box.equals("receive_box")){
  		box_name = "�ռ���";
  	}else if(box.equals("send_box")){
  		box_name = "������";
  	}else if(box.equals("nosend_box")){
  		box_name = "�ݸ���";
  	}else if(box.equals("receive_deleted_box")){
  		box_name = "��ɾ���ʼ�";
  	}
  %>
  </head>
  
  <%@ include file="/epp/css/cssControl.jsp"%><body>
   <form name="showForm">
   <input type="hidden" name="box" value="<%=box%>"/>
   <fieldset style="width:100%;height:100%;">
	<LEGEND align=center>
		<FONT size="2">վ���ʼ�--><%=box_name%></FONT>
	</LEGEND>
   <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
   <tr><td align="right">
   		<!-- <a href="javascript:goNewMessage()">�½��ʼ�</a><a href="javascript:goDeleteMessage()">ɾ������</a-->
   		<input type="button" name="newMessageButton" value="�½��ʼ�" onclick="goNewMessage()"/>
   		<input type="button" name="deleteButton" value="ɾ���ʼ�" onclick="goDeleteMessage()"/>
   		</td>
   </tr>
   </table>
   <table width="100%" border="0" align="center" cellpadding="5" cellspacing="0">
		<pg:listdata dataInfo="com.chinacreator.message.website.WebsiteMessageList" keyName="WebsiteMessageList"></pg:listdata>
		<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
		<pg:pager maxPageItems="10" scope="request" data="WebsiteMessageList" title="�����б�" isList="false">
			<pg:param name="box"/>
			<tr>
				<!--���÷�ҳ��ͷ-->
				<th width="6%" align=left>
					<input type="checkbox" name="checkBoxAll" onclick="checkAll('checkBoxAll','checkBoxOne')">
				</th>
				<th width="150" height='20' align="center" style="word-wrap:break-word;">
				<%if(box.equals("receive_box") || box.equals("receive_deleted_box")){%>	
					������
				<%}else{%>
					�ռ���
				<%}%>
				</th>
				<th width="160" height='20' align="center" style="word-wrap:break-word;">
					����
				</th>
				<th height='20' align=center>
					����
				</th>
				<%if(box.equals("receive_box") || box.equals("receive_deleted_box")){%>	
				<th height='20' align=center>	
					�Ƿ��Ѷ�
				</th>
				<%}%>
			</tr>
			<!--��⵱ǰҳ���Ƿ��м�¼-->
			<pg:notify>
				<tr height='25'>
					<td colspan=100 align='center'>
						��ʱû�м�¼��
					</td>
				</tr>
			</pg:notify>
			<!--list��ǩѭ�����ÿ����¼-->
			<pg:list>
				<tr onMouseOver="this.className='mouseover'" onMouseOut="this.className= 'mouseout'"  ondblclick="goLookMessage('<pg:cell colName="id" defaultValue=""/>','<%=box%>')" style="cursor:hand">
					<!-- onDBLclick="download('<pg:cell colName="id" defaultValue=""/>','type')"-->
					<td nowrap="true" align=left>
						<input type="checkbox" name="checkBoxOne" onclick="checkOne('checkBoxAll','checkBoxOne')" value='<pg:cell colName="id" defaultValue=""/>'>
					</td>
					<td width="150" height='20' align=center style="word-wrap:break-word;">
					<%if(box.equals("receive_box") || box.equals("receive_deleted_box")){%>	
						<pg:cell colName="sender_name" defaultValue="" />
					<%}else{%>
						<pg:cell colName="receiver_name" defaultValue="" maxlength="23" replace="..." />
					<%}%>													
					</td>
					<td width="160" height='20' align="center" style="word-wrap:break-word;">
						<pg:cell colName="title" defaultValue="" maxlength="12" replace="..." />
					</td>
					<td height='20' align=center>
					<%if(box.equals("nosend_box")){%>	
						<pg:cell colName="save_time" defaultValue="" />
					<%}else{%>
						<pg:cell colName="send_time" defaultValue="" />
					<%}%>
					</td>
					<%if(box.equals("receive_box") || box.equals("receive_deleted_box")){%>
					<td height='20' align=center>
						<pg:cell colName="isread" defaultValue="" />
					</td>
					<%}%>
				</tr>
			</pg:list>									
			<tr height="30" class="labeltable_middle_tr_01">
				<td colspan=100 align='center'>
					��
					<pg:rowcount />
					����¼
					<pg:index />
				</td>
			</tr>
		</pg:pager>
	</table>
	</fieldset>
	</form>
  </body>
</html>