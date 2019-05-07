<% 
  response.setHeader("Cache-Control", "no-cache"); 
  response.setHeader("Pragma", "no-cache"); 
  response.setDateHeader("Expires", -1);  
  response.setDateHeader("max-age", 0); 
%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%
/**
 * 
 * <p>Title: ѡ����Դ�б�</p>
 *
 * <p>Description: ѡ����Դ�б�</p>
 *
 * <p>Copyright: Copyright (c) 2008</p>
 *
 * <p>Company: chinacreator</p>
 * @Date 2008-11-4
 * @author gao.tang
 * @version 1.0
 */
 %>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%
	AccessControl accessControl = AccessControl.getInstance();
	if(!accessControl.checkManagerAccess(request, response)){
		return;
	}
	
	String restypeId = request.getParameter("restypeId");
%>

<html>
<head>
	<title></title>
	<base target="_self">	
	<link rel="stylesheet" type="text/css" href="../../css/windows.css">
	<script type="text/javascript" language="Javascript">
		function okadd(){	
			selectNode = document.all.item("checkBoxOne");
			if(selectNode==null){
 				alert("��ѡ����Դ��"); return;
 			}    
 			var ret ;
 	
 			if(selectNode.length)
 			{
 				for(var i = 0;  i < selectNode.length; i ++)
 				{
 					if(selectNode[i].checked)
 					{
 						ret = selectNode[i].value;
 					}
 			
 				}
 			}
 			else if(selectNode)
 			{
 				if(selectNode.checked)
				{
					ret = selectNode.value;
				}
 			}
 			if(!ret)
 			{
 				alert("��ѡ����Դ��"); return;
 			}    
			window.returnValue = ret;   
			window.close();
		}
	
	</script>
</head>

<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin"  scroll="no">
<div align="center">
<tr>
<td>
<input name="add" type="button" class="input" value="ȷ��" onclick="okadd()" >
    <input name="exit" type="button" class="input" value="ȡ��" onclick="parent.window.close();">
</td>
</tr>
</DIV>
<div id="contentborder" style="width:100%;height:495;overflow:auto">

    <table width=100% border="1" cellpadding="0" cellspacing="0" bordercolor="#B7CBE4"  class="Datalisttable">
    <pg:listdata dataInfo="ResSearchList" keyName="ResSearchList" />
						<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
						<pg:pager maxPageItems="10" scope="request" data="ResSearchList" isList="false">
							<tr class="cms_report_tr">
								<!--���÷�ҳ��ͷ-->
								<td class="headercolor" height='30' width="4%">
									
								</td>
								<input class="text" type="hidden" name="selectId">
								<td class="headercolor" height='30' width="18%">��Դ����</td>
								<td class="headercolor" height='30' width="18%">��Դ����</td>
								<td class="headercolor" height='30' width="30%">������Ϣ</td>
								
							</tr>
							<pg:param name="restypeId" />
							<pg:param name="title" />
							<pg:param name="path" />

							<!--��⵱ǰҳ���Ƿ��м�¼-->
							<pg:notify>
								<tr height="18px" class="labeltable_middle_tr_01">
									<td colspan=100 align='center' height='30'>
										��ʱû����Դ��
									</td>
								</tr>
							</pg:notify>

							<!--list��ǩѭ�����ÿ����¼-->
							<pg:list>
								<% 
									String title = dataSet.getString("title");
									String path = dataSet.getString("path");
									if(path == null || "".equals(path)){
										path = title;
									}
								%>
								<tr class="cms_data_tr" >
									<td class="tablecells" nowrap="nowrap" height='30'>
										<input type="radio" name="checkBoxOne"  value="<%=title+":"+path %>"  width="10" />
									</td>
									<td class="tablecells" nowrap="nowrap" height='30'>
										<pg:cell colName="restypeName" defaultValue="" />
									</td>
									
									<!-- ��Դ�޸ģ�ֻ����ӵ�г�������Ա��ɫ���û��ܽ��д������ --> 
									<td class="tablecells" nowrap="nowrap" height='30' style="cursor:hand" bgcolor="#F6FFEF">
									<input type="hidden" name="title" value="<pg:cell colName="title" defaultValue="" />"/>
										<pg:cell colName="title" defaultValue="" />
									</td>
									<td class="tablecells" nowrap="nowrap" height='30'>
										<pg:equal colName="path" value="">
											<pg:cell colName="title"  maxlength="14" />
										</pg:equal>
										<pg:cell colName="path"  maxlength="14" />
									</td>
									
								</tr>
							</pg:list>
							<tr height="18px">
								<td colspan=7 align='center' class="Data_List_Table_Bottom">
									��<pg:rowcount/>����¼ <pg:index />						
								</td>
						</tr>
							<input name="queryString" value="<pg:querystring/>" type="hidden">
						</pg:pager>
    </table>
</div>
</body>

</html>