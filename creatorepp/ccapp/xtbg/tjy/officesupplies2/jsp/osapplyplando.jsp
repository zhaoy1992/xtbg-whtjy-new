<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.entity.OsApplanBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsapPlanService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsapPlanServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.archive.dao.FlowBusiDataSaveDao"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DbManager"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsKucunService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsKucunServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.entity.OsHavaObjectBean"%>

<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	String action = request.getParameter("action");
	//申购表信息
	String t_id = request.getParameter("T_ID");//主键
	String t_org_id = request.getParameter("T_ORG_ID");//部门id
	String t_org_name = request.getParameter("T_ORG_NAME");//部门名
	if(t_org_name != null){
		t_org_name = java.net.URLDecoder.decode(t_org_name, "UTF-8");
	}
	String t_creator_time = request.getParameter("T_CREATOR_TIME");//申请时间
	String t_title = request.getParameter("T_TITLE");//标题
	if(t_title != null){
		t_title = java.net.URLDecoder.decode(t_title, "UTF-8");
	}
	String t_user_name = request.getParameter("T_USER_NAME");//申请人
	if(t_user_name != null){
		t_user_name = java.net.URLDecoder.decode(t_user_name, "UTF-8");
	}
	String t_user_id = request.getParameter("T_USER_ID");//申请id
	String t_rkuser_id = request.getParameter("t_rkuser_id");//入库人id
	String t_rkdate = request.getParameter("t_rkdate");
	String t_rkuser_name = request.getParameter("t_rkuser_name");
	if(t_rkuser_name != null){
		t_rkuser_name = java.net.URLDecoder.decode(t_rkuser_name, "UTF-8");
	}
	
	OsapPlanService service = new OsapPlanServiceImpl();
	OsApplanBean bean = new OsApplanBean();
	
	bean.setT_id(t_id);
	bean.setT_org_id(t_org_id);
	bean.setT_org_name(t_org_name);
	bean.setT_creator_time(t_creator_time);
	bean.setT_title(t_title);
	bean.setT_user_name(t_user_name);
	bean.setT_user_id(t_user_id);
	bean.setT_rkuser_id(t_rkuser_id);
	bean.setT_rkuser_name(t_rkuser_name);
	bean.setT_rkdate(t_rkdate);
	//入库以规格id做标准，一个规格一个库存
	String[] IT_NAME_ID = request.getParameterValues("IT_NAME_ID");//规格id
	String[] T_OS_OB_NO = request.getParameterValues("T_OS_OB_NO");//数量
	
	
	boolean flag = false;
	Connection conn = null;
	if(action.equals("insert")){
		try {
			flag = service.insertApplan(bean);
			String customClassName = request.getParameter(FlowBusiDataSaveDao.CUSTOM_CRUD_CLASSNAME_FLAG);
			conn = DbManager.getInstance().getTransactionConnection();
			if(flag&&!StringUtil.isBlank(customClassName)){
				FlowBusiDataSaveDao dao = (FlowBusiDataSaveDao)Class.forName(customClassName).newInstance();
				flag = dao.saveBusiInfo(request, conn);
			}
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
		} finally{
			DbManager.closeConnection(conn);
		}
	}else if(action.equals("ruku")){
		flag = service.changeState(bean);
		OsKucunService kucunService = new OsKucunServiceImpl();
		for(int i=0;i<T_OS_OB_NO.length;i++){
			if(!T_OS_OB_NO[i].equals(0) && !StringUtil.isBlank(T_OS_OB_NO[i])){
				OsHavaObjectBean ItemBean = new OsHavaObjectBean();
				ItemBean.setT_ha_rkuser_id(t_rkuser_id);
				ItemBean.setT_ha_rkuser_name(t_rkuser_name);
				ItemBean.setT_ha_rkuser_date(t_rkdate);
				ItemBean.setT_ha_no(T_OS_OB_NO[i]);//数量
				String[] NEW_IT_ID_VALUE_Arr = IT_NAME_ID[i].split(";");//规格
				if (NEW_IT_ID_VALUE_Arr.length == 1) {
	        		ItemBean.setIt_id("");
				}else{
					ItemBean.setIt_id(NEW_IT_ID_VALUE_Arr[1]);
				}
				flag = flag & kucunService.updateNo(ItemBean);
			}
		}
	}	
%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title></title>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript">
	var flag = "<%=flag%>";
	var action = "<%=action%>";
	if(!flag){
		alert('操作失败！');
		parent.resetSubmit();
	}else{
		if(action == "insert"){
			location.href = "<%=path%>/ccapp/xtbg/tjy/officesupplies2/jsp/showpersonosplan.jsp";
		}else if(action == "ruku"){
			location.href = "<%=path%>/ccapp/xtbg/tjy/officesupplies2/jsp/osrukulist.jsp";
		}
	}
</script>
</head>
<body>

</body>

</html>