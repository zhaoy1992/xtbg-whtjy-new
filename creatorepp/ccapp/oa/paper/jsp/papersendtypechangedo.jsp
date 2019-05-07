<%--
描述：信息发布处理
作者：黄海
版本：1.0
日期：2013-09-28
--%>
<%@page import="java.util.HashMap"%>
<%@page import="com.chinacreator.xtbg.core.paper.service.PaperService"%>
<%@page import="com.chinacreator.xtbg.core.paper.service.impl.PaperServiceImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.regex.Matcher"%>
<%@ page import="com.alibaba.fastjson.JSONObject" %>

<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	
	String responseCode="";//1:回调js
	JSONObject responseObj = new JSONObject();
	String responseObj_SUCCESS="操作成功";
	String responseObj_FIAL="操作失败";
	PaperService service = new PaperServiceImpl();
	String sendType = StringUtil.deNull(request.getParameter("sendType"));
	boolean flag = false;
	String action = request.getParameter("action");
	if("SaveReceiveInfo".equals(action)){
		responseCode = "1";
		HashMap<String, String> map = new HashMap<String, String>();
  		map.put("sendType", sendType);
  		map.put("p_paper_unit", StringUtil.deNull(request.getParameter("p_paper_unit")));
  		map.put("p_paper_unitid", StringUtil.deNull(request.getParameter("p_paper_unitid")));
  		map.put("p_paper_user", StringUtil.deNull(request.getParameter("p_paper_user")));
  		map.put("p_paper_userid", StringUtil.deNull(request.getParameter("p_paper_userid")));
  		map.put("p_manage_ids", StringUtil.deNull(request.getParameter("p_manage_ids")));
  		
		flag = service.savePaperReceiveInfo(map);
		if(flag){
			responseObj.put("info",responseObj_SUCCESS);
		}else{
			responseObj.put("info",responseObj_FIAL);
		}
		responseObj.put("flag",flag);
	}else if("SendAdd".equals(action)){
		responseCode = "1";
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("p_paper_unitid", StringUtil.deNull(request.getParameter("m_receiver_unit_ids")));
  		map.put("p_paper_unit", StringUtil.deNull(request.getParameter("m_receiver_unit_names")));
  		map.put("p_paper_userid", StringUtil.deNull(request.getParameter("m_receiver_user_ids")));
  		map.put("p_paper_user", StringUtil.deNull(request.getParameter("m_receiver_user_names")));
  		map.put("m_msg_type", StringUtil.deNull(request.getParameter("m_msg_type")));
  		map.put("m_msg_contents", StringUtil.deNull(request.getParameter("m_msg_contents")));
  		map.put("p_manage_ids", StringUtil.deNull(request.getParameter("p_manage_ids")));
  		
		flag = service.savePaperSendAdd(map);
		if(flag){
			responseObj.put("info",responseObj_SUCCESS);
		}else{
			responseObj.put("info",responseObj_FIAL);
		}
		responseObj.put("flag",flag);
	}
	
	//2:响应页面
	if("1".equals(responseCode)){
		if(responseObj!=null){
	%>
			<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
				<head></head>
				<body>
				<script>
					try{
						var result='<%=responseObj.toString()%>';
						eval("parent.afterSubmitFn('"+result+"');");
					}catch(e){alert(e.description);}
				</script>
				</body>
			</html>
	<%
		}
	}
	%>