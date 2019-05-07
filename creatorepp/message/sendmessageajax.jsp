<%@ page pageEncoding="GBK" import="com.chinacreator.message.MessageFactory
				,com.chinacreator.message.Message
				,com.chinacreator.security.AccessControl
				,com.chinacreator.message.util.*
				,java.util.*
				" %>
<%

	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request,response);

	String from = accesscontroler.getUserAccount();
	String rtxsender = accesscontroler.getUserName() + "(" + accesscontroler.getUserAccount() + ")";// 用户真实姓名
	String title = request.getParameter("title");
	String receivers = request.getParameter("receiver_name");
	String content = request.getParameter("content");
	String sms = request.getParameter("sms");
	String rtx = request.getParameter("rtx");
	String sendType = request.getParameter("sendType");
	
	int smsFlag = -1;
	int rtxFlag = -1;
	String returnVal = "";

	Map paraMap = new HashMap();
	paraMap.put("title",title);
	Map valMap = null;
	Message message = MessageFactory.getMessageInstance();
	try{
		valMap = message.sendMessage(from, receivers,content,sendType,paraMap);
	}catch (Exception e){
		e.printStackTrace();
		return;
	}
	
	if (sendType.indexOf("sms")!=-1) {
		int smsVal = Integer.parseInt(valMap.get("sms")+"");

		if (smsVal == Integer.parseInt(MsgConfig.getProperties("SMS_SEND_SUCCESS"))) {
			// 插入数据库成功
			returnVal = "sms:0";
		} else if (smsVal == Integer.parseInt(MsgConfig.getProperties("SMS_MOBILE_NULL"))) {
			// 号码为空
			returnVal = "sms:1";
		} else if (smsVal == Integer.parseInt(MsgConfig.getProperties("SMS_CONTENT_NULL"))) {
			// 发送内容为空
			returnVal = "sms:2";
		} else if (smsVal == Integer.parseInt(MsgConfig.getProperties("SMS_CONTENT_TOLONG"))) {
			// 发送内容查出限制
			returnVal = "sms:3";
		} else {
			// 发送失败
			returnVal = "sms:4";
		}
	}

	if (sendType.indexOf("rtx")!=-1) {
	int smsVal = Integer.parseInt(valMap.get("rtx")+"");
	
		if (smsVal == Integer.parseInt(MsgConfig.getProperties("RTX_SEND_SUCCESS"))) {
			// 发送成功
			returnVal += "rtx:0";
		} else if (smsVal == Integer.parseInt(MsgConfig.getProperties("RTX_TITLE_NULL"))) {
			returnVal += "rtx:1";
		} else if (smsVal == Integer.parseInt(MsgConfig.getProperties("RTX_TITLE_TOLONG"))) {
			returnVal += "rtx:2";
		} else if (smsVal ==Integer.parseInt(MsgConfig.getProperties("RTX_CONTENT_NULL"))) {
			returnVal += "rtx:3";
		} else if (smsVal ==Integer.parseInt(MsgConfig.getProperties("RTX_CONTENT_TOLONG"))) {
			returnVal += "rtx:4";
		} else {
			// 发送失败
			returnVal += "rtx:5";
		}
	}
	
	if (sendType.indexOf("sys")!=-1) {
	int smsVal = Integer.parseInt(valMap.get("sys")+"");
	
		if (smsVal == Integer.parseInt(MsgConfig.getProperties("SYS_SEND_SUCCESS"))) {
			// 发送成功
			returnVal += "sys:0";
		} else if (smsVal == Integer.parseInt(MsgConfig.getProperties("SYS_TITLE_NULL"))) {
			returnVal += "sys:1";
		} else if (smsVal == Integer.parseInt(MsgConfig.getProperties("SYS_TITLE_TOLONG"))) {
			returnVal += "sys:2";
		} else if (smsVal ==Integer.parseInt(MsgConfig.getProperties("SYS_CONTENT_NULL"))) {
			returnVal += "sys:3";
		} else if (smsVal ==Integer.parseInt(MsgConfig.getProperties("SYS_CONTENT_TOLONG"))) {
			returnVal += "sys:4";
		} else {
			// 发送失败
			returnVal += "sys:5";
		}
	}
	// 返回客户端
	out.print(returnVal);

%>