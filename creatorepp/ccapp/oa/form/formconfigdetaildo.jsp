<%--
describe:表单do页面
author:shuqi.liu
date: 2013-6-24
--%>
<%@page contentType="text/html; charset=utf-8"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.core.form.service.Formservice"%>
<%@page import="com.chinacreator.xtbg.core.form.service.impl.FormserviceImpl"%>
<%@page import="com.chinacreator.xtbg.core.form.entity.OaMdColumnsBean"%>
<%@page import="com.alibaba.fastjson.JSONArray"%>
<%
	//AccessControl accesscontroler = AccessControl.getInstance();
	//accesscontroler.checkAccess(request, response);
	String action = request.getParameter("action");
	String openwindid = request.getParameter("openwindid");//窗口ID
	Formservice Formservice = new FormserviceImpl();
	boolean flag = false;
	 if("save".equals(action)){//保存表单配置信息
		String paramJson = request.getParameter("paramJson");//属性
		flag = Formservice.saveFormConfig(paramJson);
		
	}else if("update".equals(action)){//保存表单配置信息
		String paramJson = request.getParameter("paramJson");//属性
		flag = Formservice.updateFormConfig(paramJson);
	}
%>
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
		  if(removeWindows('<%=openwindid%>',true,false,true)){
	    		window.parent.location.reload();
	    	}
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
window.parent.backparent();
//window.parent.JqueryDialog.SubmitCompleted(mes, true, bool);
</script>
</body>