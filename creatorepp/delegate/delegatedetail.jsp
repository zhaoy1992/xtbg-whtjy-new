<%@ page language="java" import="java.util.*,com.chinacreator.epp.delegate.*" pageEncoding="GBK"%>
<%@page import="org.enhydra.shark.SharkEngineManager"%>
<%@page import="org.frameworkset.spi.BaseSPIManager"%>
<%@page import="com.chinacreator.sysmgrcore.manager.OrgManager"%>
<%@page import="com.chinacreator.sysmgrcore.entity.Organization"%>
<%
String basePath = request.getContextPath()+"/";

//modify by minghua.guo[2011-4-26] ��ְ���������ǰӦ��id��ȡ����
boolean isSys_user_enablemutiorg = SharkEngineManager.getInstance().isSys_user_enablemutiorg();
%>

<html>
  <head>
    <title>��ϸ��Ϣ</title>
   
	<meta http-equiv="pragma" content="no-cache">
<link rel="stylesheet" type="text/css" href="<%=basePath%>sysmanager/css/windows.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>sysmanager/css/contentpage.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>sysmanager/css/tab.winclassic.css">

  </head>
  
		<%@ include file="/epp/css/cssControl.jsp"%>
  <body>
   <%
   String id=request.getParameter("id");
   Delegate delegate=null;
   if(id!=null && !"".equals(id.trim())){
  	delegate=DelegateService.getInstance().getDelegateById(id.trim());
   }

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
  
   //request.setAttribute("d",delegate);
   
    %>
    
    
   <table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin" align="center">
    <tr><td height='20' class="headercolor" colspan="2">ί��������ϸ��Ϣ</td></tr>
    <tr class="labeltable_middle_td">
    <td height='10' width="20%" align=left class="tablecells" style="word-wrap:break-word;">ί����ID</td>
    <td height='10' width="20%" align=left class="tablecells" style="word-wrap:break-word;"><%=delegate.getDesignatorId() %></td>
    </tr>
    
     <tr class="labeltable_middle_td">
    <td height='10' width="20%" align=left class="tablecells" style="word-wrap:break-word;">ί������</td>
    <td height='10' width="80%" align=left class="tablecells" style="word-wrap:break-word;"><%=delegate.getDesignator() %></td>
    </tr>
    
    <%if(isSys_user_enablemutiorg){ %>
     <tr class="labeltable_middle_td">
    <td height='10' width="20%" align=left class="tablecells" style="word-wrap:break-word;">ί���˻���</td>
    <td height='10' width="80%" align=left class="tablecells" style="word-wrap:break-word;"><%=orgName %></td>
    </tr>
    <%} %>
    
     <tr class="labeltable_middle_td">
    <td height='10' width="20%" align=left class="tablecells" style="word-wrap:break-word;">��ί����ID</td>
    <td height='10' width="80%" align=left class="tablecells" style="word-wrap:break-word;"><%=delegate.getDesigneeId() %></td>
    </tr>
    
     <tr class="labeltable_middle_td">
    <td height='10' width="20%" align=left class="tablecells" style="word-wrap:break-word;">��ί������</td>
    <td height='10' width="80%" align=left class="tablecells" style="word-wrap:break-word;"><%=delegate.getDesigneeName() %></td>
    </tr>
    
    <%if(isSys_user_enablemutiorg){ %>
     <tr class="labeltable_middle_td">
    <td height='10' width="20%" align=left class="tablecells" style="word-wrap:break-word;">��ί���˻���</td>
    <td height='10' width="80%" align=left class="tablecells" style="word-wrap:break-word;"><%=orgName1 %></td>
    </tr>
    <%} %>
    
     <tr class="labeltable_middle_td">
    <td height='10' width="20%" align=left class="tablecells" style="word-wrap:break-word;">������ID</td>
    <td height='10' width="80%" align=left class="tablecells" style="word-wrap:break-word;"><%=delegate.getOpId() %></td>
    </tr>
    
     <tr class="labeltable_middle_td">
    <td height='10' width="20%" align=left class="tablecells" style="word-wrap:break-word;">��������</td>
    <td height='10' width="80%" align=left class="tablecells" style="word-wrap:break-word;"><%=delegate.getOp() %></td>
    </tr>
    
     <tr class="labeltable_middle_td">
    <td height='10' width="20%" align=left class="tablecells" style="word-wrap:break-word;">ί������</td>
    <td height='10' width="80%" align=left class="tablecells" style="word-wrap:break-word;">
    <%
    if("1".equals(delegate.getDelegateType())){
    out.print("�ϼ�ί��");
    }
    
    if("2".equals(delegate.getDelegateType())){
    out.print("ί�б���");
    }
     %>
    </td>
    </tr>
    
     <tr class="labeltable_middle_td">
    <td height='10' width="20%" align=left class="tablecells" style="word-wrap:break-word;">ί��ʱ��</td>
    <td height='10' width="80%" align=left class="tablecells" style="word-wrap:break-word;"><%=delegate.getDelegateTime() %></td>
    </tr>
    
     <tr class="labeltable_middle_td">
    <td height='10' width="20%" align=left class="tablecells" style="word-wrap:break-word;">ί�н���ʱ��</td>
    <td height='10' width="80%" align=left class="tablecells" style="word-wrap:break-word;"><%=delegate.getDelegateEndTime() %></td>
    </tr>
    
        <tr class="labeltable_middle_td">
    <td height='10' width="20%" align=left class="tablecells" style="word-wrap:break-word;">ί��ȡ��ʱ��</td>
    <td height='10' width="80%" align=left class="tablecells" style="word-wrap:break-word;"><%=delegate.getDelegateCancelTime() %></td>
    </tr>
    
        <tr class="labeltable_middle_td">
    <td height='10' width="20%" align=left class="tablecells" style="word-wrap:break-word;">ί��״̬</td>
    <td height='10' width="80%" align=left class="tablecells" style="word-wrap:break-word;">
 <%
   
   	if("1".equals(delegate.getDelegateStat())){
    	out.print("�ȴ�ȷ��");
    
   	 }
    
      if("2".equals(delegate.getDelegateStat())){
   		 out.print("ί����");
    
   		 }
    
      if("3".equals(delegate.getDelegateStat())){
    out.print("ί�н���");
    
    }
      if("4".equals(delegate.getDelegateStat())){
    out.print("ȡ��ί��");
    
    }
      if("5".equals(delegate.getDelegateStat())){
    out.print("�ܾ�ί��");
    
    }
    %>
    </td>
    </tr>
    
    <tr class="labeltable_middle_td">
    <td height='10' width="20%" align=left class="tablecells" style="word-wrap:break-word;">���ŷ�ʽ</td>
    <td height='10' width="80%" align=left class="tablecells" style="word-wrap:break-word;">
    <%
    String awoketype = delegate.getAwokeType();
    if(awoketype != null && awoketype.indexOf("1") > -1) {
        out.print("(RTX��Ϣ����)");
    }
    if(awoketype != null && awoketype.indexOf("2") > -1){
        out.print("(��������)");
    }
    if(awoketype != null && awoketype.indexOf("3") > -1){
        out.print("(վ���ʼ�)");
    }
    %>
    </td>
    </tr>
    
     <tr class="labeltable_middle_td">
    <td height='10' width="20%" align=left class="tablecells" style="word-wrap:break-word;">ҵ��Χ������</td>
    <td height='10' width="80%" align=left class="tablecells" style="word-wrap:break-word;">
    <%if("app".equals(delegate.getEcType())){
        out.print("��������ҵ��");
    }else{
        out.print("��ѡ����ҵ��");
    }
	%>
    </td>
    </tr>
    
    <tr class="labeltable_middle_td">
    <td height='10' width="20%" align=left class="tablecells" style="word-wrap:break-word;">ģ��(����)ID</td>
    <td height='10' width="80%" align=left class="tablecells" style="word-wrap:break-word;"><%=delegate.getEcId() %></td>
    </tr>
    
     <tr class="labeltable_middle_td">
    <td height='10' width="20%" align=left class="tablecells" style="word-wrap:break-word;">ģ��(����)����</td>
    <td height='10' width="80%" align=left class="tablecells" style="word-wrap:break-word;">
<%=new DelegateUtils().getTrasString(delegate.getEcName(),40)%>
    </td>
    </tr>
    
    <tr class="labeltable_middle_td">
    <td height='10' width="20%" align=left class="tablecells" style="word-wrap:break-word;">ȷ��ʱ��</td>
    <td height='10' width="80%" align=left class="tablecells" style="word-wrap:break-word;"><%=delegate.getConfirmTime() %></td>
    </tr>
    
    <tr class="labeltable_middle_td" align="center">
    <td height='10' width="100%" align="center" class="tablecells" style="word-wrap:break-word;" colspan="2" >
   
    <input type="button" value="�ر�" class="input" style="cursor:hand" onclick="javascript:window.close();"/>
    </td>
   
    </tr>
    </table>
  </body>
</html>
