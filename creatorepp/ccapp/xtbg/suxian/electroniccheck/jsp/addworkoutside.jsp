<%--
描述：专家库管理界面
作者：邱炼
版本：1.0
日期：2014-02-17
--%>
<%@page import="com.chinacreator.xtbg.tjy.review.service.ReviewUserService"%>
<%@page import="com.chinacreator.xtbg.tjy.review.service.impl.ReviewUserServiceImpl"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.security.authorization.AuthRole"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String actionName = request.getParameter("actionName");
	
	String ip = request.getHeader("x-forwarded-for");
	if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
	   ip = request.getHeader("Proxy-Client-IP");
	}
	if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
	   ip = request.getHeader("WL-Proxy-Client-IP");
	}
	if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
	   ip = request.getRemoteAddr();
	} 
	
	
	AuthRole authRoles[] = accesscontroler.getAllRoleofUser(accesscontroler.getUserAccount());
	boolean electRole = false;
	for(int i=0; i<authRoles.length;i++	){
		//【考勤管理员】角色
		if("考勤管理员".equals(authRoles[i].getRoleName())){
			electRole = true;
		}
	}
	//当前机构ID
	String orgId = accesscontroler.getChargeOrgId();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>外勤打卡管理</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 引入jQuery_dialog -->
<script src="../../../resources/plug/jquery_dialog/jquery_dialog.js"></script>
<!-- 引入公共JS -->
<!-- 引入formvValidatetion -->
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="UTF-8"></script>
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="UTF-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery("#form1").validationEngine();
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
		var okF = function(){
			jQuery("#hidden_action").val("addoutsideInfo");
			jQuery("#form1").submit();
		}
		var p={
				headerText:'提示',
				okName:'确认',
		        okFunction:okF,
		        cancelName:'取消'
		};
	    alert("确认给以上人员登记外勤记录吗？",p);
	}
}

function closed(){
	removeWindows('',true);
}

/**
 * 选取人员
 */
var chooseReportUnits = function(){
	var s = new $.z_tree();
	  s.treeID='mian';
	  s.treetypestr="checkbox";
	  s.ischekc="false";
	  s.isShowSeacher=true;
	  s.treeName="选取人员";
	  s.headerName="选取人员";
	  <%if(electRole==false){%>
	 	 s.type="APERSON";
	  <%}else{%>
		s.type="{'type':'tree_tjy_workside'}";
	  	s.orgID="<%=orgId%>";
	  <%}%>
	  s.selectedIds=$('#outside_userid').val();
	  s.returnFunction=function(orgObj){
		 $('#outside_userid').val(orgObj.id);
	  	 $('#outside_name').val(orgObj.name);
	  }
  	 s.init();
	  
}	
</script>
<body style="overflow-y:hidden;">
	<form id="form1" action="addorupdateworktimedo.jsp" method="post"  >
		<input type="hidden" name="outside_userid" id="outside_userid" value="">
		<input type='hidden' name='action' id="hidden_action"/>
		<input type='hidden' name='outsideIP' id="outsideIP" value="<%=StringUtil.deNull(ip) %>"/>
		<input type="hidden" name="windowsId" id="windowsId" value='<%=StringUtil.deNull(request.getParameter("windowsId"))%>'/>
		<div id="users-contain">
			<table  width="100%" border="0" cellspacing="0" cellpadding="0" >
					<tr>
						<th class="content_02_box_div_table_th"><font color="red">*</font>出勤人员：</th>
						<td class="content_02_box_div_table_td">
							<textarea name="outside_name" id="outside_name" class="validate[required,maxSize[50]]" cols="32" rows="6" onclick="chooseReportUnits()"></textarea>
							<input name="" type="button" value="" style="float: right;margin-right: 28px;"   class="but_x" onclick="chooseReportUnits()"/>
						</td>
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th"><font color="red">*</font>出勤日期：</td>
						<td class="content_02_box_div_table_td">
							<input class="validate[required] date_120 Wdate" type="text"
								id="datetime" name="datetime" 
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="height:23px;width: 160px"/>
						</td>
						
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th">打卡IP：</td>
						<td class="content_02_box_div_table_td">
							<%=StringUtil.deNull(ip)%>
						</td>
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th">出勤详细信息：</td>
						<td class="content_02_box_div_table_td">
							<textarea name="details" id="details" class="validate[required,maxSize[1500]]" cols="32" rows="5" ></textarea>
						</td>
					</tr>
					
			</table>
		</div>
		
		<div class="cue_box_foot">
			<input class="but_y_01" type="button" value="返回" onclick="removeAlertWindows('',true)" />
			<input class="but_y_01" type="button" id="sel"  value="完成" onclick="Ok()"/>
		</div>
		
	</form>
	
	<iframe name="filetypeinfodoJSPhiddenFrame" width=0 height=0></iframe>
</body>
</html>