<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.businessclassmanager.service.impl.FormClassServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.businessclassmanager.service.FormClassService"%>
<%@page import="com.chinacreator.xtbg.core.businessclassmanager.entity.FormClass"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>

<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	//用户信息（用户真实名称：用户帐号[用户ID]）
	String userInfo = control.getUserName()+":"+control.getUserAccount()+"["+control.getUserID()+"]";
	//操作的ip地址
	String remoteAddr = request.getRemoteAddr();
	//用户信息
	String operUser = userInfo;
	//操作的ip地址
	String operSource = remoteAddr;
	String subid =StringUtil.deNull(request.getParameter("subid"));
	String app_id = control.getCurrentSystemID();
	String ec_name = request.getParameter("ec_name");
	String remark = request.getParameter("remark");
	String ec_id = request.getParameter("ec_id");
	String ec_upid = "";
	boolean isEdit =request.getParameter("isEdit")!=null&&request.getParameter("isEdit").equals("true");

	if(isEdit) {		
		ec_upid = request.getParameter("ec_upid");
	}else{
		ec_upid=ec_id;
	}
	String ec_sn = request.getParameter("ec_sn");
			
	FormClass formClass = new FormClass();
	formClass.setApp_id(app_id);
	formClass.setEc_id(ec_id);			
	formClass.setEc_name(ec_name);
	formClass.setEc_upid(ec_upid);//新增子类时作为父类id
	formClass.setRemark(remark);
	formClass.setOwner_id(control.getUserID());
    formClass.setEc_sn(ec_sn);
	FormClassService formClassManager = new FormClassServiceImpl();
	String b="";
	if(!isEdit){
		if(!formClassManager.isExistByUpId(ec_name,app_id,ec_id)){
	        if(formClassManager.insertFormClass(formClass)){
	       		b="true";
	        }
		}else{
			b="false";
		}
	}else{
		if(!formClassManager.isExistByEc_name(ec_name,app_id,ec_id,ec_upid)){
	       	if(formClassManager.updateFormClass(formClass)){
	       		b="true";
	       	}
		}else{
			b="false";
		}
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
		<script type="text/javascript">
		var mes = "";
		var bool = true;
		if(!<%=isEdit%>){
			if('true'=='<%=b%>'){
				alert("新增子类成功！");
				parent.window.top.findPageCacheName('<%=subid%>').superwindow.parent.setleftIframeSrc('navigator_content.jsp?numner=1');
				parent.back();
			}else if('false'=='<%=b%>'){
				alert("该类别名称已存在，请换一个名称！");
			}else{
				alert("新增子类失败！");
			}
		}else{
			if('true'=='<%=b%>'){
				alert("修改类别信息成功！");
				parent.window.top.findPageCacheName('<%=subid%>').superwindow.parent.setleftIframeSrc('navigator_content.jsp?numner=1');
				parent.back();
			}else if('false'=='<%=b%>'){
				alert("该类别名称已存在，请换一个名称！");
			}else{
				alert("修改类别信息失败！");
			}
		}
		</script>
	</head>

	<body>
	</body>
</html>