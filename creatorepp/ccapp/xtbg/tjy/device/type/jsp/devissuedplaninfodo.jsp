<%--
�������´�˼�ƻ�����ҳ��
���ߣ�����
�汾��1.0
���ڣ�2014-04-04
--%>
<%@page import="com.chinacreator.xtbg.tjy.device.entity.DevIssuedPlanBean"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.DevIssuedPlanService"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.impl.DevIssuedPlanServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.device.entity.DevCheckInfoBean"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.regex.Matcher"%>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	
	String responseCode="";//1:�ص�js
	Object responseObj=null;
	String responseObj_SUCCESS="�����ɹ�";
	String responseObj_FIAL="����ʧ��";
	
	boolean flag = false;
	//1:���ദ������
	String action = request.getParameter("action");
	DevIssuedPlanService service = new DevIssuedPlanServiceImpl();
	//1.1:�� ��reviewUserinfo
	if("addInfo".equals(action)){
		responseCode = "1";
		String [] t_sbidArray = request.getParameterValues("t_sb_id");
		String [] devcodeArray = request.getParameterValues("dev_code");
		String [] devnameArray = request.getParameterValues("dev_name");
		for(int i=0 ; i< t_sbidArray.length;i++){
			String sb_id = t_sbidArray[i];
			DevIssuedPlanBean bean = new DevIssuedPlanBean();
			bean = (DevIssuedPlanBean)RequestBeanUtils.getValuesByRequest(request,bean);
			bean.setT_sb_id(sb_id);
			String beanId = service.insertOrUpdateDevIssuedPlan(bean);
			
			if(beanId!=null&&beanId.length()>0){
				responseObj = responseObj_SUCCESS+","+beanId;
			}else{
				responseObj = responseObj_FIAL;
			}
		}
	}

	//1.2:ɾPsdataTypeInfo
	if("deleteInf".equals(action)){
		responseCode = "1";
		String deleteStr = request.getParameter("delete");
		String[] deleteArr = deleteStr.split(",");
		String flagStr = "false";
		if(deleteArr.length>0){
			flagStr = service.deleteDevIssuedPlanByIds(deleteArr);
		}
		if("true".equals(flagStr)){
			flag=true;
			responseObj=responseObj_SUCCESS;
		}else if("number".equals(flagStr)){
			flag=true;
			responseObj="���౻���ã�����ɾ����";
		}
		
		if(flag){
			responseObj = responseObj;
		}else{
			responseObj = responseObj_FIAL;
		}
	}
	
	//2:��Ӧҳ��
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