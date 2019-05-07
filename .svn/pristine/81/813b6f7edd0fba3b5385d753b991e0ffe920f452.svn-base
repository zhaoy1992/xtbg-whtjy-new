<%@page import="com.chinacreator.xtbg.core.common.fancyuoload.servlet.AttachmentConfigBean"%>
<%@page contentType="text/html;charset=utf-8" language="java"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.upload.util.*"%>
<%@page import="com.chinacreator.xtbg.core.upload.dao.UploadDao"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DbManager"%>
<%@page import="com.chinacreator.xtbg.core.kbm.dao.KbmDocReceiveDao"%>
<%@page import="com.chinacreator.xtbg.core.kbm.dao.impl.KbmDocReceiveDaoImpl"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.File"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String k_doc_id = StringUtil.deNull(request.getParameter("k_doc_id"));
	Connection conn = null;
	boolean flag = false;
	JSONObject json = new JSONObject();
	KbmDocReceiveDao dao = new KbmDocReceiveDaoImpl();
	try {
		conn = DbManager.getInstance().getConnection();
		dao.deleteNotice(k_doc_id,conn);
		json.put("info","删除更新通知成功！");
		flag=true;
		
	} catch (Exception e) {
		json.put("info","删除更新通知失败！");
	    DbManager. rollBackNoThrow(conn);
	} finally {
		if(conn!=null){
	        DbManager. closeConnection(conn);
	    } 
	}	
	json.put("flag",flag);
	out.print(json);
%>
