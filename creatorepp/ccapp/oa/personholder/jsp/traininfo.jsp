<%--
describe:培训记录信息管理界面
author:邱炼
date: 2014-02-21
--%>
<%@page import="com.chinacreator.xtbg.core.personholder.util.PersonHolderUtil"%>
<%@page import="com.chinacreator.xtbg.core.personholder.util.PersonHolderConstants"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.core.personholder.service.TrainServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.personholder.service.imp.TrainServiceImpl"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String userId = accesscontroler.getUserID();
	Map<String,String> bean = new HashMap<String,String>();
	
	String actionName = request.getParameter("actionName");
	//主键ID
	String tr_id = request.getParameter("tr_id");
	//人员用户ID
	String tr_usersn = request.getParameter("tr_usersn");
	//
	String windowId = request.getParameter("windowId");
	
	//类型业务
	TrainServiceIfc service = new TrainServiceImpl();
	if("insert".equals(actionName)){
		//创建日期
		bean.put("creator_time", DateUtil.getCurrentDateTime());
		//人员信息关联表ID
		bean.put("tr_usersn", tr_usersn);
	
	} else {
		bean = service.getTrainBean(tr_id);
	}
	//人员持证管理员角色
	boolean isROLE = PersonHolderUtil.isRolesUser(userId, PersonHolderConstants.ROLE_NAME);
	//部室持证管理员
	boolean isPersionRole = PersonHolderUtil.isRolesUser(userId, PersonHolderConstants.ORG_PERSIONROLE);
	
%>
<title>JGRID</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入jQuery UI -->
<script src="<%=path%>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>

<!-- 引入formvValidatetion -->
<script src="<%=path%>/ccapp/oa/resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="<%=path%>/ccapp/oa/resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
<!-- 引入其它 -->
<script src="<%=path%>/ccapp/oa/resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script src="<%=path%>/ccapp/oa/resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<!-- 公共部分引用结束 -->
<script type="text/javascript">

var windowId = "<%=windowId%>";
jQuery(document).ready(function() {
	jQuery("#form1").validationEngine();
	jQuery("#tr_title").focus();
	//专业级别
	jQuery("#tr_level option[value='<%=StringUtil.deNull(bean.get("tr_level"))%>']").attr("selected","selected");
	if("<%=StringUtil.deNull(bean.get("tr_level"))%>"=="2"){
		 jQuery("#tr_name_show").show();
		  jQuery("#tr_unit_show").show();
	}
	
});
/*
函数:  Ok
说明:  提交添加与修改来文单位
参数:   无
返回值: 无
*/
function Ok() {
	var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
		if (isFlag){
			jQuery("#hidden_action").val("addInfo");
			jQuery("#form1").attr("target","filetypeinfodoJSPhiddenFrame");
			jQuery("#form1").submit();
		}
	}
afterSubmitFn=function(result){
	try{
		if(result.indexOf("delete")!=-1){
			alert(result.split(",")[1]);
		}else{
			if(result.split(",").length>1){
					result = result.split(",");
					alert(result[0]);
					getParentWindow("windowId1").userSearch();
					removeAlertWindows("windowId1",true);
			} else {
				alert(result);
				getParentWindow("windowId1").userSearch();
				removeAlertWindows("windowId1",true);
			}
			
		}
	}catch(e){alert(e.description);}
};

function closed(){
	removeAlertWindows("windowId1",true);
}

/*
函数:  changeLevle
说明:  培训级别选择 其它项目时，显示证件名称，培训单位
参数:   无
返回值: 无
*/
function changeLevle(){
	  var tr_level =jQuery("#tr_level  option:selected").val();
	  if(tr_level=="2"){
		  jQuery("#tr_name_show").show();
		  jQuery("#tr_unit_show").show();
	  } else {
		  jQuery("#tr_name_show").hide();
		  jQuery("#tr_unit_show").hide();
	  }
}
</script>
</head>
<body style="overflow-y: hidden;">
<form id="form1" action="traininfodo.jsp" method="post">
	<input type='hidden' name='action' id="hidden_action"/>
	<input type="hidden" name="tr_id" id="tr_id" value="<%=StringUtil.deNull(bean.get("tr_id"))%>">
	<input type="hidden" name="tr_usersn" id="tr_usersn" value="<%=StringUtil.deNull(bean.get("tr_usersn"))%>">
	<!-- 表格-->
	<div id="users-contain">
		<table  width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<th class="content_02_box_div_table_th">培训级别：</th>
				<td class="content_02_box_div_table_td" >
					 <select id="tr_level"
                                  name="tr_level" size="1" class="select_100_box" style="width: 160px;" onchange="changeLevle();">
                          <option value="1">专业技术</option>
                          <option value="0">非专业</option>
                          <option value="2">其它项目</option>
                      </select>
				</td>
			</tr>
			<tr>
				<td  class="content_02_box_div_table_th"><font color="red">*</font>培训主题：</td>
				<td class="content_02_box_div_table_td">
					<input style="width:200px;height=23px" type="text" name="tr_title" class="validate[required,maxSize[100]] input_188"
					id="tr_title"
					value="<%=StringUtil.deNull(bean.get("tr_title"))%>">
				</td>
				
			</tr>
			<tr>
				<td class="content_02_box_div_table_th" class="poptableLable"><font color="red">*</font>培训内容：</td>
				<td class="content_02_box_div_table_td">
					<input style="width:90%;height=23px" type="text" name="tr_content" class="validate[required,maxSize[1000]] input_188"
					id="tr_content"
					value="<%=StringUtil.deNull(bean.get("tr_content"))%>">
				</td>
			</tr>
			<tr>
				<td class="content_02_box_div_table_th" class="poptableLable"><font color="red">*</font>培训时间：</td>
				<td class="content_02_box_div_table_td">
					<input type="text" name="tr_time" id="tr_time" 
								 class="validate[required] date_120 Wdate" style="width: 160px;height :23px;"  
									value="<%=StringUtil.deNull(bean.get("tr_time"))%>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})">
				</td>
			</tr>
			<tr>
				<td class="content_02_box_div_table_th" class="poptableLable"><font color="red">*</font>培训课时：</td>
				<td class="content_02_box_div_table_td">
					<input style="width:90%;height=23px" type="text" name="tr_hour" class="validate[required,maxSize[10],custom[positiveinteger]] input_188"
					id="tr_hour"
					value="<%=StringUtil.deNull(bean.get("tr_hour"))%>">
				</td>
			</tr>
			<tr>
				<td class="content_02_box_div_table_th" class="poptableLable"><font color="red">*</font>地点：</td>
				<td class="content_02_box_div_table_td">
					<input style="width:90%;height=23px" type="text" name="tr_address" class="validate[required,maxSize[100]] input_188"
					id="tr_address"
					value="<%=StringUtil.deNull(bean.get("tr_address"))%>">
				</td>
			</tr>
			<tr>
				<td class="content_02_box_div_table_th" class="poptableLable"><font color="red">*</font>培训费用（元）：</td>
				<td class="content_02_box_div_table_td">
					<input style="width:90%;height=23px" type="text" name="tr_money" class="validate[required,maxSize[10],custom[positiveinteger]] input_188"
					id="tr_money"
					value="<%=StringUtil.deNull(bean.get("tr_money"))%>">
				</td>
			</tr>
			<tr>
				<td class="content_02_box_div_table_th" class="poptableLable">培训成绩：</td>
				<td class="content_02_box_div_table_td">
					<textarea class="validate[maxSize[2000]]" style="width: 99%;height: 100px;" name="tr_results" id="tr_results"><%=StringUtil.deNull(bean.get("tr_results"))%></textarea>
				</td>
			</tr>
			<tr>
				<td class="content_02_box_div_table_th" class="poptableLable">考核成绩：</td>
				<td class="content_02_box_div_table_td">
					<textarea class="validate[maxSize[2000]]" style="width: 99%;height: 100px;" name="tr_assess" id="tr_assess"><%=StringUtil.deNull(bean.get("tr_assess"))%></textarea>
				</td>
			</tr>
			<tr id="tr_name_show" style="display: none;">
				<td class="content_02_box_div_table_th" class="poptableLable">证件名称：</td>
				<td class="content_02_box_div_table_td">
					<input style="width:90%;height=23px" type="text" name="tr_name" class="validate[maxSize[100]] input_188"
					id="tr_name"
					value="<%=StringUtil.deNull(bean.get("tr_name"))%>">
				</td>
			</tr>
			<tr id="tr_unit_show" style="display: none;">
				<td class="content_02_box_div_table_th" class="poptableLable">培训单位：</td>
				<td class="content_02_box_div_table_td">
					<input style="width:90%;height=23px" type="text" name="tr_unit" class="validate[maxSize[100]] input_188"
					id="tr_unit"
					value="<%=StringUtil.deNull(bean.get("tr_unit"))%>">
				</td>
			</tr>
		</table>
	</div>
	<div class="cue_box_foot">
			<input class="but_y_01" type="button" value="关闭" onclick="closed()" />
			<%if(isROLE==true || isPersionRole==true){%>
			<input class="but_y_01" type="button" id="sel"  value="保存" onclick="Ok()"/>
			<%} %>
	</div>
</form>
<iframe name="filetypeinfodoJSPhiddenFrame" width=0 height=0></iframe>
</body>
</html>