<%@ include file="../../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../base/scripts/panes.jsp"%>

<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%%>
<html>
	<head>
		<title>委托事件查询</title>
		
		<link rel="stylesheet" type="text/css" href="../../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../../css/tab.winclassic.css">
		 <script language="JavaScript" src="../../scripts/selectTime.js" type="text/javascript"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/jobmanager/common.js" type="text/javascript"></script>		
<script language="JavaScript" src="../../include/pager.js" type="text/javascript"></script>
<%
	
 AccessControl accesscontroler = AccessControl.getInstance();
			accesscontroler.checkAccess(request, response);
			String userId = accesscontroler.getUserID();			
		String userName = accesscontroler.getUserAccount();
%>
<script language="JavaScript">
	function adduser(id,name){	    	
	  window.open('<%=request.getContextPath()%>/sysmanager/schedularmanage/selectexecutor.jsp?displayNameInput='+name+'&displayValueInput='+id,'newWin','scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250');
	}
	function selectRole(role)
	{
	if(role=='client')
	{
	document.agentSearchForm.clientName.value = '<%=userName%>';
	document.agentSearchForm.clientId.value = '<%=userId%>';
	document.agentSearchForm.agentName.value = '';
	document.agentSearchForm.agentId.value = '';
	document.agentSearchForm.clientbutton.disabled=true;
	document.agentSearchForm.agentbutton.disabled=false;
	}
	else
	{
	document.agentSearchForm.agentName.value = '<%=userName%>';
	document.agentSearchForm.agentId.value = '<%=userId%>';
	document.agentSearchForm.clientName.value = '';
	document.agentSearchForm.clientId.value = '';
	document.agentSearchForm.clientbutton.disabled=false;
	document.agentSearchForm.agentbutton.disabled=true;
	}
	
	}
function validateForm(){	

   if(!document.agentSearchForm.role[0].checked&&!document.agentSearchForm.role[1].checked)
   {
   alert("请选择您的身份！");
   return;
   }
   	if(document.agentSearchForm.role[0].checked)
   	{//当登陆者为委托人时
       if(document.all("clientname").value.length<1){
   		alert("请选择委托人！");
   		return;
       }  
       if(document.all("clientId").value!='<%=userId%>')
          {
          
           alert("委托人的姓名必须为本人！");
           document.agentSearchForm.clientName.value = '<%=userName%>';
	       document.agentSearchForm.clientId.value = '<%=userId%>';
	       return;
           }
    }
    if(document.agentSearchForm.role[1].checked)
   	{//当登陆人为代理人时
       if(document.all("agentname").value.length<1){
   		alert("请选择代理人！");
   		return;
        }  
       if(document.all("agentId").value!='<%=userId%>')
          {
           alert("代理人的姓名必须为本人！");
           document.agentSearchForm.agentName.value = '<%=userName%>';
	       document.agentSearchForm.agentId.value = '<%=userId%>';
	       return;
           }
    }
    
 	if(document.all("startTime").value.length>1&&document.all("endTime").value.length>1&&document.all.item("startTime").value>document.all.item("endTime").value)
   	{
   	alert("结束时间必须大于起始时间");
   	return;
   	}
   	// 判断是否改写了clientName ,agentName
        
   document.agentSearchForm.action="";
   document.agentSearchForm.submit();
   }
	</script>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin">
		
<div id="contentborder" align="center"> 
  <form name="agentSearchForm" action="" method="post">
    <table width="100%" height="25" border="0" bordercolor="#EEEEEE" cellpadding="0" cellspacing="1">
      <tr> 
        <td height='30' class="detailtitle" align=center colspan=6> <b>委托任务查询</b> 
        </td>
      </tr>
      <tr> 
        <td class="detailtitle" width="16%"> 您的身份</td>
        <td class="detailcontent" width="22%"> 
        <input type="radio" name="role" value="client" onclick="selectRole('client')" checked>
          委托人 
          <input type="radio" name="role" value="agent" onclick="selectRole('agent')">
          代理人 </td>
        <!--默认的是当前用户为委托人 -->
        <td  class="detailtitle">委托人 </td>
        <td > <input name="clientId" type="hidden" value="<%=userId%>"><input type="text" name="clientName"  readonly="true" value="<%=userName%>"> 
          <input name="clientbutton" type="button" onclick="adduser('clientId','clientName')" value="选人" disabled></td>
        <td class="detailtitle">代理人</td>
        <td > <input name="agentId" type="hidden" > <input name="agentName" type="text"  readonly="true"> 
          <input type="button" name="agentbutton" value="选人" onclick="adduser('agentId','agentName')"> 
        </td>
      </tr>
      <tr> 
        <td class="detailtitle" width="16%"> 开始时间</td>
        <td class="detailcontent" width="22%"> <input name="startTime" readonly="true" type="text"> 
          <INPUT type="button" value="时间" onclick="selectTime('agentSearchForm.startTime',0)"> 
        </td>
        <td  class="detailtitle">结束时间 </td>
        <td ><input name="endTime" readonly="true" type="text"> <INPUT type="button" value="时间" onclick="selectTime('agentSearchForm.endTime',0)"></td>
        <td colspan="2"> <div align="left"> 
            <input name="Submit4" type="button" class="input" value="查询" onclick="validateForm()">
            <input name="Submit22" type="reset" class="input" value="重置">
          </div>
          <div align="center"></div></td>
      </tr>
    </table>
    <hr width="100%">
    <table cellspacing="0" cellpadding="0" border="1" bordercolor="#EEEEEE" width=100% >
      <tr> 
        <td height='30' class="detailtitle" align=center colspan=5> <b>任务列表</b> 
        </td>
      </tr>
      <pg:listdata dataInfo="DevolveSearchList" keyName="DevolveSearchList" /> 
      <!--分页显示开始,分页标签初始化-->
      <pg:pager maxPageItems="15" scope="request" data="DevolveSearchList" isList="false"> 
      <tr class="labeltable_middle_td"> 
        <!--设置分页表头-->
        <th class="headercolor">业务标题</th>
      <th class="headercolor">业务名称</th>
      <th class="headercolor">环节名称</th>
        <th class="headercolor">处理时间</th>
        <th class="headercolor">处理人</th>
      </tr>
       
      <pg:param name="clientId" /> <pg:param name="agentId" /><pg:param name="startTime" /><pg:param name="endTime" /><pg:param name="role" />
      <!--检测当前页面是否有记录-->
      <pg:notify> 
      <tr height='20' class="labeltable_middle_tr_01"> 
        <td colspan=100 align='center'> 没有任务 </td>
      </tr>
      </pg:notify> 
      <!--list标签循环输出每条记录-->
      <pg:list> 
        <tr class="labeltable_middle_tr_01" onMouseOver="this.className='mousestyle1'" onMouseOut="this.className= 'mousestyle2'")" >	
        <td height='20' class="tablecells" nowrap="nowrap" align=left> <pg:cell colName="title" defaultValue="" />	
        </td>
        <td height='20' class="tablecells" nowrap="nowrap" align=left> <pg:cell colName="businessName" defaultValue="" /> 
        </td>
        <td height='20' class="tablecells" nowrap="nowrap" align=left> <pg:cell colName="taskName" defaultValue="" /> 
        </td>
        <td height='20' class="tablecells" nowrap="nowrap" align=left> <pg:cell colName="commitTime" defaultValue="" /> 
        </td>
        <td height='20' class="tablecells" nowrap="nowrap" align=left> <pg:cell colName="performer" defaultValue="" /> 
        </td>
      </tr>
      </pg:list> 
      <tr height="18px" class="labeltable_middle_tr_01"> 
        <td colspan=100 align='center'><div align="right"> </div>
          <pg:index /> <input type="hidden" name="queryString" value="<pg:querystring/>"></td>
      </tr>
      </pg:pager> 
    </table>
    <div align="center"> </div>
  </form>
</div>
<%@include file="../../sysMsg.jsp" %>
	</body>
	
</html>

