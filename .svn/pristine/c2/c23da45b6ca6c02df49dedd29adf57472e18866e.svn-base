<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@page import="com.chinacreator.xtbg.core.archive.entity.DocumentComideaBean"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.impl.ComideaServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.ComideaService"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.chinacreator.xtbg.core.common.util.ResultMap"%>
<%@page import="com.chinacreator.xtbg.core.common.util.AResultCode"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.chinacreator.xtbg.core.process.flowprocessing.dao.impl.FlowViewDaoImpl"%>
<%@page import="com.chinacreator.xtbg.core.dssave.entity.ViewListBean"%>

<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	/* String userid = request.getParameter("userid");
	String signTxt = request.getParameter("signTxt"); */
	DocumentComideaBean bean=new DocumentComideaBean();
	RequestBeanUtils.getValuesByRequest(request, bean);//获取表单提交过来的数据
	String type = request.getParameter("type");
	ComideaService service=new ComideaServiceImpl();
	/* bean.setIdea_content(signTxt);
	bean.setUser_id(userid); */
	boolean result=false;
	if("save".equals(type)){
		result=service.saveComidea(bean);
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result",result);
		out.print(jsonObj);
	}else if("del".equals(type)){
		String user_id = accesscontroler.getUserID();
		String common_idea = request.getParameter("common_idea");
		result=service.delComidea(common_idea,user_id);
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result",result);
		out.print(jsonObj);
	}else if("list".equals(type)){
		List<DocumentComideaBean> list = new ArrayList<DocumentComideaBean>();
		list = service.getList(accesscontroler.getUserID());
		ResultMap<AResultCode,List<DocumentComideaBean>>  map = new ResultMap<AResultCode,List<DocumentComideaBean>>();
		map.setResult(list);
		map.setCode(AResultCode.OK);
		out.print(JSON.toJSONString(map,true));
	}else if("yiqian".equals(type)){
		FlowViewDaoImpl dao = new FlowViewDaoImpl();
		List<ViewListBean> list = dao.getViewListForShow(request);
		ResultMap<AResultCode,List<ViewListBean>>  map = new ResultMap<AResultCode,List<ViewListBean>>();
		map.setResult(list);
		map.setCode(AResultCode.OK);
		out.print(JSON.toJSONString(map,true));
	}
	

%>
