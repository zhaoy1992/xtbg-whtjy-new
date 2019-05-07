<%-- 
描述：通知公告处理页面
作者：黄艺平
版本：1.0
日期：2013-09-19
 --%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@page import="com.chinacreator.xtbg.core.notice.entity.NoticeBaseInfoBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@page import="com.chinacreator.xtbg.core.notice.service.NoticeHandleServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.notice.service.impl.NoticeHandleServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.notice.entity.NoticeMsgBean"%><html>
<head>
<title>通知公告处理页面</title>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
boolean flag = false;
String subid=request.getParameter("subid");
String action = request.getParameter("action");
String del_n_notice_ids = "";
String calcel_n_notice_ids = "";
String n_receiverids = "";
NoticeBaseInfoBean noticeBaseInfoBean = new NoticeBaseInfoBean();
NoticeMsgBean noticMsgBean = new NoticeMsgBean();
NoticeHandleServiceIfc noticeHandleServiceIfc = new NoticeHandleServiceImpl();
if("dotempNotice".equals(action) || "dotempRelease".equals(action)) {
	noticeBaseInfoBean = (NoticeBaseInfoBean)RequestBeanUtils.getValuesByRequest(request,noticeBaseInfoBean);//获取表单提交过来的数据
	flag = noticeHandleServiceIfc.handleNotice(noticeBaseInfoBean, noticMsgBean);
} else if("delNotice".equals(action)) {
	del_n_notice_ids = request.getParameter("del_n_notice_ids");
	flag = noticeHandleServiceIfc.deleteNotice(del_n_notice_ids);
} else if("cacelRelease".equals(action)) {
	calcel_n_notice_ids = request.getParameter("calcel_n_notice_ids");
	flag = noticeHandleServiceIfc.cacelRelease(calcel_n_notice_ids);
} else if("deleteNoticeReceiver".equals(action)) {
	n_receiverids = request.getParameter("n_receiverids");
	flag = noticeHandleServiceIfc.deleteNoticeReceiverUser(n_receiverids);
}
	String tablepage = request.getParameter("tablepage");
	String tpage ="#tabs-1";
	if("2".equals(tablepage)){
		tpage = "#tabs-2";
	}	
%>
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript">
var mes = "";
var bool = true;
var action = "<%=action%>";
if(<%=flag%>){
	mes = "操作成功"; 
	bool = false;
	var submitAlertOK = function(){
		if(action == "delete"){
			window.parent.location.reload();
		}
	 	if("2"=='<%=tablepage%>'){
	 		if('<%=subid%>' == "main_todowork1"){
	 			removeWindows('<%=subid%>',true,false,true);
	 			window.parent.location.reload();
			}else{
				removeWindows('<%=subid%>'+111,true,false,true);
	     		window.parent.parent.$("#tabs").tabs('select', '<%=tpage%>');
	     	}
	 	} else {
	 	  if(removeWindows('<%=subid%>',true,false,true)){
	 		window.parent.location.reload();
	 	  }
	 	}
	}
	var p={
			headerText:'操作信息',
			okName:'确认',
	        okFunction:submitAlertOK
	};
	alert('操作成功!',p);
	window.top.getIFrameDOM("_document_body_mian_firstPagerAAAS").location.reload();
}else{
	mes = "操作失败";
	bool = false;
}
</script>
</head>
<body>
</body> 
</html>