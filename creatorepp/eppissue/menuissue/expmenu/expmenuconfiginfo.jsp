<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.eppissue.menuissue.expmenu.dbmanager.ExpmenuConfig"%>
<%@ page import="com.chinacreator.eppissue.menuissue.expmenu.vo.ExpmenuConfigVo"%>
<%@page import="com.chinacreator.eppissue.menuissue.expmenu.menu.ExpJaweManager"%>
<%@page import="com.chinacreator.eppissue.menuissue.interfaces.IComponentsExpManage"%>
<%@page import="com.chinacreator.eppissue.menuissue.factorys.ComponentsFactory"%>
<%@page import="com.chinacreator.eppissue.menuissue.configutil.ConfigManage"%>
<%@ include file="/sysmanager/include/global1.jsp"%>
<%@include file="expmenuconfigvo.jsp" %>
<%
	ExpmenuConfig expmenuConfig = new ExpmenuConfig();
	ExpmenuConfigVo expmenuConfigVo = expmenuConfig.getExpmenuConfigVoByModule(moduleID,control.getCurrentSystemID());
	ExpmenuConfigVo expmenuConfigVo2 = expmenuConfig.getExpmenuConfigVoByDB(moduleID,control.getCurrentSystemID());
	//得到默认流程绑定的表单ID add by wen.zhu 20100812
	//ExpJaweManager jaweManager = new ExpJaweManager();	
	//String defaultJaweBandingEformId=jaweManager.getDefaultEfromId(expmenuConfigVo.getJawe_id(), null , control.getCurrentSystemID());
//	String defaultJaweBandingEformId="";
//	IComponentsExpManage jaweExpManage = ComponentsFactory.getIComponentsExpManage(ConfigManage.sfs_JAWE);
//	if(null!=jaweExpManage){
//		defaultJaweBandingEformId = jaweExpManage.getEformIDsByJaweID(moduleID,expmenuConfigVo.getJawe_id());
//	}
%>
<html>
	<head>
		<title>模块配置</title>
		<!-- 提交后页面变灰 -->
		<script language="javascript" type="text/javascript"
			src="../pageGrey.js">
		</script>
		<script type="text/javascript">
			function jumpPage(){
				//提交后页面变灰
				popSignFlow(1);
				document.infoform.submit();
			}
		</script>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body onload="jumpPage();">
		<form name="infoform" action="businessclassselect.jsp" method="post">
		<input type="hidden" name="isFill" value="true">
		<input type="hidden" name="moduleID" value="<%=moduleID%>">
		<input type="hidden" name="workclass" value="<%=expmenuConfigVo2.getBusinessclass_id()%>">
		<input type="hidden" name="sel_eform_id" value="<%=expmenuConfigVo2.getEform_id()%>">
		<input type="hidden" name="sel_jawe_id" value="<%=expmenuConfigVo2.getJawe_id()%>">
		<input type="hidden" name="sel_report_id" value="<%=expmenuConfigVo2.getReport_id()%>">
		<input type="hidden" name="sel_filepath" value="<%=expmenuConfigVo2.getFilepath()%>">
		<input type="hidden" name="default_businessclass_id" value="<%=expmenuConfigVo.getBusinessclass_id()%>">
		<input type="hidden" name="default_eform_id" value="<%=expmenuConfigVo.getEform_id()%>">
		<input type="hidden" name="temp_eform_id" value="<%=expmenuConfigVo.getEform_id()%>">
		<input type="hidden" name="default_jawe_id" value="<%=expmenuConfigVo.getJawe_id()%>">				
		<input type="hidden" name="default_report_id" value="<%=expmenuConfigVo.getReport_id()%>">
		<input type="hidden" name="default_filepath" value="<%=expmenuConfigVo.getFilepath()%>">
		<input type="hidden" name="init_sel_eform_id" value="<%=expmenuConfigVo2.getEform_id()%>">
		<input type="hidden" name="init_sel_jawe_id" value="<%=expmenuConfigVo2.getJawe_id()%>">
		<input type="hidden" name="init_sel_report_id" value="<%=expmenuConfigVo2.getReport_id()%>">
		<input type="hidden" name="init_sel_filepath" value="<%=expmenuConfigVo2.getFilepath()%>">
		</form>		
	</body>
</html>
