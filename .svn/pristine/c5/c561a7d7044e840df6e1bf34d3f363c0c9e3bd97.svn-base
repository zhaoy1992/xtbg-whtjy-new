<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="java.util.*"%>
<%@page import=" com.chinacreator.xtbg.yimingju.mail.service.impl.MailServiceImpl"%>
<%@page import=" com.chinacreator.xtbg.yimingju.mail.service.MailServiceIfc"%>
<%@page import=" com.chinacreator.xtbg.yimingju.mail.entity.MailBean"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%@page import="com.chinacreator.business.common.tools.CacheCommonManageProxy"%>
<%@ page contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String userId=accesscontroler.getUserID();	
	String isFromHome = StringUtil.deNull(request.getParameter("isFromHome"));	//如果从首页进来的，保存时需要存一个特殊的标志,1表示从首页进来的
	String title=request.getParameter("title");
	String receivepname=request.getParameter("participants_name");
	String receivepid=request.getParameter("participants_id");
	String attachment_id=request.getParameter("attachment_id");
	String content=request.getParameter("content");
	String sendpid=request.getParameter("sendpid");
	String sendpname=request.getParameter("sendpname");
	String deptid=request.getParameter("deptid");
	String dxtzjsr=request.getParameter("dxtzjsr");
	String deptname=request.getParameter("deptname");
	String state=request.getParameter("state");
	String mid=request.getParameter("mid");
	String isType= request.getParameter("isType");
	String message_info = request.getParameter("message_info");
	if(!"y".equalsIgnoreCase(isType)){
		isType= "n";
	}
	MailBean mb = new MailBean();
	mb.setTitle(title);
	mb.setReceivepname(receivepname);
	mb.setReceivepid(receivepid);
	mb.setAttachment_id(attachment_id);
	mb.setContent(content);
	mb.setSendpid(sendpid);
	mb.setSendpname(sendpname);
	mb.setDeptid(deptid);
	mb.setDxtzjsr(dxtzjsr);
	mb.setDeptname(deptname);
	mb.setState(state);
	mb.setMid(mid);
	mb.setMessage_info(message_info);
	mb.setIsType(isType);
	String action=request.getParameter("action");
	String mids=request.getParameter("mids");
	String viewdel=request.getParameter("viewdel");
	String paramjosn=request.getParameter("paramjosn");
	String deltype=request.getParameter("deltype");
	boolean flag = false;
	boolean replevyFlag =true;//追回功能
	MailServiceIfc service = new MailServiceImpl();
	if("save".equals(action)) {  // 添加
		flag = service.saveMailInfo(mb);
	}else if("update".equals(action)){
		flag = service.updateMailInfo(mb);
	}else if("del".equals(action)){
		if("qbdelete".equals(deltype)){
			flag = service.deleteMailInfo1(mids);
		}else if("yjdelete".equals(deltype)){
			flag = service.deleteyjMailInfo(mids);
		}else{
			flag = service.deleteMailInfo(userId,mids);
		}
		
	} else if("replevy".equals(action)){//追回邮件
		String con_id = DaoUtil.SqlToField("select count(*) from ymj_oa_jbxx_mail a, ymj_oa_user_mail b where a.mid = b.mid and a.sendpid='"+userId+"' and b.readstate = '1' and a.mid in("+mids+")");
		if (Integer.valueOf(con_id) > 0){
			flag = false;
		} else {
			replevyFlag = service.replevyMail(userId,mids);	
			//追回功能
			if(replevyFlag == false ){
				flag = false ;
			} else {
				flag = true ;
			}
		}
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>邮件信息保存from</title>
</head>
<body>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<script type="text/javascript">
var mes = "";
var action = '<%=action%>';
var viewdel = '<%=viewdel%>';
var flag = <%=flag%>;
var replevyFlag = <%=replevyFlag%>;
var bool = true;
if(flag){
	mes = "操作成功";
}else{
	mes = "操作失败"	;
	if(action=="replevy"){
		<%if(CacheCommonManageProxy.getBooleanSystemParam("mailName")){%>
			mes = "文件已阅读不能被追回！";
		<%}else {%>
			mes = "邮件已阅读不能被追回！";
		<%}%>
		
		if(replevyFlag ==false){
			mes = "操作失败"	;
		}
	}
	
	bool = false;
}

var OKF = function(){
	if(window.top.removeWindows('',true)){
		if((action == "replevy" || action == "del") && viewdel != "viewdel"){
			window.parent.location.reload();
		} else if("<%=isFromHome%>" == "1"){
			//window.parent.parent.jQuery("#tabs").tabs({ selected: 2 });
			//window.parent.saveBack();
			window.parent.location.href = "mailTabs.jsp?select=3";
		} else if(action=="update"){
			window.parent.parent.jQuery("#tabs").tabs("select","3");
		}else{
			window.parent.parent.jQuery("#tabs").tabs({ selected: 0 });
		}
	}
}
window.top.alert(mes,{headerText:'提示',okName:'确认',okFunction:OKF});
</script>
</body>
</html>