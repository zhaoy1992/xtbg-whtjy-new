<%-- 
描述：全宗号处理页面
作者：肖杰
版本：1.0
日期：2013-07-12
 --%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileFondsnoServicImpl"%>
<%@page import="com.chinacreator.xtbg.core.file.service.FileFondsnoServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.file.entity.FileFondsnoBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<head>
<title>全宗号处理页面</title>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
boolean flag = false;
boolean flag1=true;
String subid=request.getParameter("subid");
String action = request.getParameter("action");
FileFondsnoBean fileFondsnoBean = new FileFondsnoBean();
FileFondsnoServiceIfc fileFondsnoServiceIfc = new FileFondsnoServicImpl();
fileFondsnoBean = (FileFondsnoBean)RequestBeanUtils.getValuesByRequest(request,fileFondsnoBean);
Map<String, String> viewMap = new HashMap<String, String>();
viewMap=fileFondsnoServiceIfc.getFileFondsnoBeanByOrgid(fileFondsnoBean.getF_org_id());
String str=fileFondsnoServiceIfc.isNameorCode(fileFondsnoBean.getF_fondsno_name(), fileFondsnoBean.getF_fondsno(),fileFondsnoBean.getF_fonds_id());

if("addFileFondsno".equals(action)) {
	if("".equals(StringUtil.deNull(viewMap.get("f_org_id")))){
		if((!"name".equals(str))&&(!"code".equals(str))){
			flag=fileFondsnoServiceIfc.addFileFondsno(fileFondsnoBean);
		}else{
			flag=true;
		}
	}else{
		flag=true;
		flag1=false;
	}
} else if("deleteFileFondsno".equals(action)) {
	String f_fonds_id=request.getParameter("f_fonds_id");
	flag=fileFondsnoServiceIfc.deleteFileFondsno(f_fonds_id);
} else if("updateFileFondsno".equals(action)){
	if("".equals(StringUtil.deNull(viewMap.get("f_org_id")))||(viewMap.get("f_fonds_id").equals(fileFondsnoBean.getF_fonds_id()))){
		if((!"name".equals(str)&&!"code".equals(str))){
			flag=fileFondsnoServiceIfc.updateFileFondsno(fileFondsnoBean);
		}else{
			flag=true;
		}
	}else{
		flag=true;
		flag1=false;
	}
}

%>
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript">
var mes = "";
var bool = true;
var action = "<%=action%>";
if(<%=flag%>){
	bool = false;
	if('name'=='<%=str%>'){
		alert('该全宗号名称已经存在，请换一个全宗号名称！');
	}else if('code'=='<%=str%>'){
		alert('该全宗号已经存在，请换一个全宗号 ！');
	}else{
	if(<%=flag1%>){
		mes = "操作成功"; 
		var submitAlertOK = function(){
	
			if(action == "deleteFileFondsno"){
				window.parent.location.reload();
			}else {
					window.parent.back();
				}
		}
	   
		var p={
				headerText:'操作信息',
				okName:'确认',
		        okFunction:submitAlertOK
		};
		alert('操作成功!',p);
		}else{
			alert('该单位已有相应档案全宗号，请选择其他单位！');
		}
	}
}else{
	mes = "操作失败"	;
	bool = false;
}
</script>
</head>
<body>
</body> 
</html>