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
		<title>��־����</title>
		
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/tab.winclassic.css">

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
	
		
	
	function dealRecord(dealType) {//ɾ����־
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
	    		var msg = "��ȷ��Ҫɾ����(ɾ�����ǲ������ٻָ���)";
	        	if(confirm(msg)){    
		            LogForm.action="deleteLog.jsp";
		            LogForm.target = "deleteLogs"; 
		            document.all("deleteLogs").src = "deleteLog.jsp";                      
		            LogForm.submit();
		        }
			} 
	    }else{
	    	alert("����Ҫѡ��һ����¼��");
	    	return false;
	   }
	}
	
	
		function dealAllRecord() {//ɾ����־
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
			if(confirm("ȷ��ɾ�������(ɾ�����ǲ������ٻָ���)��"))
			{
				LogForm.action="<%=rootpath%>/sysmanager/logmanager/submitLog_do.jsp?flag=2";
				LogForm.submit();
			}
		}else{
	    	alert("��ǰ�޿���ɾ���ļ�¼��");
	    	return false;
	   }
  		   
	}		
	function dealRangeRecord(){
        var operUser = parent.document.all("operUser").value;
       if(operUser=="") operUser = "���в�����";
        var oper = parent.document.all("oper").value;
        if(oper=="") oper = "��������";
        var type = parent.document.all("type").value;
        if(type=="") type = "��������";
        var startDate = parent.document.all("startDate").value;
        var endDate = parent.document.all("endDate").value;
        if(startDate!="" && endDate!="")
        {
        var msg = "��ȷ��ɾ�� \n" ;
        msg += "�������ʺ�:"+operUser+"\n";
        msg += "��־����:"+oper+"\n";
        msg += "��־����:"+type+"\n";
        msg += "ʱ���"+startDate+"��"+endDate+"֮�����־��?";
        if(confirm(msg)){
            LogForm.action="deleteRangeLogs.jsp?operUser="+operUser+"&&oper="+oper+"&&type="+type+"&&startDate="+startDate+"&&endDate="+endDate;
            LogForm.target = "deleteLogs";
            LogForm.submit();
        }
        }
        else
        {
        	alert('��ָ��Ҫɾ���Ĳ�����ֹʱ��');
        }
    
    }
    
    function logDetailQuery(logId){
    	window.showModalDialog("logDetailList.jsp?logId="+logId,window,"dialogWidth:"+(800)+"px;dialogHeight:"+(600)+"px;scroll=yes;status=no;titlebar=no;toolbar=no;maximize=yes;minimize=0;");
    	
    }
</script>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin">
		<div id="contentborder" align="center">
		 	<iframe src="" name="deleteLogs" width=0 height=0 style="display:none"></iframe>
			<!-- ��Щ���ܲ���Ҫ�ṩ
			<div align="left">
<input name="button" type="button" class="input"
								onclick="dealRecord(1)" value="ɾ��ѡ����">
                              &nbsp;<input name="button" type="button" class="input"
                                onclick="dealRangeRecord()" value="��ʱ���ɾ��">
							  &nbsp;<input type="button" value="ɾ������" class="input"
								onclick="dealAllRecord()">
							    </div>
				 -->		    
				<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">

					
					<pg:listdata dataInfo="com.chinacreator.sysmgrcore.web.tag.LogSearchList" keyName="LogSearchList" />
					<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
					<pg:pager maxPageItems="12" scope="request" data="LogSearchList" isList="false">
						<tr class="labeltable_middle_td">
							<!--���÷�ҳ��ͷ-->
							<td class="headercolor" align="center">
				  			<input type="checkBox" name="checkBoxAll" onClick="checkAll('checkBoxAll','ID')">
				  			</td>
				  			<input class="text" type="hidden" name="selectId">
				  			
				  			<td height='20' class="headercolor">����ģ��</td>
				    		<td height='20' class="headercolor">�������ʺ�</td>
				    		<td height='20' class="headercolor">�����˻���</td>				    		
							<td height='20' class="headercolor">��־����</td>
							<td height='20' class="headercolor">��������</td>
							<td height='20' class="headercolor">��־��Դ</td>
							<td height='20' class="headercolor">����ʱ��</td>
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
						
						
						<!--��⵱ǰҳ���Ƿ��м�¼-->
						<pg:notify>
							<tr height='25' class="labeltable_middle_tr_01">
								<td colspan="100" align='center'>
									��ʱû����־��¼
								</td>
							</tr>
						</pg:notify>
						<%
							//�Ҽ��˵�
						//	ContextMenu contextmenu = new ContextMenuImpl();
					 	%>
						<!--list��ǩѭ�����ÿ����¼-->
						<pg:list>
						<% 
							String logId = dataSet.getString("logId");
						//	Menu menu = new Menu();
						//	menu.setIdentity("opuser_"+logId);
						//	Menu.ContextMenuItem menuitem2 = new Menu.ContextMenuItem();
						//	menuitem2.setName("��־��ϸ�鿴");
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
								<pg:equal colName="operType" value="0">�޲���</pg:equal>
								<pg:equal colName="operType" value="1">����</pg:equal>
								<pg:equal colName="operType" value="2">ɾ��</pg:equal>
								<pg:equal colName="operType" value="3">�޸�</pg:equal>
								<pg:equal colName="operType" value="4">����</pg:equal>								
								</td>
								<td nowrap height='20' align="left" class="tablecells"><pg:cell colName="visitorial" defaultValue="" /></td>
								<td nowrap height='20' align="left" class="tablecells"><pg:cell colName="operTime" defaultValue="" dateformat="yyyy-MM-dd HH:mm:ss"/></td>
								
							</tr>
						</pg:list>
						<tr height="30" class="labeltable_middle_tr_01">
							<td colspan="100" align='center'>
							  ��<pg:rowcount/>����¼&nbsp;&nbsp;<pg:index />
							<input type="hidden" name="querystring" value="<pg:querystring/>"></td>
						</tr>
					</pg:pager>
 
				</table>

	          <div align="center"></div>
		</div>
			</body>
</html>
