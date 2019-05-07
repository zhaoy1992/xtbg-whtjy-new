<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.tjy.canteenitemssupplies.service.impl.OsHavaObjectServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.canteenitemssupplies.service.OsHavaObjectService"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String mFilePath = request.getSession().getServletContext().getRealPath(""); 
	//设备ID
    String t_ha_id = request.getParameter("t_ha_id");
    /*********查询设备ID************/
    OsHavaObjectService osHavaObjectService = new OsHavaObjectServiceImpl();
    JSONObject jsonObj = new JSONObject();
    List<Map<String, String>> osHavaList = osHavaObjectService.queryHavaObjectByHaId(t_ha_id);
    Map<String, String> osHavaMap = new HashMap<String,String>();
    if(osHavaList.size()!=0){
    		osHavaMap = osHavaList.get(0);
    } 
    //判断是否是领用状态
    if(StringUtil.deNull(osHavaMap.get("t_ha_sbstate")).equals("2")){
    	jsonObj.put("result",true);
    } else {
    	jsonObj.put("result",false);
    }
    response.getWriter().print(jsonObj);	
%>

