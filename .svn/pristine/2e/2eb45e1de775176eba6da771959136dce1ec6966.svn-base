<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.DevIssuedPlanService"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.impl.DevIssuedPlanServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.device.entity.DevIssuedPlanBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.DevIssuedDetailsService"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.impl.DevIssuedDetailsServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.tjy.device.entity.DevIssuedDetailsBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="org.python.modules.re"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.entity.OsAccountBean"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsAccountService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsAccountServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%
	String path = request.getContextPath();
	
	String method = request.getParameter("method");

	String flag = "false";
	//核验计划表处理
	DevIssuedPlanService service = new DevIssuedPlanServiceImpl();
	DevIssuedPlanBean bean = new DevIssuedPlanBean();
	bean = (DevIssuedPlanBean)RequestBeanUtils.getValuesByRequest(request,bean);
	//核验设备处理
	DevIssuedDetailsService detailService = new DevIssuedDetailsServiceImpl();
	//仪器设备处理
	OsAccountService accountService = new OsAccountServiceImpl();
	
	String[] sb_id = request.getParameterValues("t_sb_id");//待检设备id
	String[] last_date = request.getParameterValues("this_calibration_time");//上次检验时间
	
	if(method.equals("delete")){
		String ids = request.getParameter("ids");
		String[] id_arr = ids.split(",");
		if(id_arr.length > 0){
			flag = service.deleteDevIssuedPlanByIds(id_arr);
		}
	}else if(method.equals("insert")){
		flag = service.insertDevIssuedPlan(bean);
		if(sb_id.length>0){
			for(int i=0;i<sb_id.length;i++){
				if(!StringUtil.nullOrBlank(sb_id[i])){
					DevIssuedDetailsBean detailsBean = new DevIssuedDetailsBean();
					detailsBean.setId(DaoUtil.getUUID());
					detailsBean.setPlan_id(bean.getPlan_id());
					detailsBean.setSb_id(sb_id[i]);
					detailsBean.setLast_date(last_date[i]);
					detailService.insert(detailsBean);
				}
			}
		}
	}else if(method.equals("update")){
		//做是否完成判断
		String is_wancheng = StringUtil.deNull(request.getParameter("is_wancheng"));
	
		flag = service.updateDevIssuedPlan(bean);
		//删除待检物品
		detailService.delete(bean.getPlan_id());
		//新增
		if(sb_id.length>0){
			for(int i=0;i<sb_id.length;i++){
				if(!StringUtil.nullOrBlank(sb_id[i])){
					DevIssuedDetailsBean detailsBean = new DevIssuedDetailsBean();
					detailsBean.setId(DaoUtil.getUUID());
					detailsBean.setPlan_id(bean.getPlan_id());
					detailsBean.setSb_id(sb_id[i]);
					detailsBean.setLast_date(last_date[i]);
					detailService.insert(detailsBean);
					//已完成则需改变设备的检验时间
					if(is_wancheng.equals("1")){
						OsAccountBean accountBean = new OsAccountBean();
						accountBean.setId(sb_id[i]);
						accountBean.setThis_calibration_time(DateUtil.getCurrentDateString("yyyy-MM-dd"));
						
						accountService.updateCalibrationTime(accountBean);
					}
				}
			}
		}
	}

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title></title>
<script type="text/javascript">
	var flag = "<%=flag%>";
	var method = "<%=method%>";
	if(flag == "true"){
		if(method == "delete"){
			parent.userSearch();
		}else{
			parent.removeAlertWindows("",true);
		}
	}else{
		parent.alert("操作失败")
	}
</script>
</head>
<body>

</body>

</html>