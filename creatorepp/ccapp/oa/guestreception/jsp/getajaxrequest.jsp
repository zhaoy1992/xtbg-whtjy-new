
<%@page import="com.chinacreator.xtbg.core.guestreception.entity.GuestReceiveBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.tree.entity.ResourceRoleUserBean"%>
<%@page import="com.chinacreator.xtbg.core.guestreception.entity.GuestreceptionBean"%>
<%@page import="com.chinacreator.xtbg.core.common.tree.dao.impl.ResouceConfigDaoImpl"%>
<%@page import="com.chinacreator.xtbg.core.guestreception.dao.impl.GuestreceptionDaoImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.tree.dao.ResourceConfigDao"%>
<%@page import="com.chinacreator.xtbg.core.guestreception.dao.GuestreceptionDao"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.apache.ecs.xhtml.strike"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.alibaba.fastjson.JSONObject"%><%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String user_ids = request.getParameter("user_ids");
	//System.out.println(user_ids);
	if(!StringUtil.isBlank(user_ids)){
	GuestreceptionDao guestreceptionDao=new GuestreceptionDaoImpl();
	ResourceConfigDao resourceRoleConfigDao=new ResouceConfigDaoImpl();
	List<GuestReceiveBean> list =new ArrayList<GuestReceiveBean>(); 
	String jsonStr = "";
	String user_idArray[]=user_ids.split(",");
	Set<String> userSet =new HashSet<String>();
	for(int i=0;i<user_idArray.length;i++){
		userSet.add(user_idArray[i]);
	}
	Iterator<String> it= userSet.iterator();
	user_ids="";
	for (String id : userSet) {
	    user_ids+=id;
	    if(it.hasNext()){
	    	user_ids+=",";
	    }
	}
	user_ids=user_ids.substring(0, user_ids.length()-1);
	list=guestreceptionDao.queryUserBaseInfo(user_ids);
	//String usersexn[]=usersex.split(",");
	//String userIdn[]=user_ids.split(",");
	//String orgname=guestreceptionDao.queryOrg(user_ids);
	List<String> orgList=new ArrayList<String>();
	for(int i=0;i<list.size();i++){
		ResourceRoleUserBean rBean=new ResourceRoleUserBean();
		rBean=resourceRoleConfigDao.queryUserMatchOrg(list.get(i).getPtuserid());
		orgList.add(rBean.getOrgname());
	}

	//String orgnamen[]=orgname.split(",");
	for(int i = 0 ; !StringUtil.nullOrBlank(user_ids) && i < list.size(); i++ ){
		
		jsonStr += "{'id':'"+list.get(i).getPtuserid()+"','name':'"+list.get(i).getPtusername()+"','sex':'"+list.get(i).getPtsex()+"','orgname':'"+orgList.get(i)+"','post':''},";
	}
	if(jsonStr.length() > 0){
		jsonStr = jsonStr.substring(0,jsonStr.length()-1);
		jsonStr = "["+jsonStr+"]";
		out.print(JSONObject.parseArray(jsonStr));
	}else{
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("value","null");
		out.print(jsonObj);
	}
	
	}else{
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("value","null");
		out.print(jsonObj);
	}
	//response.getWriter().write("name:'0',value:'1'");
%>
