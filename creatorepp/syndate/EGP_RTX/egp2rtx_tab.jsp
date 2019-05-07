<%@page contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.syndatemanager.rtxmanager"%>
<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires",0);
	
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);

    rtxmanager RM = new rtxmanager();
    String isConnect = "";
   
   if(RM.getCon()!=null){
      isConnect = "true";
   }else{
      isConnect = "连接RTX数据库失败，请检查RTX连接配置";
   }

%>
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="../../css/windows.css">
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<tab:tabConfig />
		<title>平台与RTX同步选项卡</title>
		<script type="text/javascript">
			  var isConnect = '<%=isConnect%>';
			  if(isConnect!="true"){
			  	alert(isConnect);
			  }
		</script>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body bgcolor="#F7F8FC">
	
		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			align="center">
			<tr>
				<td colspan="2">

					<tab:tabContainer id="tb-tab"
						selectedTabPaneId="tb-tab1">

						<tab:tabPane id="tb-tab1" tabTitle="机构" lazeload="true">
							<tab:iframe id="manualmove" src="egp2rtx_dept.jsp"
								frameborder="0" scrolling="no" width="100%" height="480">
							</tab:iframe>
						</tab:tabPane>

						<tab:tabPane id="tb-tab2" tabTitle="用户" lazeload="true">
							<tab:iframe id="prerealtime" src="egp2rtx_user.jsp"
								frameborder="0" scrolling="no" width="100%" height="480">
							</tab:iframe>
						</tab:tabPane>
                        

			         </tab:tabContainer>
				</td>
			</tr>
		</table>
	</body>
</html>
