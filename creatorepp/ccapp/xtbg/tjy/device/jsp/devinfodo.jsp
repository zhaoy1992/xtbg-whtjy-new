
<%@page import="com.chinacreator.xtbg.tjy.device.entity.DevBorrowBean"%>
<%@page import="com.chinacreator.xtbg.tjy.device.dao.Impl.DevBorrowDaoImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.impl.DevBorrowServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.DevBorrowService"%>
<%@page import="com.chinacreator.xtbg.tjy.device.entity.DevChuzuBean"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.impl.DevScrapServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.DevScrapService"%>
<%@page import="com.chinacreator.xtbg.tjy.device.entity.DevScrapBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.DevInfoItemService"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.impl.DevInfoItemServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.device.entity.DevInfoItemBean"%>
<%@page import="com.chinacreator.xtbg.tjy.device.entity.DevAccountInfo"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.DevAccountInfoService"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.impl.DevAccountServiceImpl"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.regex.Matcher"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	String responseCode="";
	Object responseObj=null;
	String responseObj_SUCCESS="操作成功";
	String responseObj_FIAL="操作失败";
	
	boolean flag = false;

	String action = request.getParameter("action");
	//String action = "";
	String dev_code = request.getParameter("dev_code");
	String devScrapJsonObj = request.getParameter("devScrapJsonObj");
	String url = "action";

	if("addScrap".equals(action)){
		DevScrapService scrap = new DevScrapServiceImpl();
		DevScrapBean bean = new DevScrapBean();
		bean = (DevScrapBean)RequestBeanUtils.getValuesByRequest(request,bean);
		flag = scrap.saveDevScrapInfo(bean);
		if(flag){
			DevBorrowDaoImpl dao = new DevBorrowDaoImpl();
			dao.updatedev_state(bean.getT_sb_id(),"3");
			url = path+"/ccapp/xtbg/tjy/device/jsp/devscrap2.jsp";
		}
	}else if("addDevchuzu".equals(action)){
		String t_sb_id = request.getParameter("TA_OA_DEVBORROW__T_SB_ID");
		String t_jbr_id = request.getParameter("TA_OA_DEVBORROW__T_JBR_ID");
		String t_jre_mc = request.getParameter("TA_OA_DEVBORROW__T_JRE_MC");
		String t_lyorg_id = request.getParameter("TA_OA_DEVBORROW__T_LYORG_ID");
		String t_lyorg_mc = request.getParameter("TA_OA_DEVBORROW__T_LYORG_MC");
 		String t_lydate = request.getParameter("TA_OA_DEVBORROW__T_LYDATE");
		String t_title   = request.getParameter("TA_OA_DEVBORROW__T_TITLE");
		String t_ghdate = request.getParameter("dis_TA_OA_DEVBORROW__T_GHDATE");
		String t_money =  request.getParameter("T_MONEY");
		DevBorrowBean bean = new DevBorrowBean();
		bean.setT_sb_id(t_sb_id);
		bean.setT_jbr_id(t_jbr_id);
		bean.setT_jre_mc(t_jre_mc);
		bean.setT_lyorg_id(t_lyorg_id);
		bean.setT_lyorg_mc(t_lyorg_mc);
		bean.setT_title(t_title);
		bean.setT_money(t_money);
		bean.setT_ghdate(t_ghdate);
		DevBorrowService service = new DevBorrowServiceImpl();
		flag = service.saveDevBorrowInfo(bean);
		if(flag){
			DevBorrowDaoImpl dao = new DevBorrowDaoImpl();
			dao.updatedev_stockflag(t_sb_id,"3");
			url = path+"/ccapp/xtbg/tjy/device/jsp/devchuzu.jsp"; 
		}
	}else if("addDevjieyong".equals(action)){
		String t_sb_id = request.getParameter("TA_OA_DEVBORROW__T_SB_ID");
		String t_jbr_id = request.getParameter("TA_OA_DEVBORROW__T_JBR_ID");
		String t_jre_mc = request.getParameter("TA_OA_DEVBORROW__T_JRE_MC");
		String t_lyorg_id = request.getParameter("TA_OA_DEVBORROW__T_LYORG_ID");
		String t_lyorg_mc = request.getParameter("TA_OA_DEVBORROW__T_LYORG_MC");
 		String t_lydate = request.getParameter("TA_OA_DEVBORROW__T_LYDATE");
		String t_ghdate = request.getParameter("dis_TA_OA_DEVBORROW__T_GHDATE");
		String t_title   = request.getParameter("TA_OA_DEVBORROW__T_TITLE");
		DevBorrowBean bean = new DevBorrowBean();
		bean.setT_sb_id(t_sb_id);
		bean.setT_jbr_id(t_jbr_id);
		bean.setT_jre_mc(t_jre_mc);
		bean.setT_lyorg_id(t_lyorg_id);
		bean.setT_lyorg_mc(t_lyorg_mc);
		bean.setT_title(t_title);
		bean.setT_ghdate(t_ghdate);
		DevBorrowService service = new DevBorrowServiceImpl();
		flag = service.saveDevBorrowInfo(bean);
		if(flag){
			DevBorrowDaoImpl dao = new DevBorrowDaoImpl();
			dao.updatedev_stockflag(t_sb_id,"2");
			url = path+"/ccapp/xtbg/tjy/device/jsp/devjieyong.jsp"; 
		}
	}else if("addDevguih".equals(action)){
		DevBorrowBean bean = new DevBorrowBean();
		String t_sb_id = request.getParameter("TA_OA_DEVBORROW__T_SB_ID");
		String dev_state = request.getParameter("dev_state");
		String guihid = request.getParameter("guihid");
		
		bean.setT_sb_id(t_sb_id);
		bean.setT_id(guihid);
		DevBorrowService service = new DevBorrowServiceImpl();
		flag = service.updateDevBorrowInfo(bean);
		if(flag){
			DevBorrowDaoImpl dao = new DevBorrowDaoImpl();
			dao.updatedev_stockflag(t_sb_id,"1");
			dao.updatedev_state(t_sb_id, dev_state);
			url = path+"/ccapp/xtbg/tjy/device/jsp/devguih.jsp"; 
		}
	}else if("addDevdiaobo".equals(action)){
		String t_sb_id = request.getParameter("T_SB_ID");
		String user_orgid = request.getParameter("diaoru_org_id");
		String user_orgname = request.getParameter("diaoru_org_name");
		String custos_userid = request.getParameter("in_now_user_id");
		String custos_username = request.getParameter("in_now_user_name");
		DevBorrowService service = new DevBorrowServiceImpl();
		flag = service.updateDevDiaobo(user_orgid, user_orgname, custos_userid, custos_username, t_sb_id);
		if(flag){
			url = path+"/ccapp/xtbg/tjy/device/jsp/devdiaobo.jsp"; 
		}
	}


	
		%>
		</head>
		<body>
	
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>

	<script type="text/javascript">
	var flag = "<%=flag%>";
	var url = "<%=url%>";
	var success = "<%=responseObj_SUCCESS%>";
	var error = "<%=responseObj_FIAL%>";
	if(flag){
		alert(success);
		location.href=url;//刷新当前页面.
	} else {
		alert(error);
	}
	</script>
	<iframe name="frame1" width=0 height=0> </iframe> 
	</body>
	</html>
	