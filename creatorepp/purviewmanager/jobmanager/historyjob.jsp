<%
/*
 * <p>Title: 历史职位查看页面</p>
 * <p>Description: 历史职位查看页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-26
 * @author baowen.liu
 * @version 1.0
 */
%>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkManagerAccess(request,response);
%>

<html>

   <head>
   <link rel="stylesheet" type="text/css" href="../css/windows.css">
	<link rel="stylesheet" type="text/css" href="../css/treeview.css">
   </head>
   
  <%@ include file="/epp/css/cssControl.jsp"%><body >
    <table width=100% border="0" cellpadding="0" cellspacing="1" class="thin">
                     <pg:listdata dataInfo="JobHistoryList" keyName="JobHistoryList" />
						<!--分页显示开始,分页标签初始化-->
						<pg:pager maxPageItems="13" id="JobHistoryList" scope="request" data="JobHistoryList" isList="false">
							<tr>
								<!--设置分页表头-->
								
								<td class="headercolor" height='30'>用户姓名</td>
								<td class="headercolor">用户登录名</td>
								<td class="headercolor">所属岗位</td>
								<td class="headercolor">所在机构</td>
								<td class="headercolor">上岗时间</td>	
								<td class="headercolor">离岗时间</td>								
								<td class="headercolor">岗位状态</td>
							</tr>
							<pg:param name="org_name" />
							<pg:param name="user_Name" />
							<pg:param name="job_name" />
							<pg:param name="jobId" />
							<!--检测当前页面是否有记录-->
							<pg:notify>
								<tr height="18px" class="labeltable_middle_tr_01">
									<td colspan=7 align='center'>
										没有历史记录
									</td>
								</tr>
							</pg:notify>

							<!--list标签循环输出每条记录-->
							<pg:list>								
								<tr onmouseover="this.className='mouseover'" onmouseout="this.className= 'mouseout'" onclick="" >
									
									<td class="tablecells" nowrap="nowrap" height='20'>
										<pg:cell colName="userRealname" defaultValue="" />
									</td>
									<td class="tablecells" nowrap="nowrap" height='20'>
										<pg:cell colName="userName" defaultValue="" />
									</td>
									<td class="tablecells" nowrap="nowrap">
										<pg:cell colName="jobName" defaultValue="" />
									</td>									
									<td class="tablecells" nowrap="nowrap" >
										<pg:cell colName="orgName" defaultValue="" />
									</td>
									<td class="tablecells" nowrap="nowrap">
										<pg:cell colName="jobStartTime" defaultValue="未知" dateformat="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td class="tablecells" nowrap="nowrap">
										<pg:cell colName="quashTime" defaultValue="未知" dateformat="yyyy-MM-dd HH:mm:ss"/>
									</td>
									
									<td class="tablecells" nowrap="nowrap">
										
										<pg:equal colName="fettle" value="1">在岗</pg:equal>
					  					<pg:equal colName="fettle" value="0">离岗</pg:equal>																										    					    							    				    		
					  					<pg:equal colName="fettle" value=" ">未知</pg:equal>
									</td>	
								</tr>
							</pg:list>
							<tr height="18px" class="labeltable_middle_tr_01">
								<td colspan=7 align='center'>
									共<pg:rowcount/>条记录 <pg:index />
								</td>						
							</tr>
							<input name="queryString" value="<pg:querystring/>" type="hidden">
						</pg:pager>
</table>
	</body>
	
</html>
