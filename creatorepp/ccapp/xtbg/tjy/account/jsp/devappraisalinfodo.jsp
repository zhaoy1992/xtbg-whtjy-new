
<%@page import="com.chinacreator.xtbg.tjy.device.entity.DevAppraisalBean"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.impl.DevAppraisalServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.DevAppraisalService"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.entity.OsAccountBean"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsAccountService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsAccountServiceImpl"%>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	
	String responseCode="";//1:回调js
	Object responseObj=null;
	String responseObj_SUCCESS="操作成功";
	String responseObj_FIAL="操作失败";
	
	boolean flag = false;
	//1:分类处理请求
	String action = request.getParameter("action");
	DevAppraisalService service = new DevAppraisalServiceImpl();
	OsAccountService accountService = new OsAccountServiceImpl();
	//1.1:增 改
	if("addInfo".equals(action)){
		responseCode = "1";
		DevAppraisalBean bean = new DevAppraisalBean();
		bean = (DevAppraisalBean)RequestBeanUtils.getValuesByRequest(request,bean);
		String beanId = service.insertOrUpdateDevAppraisal(bean);
		//更新設備檢查時間
		OsAccountBean accountBean = new OsAccountBean();
		accountBean.setId(bean.getT_sb_id());
		accountBean.setThis_calibration_time(request.getParameter("appr_time"));
		accountBean.setNext_calibration_time(request.getParameter("next_appr_time"));
		accountService.updateCalibrationTime(accountBean);
		
		if(beanId!=null&&beanId.length()>0){
			responseObj = responseObj_SUCCESS+","+beanId;
		}else{
			responseObj = responseObj_FIAL;
		}
	}

	//1.2:删PsdataTypeInfo
	if("deleteInf".equals(action)){
		responseCode = "1";
		String deleteStr = request.getParameter("delete");
		String[] deleteArr = deleteStr.split(",");
		String flagStr = "false";
		if(deleteArr.length>0){
			flagStr = service.deleteDevDevAppraisalByIds(deleteArr);
		}
		if("true".equals(flagStr)){
			flag=true;
			responseObj=responseObj_SUCCESS;
		}else if("number".equals(flagStr)){
			flag=true;
			responseObj="分类被引用，不能删除！";
		}
		
		if(flag){
			responseObj = responseObj;
		}else{
			responseObj = responseObj_FIAL;
		}
	}
	
	//2:响应页面
	if("1".equals(responseCode)){
		if(responseObj!=null){
			String result = "";
			if(responseObj instanceof String){
				result = responseObj.toString();
			}else{
				result = JSON.toJSONString(responseObj,true);
				Pattern p = Pattern.compile("\\s*|\t|\r|\n");
				Matcher m = p.matcher(result);
				result= m.replaceAll("");
			}
		%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
	<head></head>
	<body>
	<script>
		try{
			var result='<%=result%>';
			eval("parent.afterSubmitFn('"+result+"');");
		}catch(e){alert(e.description);}
	</script>
	</body>
</html>
	<%
		}
	}
	%>