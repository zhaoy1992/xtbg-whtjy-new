
<%@page import="com.chinacreator.xtbg.core.guestreception.entity.GuestReceiveBean"%>
<%@page import="com.chinacreator.xtbg.core.common.tree.entity.ResourceRoleUserBean"%>
<%@page import="com.chinacreator.xtbg.core.guestreception.entity.GuestreceptionBean"%>
<%@page import="com.chinacreator.xtbg.core.common.tree.dao.impl.ResouceConfigDaoImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.tree.dao.ResourceConfigDao"%>
<%@page import="com.chinacreator.xtbg.core.guestreception.dao.impl.GuestreceptionDaoImpl"%>
<%@page import="com.chinacreator.xtbg.core.guestreception.dao.GuestreceptionDao"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.alibaba.fastjson.JSONObject"%><%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String user_ids = request.getParameter("user_ids");
	//System.out.println(user_ids);
	GuestreceptionDao guestreceptionDao=new GuestreceptionDaoImpl();
	//String usersex=guestreceptionDao.queryUserSex(user_ids);
	ResourceConfigDao resourceRoleConfigDao=new ResouceConfigDaoImpl();
	List<GuestReceiveBean> list =new ArrayList<GuestReceiveBean>();
	list=guestreceptionDao.queryUserBaseInfo(user_ids);
	String orgname="";
	String usersex="";
	for(int i=0;i<list.size();i++){
		ResourceRoleUserBean rBean=new ResourceRoleUserBean();
		rBean =resourceRoleConfigDao.queryUserMatchOrg(list.get(i).getPtuserid());
		orgname= rBean.getOrgname();
		usersex= list.get(i).getPtsex();
	}
	
	String jsonStr="{'usersex':'"+ usersex +"','orgname':'"+orgname+"'}";
	//System.out.print(jsonStr);
	JSONObject jsonObj = new JSONObject();
	jsonObj=JSONObject.parseObject(jsonStr);
	out.print(jsonObj);
	
	
%>
