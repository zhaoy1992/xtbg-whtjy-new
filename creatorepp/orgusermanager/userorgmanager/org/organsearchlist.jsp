<%
/**
 * <p>Title: 机构查询</p>
 * <p>Description: 机构查询页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-17
 * @author da.wei
 * @version 1.0
 **/
 %>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.User"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%         
  			String orgId = request.getParameter("orgId");
			String remark5 = request.getParameter("remark5");
			String orgnumber = request.getParameter("orgnumber");
			String orgcreator = request.getParameter("orgcreator");
			if (remark5 == null)
				remark5 = "";
			if (orgnumber == null)
				orgnumber = "";
			if (orgcreator == null)
			    orgcreator = "";	
%>
<html>
	<head>
		<title>属性容器</title>
		<link rel="stylesheet" type="text/css" href="../../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../../css/treeview.css">
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
		<div id="contentborder" align="center">
			<form name="Org" action="" method="post">
				<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
					<pg:listdata dataInfo="com.chinacreator.sysmgrcore.purviewmanager.tag.OrgSearchList" keyName="OrgList" />
					<!--分页显示开始,分页标签初始化-->
					<pg:pager maxPageItems="15" scope="request" data="OrgList" isList="false">
						<tr>
							<!--设置分页表头-->
							<td height="30px" class="headercolor">
								机构名称
							</td>
							<input class="text" type="hidden" name="selectId">
							<td height="30px" class="headercolor">
								机构编号
							</td>
							<td height="30px" class="headercolor">
								机构排序号
							</td>
							<td height="30px" class="headercolor">
								机构描述
							</td>
                         	<%--<td height="30px" class="headercolor">
								机构创建人
							</td>--%>

						</tr>
						<pg:param name="orgName" />
						<pg:param name="code" />
						<pg:param name="remark5" />
						<pg:param name="orgnumber" />
						<pg:param name="orgcreator"  />
						<!--检测当前页面是否有记录-->
						<pg:notify>
							<tr height="18px">
								<td colspan=100 align='center'>
									暂时没有接收单位
								</td>
							</tr>
						</pg:notify>

						<!--list标签循环输出每条记录-->
						<pg:list>
						<%--<%
						   String owner_Id=(String)dataSet.getString("creator");
						   
						   UserManager usermanager=SecurityDatabase.getUserManager();
					        User user=usermanager.getUserById(owner_Id);
					       String username="";
					       String userrealname="";
					       if(user != null){
					       		username=user.getUserName();
					       		userrealname=user.getUserRealname();	
					       }
					      
						%>--%>
							<tr onmouseover="this.className='mouseover'" onmouseout="this.className= 'mouseout'" onDBLclick="">

								<td height="20px" align="left" class="tablecells">
									<pg:null colName="remark5">
										<pg:cell colName="orgName" />
									</pg:null>
									<pg:notnull colName="remark5">
										<pg:equal colName="remark5" value="">
											<pg:cell colName="orgName" />
										</pg:equal>
										<pg:notequal colName="remark5" value="">
											<pg:cell colName="remark5" />
										</pg:notequal>
									</pg:notnull>
								</td>
								<td height="20px" align=left class="tablecells">
									<pg:cell colName="orgnumber" defaultValue=" " />
								</td>
								<td height="20px" align=left class="tablecells">
									<pg:cell colName="orgSn" defaultValue=" " />
								</td>
								<td height="20px" align=left class="tablecells">
									<pg:notnull colName="orgdesc">
										<pg:cell colName="orgdesc" defaultValue=" " />
									</pg:notnull>

									<pg:null colName="orgdesc">没有描述</pg:null>
									<pg:equal colName="orgdesc" value="">没有描述</pg:equal>
								</td>
                                    <%--<td height="20px" align=left class="tablecells">
									<%=username%>【<%=userrealname%>】
								</td>--%>
							</tr>
						</pg:list>
						<tr height="30px">
							<td colspan=100 align='center' class="detailcontent">
								共
								<pg:rowcount />
								条记录
								<pg:index />
								<input type="hidden" name="queryString" value="<pg:querystring/>">
							</td>
						</tr>
					</pg:pager>

				</table>
			</form>
		</div>
	</body>

</html>
