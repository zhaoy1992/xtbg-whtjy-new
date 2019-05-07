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
 * <p>Title: 选择资源列表</p>
 *
 * <p>Description: 选择资源列表</p>
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
 				alert("请选择资源！"); return;
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
 				alert("请选择资源！"); return;
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
<input name="add" type="button" class="input" value="确定" onclick="okadd()" >
    <input name="exit" type="button" class="input" value="取消" onclick="parent.window.close();">
</td>
</tr>
</DIV>
<div id="contentborder" style="width:100%;height:495;overflow:auto">

    <table width=100% border="1" cellpadding="0" cellspacing="0" bordercolor="#B7CBE4"  class="Datalisttable">
    <pg:listdata dataInfo="ResSearchList" keyName="ResSearchList" />
						<!--分页显示开始,分页标签初始化-->
						<pg:pager maxPageItems="10" scope="request" data="ResSearchList" isList="false">
							<tr class="cms_report_tr">
								<!--设置分页表头-->
								<td class="headercolor" height='30' width="4%">
									
								</td>
								<input class="text" type="hidden" name="selectId">
								<td class="headercolor" height='30' width="18%">资源类型</td>
								<td class="headercolor" height='30' width="18%">资源名称</td>
								<td class="headercolor" height='30' width="30%">描述信息</td>
								
							</tr>
							<pg:param name="restypeId" />
							<pg:param name="title" />
							<pg:param name="path" />

							<!--检测当前页面是否有记录-->
							<pg:notify>
								<tr height="18px" class="labeltable_middle_tr_01">
									<td colspan=100 align='center' height='30'>
										暂时没有资源项
									</td>
								</tr>
							</pg:notify>

							<!--list标签循环输出每条记录-->
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
									
									<!-- 资源修改，只能是拥有超级管理员角色的用户能进行此项操作 --> 
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
									共<pg:rowcount/>条记录 <pg:index />						
								</td>
						</tr>
							<input name="queryString" value="<pg:querystring/>" type="hidden">
						</pg:pager>
    </table>
</div>
</body>

</html>