<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.util.*,com.chinacreator.sysmgrcore.entity.User"%>
<%AccessControl accesscontroler = AccessControl.getInstance();
            accesscontroler.checkAccess(request, response);

            %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>用户映射</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
		<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/jobmanager/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
		<script language="JavaScript" src="../scripts/common.js" type="text/javascript"></script>
		<script language="JavaScript">
   	
	
	function deletePkg(pkgID,version){
		
		document.forms[0].action="../packagemanage/packageManager.do?method=deletePkg";
		document.forms[0].submit();
	}
	function updatePkg(){		  
		document.location.href="updatePkg.jsp";
	}
		</script>
		<!--
    <link rel="stylesheet" type="text/css" href="styles.css">
    -->
	</head>

	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" >
		<div id="contentborder" align="center">

			<FORM name="UserForm" action="" method="post">
				<TABLE width="100%" cellpadding="1" cellspacing="1" bordercolor="#EEEEEE">
					<!--分页显示开始,分页标签初始化-->
					<TR>
						<TD height="30" class="detailtitle" align="center" colspan="8">
							<B>用户映射列表</B>
						</TD>
					</TR>
					<pg:listdata dataInfo="PackageList" keyName="PackageList" />
					<pg:pager maxPageItems="12" scope="request" data="PackageList" isList="false">
						<TH class="headercolor">
							角色名
						</TH>
						
						<TH class="headercolor">
							用户名
						</TH>

						<pg:list>
							<tr class="labeltable_middle_tr_01" onMouseOver="this.className='mousestyle1'" onMouseOut="this.className= 'mousestyle2'">
								<td class="tablecells" width="20%" nowrap="nowrap">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
									<pg:equal colName="actorName" value="">未命名</pg:equal>
									<pg:cell colName="actorName" defaultValue="" />
								</td>
								<td class="tablecells" width="20%" nowrap="nowrap">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
									<pg:equal colName="userName" value="">未命名</pg:equal>
									<pg:cell colName="userName" defaultValue="" />
								</td>
								
								<td class="tablecells" width="15%" nowrap="nowrap">
									
								</td>
							</tr>
						</pg:list>
						<tr height="18px" class="labeltable_middle_tr_01">
							<td colspan=5 align='center' nowrap="nowrap">
								<pg:index />
							</td>
						</tr>
						<input name="queryString" value="<pg:querystring/>" type="hidden">
					</pg:pager>
				</TABLE>
			</FORM>
		</div>
	</body>
</html>
