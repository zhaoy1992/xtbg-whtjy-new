<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.iweboffice.service.impl.WordTemplateServiceImpl" %>
<%@page import="com.chinacreator.xtbg.core.common.iweboffice.service.WordTemplateServiceIfc" %>
<%@page import="com.chinacreator.xtbg.core.common.iweboffice.bean.WordRuleItemBean" %>
<%@page import="com.chinacreator.xtbg.core.common.commonlist.Constant" %>
<%@page import="java.util.List" %>
<%@ taglib uri="/WEB-INF/archive-taglib.tld" prefix="oa"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String user_id = accesscontroler.getUserID();//用户id
    String user_name = accesscontroler.getUserName();//用户名
    String time = DateUtil.getCurrentDateTime();//当前时间
    String date = DateUtil.getCurrentDate();//当日期
    //获得缓存的机构信息
    UserCacheBean userBean = UserCache.getUserCacheBean(user_id);
    String org_id = userBean.getOrg_id();//所属部门id
    String org_name = userBean.getOrg_name();//所属部门名
    String unit_id = userBean.getUnit_id();    //所属单位id
    String unit_name =  userBean.getUnit_name();//所属单位名
    //TODO  查询出表单的配置OA_WORD_TEXTINPUT 放入隐藏域里 。每次输入或者提交前，将WORD标签的值放入隐藏域。
   	String template_id = request.getParameter("template_id");
   	template_id = "50";
    WordTemplateServiceIfc service = new WordTemplateServiceImpl();
    List<WordRuleItemBean> wordRuleItemBeanList = service.getRuleItemBeanList(template_id);
    
%>

<!DOCTYPE html>
<html style="overflow-y:scroll;">
<head>
<script src="../process/wordtemplate/js/wordtemplateutil.js" type="text/javascript"></script>
<oa:init>
<title>测试WORD发文</title>
<script>
	var FINGERPRINT = "";
	var inputList = [
	<%
	for(int i = 0 ; i < wordRuleItemBeanList.size(); i ++){
	%>
	"<%=wordRuleItemBeanList.get(i).getTextinput_name()%>",
	<%
	}
	%>
	""];
	inputList.length = inputList.length - 1;
	function initWord(){
		var iWebOffice = document.getElementsByName("WebOffice")[0];
	    documentProtect(iWebOffice.WebObject, FINGERPRINT);
	}	
	
	//.do页面的回调函数，将验证框架里的isSubmit重置，用来防止提交失败后再提交失效。
	function resetSubmit(){
		jQuery("#form1").resetSubmit(false);
	}
	
	//此方法用于在提交表单的时候将WORD标签里的值SET入隐藏域
	function setInputValue(){
		var iWebOffice = document.getElementsByName("WebOffice")[0];
		for(var i = 0 ; i < inputList.length ; i ++){
			var value = getTextInputValue(iWebOffice.WebObject,inputList[i]);
			value = value.replaceAll(" ","");//WORD控件里获取掉空格，保存时会有乱码问题，将其去掉。
			jQuery("#"+inputList[i]).val(value);
		}
	}
</script>
</head>
<body style="width:1024px;height:768px;" onload = "initWord()">
<form id="form1" name="form1" action="" method="post">
<input id="busi_id" name="busi_id" type="hidden"/>
<input id="opt_type" name="opt_type" type="hidden"/>
<input id="busiTypeCode" name="busiTypeCode" type="hidden"/>
<input id="busiTypeCode" name="busiTypeCode" type="hidden"/>
<%for(int i=0; i<wordRuleItemBeanList.size();i++){
  String bid = wordRuleItemBeanList.get(i).getTable_id()+Constant.SEPARATOR+ wordRuleItemBeanList.get(i).getColumn_id();%>
  <input id="<%=bid%>" name="<%=bid%>" type="hidden"/>
<%} %>
<div id="tabs1" style="width:100%;border: 0px;">
		<table width="100%" border="0" cellspacing="1" cellpadding="0" style="display: inline;">
			<tr style="height:60px">
				<td style="display: inline;"><oa:flowcommonstart flowType="1" />
				</td>
			</tr>
		</table>
		<div id="tabs-3">
			<oa:webtext column="ZW_ID" table="OA_TEST_FORM"/>
		</div>	
</div>	    		
<IFRAME name=frame1 width=100% height=0> </IFRAME> 
</form>
</body>
</oa:init>
</html>
