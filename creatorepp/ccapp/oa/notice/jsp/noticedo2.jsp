<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.commonlist.PagingBean"%>
<%@page import="com.chinacreator.xtbg.core.notice.list.NoticeViewList"%>
<%@page import="com.chinacreator.xtbg.core.common.util.ResultMap"%>
<%@page import="com.chinacreator.xtbg.core.common.util.AResultCode"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.chinacreator.xtbg.core.notice.service.NoticeHandleServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.notice.service.impl.NoticeHandleServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.fancyuoload.dao.FiletransfersSysDao"%>
<%@page import="com.chinacreator.xtbg.core.common.fancyuoload.dao.impl.FiletransfersSysDaoImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.fancyuoload.entity.FileInfoBean"%>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
UserCacheBean u = UserCache.getUserCacheBean(accesscontroler.getUserID());	//获取用户缓存对象

String method = request.getParameter("method");

NoticeHandleServiceIfc service = new NoticeHandleServiceImpl();

if(method.equals("list")){//得列表
	String parmjson = request.getParameter("parmjson");
	String sortName = request.getParameter("sortName");
	String sortOrder = request.getParameter("sortOrder");
	long offset = Long.parseLong(request.getParameter("offset"));
	int maxPagesize = Integer.parseInt(request.getParameter("maxPagesize"));
	PagingBean pb = new PagingBean();
	NoticeViewList list = new NoticeViewList();
	pb = list.getDataList(parmjson,sortName,sortOrder,offset,maxPagesize);
	ResultMap<AResultCode,PagingBean> result = new ResultMap<AResultCode,PagingBean>();
	result.setCode(AResultCode.OK);
	result.setResult(pb);
	out.write(JSON.toJSONString(result,true));
}else if(method.equals("getByID")){//getbyid
	String id = request.getParameter("id");
	Map<String,String> map = new HashMap<String,String>();
	map = service.getNoticeBaseInfoBean(id);
	ResultMap<AResultCode,Map<String,String>> result = new ResultMap<AResultCode,Map<String,String>>();
	result.setCode(AResultCode.OK);
	result.setResult(map);
	out.write(JSON.toJSONString(result,true));
}else if(method.equals("updateState")){//已读
	String n_receiverid = request.getParameter("n_receiverid");
	service.updateNoticeReceiverUserState(n_receiverid);
}else if(method.equals("fujian")){//附件列表
	FiletransfersSysDao dao = new FiletransfersSysDaoImpl();
	ResultMap<AResultCode, List<FileInfoBean>> result = new ResultMap<AResultCode, List<FileInfoBean>>();
	String attach_id = request.getParameter("attach_id");
	List<FileInfoBean> rows = dao.getFileInfoBeanlist(attach_id);
	result.setCode(AResultCode.OK);
	result.setResult(rows);
	out.write(JSON.toJSONString(result,true));
}
%>


