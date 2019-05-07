<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.DevScrapService"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.impl.DevScrapServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.device.entity.DevScrapBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsAccountService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsAccountServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.entity.OsAccountBean"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.entity.OsAccountHistoryBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsAccountHistoryService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsAccountHistoryServiceImpl"%>

<%
	String path = request.getContextPath();
	
	String method = request.getParameter("method");
	
	DevScrapService scrap = new DevScrapServiceImpl();
	DevScrapBean bean = new DevScrapBean();
	bean = (DevScrapBean)RequestBeanUtils.getValuesByRequest(request,bean);
	
	boolean flag = false;
	
	if(method.equals("insert")){
		flag = scrap.saveDevScrapInfo(bean);
		//改变处置状态
		OsAccountService accountService = new OsAccountServiceImpl();
		OsAccountBean accountBean = new OsAccountBean();
		accountBean.setId(bean.getT_sb_id());
		accountBean.setDealt("报废");
		accountBean.setDealt_date(bean.getT_sqrq());
		accountBean.setState("报废");
		flag = flag & accountService.changeState(accountBean);
		//增加使用记录
		OsAccountHistoryService historyService = new OsAccountHistoryServiceImpl();
		OsAccountHistoryBean historyBean = new OsAccountHistoryBean();
		historyBean.setId(DaoUtil.getUUID());
		historyBean.setGdzc_id(bean.getT_sb_id());
		historyBean.setGdzc_name(bean.getT_sb_name());
		historyBean.setUser_id(bean.getUser_id());
		historyBean.setUser_name(bean.getUser_name());
		historyBean.setOrg_id(bean.getOrg_id());
		historyBean.setOrg_name(bean.getOrg_name());
		historyBean.setUse_type("报废");
		historyBean.setUser_date(bean.getT_sqrq());
		historyBean.setGhdj_id(bean.getT_id());
		flag = flag & historyService.insertHisetory(historyBean); 
	}
	

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title></title>
<script type="text/javascript">
	var flag = "<%=flag%>";
	if(flag){
		location.href = "<%=path%>/ccapp/xtbg/tjy/account/jsp/devscrap.jsp";
	}else{
		parent.alert("操作失败")
	}
</script>
</head>
<body>

</body>

</html>