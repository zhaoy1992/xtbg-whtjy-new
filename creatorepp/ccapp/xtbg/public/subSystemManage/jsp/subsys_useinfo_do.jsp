<%--
�������ⲿ��ϵͳ������Ϣ���˵Ľ���ҳ��
���ߣ�����
�汾��1.0
���ڣ�2013-4-28
--%>


<%@ page contentType="text/html; charset=GBK"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">



<%@page import="com.chinacreator.security.AccessControl"%>

<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.pub.util.RequestBeanUtils"%>


<%@page import="com.chinacreator.xtbg.pub.subSystemManage.service.impl.SubSystemServiceImpl"%>
<%@page import="com.chinacreator.xtbg.pub.subSystemManage.service.SubSystemServiceIfc"%>
<%@page import="com.chinacreator.xtbg.pub.subSystemManage.entity.SubsysManageBean"%>
<%@page import="com.chinacreator.xtbg.pub.subSystemManage.entity.SubsysUseInfoBean"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%><html>
<head>
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<title>�ⲿ��ϵͳ������Ϣ���˵Ľ���ҳ��</title>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	SubsysUseInfoBean subsysUseInfoBean = new SubsysUseInfoBean();
	subsysUseInfoBean = (SubsysUseInfoBean)RequestBeanUtils.getValuesByRequest(request,subsysUseInfoBean);
	String info_id = subsysUseInfoBean.getInfo_id();
	
	
	String action = request.getParameter("action_now");
	SubSystemServiceIfc subSystemServiceIfc = new SubSystemServiceImpl();
	Map<String,Object> resultMap = new HashMap<String,Object>();
	boolean flag = false;
	String flag1 ="����ʧ��";

	if("save".equals(action)) {
		resultMap = subSystemServiceIfc.saveSubSystemUseInfo(subsysUseInfoBean);
		flag = (Boolean)resultMap.get("isSucess");
		flag1 = (String)resultMap.get("resultStr");
	}  else if("del".equals(action)) {
		flag = subSystemServiceIfc.deleteSubSystemUseInfo(info_id);
	}
	

%>
<script type="text/javascript">
var mes = "";
var bool = true;

if(<%=flag%>){
	mes = "�����ɹ�";
	bool = false;
	var submitAlertOK = function(){
		var obj = {action:'<%=action%>'}
		parent.sucessBackFun(obj);
	}
	var p={
			headerText:'������Ϣ',
			okName:'ȷ��',
	        okFunction:submitAlertOK
	};
	alert("�����ɹ���",p);
	
}else {
	mes = "<%=flag1%>";
	bool = false;
	alert("<%=flag1%>",p);
}


//window.parent.JqueryDialog.SubmitCompleted(mes, true, bool);
</script>
</head>
<body>
</body> 
</html>