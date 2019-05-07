<%-- 
	描述：角色机构列表查询
	作者：黄艺平
	版本：1.0
	日期：2013-05-30
 --%>
<%     
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0); 
%>



<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>

<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.User"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager"%>


<%	
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	request.setAttribute("action","org");
	String roleId = request.getParameter("roleId");	
	
	String orgName = request.getParameter("orgName");
	String remark5 = request.getParameter("remark5");
	//String creator = request.getParameter("creator");
	
	orgName = orgName == null ? "" : orgName; 
	remark5 = remark5 == null ? "" : remark5 ;
	
	UserManager usermanager=SecurityDatabase.getUserManager();

	
%>
<html>
	<head>
		<title>属性容器</title>
		<link href="../css/windows.css" rel="stylesheet" type="text/css">
		<link href="../css/treeview.css" rel="stylesheet" type="text/css">
		
		<script language="JavaScript" src="../../../../purviewmanager/scripts/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="../../../../purviewmanager/scripts/pager.js" type="text/javascript"></script>
		<!-- 引入jQuery -->
		<script type="text/javascript" src="../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
		<!-- 引入其它 -->
		<script src="../../resources/util/public.js" type="text/javascript"></script>
		<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script> 
		<script language="javascript">	
			function clearQueryInfo()
			{
				orgList.orgName.value = '';
				orgList.remark5.value = '';
			}
			
			function querySub(){
				var orgName = orgList.orgName.value;
				var remark5 = orgList.remark5.value;
				document.orgList.action = "roleorgquery.jsp?orgName="+orgName+"&remark5="+remark5+"&type=org&roleId=<%=roleId%>";
				//alert(document.orgList.action)
				document.orgList.submit();
			}
		</script>
		<%@ include file="/epp/css/cssControl.jsp"%><body >
			<div align="center">
				<form name="orgList" method="post" >	
					<table cellspacing="1" cellpadding="0" border="0" bordercolor="#EEEEEE" width=100% class="thin">
						<tr>
							<td width="10%" nowrap>
								<div align="center">
									 机构名称
								</div>
							</td>
							<td width="20%" nowrap>
								<div align="left">
									<input type="text" name="orgName" value="<%=orgName%>" size="30">
								</div>
							</td>
							<td width="10%" nowrap>
								<div align="center">
									 机构显示名称
								</div>
							</td>
							<td width="20%" nowrap>
								<div align="left">
									<input type="text" name="remark5" value="<%=remark5%>" size="30">
								</div>
							</td>
							<!-- 
							<td width="10%" nowrap>
								<div align="center">
									 机构创建者
								</div>
							</td>
							 
							<td width="20%" nowrap>
								<div align="left">
									<input type="text" name="creator" value="" size="20">
								</div>
							</td>
							-->
							<td>
								<div align="center">
									&nbsp;<input type="button"  value="查询" onclick="querySub()" class="input">&nbsp;&nbsp;&nbsp;
									<input type="button"  value="清空" onclick="clearQueryInfo()" class="input">&nbsp;&nbsp;&nbsp;
									<input type="button"  value="关闭" onclick="removeAlertWindows('',true)" class="input">&nbsp;&nbsp;&nbsp;
								</div>
							</td>
						</tr>
					</table>
				
				<hr width="100%">
				
				<pg:listdata dataInfo="com.chinacreator.sysmgrcore.purviewmanager.tag.RoleGrantSearchList" keyName="RoleGrantSearchList" />
				<!--分页显示开始,分页标签初始化-->
				<pg:pager maxPageItems="15" id="RoleGrantSearchList" scope="request" data="RoleGrantSearchList" isList="false">
					<table cellspacing="1" cellpadding="0" border="0" width=100% class="thin">
						<tr>
							<!--设置分页表头-->								
							<td height='30' width="20%" class="headercolor"  >机构名称</td>
							<td height='30' width="*" class="headercolor"  >机构显示名称</td>
							<td height='30' width="20%" class="headercolor"  >机构编号</td>
							<td height='30' width="17%" class="headercolor"  >行政区码</td>
							<td height='30' width="*" class="headercolor"  >机构创建者</td>
						</tr>
							
						<pg:param name="roleId" value="<%=roleId%>"/>
						<pg:param name="orgName"/>
						<pg:param name="remark5"/>
						<pg:param name="type" value="org"/>
						<pg:param name="creator"/>
	                      
						<!--检测当前页面是否有记录-->
						<pg:notify>
							<tr height="18px" class="labeltable_middle_tr_01">
								<td colspan=100 align='center' height='20'>
									暂时没有机构
								</td>
							</tr>
						</pg:notify>
	
						<!--list标签循环输出每条记录-->
						<pg:list>
							<tr onmouseover="this.className='mouseover'" onmouseout="this.className= 'mouseout'">
								<td height='20' class="tablecells" nowrap="nowrap">
									<pg:cell colName="orgName" defaultValue="" />
								</td>
								
								<td height='20' class="tablecells" nowrap="nowrap">
									<pg:cell colName="remark5" defaultValue="" />
									<pg:null colName="remark5">机构显示名称为空</pg:null>
									<pg:equal colName="remark5" value="">机构显示名称为空</pg:equal>
								</td>	
								
								
								
								<td height='20' class="tablecells" nowrap="nowrap" >									
									<pg:cell colName="orgnumber" defaultValue="" />
									<pg:null colName="orgnumber">机构编号名称为空</pg:null>
									<pg:equal colName="orgnumber" value="">机构编号名称为空</pg:equal>
								</td>
								
								<td height='20' class="tablecells" nowrap="nowrap" >
									<pg:notnull colName="org_xzqm">
										<pg:cell colName="org_xzqm" defaultValue=" "/>
									</pg:notnull>
									
									<pg:null colName="org_xzqm">行政区码为空</pg:null>
									<pg:equal colName="org_xzqm" value="">行政区码为空</pg:equal>
								</td>
								<td height='20' class="tablecells" nowrap="nowrap" >
									<%
										//增加角色的创建人登陆名和实名
										//baowen.liu 2008-4-14
										String creatorId = dataSet.getString("creator");
										if(creatorId == null || "".equals(creatorId)){
											out.print("未知");
										}else{
											User user=usermanager.getUserById(creatorId);
											String username=user.getUserName();
											String userrealname=user.getUserRealname();
											out.print(username + "【" + userrealname + "】");
										}
									%>
								</td>
							</tr>
						</pg:list>
						
						<tr height="30px" class="labeltable_middle_tr_01">
							<td colspan=5 align='center'>
								每页15条记录	共<pg:rowcount/>条记录  <pg:index />
							</td>
						</tr>
					<input name="queryString" value="<pg:querystring/>" type="hidden">
				 </table>
				 </pg:pager>
			</form>
		</div>
	</body>
</html>