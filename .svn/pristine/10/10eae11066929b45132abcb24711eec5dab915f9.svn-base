
<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ page import="com.chinacreator.security.*"%>
<%@page import="com.chinacreator.epp.util.orgusertb.RtxManager"%>
<%@page import="com.chinacreator.message.util.MsgConfig"%>
<%@page import="com.chinacreator.message.factory.MsgRMIClientServerFactory"%>
<%
response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires",0);
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	RtxManager rtxManager = new RtxManager();
	String isConnect = "";
	boolean useRMI = "1".equals(MsgConfig.getProperties("RTX_USER_RMISEND"));
	if(useRMI){//判断rtx连接是否成功
		try{
			MsgRMIClientServerFactory.getRmiMsgServer().isExists("select * from SYS_User");
			isConnect = "true";
		}catch(Exception e){
			isConnect = "连接RTX数据库失败,远程服务未打开或出现异常";
		}
	}else{
		if(rtxManager.getCon()!=null)
		isConnect = "true";
		else
		isConnect = "连接RTX数据库失败，请检查RTX连接配置";
	}
%>
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="../../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../../css/treeview.css">
		<title>组织机构管理</title>
		<script type="text/javascript">
			  var isConnect = '<%=isConnect%>';
			  if(isConnect!="true"){
			  	alert(isConnect);
			  }
		</script>
	</head>
	<frameset name="userOrgFrame" cols="25%,*" border=0 framespacing="0">
		<frame frameborder=1 scrolling="yes" name="org_tree" src="pt_org_tree.jsp" marginWidth=0 marginHeight=0 >
		</frame>
		<frame frameborder=0 scrolling="yes" name="ptuser_list" src="ptuser_list.jsp" marginWidth=0 marginHeight=0 >
		</frame>
	</frameset>
</html>
