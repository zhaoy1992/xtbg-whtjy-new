<%--
�������豸ά�޺ͱ�����¼����ҳ��
���ߣ�����
�汾��1.0
���ڣ�2014-03-08
--%>
<%@page import="com.chinacreator.xtbg.tjy.device.entity.DevTakcareBean"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.DevTakcareService"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.impl.DevTakcareServiceImpl"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsAccountService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsAccountServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.entity.OsAccountBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
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
	DevTakcareService service = new DevTakcareServiceImpl();
	//�豸����
	OsAccountService accountService = new OsAccountServiceImpl();
	
	//1.1:�� ��
	if("addInfo".equals(action)){
		responseCode = "1";
		DevTakcareBean bean = new DevTakcareBean();
		bean = (DevTakcareBean)RequestBeanUtils.getValuesByRequest(request,bean);
		String beanId = service.insertOrUpdateDevTakcare(bean);
		//�ı��豸״̬
		OsAccountBean accountBean = new OsAccountBean();
		accountBean.setId(bean.getT_sb_id());
		accountBean.setState("�ڿ�ά��");
		accountService.changeState(accountBean);
		
		if(beanId!=null&&beanId.length()>0){
			responseObj = responseObj_SUCCESS+","+beanId;
		}else{
			responseObj = responseObj_FIAL;
		}
	}

	//1.2:ɾPsdataTypeInfo
	if("deleteInf".equals(action)){
		responseCode = "1";
		String deleteStr = request.getParameter("delete");
		String[] deleteArr = deleteStr.split(",");
		String flagStr = "false";
		if(deleteArr.length>0){
			flagStr = service.deleteDevDevTakcareByIds(deleteArr);
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
	}else if("changeInfo".equals(action)){//���û򱨷�
		responseCode = "1";
		OsAccountBean accountBean = new OsAccountBean();
		String is_qiyong = request.getParameter("is_qiyong");//0Ϊ����1Ϊ����
		String t_sb_id = request.getParameter("t_sb_id");//�豸id
		accountBean.setId(t_sb_id);
		System.out.println("is_qiyong==========="+is_qiyong);
		if(is_qiyong.equals("0")){//����
			accountBean.setState("�ڿ�����");
		}else{
			accountBean.setState("����");
			accountBean.setDealt("����");
			accountBean.setDealt_date(DateUtil.getCurrentDateString("yyyy-MM-dd"));
		}
		flag = accountService.changeState(accountBean);
		
		if(flag){
			responseObj = responseObj_SUCCESS;
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