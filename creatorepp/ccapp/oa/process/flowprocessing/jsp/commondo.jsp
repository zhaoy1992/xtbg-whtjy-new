<%@page import="java.util.HashMap"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.impl.OvercommonServiceImpl"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.chinacreator.xtbg.core.archive.service.ArchiveService"%>
<%@ page import="com.chinacreator.xtbg.core.archive.service.impl.ArchiveServiceImpl"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.archive.dao.CircularizeDao"%>
<%@page import="com.chinacreator.xtbg.core.archive.dao.impl.CircularizeDaoImpl"%>
<%
	String path = request.getContextPath();
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	String operationType = request.getParameter("operationType");
	String windowsId = request.getParameter("windowsId");
	String insname_rule = request.getParameter("insname_rule");
	String busitype_code = request.getParameter("busiTypeCode");
	String circularize_id = request.getParameter("circularize_id");
	//String indexReturn = request.getParameter("indexReturn");
	String msg = "";
	boolean flag = true;
	Map<String,Object> returnMap  = new HashMap<String,Object>();
	if("overcommondo".equals(operationType)){//湖北特检院传阅能够填写意见
		//传阅的处理
		ArchiveService oFlowServlet = new OvercommonServiceImpl();
		CircularizeDao dao = new CircularizeDaoImpl();
		flag = dao.updateDone(circularize_id);
		returnMap  = oFlowServlet.handler(request, response);
	}else{
		ArchiveService flowServlet = new ArchiveServiceImpl();
		 returnMap  = flowServlet.handler(request, response);
	}
	if(returnMap!=null){
		flag = (Boolean)returnMap.get("flag") && flag;
		msg = (String)returnMap.get("erroMsg");
		if(!StringUtil.isBlank(msg)){
			msg = msg.trim();
		}

	}
	
%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title></title>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript">
	if(<%=(!flag)%>){
		alert('操作失败！<%=msg%>');
		parent.resetSubmit();
	}else{
		if(typeof(parent.afterActionSuccessFn)=='function'){
			try{
				parent.afterActionSuccessFn('<%=operationType%>');
			}catch(e){alert("Fn[name='afterActionSuccessFn'] error");}
		}else if("<%=operationType%>"=="dotemp"){//如果是暂存，那么跳转到暂存列表
			if(typeof(parent.resetSubmit)=='function'
				&&typeof(parent.resetOptType)=='function'){
				alert("操作成功");
				parent.resetSubmit();
				parent.resetOptType("update");
			}else{
				removeAlertWindows("newwindows", false, true, "操作成功", true, "<%=path%>/ccapp/oa/process/flowprocessing/jsp/mainwork.jsp?indexReturn=2",false);
			}
		}else{
			if("XXFBSP" == "<%=busitype_code%>"){
				removeAlertWindows("<%=windowsId%>", false, true, "操作成功", true, "<%=path%>/ccapp/xtbg/tjy/processing/mainhandlist.jsp",false);
			}else{
				removeAlertWindows("<%=windowsId%>", false, true, "操作成功", true, "<%=path%>/ccapp/oa/process/flowprocessing/jsp/mainwork.jsp",false);
			}
		}
	}
</script>
</head>
<body>

</body>

</html>