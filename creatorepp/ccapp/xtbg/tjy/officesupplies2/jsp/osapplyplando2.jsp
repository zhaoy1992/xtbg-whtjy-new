<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.entity.OsApplanBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsapPlanService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsapPlanServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.entity.OsHavaObjectBean"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsKucunService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsKucunServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.entity.OsAppObjectBean"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsAppObjectService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsAppObjectServiceImpl"%>

<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	String action = request.getParameter("action");
	boolean flag = false;
	//入库以规格id做标准，一个规格一个库存
	String[] IT_NAME_ID = request.getParameterValues("IT_NAME_ID");//规格id
	String[] T_OS_OB_NO = request.getParameterValues("T_OS_OB_NO");//数量
	String[] T_OS_OB_ID = request.getParameterValues("T_OS_OB_ID");//id
	String[] OFUSTYPE_MONEY = request.getParameterValues("OFUSTYPE_MONEY");//单价
	
	OsapPlanService service = new OsapPlanServiceImpl();
	OsKucunService kucunService = new OsKucunServiceImpl();
	OsAppObjectService objectService = new OsAppObjectServiceImpl();
	OsApplanBean bean = new OsApplanBean();
	bean = (OsApplanBean)RequestBeanUtils.getValuesByRequest(request,bean); 
	
	if(action.equals("insert")){
		flag = service.insertApplan(bean,request);
	}else if(action.equals("ruku")){
		flag = service.changeState(bean);//改变申购单入库状态

		for(int i=0;i<T_OS_OB_ID.length;i++){
			if((!StringUtil.nullOrBlank(T_OS_OB_NO[i])) || (!StringUtil.nullOrBlank(OFUSTYPE_MONEY[i]))){
				//改变库存
				OsHavaObjectBean ItemBean = new OsHavaObjectBean();
				ItemBean.setT_ha_rkuser_id(bean.getT_rkuser_id());
				ItemBean.setT_ha_rkuser_name(bean.getT_rkuser_name());
				ItemBean.setT_ha_rkuser_date(bean.getT_rkdate());
				ItemBean.setT_ha_no(T_OS_OB_NO[i]);//数量
				ItemBean.setIt_id(IT_NAME_ID[i]);//规格
			
				flag = flag & kucunService.updateNo(ItemBean);
				//改变物品状态与单价
				OsAppObjectBean objectBean = new OsAppObjectBean();
				objectBean.setRk_id(bean.getT_rkuser_id());
				objectBean.setRk_name(bean.getT_rkuser_name());
				objectBean.setRk_date(bean.getT_rkdate());
				objectBean.setOfustype_money(OFUSTYPE_MONEY[i]);
				objectBean.setT_os_ob_id(T_OS_OB_ID[i]);
				
				flag = flag & objectService.changeItemState(objectBean);
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