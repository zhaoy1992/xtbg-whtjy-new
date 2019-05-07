<%@page import="com.chinacreator.xtbg.pub.sms.service.SmsProxy"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.chinacreator.xtbg.pub.util.DbconnManager"%>
<%@page import="com.chinacreator.xtbg.pub.util.BeanUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.DateUtil"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
 <title>
 </title>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String username = accesscontroler.getUserName();
	String path = request.getContextPath();
	String isType = request.getParameter("isType"); //短信
	String isnow = request.getParameter("isnow"); //即时消息
	String message_info = request.getParameter("message_info"); //内容
	String boorow_user_id = request.getParameter("boorow_user_id");//接收短信用户 ID 
	String boorow_user_name = request.getParameter("boorow_user_name");
	String phone_number = request.getParameter("phone_number");
	
	boolean flag = false;
	if("y".equals(isType)){
		Connection con = DbconnManager.getInstance().getTransactionConnection();
		try {
			Map<String, String> map = new HashMap<String, String>();
			map.put("conferenceNotice", "conferenceNotice");
			map.put("phone_number", phone_number);
			map.put("boorow_user_name", boorow_user_name);
			map.put("boorow_user_id", boorow_user_id);
			map.put("isSend", isType);
			map.put("content", message_info);
			map.put("accepter", username); //发送人
			SmsProxy.doSendMesg(map, con);
			con.commit();
			flag = true;
		} catch (Exception e) {
			con.rollback();
		}finally{
			con.close();
		}
	}if("y".equals(isnow)){
		System.out.print("__________________________即时消息："+message_info+"("+username+" 发送)");
		flag = true;
	}
%>
<script type="text/javascript">
var mes = "<%=flag%>";
var bool = true;
if(mes == "true"){
	mes ="操作成功";
}else{
	mes ="操作失败"
	bool = false;
}
var ok=function(){
	window.parent.parent.location.href="<%=path%>/ccapp/xtbg/caizhengting/ibrary/jsp/ibrarybookrindex.jsp";
}
if(window.top.removeAlertWindows('',false,bool,mes,true)){
	if(bool){
		window.top.alert(mes,{headerText:'处理结果',okName:'确认',okFunction:ok})
	}
	else{
		window.top.alert(mes)
	}
}
</script>
<body>
</body> 
</html>
