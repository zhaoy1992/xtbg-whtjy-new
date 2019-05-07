<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.sql.SQLException"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="com.chinacreator.xtbg.core.process.processconfig.service.FlowInfoConfigServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.process.processconfig.service.impl.FlowInfoConfigServiceImpl"%><html>
<%@page import="java.io.File"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String jsonparam = request.getParameter("jsonparam");
	String table_id = request.getParameter("table_id");
	String form_image_id = request.getParameter("form_image_id");
	String busitype_code = request.getParameter("busitype_code");//流程对应的业务类型
	
	boolean flag = true;
	String flow_id = "";
	FlowInfoConfigServiceIfc flowInfoConfigService = new FlowInfoConfigServiceImpl();
	try{
		flow_id = flowInfoConfigService.saveFlowConfigInfo(jsonparam);
		flowInfoConfigService.saveTableBusinessMapping(table_id,busitype_code);
		//如果上传了图片，则将图标从数据库放到图片文件夹
		if(!StringUtil.isBlank(form_image_id)){
			//TODO 此处应该做成配置
		    String upload_To_SeverPath =  File.separator+"ccapp"+File.separator+"oa"+File.separator+"archive"+File.separator+"resources"+File.separator+"images"+File.separator+"";
		    upload_To_SeverPath = upload_To_SeverPath.trim();
			String  mFilePath = request.getSession().getServletContext().getRealPath("");  //取得服务器路径
			String  path = mFilePath+ upload_To_SeverPath;
			FileUtil.tableTodisk(path, form_image_id);
		}
		if(StringUtil.nullOrBlank(flow_id)){
			flag=false;
		}
	}catch(Exception e){
		flag = false;
		e.printStackTrace();
	} 
	String openwindid = request.getParameter("openwindid");
%>
</head>
<body>
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js" ></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript">
var mes = "";
var bool = true;
if(<%=flag%>){
	mes = "操作成功"; 
	bool = false;
	//parent.showcflow();
	  var submitAlertOK = function(){
	    	window.parent.parent.parent.location.reload();
	    }
		var p={
			headerText:'处理结果',
				okName:'确认',
		        okFunction:submitAlertOK
		};
		alert('操作成功！',p);
}else{
	mes = "操作失败"	;
	bool = false;
	alert(mes);
}
//window.parent.JqueryDialog.SubmitCompleted(mes, true, bool);
</script>
</body>
</html>