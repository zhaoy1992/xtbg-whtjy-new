<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.core.process.fgw_flowprocessing.dao.impl.FlowDataContenDaoImpl"%>
<%@page import="com.chinacreator.xtbg.core.process.fgw_flowprocessing.dao.FlowDataContenDao"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
String mFilePath = request.getSession().getServletContext().getRealPath(""); 
    String id = request.getParameter("id");
    /*********读取正文内容************/
    FlowDataContenDao flowdatacontendao = new FlowDataContenDaoImpl();
    String textId = DaoUtil.sqlToField("select t.bodys from ta_oa_w_fileinfo t where t.id='"+id+"'");
    
    if(!StringUtil.isBlank(textId)){
    	int index = textId.indexOf("|");
    	textId = textId.substring(0,index);
        boolean result = flowdatacontendao.showWord(textId,mFilePath);
        
    	JSONObject jsonObj = new JSONObject();
    	jsonObj.put("result",result);
    	jsonObj.put("textId",textId);
    	out.print(jsonObj);	
    }
%>

