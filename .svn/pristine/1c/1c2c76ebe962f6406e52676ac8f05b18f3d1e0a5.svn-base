<%--
描述：维修登记处理页面
作者：夏天
版本：1.0
日期：2014-03-07
--%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsHavaObjectServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsHavaObjectService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.entity.OsupplieRepairBean"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsupplieRepairServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsupplieRepairService"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.regex.Matcher"%>
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
	OsupplieRepairService osupplieRepairService= new OsupplieRepairServiceImpl();
	
	OsHavaObjectService osHavaObjectService = new OsHavaObjectServiceImpl();
	//1.1:增 改reviewUserinfo
	if("addInfo".equals(action)){
		responseCode = "1";
		OsupplieRepairBean osupplieRepairBean = new OsupplieRepairBean();
		osupplieRepairBean = (OsupplieRepairBean)RequestBeanUtils.getValuesByRequest(request,osupplieRepairBean);
		String beanId = osupplieRepairService.saveOrUpdate(osupplieRepairBean);
		
		String havaIds = osupplieRepairBean.getReplace_partids();
		if(!StringUtil.isBlank(havaIds)){
			osHavaObjectService.updateHavaObjectStateByHaIds(havaIds, "3");//将库存设备修改为在修状态
		}
		
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
		String flagStr = "false";
		if(null != deleteStr){
			flagStr = osupplieRepairService.delete(deleteStr);
		}
		if("true".equals(flagStr)){
			flag=true;
			responseObj=responseObj_SUCCESS;
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