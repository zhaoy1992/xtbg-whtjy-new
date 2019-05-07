<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.xtbg.core.common.commonlist.PagingBean"%>
<%@page import="com.chinacreator.xtbg.tjy.processing.list.ToBeDeWorkList"%>
<%@page import="com.chinacreator.xtbg.core.common.util.ResultMap"%>
<%@page import="com.chinacreator.xtbg.core.common.util.AResultCode"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.chinacreator.xtbg.tjy.processing.list.DoDeWorkList"%>
<%@page import="com.chinacreator.xtbg.tjy.processing.list.DoneDeWorkList"%>
<%@page import="com.chinacreator.xtbg.core.archive.list.DoBackList"%>
<%@page import="com.chinacreator.xtbg.core.process.flowprocessing.list.FindLsWorkList"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.dao.ElectInfoDao"%>
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.dao.imploracle.ElectInfoDaoImpl"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DbManager"%>
<%@page import="com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowInstanceDataSaveDao"%>
<%@page import="com.chinacreator.xtbg.core.process.flowprocessing.dao.impl.FlowInstanceDataSaveDaoImpl"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.ArchiveService"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.impl.ArchiveServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%
String path = request.getContextPath();

String method = request.getParameter("method");

if(method.equals("getZc")){//得休假暂存列表
	String parmjson = request.getParameter("parmjson");	
	String sortName = request.getParameter("sortName");
	String sortOrder = request.getParameter("sortOrder");
	long offset = Long.parseLong(request.getParameter("offset"));
	int maxPagesize = Integer.parseInt(request.getParameter("maxPagesize"));
	PagingBean pb = new PagingBean();
	ToBeDeWorkList list = new ToBeDeWorkList();
	pb = list.getDataList(parmjson,sortName,sortOrder,offset,maxPagesize);
	ResultMap<AResultCode,PagingBean> result = new ResultMap<AResultCode,PagingBean>();
	result.setCode(AResultCode.OK);
	result.setResult(pb);
	out.print(JSON.toJSONString(result,true));
}else if(method.equals("getDb")){//得休假待办列表
	String parmjson = request.getParameter("parmjson");
	String sortName = request.getParameter("sortName");
	String sortOrder = request.getParameter("sortOrder");
	long offset = Long.parseLong(request.getParameter("offset"));
	int maxPagesize = Integer.parseInt(request.getParameter("maxPagesize"));
	PagingBean pb = new PagingBean();
	DoDeWorkList list = new DoDeWorkList();
	pb = list.getDataList(parmjson,sortName,sortOrder,offset,maxPagesize);
	ResultMap<AResultCode,PagingBean> result = new ResultMap<AResultCode,PagingBean>();
	result.setCode(AResultCode.OK);
	result.setResult(pb);
	out.print(JSON.toJSONString(result,true));
}else if(method.equals("getYb")){//得休假已办列表
	String parmjson = request.getParameter("parmjson");
	String sortName = request.getParameter("sortName");
	String sortOrder = request.getParameter("sortOrder");
	long offset = Long.parseLong(request.getParameter("offset"));
	int maxPagesize = Integer.parseInt(request.getParameter("maxPagesize"));
	PagingBean pb = new PagingBean();
	DoneDeWorkList list = new DoneDeWorkList();
	pb = list.getDataList(parmjson,sortName,sortOrder,offset,maxPagesize);
	ResultMap<AResultCode,PagingBean> result = new ResultMap<AResultCode,PagingBean>();
	result.setCode(AResultCode.OK);
	result.setResult(pb);
	out.print(JSON.toJSONString(result,true));
}else if(method.equals("tuihui")){//退回环节列表
	String parmjson = request.getParameter("parmjson");
	String sortName = request.getParameter("sortName");
	String sortOrder = request.getParameter("sortOrder");
	long offset = Long.parseLong(request.getParameter("offset"));
	int maxPagesize = Integer.parseInt(request.getParameter("maxPagesize"));
	PagingBean pb = new PagingBean();
	DoBackList list = new DoBackList();
	pb = list.getDataList(parmjson,sortName,sortOrder,offset,maxPagesize);
	ResultMap<AResultCode,PagingBean> result = new ResultMap<AResultCode,PagingBean>();
	result.setCode(AResultCode.OK);
	result.setResult(pb);
	out.print(JSON.toJSONString(result,true));
}else if(method.equals("history")){//办件历史列表
	String parmjson = request.getParameter("parmjson");
	String sortName = request.getParameter("sortName");
	String sortOrder = request.getParameter("sortOrder");
	long offset = Long.parseLong(request.getParameter("offset"));
	int maxPagesize = Integer.parseInt(request.getParameter("maxPagesize"));
	PagingBean pb = new PagingBean();
	FindLsWorkList list = new FindLsWorkList();
	pb = list.getDataList(parmjson,sortName,sortOrder,offset,maxPagesize);
	ResultMap<AResultCode,PagingBean> result = new ResultMap<AResultCode,PagingBean>();
	result.setCode(AResultCode.OK);
	result.setResult(pb);
	out.print(JSON.toJSONString(result,true));
}else if(method.equals("delflow")){//删除
	Connection conn = null;
	boolean flag = true;
	FlowInstanceDataSaveDao instancedao =new FlowInstanceDataSaveDaoImpl();
	try{
		conn = DbManager.getInstance().getTransactionConnection();
		String ins_id = StringUtil.deNull(request.getParameter("ins_id"));
		String ins_code = StringUtil.deNull(request.getParameter("ins_code"));
		//如果为请假流程，先删请假数据
		String sql = "select t.busitype_type_code from oa_flow_instance i left join oa_flow_busitype t on i.busitype_code = t.busitype_code where i.ins_id = '"+ins_id+"'";
		String busitype_type_code = DaoUtil.sqlToField(sql);
		if(busitype_type_code.equals("kqgl")){
			ElectInfoDao electInfoDao = new ElectInfoDaoImpl();
			flag = flag & electInfoDao.del(ins_id,conn);
		}
		//删除流程实例
		flag = flag&instancedao.delFlowIns(ins_id,conn);
		//删除平台数据
		flag = flag&instancedao.delShakeFlow(ins_code,conn);
		
		out.print(flag);
	} catch (Exception e) {
		DbManager.rollBackNoThrow(conn);
		e.getMessage();
	} finally{
		DbManager.closeConnection(conn);
	}
}else if(method.equals("songhouxu")){//送后续
	ResultMap<AResultCode,Map<String,Object>> result = new ResultMap<AResultCode,Map<String,Object>>();
	Map<String,Object> returnMap  = new HashMap<String,Object>();
	ArchiveService flowServlet = new ArchiveServiceImpl();
    returnMap  = flowServlet.handler(request, response);
    result.setCode(AResultCode.OK);
    result.setResult(returnMap);
    out.print(JSON.toJSONString(result,true));
}

%>


