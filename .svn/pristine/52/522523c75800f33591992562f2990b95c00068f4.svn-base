<%@page import="com.chinacreator.xtbg.waitDoWork.dao.imploracle.FirstPageDaoImpl"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.workbench.entity.ShowItemDetailDataBean" %>
<%@page import="com.chinacreator.xtbg.core.workbench.entity.ItemValueBean" %>
<%@page import="com.alibaba.fastjson.JSONObject" %>
<%@page import="com.chinacreator.xtbg.core.workbench.entity.ShowItemDataBean" %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String userid = request.getParameter("user_id");
    String path = request.getContextPath();;//系统上下文目录
    
	FirstPageDaoImpl firstPageDaoImpl = new FirstPageDaoImpl();
	List<Map<String, String>> resList = firstPageDaoImpl.queryIfm_NoticUserData(userid,4);//查询结果最多4行的数据
	ShowItemDataBean showItemDataBean = new ShowItemDataBean();
	showItemDataBean.setItemID("");
	showItemDataBean.setShowMaxRowNum(4);
	String[] showColumns = new String[]{"n_title"}; //显示列
	String[] realShowColumns = new String[]{"n_title"};//真实显示列
	String[] urlParamColumns = new String[]{"n_notice_id"};
	for(Map<String, String> dateMap : resList){
		ShowItemDetailDataBean showItemDetailDataBean = new ShowItemDetailDataBean();
		
		String clickUrl = path+"/ccapp/oa/notice/jsp/noticespecialtypeview.jsp?isview=view&subid=hostNotic&urls=jsy";
		if(clickUrl.indexOf("?") == -1) {
			clickUrl = clickUrl+"?1=1";
		}
		
		for(int i=0;i<showColumns.length;i++){
			ItemValueBean bean = new ItemValueBean();
			bean.setValue(dateMap.get(showColumns[i]));//真实值
			bean.setShowValue(dateMap.get(realShowColumns[i]));//显示值
			showItemDetailDataBean.setValue(bean);
		}
		
		for(String column : urlParamColumns){
			String param = "&"+column+"="+dateMap.get(column);
			clickUrl += param;
		}
		showItemDetailDataBean.setClickUrl(clickUrl);
		showItemDataBean.setShowItemDetailDataBean(showItemDetailDataBean);
	}
	out.println(JSONObject.toJSON(showItemDataBean).toString());
%>
