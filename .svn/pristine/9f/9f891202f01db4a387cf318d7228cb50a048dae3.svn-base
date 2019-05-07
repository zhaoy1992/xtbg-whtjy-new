
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.imploracle.PurchaseApprovalRoolDaoImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.imploracle.PurchaseApplyDaoImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.PurchaseApprovalRoolDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="com.chinacreator.xtbg.fagaiwei.fixedAssets.entity.FixedAssetsInfoBean"%>
<%@page import="com.alibaba.fastjson.JSONArray"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.fagaiwei.fixedAssets.service.impl.FixedAssetServiceImpl"%>
<%@page import="com.chinacreator.xtbg.fagaiwei.fixedAssets.service.FixedAssetServiceIfc"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.fagaiwei.fixedAssets.dao.FixedAssetDao"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.alibaba.fastjson.JSONObject"%><%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String goodsids = request.getParameter("goodsids");
	String[] goodsidArray=goodsids.split(",");
	Set<String> set=new HashSet<String>();
	for(int i=0;i<goodsidArray.length;i++){
		set.add(goodsidArray[i]);
	}
	String[] idtype=set.toArray(new String[0]);
	Map<String,String> map=new HashMap<String,String>();
	for(int j=0;j<idtype.length;j++){
		int m=0;
		for(int k=0;k<goodsidArray.length;k++){
			if(idtype[j].equals(goodsidArray[k])){
				m++;
			}
		}
		map.put(idtype[j], String.valueOf(m));
	}
	PurchaseApprovalRoolDao purchaseApprovalRoolDao=new PurchaseApprovalRoolDaoImpl();
	List<String> list=new ArrayList<String>();
	for (String key : map.keySet()) {
		list.add(purchaseApprovalRoolDao.querykc(key, map.get(key))); 
	}
	String str="";
	for(int i=0;i<list.size();i++){
		str+=list.get(i)+",";
	}
	str=str.substring(0, str.length()-1);
	response.getWriter().print(str); 
%>
