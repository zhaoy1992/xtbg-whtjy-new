<%--
��������Ʒ�����ҳ��
���ߣ�����
�汾��1.0
���ڣ�2014-02-18
--%>
<%@page import="com.chinacreator.xtbg.tjy.canteenitemssupplies.entity.OsuserTypeItemBean"%>
<%@page import="com.chinacreator.xtbg.tjy.canteenitemssupplies.service.OsUserTypeItemService"%>
<%@page import="com.chinacreator.xtbg.tjy.canteenitemssupplies.service.impl.OsUserTypeItemServiceImpl"%>
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
	OsUserTypeItemService service = new OsUserTypeItemServiceImpl();
	//1.1:�� ��PsdataTypeInfo
	if("addOsupplieTypeInfo".equals(action)){
		responseCode = "1";
		OsuserTypeItemBean bean = new OsuserTypeItemBean();
		bean = (OsuserTypeItemBean)RequestBeanUtils.getValuesByRequest(request,bean);
		String beanId = service.insertOrUpdateOsUserTypeItem(bean);
		
		if(beanId!=null&&beanId.length()>0){
			responseObj = responseObj_SUCCESS+","+beanId;
		}else{
			responseObj = responseObj_FIAL;
		}
	}

	//1.2:ɾPsdataTypeInfo
	if("deleteOsupplietypeInf".equals(action)){
		responseCode = "1";
		String deleteStr = request.getParameter("delete");
		String[] deleteArr = deleteStr.split(",");
		String flagStr = "false";
		if(deleteArr.length>0){
			flagStr = service.deleteOsUserTypeItemByIds(deleteArr);
		}
		if("true".equals(flagStr)){
			flag=true;
			responseObj=responseObj_SUCCESS;
		}else if("number".equals(flagStr)){
			flag=true;
			responseObj="�ѹ�����������޷�ɾ����";
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