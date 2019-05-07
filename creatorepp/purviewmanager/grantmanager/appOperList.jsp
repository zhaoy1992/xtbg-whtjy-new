
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.OperManager,
				 com.chinacreator.resource.ResourceManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.sitemanager.*" %>
<%@ page import="com.chinacreator.framework.*"%>		
<%@ page import="com.chinacreator.cms.util.CMSUtil" %>		
				
<%
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkManagerAccess(request,response);
    
    //�Ƿ�����������Ȩ�� true����������Ȩ�ޣ�false����������Ȩ��
    String isBatch = request.getParameter("isBatch");
    //�õ���Ҫ����Ȩ�޵��û�ID���ɫID
    String currRoleId = (String)request.getParameter("currRoleId");
    
    //�õ�����Ȩ����  user��role
    String role_type = (String)request.getParameter("role_type");
    
    //�����Ȩ����Ϊ"user"��
    String orgId = (String)request.getParameter("currOrgId");
	
	//��Դ���� role,organization,column....
	String resTypeId = request.getParameter("resTypeId");
	
	//��ԴID
	String resId = request.getParameter("resId");
	//��Դ���ƻ�����
	String resName = request.getParameter("resName");
	
	
	
	
	
%>

<html>
<head>    
  <title>��������</title>
  <link rel="stylesheet" type="text/css" href="../css/windows.css">
  <script language="JavaScript" src="../scripts/func.js" type="text/javascript"></script>
  <link rel="stylesheet" type="text/css" href="../css/windows.css">
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin">
<div id="contentborder">
	
<center>

<form name="Form1" target="group"  method="post" >
	<fieldset>
	    <LEGEND align=left><strong><FONT size=2>Ȩ������</FONT></strong></LEGEND>
	    <table width="100%" height="22" border="0" cellpadding="0" cellspacing="1" class="thin">
	    <tr class="tr">
	        <td class="td"  height="22" align="center"><strong>Ӧ������<strong></td>
	        <td class="td"  height="22" align="center" ><strong>Ӧ��ID</strong></td>
	        <td class="td"  height="22" align="center" ><strong>����Ȩ��</strong></td>
	      </tr>
	      <%
	
		String parentPath = "cms::menu://sysmenu$root/appManager$module";
		SiteManagerImpl simpl = new SiteManagerImpl();
		List items = simpl.getSubItems(parentPath);   
		List isSetedList = simpl.getSetedAppInSite(resId); //resid ��Ϊ siteid
		for(int i=0;i<items.size();i++){
			String flag = "";
			String itemId = "";
			String itemName = "";
			String itemPath = "";
			int dolarcount = 1;
			String type = "";
			if(items.get(i)  instanceof  Item){
				Item item = (Item)items.get(i);
				
				itemId = item.getId();
				itemName = item.getName();
				itemPath = item.getPath();
				type = "item";
				dolarcount = CMSUtil.count(itemPath,'$') - 2;
				
			}else if(items.get(i) instanceof Module){
				Module module = (Module)items.get(i);
				itemId = module.getId();
				itemName = module.getName();
				itemPath = module.getPath();
				type = "module";
				dolarcount = CMSUtil.count(itemPath,'$') - 2;
			}
			String setId = itemPath + "^" + itemId;
			for(int j=0;j<isSetedList.size();j++){							    
				String sid = (String)isSetedList.get(j);					
				if(setId.equals(sid)) {
					flag = "checked";
					break;
				}
			}
			if(!flag.equals("checked"))
			{
				continue;
			}
		%>
		<tr>
			<td style="text-align:left">
			<%
				for(int j = 0; j < dolarcount; j ++)
				{	
					out.println( "<img src='../images/site/space_br.gif'/>");
				}
				out.println("<img src='../images/site/" + type +".gif'/>");
				out.println(itemName);
			%>
			</td>
			
			<td><%=itemId%></td>
			
			<%
				if(flag.length()>0)
				{
			%>
			<td onclick="openWin('operList_siteapp_tab.jsp?currRoleId=<%=currRoleId%>&role_type=<%=role_type%>&resId=<%=resId+"$$"+itemId%>&resTypeId=<%=resTypeId%>&resTypeName=<%=itemId%>&title=<%=itemName%>&username=<%=itemName%>&currOrgId=<%=orgId %>',600,500)">
				<img src="../images/site/new_doc.gif" border="0"  style="cursor:hand">
			</td>
			<%
				}
				else
				{
			%>
			<td>&nbsp;</td>
			<%
				}
			%>
		</tr>    
		<%
		}
		%>   
	    </table>
    </fieldset>
</form>

<IFRAME name="group" width="0" height="0"></IFRAME>

</center>
</div>
</body>
</html>