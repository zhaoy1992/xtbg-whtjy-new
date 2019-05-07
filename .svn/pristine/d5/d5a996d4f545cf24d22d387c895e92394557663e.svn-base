<%@ page language="java" import="java.util.*,com.chinacreator.epp.delegate.*" pageEncoding="GBK"%>
<%@page import="org.enhydra.shark.SharkEngineManager"%>
<%@page import="org.frameworkset.spi.BaseSPIManager"%>
<%@page import="com.chinacreator.sysmgrcore.manager.OrgManager"%>
<%@page import="com.chinacreator.sysmgrcore.entity.Organization"%>
<%
String basePath = request.getContextPath()+"/";

//modify by minghua.guo[2011-4-26] 兼职借调处理，当前应用id获取处理
boolean isSys_user_enablemutiorg = SharkEngineManager.getInstance().isSys_user_enablemutiorg();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    
    <title>详细信息</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>sysmanager/css/windows.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>sysmanager/css/contentpage.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>sysmanager/css/tab.winclassic.css">
	<script type="text/javascript" src="<%=basePath%>delegate/prototype-1.4.0.js"></script>
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
		alert("成功接受！！");
		window.location.href='<%=basePath%>delegate/mydelegate.jsp?nowtime=' + new Date().getTime();
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
		alert("成功拒绝！！");
		window.location.href='<%=basePath%>delegate/mydelegate.jsp?nowtime=' + new Date().getTime();
		}else{
		alert(restr);
		}
		}
	
		
		</script>
  </head>
  
		<%@ include file="/epp/css/cssControl.jsp"%>
  <body>
   <%
   String id=request.getParameter("id");
   Delegate delegate=null;
   if(id!=null && !"".equals(id.trim())){
  	delegate=DelegateService.getInstance().getDelegateById(id.trim());
   }
   
  
   //request.setAttribute("d",delegate);

   OrgManager orgImpl = (OrgManager)BaseSPIManager.getProvider("OrgManagement");
   Organization org = orgImpl.getOrgById(delegate.getDesignatorOrgId());
   String orgName = "";
   if(org != null){
	   orgName = org.getOrgName();
   }
   Organization org1 = orgImpl.getOrgById(delegate.getDesigneeOrgId());
   String orgName1 = "";
   if(org1 != null){
	   orgName1 = org1.getOrgName();
   }
    %>
    
    <br>
      <br>
        <br>
   <table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin" align="center">
    <tr><td height='20' class="headercolor" colspan="2">被委托任务详细信息</td></tr>
    <tr class="labeltable_middle_td">
    <td height='10' width="20%" align=left class="tablecells" style="word-wrap:break-word;">委托人ID</td>
    <td height='10' width="80%" align=left class="tablecells" style="word-wrap:break-word;"><%=delegate.getDesignatorId() %></td>
    </tr>
    
     <tr class="labeltable_middle_td">
    <td height='10' width="20%" align=left class="tablecells" style="word-wrap:break-word;">委托人名</td>
    <td height='10' width="80%" align=left class="tablecells" style="word-wrap:break-word;"><%=delegate.getDesignator() %></td>
    </tr>
    
    <%if(isSys_user_enablemutiorg){ %>
     <tr class="labeltable_middle_td">
    <td height='10' width="20%" align=left class="tablecells" style="word-wrap:break-word;">委托人机构</td>
    <td height='10' width="80%" align=left class="tablecells" style="word-wrap:break-word;"><%=orgName %></td>
    </tr>
    <%} %>
    
     <tr class="labeltable_middle_td">
    <td height='10' width="20%" align=left class="tablecells" style="word-wrap:break-word;">被委托人ID</td>
    <td height='10' width="80%" align=left class="tablecells" style="word-wrap:break-word;"><%=delegate.getDesigneeId() %></td>
    </tr>
    
     <tr class="labeltable_middle_td">
    <td height='10' width="20%" align=left class="tablecells" style="word-wrap:break-word;">被委托人名</td>
    <td height='10' width="80%" align=left class="tablecells" style="word-wrap:break-word;"><%=delegate.getDesigneeName() %></td>
    </tr>
    
    <%if(isSys_user_enablemutiorg){ %>
     <tr class="labeltable_middle_td">
    <td height='10' width="20%" align=left class="tablecells" style="word-wrap:break-word;">被委托人机构</td>
    <td height='10' width="80%" align=left class="tablecells" style="word-wrap:break-word;"><%=orgName1 %></td>
    </tr>
    <%} %>
    
     <tr class="labeltable_middle_td">
    <td height='10' width="20%" align=left class="tablecells" style="word-wrap:break-word;">操作人ID</td>
    <td height='10' width="80%" align=left class="tablecells" style="word-wrap:break-word;"><%=delegate.getOpId() %></td>
    </tr>
    
     <tr class="labeltable_middle_td">
    <td height='10' width="20%" align=left class="tablecells" style="word-wrap:break-word;">操作人名</td>
    <td height='10' width="80%" align=left class="tablecells" style="word-wrap:break-word;"><%=delegate.getOp() %></td>
    </tr>
    
     <tr class="labeltable_middle_td">
    <td height='10' width="20%" align=left class="tablecells" style="word-wrap:break-word;">委托类型</td>
    <td height='10' width="80%" align=left class="tablecells" style="word-wrap:break-word;">
    <%
    if("1".equals(delegate.getDelegateType())){
    out.print("上级委托");
    
    }
    
    if("2".equals(delegate.getDelegateType())){
    out.print("委托别人");
    }
     %>
    </td>
    </tr>
    
     <tr class="labeltable_middle_td">
    <td height='10' width="20%" align=left class="tablecells" style="word-wrap:break-word;">委托时间</td>
    <td height='10' width="80%" align=left class="tablecells" style="word-wrap:break-word;"><%=delegate.getDelegateTime() %></td>
    </tr>
    
     <tr class="labeltable_middle_td">
    <td height='10' width="20%" align=left class="tablecells" style="word-wrap:break-word;">委托结束时间</td>
    <td height='10' width="80%" align=left class="tablecells" style="word-wrap:break-word;"><%=delegate.getDelegateEndTime() %></td>
    </tr>
    
        <tr class="labeltable_middle_td">
    <td height='10' width="20%" align=left class="tablecells" style="word-wrap:break-word;">委托取消时间</td>
    <td height='10' width="80%" align=left class="tablecells" style="word-wrap:break-word;"><%=delegate.getDelegateCancelTime() %></td>
    </tr>
    
        <tr class="labeltable_middle_td">
    <td height='10' width="20%" align=left class="tablecells" style="word-wrap:break-word;">委托状态</td>
    <td height='10' width="80%" align=left class="tablecells" style="word-wrap:break-word;">
   <%
   
   	if("1".equals(delegate.getDelegateStat())){
    	out.print("等待确认");
    
   	 }
    
      if("2".equals(delegate.getDelegateStat())){
    out.print("委托中");
    
    }
    
      if("3".equals(delegate.getDelegateStat())){
    out.print("委托结束");
    
    }
      if("4".equals(delegate.getDelegateStat())){
    out.print("取消委托");
    
    }
      if("5".equals(delegate.getDelegateStat())){
    out.print("拒绝委托");
    
    }
    %>
    
    </td>
    </tr>
    
    <tr class="labeltable_middle_td">
    <td height='10' width="20%" align=left class="tablecells" style="word-wrap:break-word;">短信方式</td>
    <td height='10' width="80%" align=left class="tablecells" style="word-wrap:break-word;">
    <%
    String awoketype = delegate.getAwokeType();
    if(awoketype != null && awoketype.indexOf("1") > -1) {
        out.print("(RTX信息提醒)");
    }
    if(awoketype != null && awoketype.indexOf("2") > -1){
        out.print("(短信提醒)");
    }
    if(awoketype != null && awoketype.indexOf("3") > -1){
        out.print("(站内邮件)");
    }
    %>
    </td>
    </tr>
    
     <tr class="labeltable_middle_td">
    <td height='10' width="20%" align=left class="tablecells" style="word-wrap:break-word;">业务范围的类型</td>
    <td height='10' width="80%" align=left class="tablecells" style="word-wrap:break-word;">
    <%if("app".equals(delegate.getEcType())){
        out.print("所有流程业务");
    }else{
        out.print("可选流程业务");
    }
	%>
    </td>
    </tr>
    
    <tr class="labeltable_middle_td">
    <td height='10' width="20%" align=left class="tablecells" style="word-wrap:break-word;">模块(事项)ID</td>
    <td height='10' width="80%" align=left class="tablecells" style="word-wrap:break-word;"><%=delegate.getEcId() %></td>
    </tr>
    
     <tr class="labeltable_middle_td">
    <td height='10' width="20%" align=left class="tablecells" style="word-wrap:break-word;">模块(事项)名称</td>
    <td height='10' width="80%" align=left class="tablecells" style="word-wrap:break-word;">
   
    <%=new DelegateUtils().getTrasString(delegate.getEcName(),40)%>
    </td>
    </tr>
    
    <tr class="labeltable_middle_td">
    <td height='10' width="20%" align=left class="tablecells" style="word-wrap:break-word;">确认时间</td>
    <td height='10' width="80%" align=left class="tablecells" style="word-wrap:break-word;"><%=delegate.getConfirmTime() %></td>
    </tr>
    
      <tr class="labeltable_middle_td" align="center">
    <td height='20' width="20%" align="center" class="tablecells" style="word-wrap:break-word;">
   
    <input type="button" value="关闭" class="input" style="cursor:hand" onclick="javascript:window.close();"/>
    </td>
   
    <td height='20' width="80%" align="center" class="tablecells" style="word-wrap:break-word;">
    	<%
		if("1".equals(delegate.getDelegateStat())){
		    
     	%>
    	<input type="button" value="接受委托" onclick="accept123(<%=delegate.getDelegateId() %>)" class="input"/>
    	<input type="button" value="拒绝委托" onclick="reject123(<%=delegate.getDelegateId() %>)" class="input"/>
   		<%} %>
    </td>
    </tr>
    </table>
  </body>
</html>
