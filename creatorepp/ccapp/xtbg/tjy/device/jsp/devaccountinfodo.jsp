<%--
描述：设备基本信息处理页面
作者：邱炼
版本：1.0
日期：2014-02-18
--%>
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
	DevAccountInfoService service = new DevAccountServiceImpl();
	DevInfoItemService itemService = new DevInfoItemServiceImpl();
	//1.1:增 改reviewUserinfo
	if("addInfo".equals(action)){
		responseCode = "1";
		DevAccountInfo bean = new DevAccountInfo();
		//配件ID
		String[] parts_id = request.getParameterValues("id"); 
		//配件名称
		String[] parts_name = request.getParameterValues("parts_name"); 
		//配件规格
		String[] parts_type = request.getParameterValues("parts_type"); 
		//数量
		String[] parts_count = request.getParameterValues("parts_count");
		bean = (DevAccountInfo)RequestBeanUtils.getValuesByRequest(request,bean);
		String beanId = service.insertOrUpdateDevAccount(bean);
		//删除业务配件信息
		itemService.deleteDevInfoItemByIds(new String[]{bean.getDev_code()});
		//业务配件信息
		for(int i=0;i<parts_name.length;i++){
			DevInfoItemBean itemBean = new DevInfoItemBean();
			itemBean.setDev_code(bean.getDev_code());
			itemBean.setParts_name(parts_name[i]);
			itemBean.setParts_type(parts_type[i]);
			itemBean.setParts_count(parts_count[i]);
			itemBean.setParts_no(i+"");
			itemService.insertOrUpdateDevInfoItem(itemBean);
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
		String[] deleteArr = deleteStr.split(",");
		String flagStr = "false";
		if(deleteArr.length>0){
			flagStr = service.deleteDevAccountByIds(deleteArr);
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