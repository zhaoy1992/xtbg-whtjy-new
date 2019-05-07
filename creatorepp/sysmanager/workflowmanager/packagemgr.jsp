<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.holiday.*"%>
<%@ page import="java.util.*,com.chinacreator.sysmgrcore.entity.User"%>
<%AccessControl accesscontroler = AccessControl.getInstance();
            accesscontroler.checkAccess(request, response);

            %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>包管理</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
		<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/jobmanager/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
		<script language="JavaScript" src="../scripts/common.js" type="text/javascript"></script>
		<script language="JavaScript">
   	
	
	function deletePkg(pkgID,version,o){

		document.forms[0].pkgID.value = pkgID;
		document.forms[0].version.value = version;
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

	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scrolling="no">
		<div id="contentborder" align="center">

			<FORM name="PackageForm" action="" method="post">
			<input type="hidden" name="pkgID">
			<input type="hidden" name="version">
				<TABLE width="100%" cellpadding="1" cellspacing="1" bordercolor="#EEEEEE" class="thin">
					<!--分页显示开始,分页标签初始化-->
					<TR>
						<TD height="30" class="detailtitle" align="center" colspan="8">
							<B>包列表</B>
						</TD>
					</TR>
					<pg:listdata dataInfo="PackageList" keyName="PackageList" />
					<pg:pager maxPageItems="15" scope="request" data="PackageList" isList="false">
						<td class="headercolor">
							包id/包名
						</td>
						<td class="headercolor">
							包版本
						</td>
						<td class="headercolor">
							备注
						</td>
						<td class="headercolor">
							操作
						</td>
						<pg:list>
							<pg:equal colName="version" value="0">
								<tr bgcolor = "#608291"  >
									<td   width="20%" nowrap="nowrap">
										包id：<pg:cell colName="id" defaultValue="" />
									</td>
									<td>&nbsp
									</td>
									<td>&nbsp
									</td>
									<td class="tablecells" width="20%" nowrap="nowrap">
										<input type="button" class="input" value="删除所有版本" onclick="javascript:deletePkg('<pg:cell colName="id" defaultValue="" />','')">
										<input type="button" class="input" value="更新包" onclick="updatePkg()" >
									</td>
								</tr>
							</pg:equal>
							<pg:notequal colName="version" value="0">
							<tr class="labeltable_middle_tr_01" onMouseOver="this.className='mousestyle1'" onMouseOut="this.className= 'mousestyle2'">
								<td class="tablecells" width="20%" nowrap="nowrap">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
									包名:<pg:equal colName="name" value="">未命名</pg:equal>
									<pg:cell colName="name" defaultValue="" />
								</td>
								<td class="tablecells" width="20%" nowrap="nowrap">
									<pg:equal colName="version" value="">无版本号</pg:equal>
									<pg:cell colName="version" defaultValue="" />
								</td>
								<td class="tablecells" width="15%" nowrap="nowrap">
									<pg:equal colName="memo" value="">无备注</pg:equal>
									<pg:cell colName="memo" defaultValue="" />
								</td>
								<td class="tablecells" width="15%" nowrap="nowrap">
									<input type="button" class="input" name="ID" value="删除当前版本" onclick="javascript:deletePkg('<pg:cell colName="id" defaultValue="" />','<pg:cell colName="version" defaultValue="1" />')">
								</td>
								</tr>
							</pg:notequal>
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
