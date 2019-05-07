<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	/**
	 *<p>Title:applicant.jsp</p>
	 *<p>Description:事项环节配置jsp页面</p> 
	 *<p>Company:湖南科创</p>
	 *@author 夏天
	 *@version 1.0
	 *2011-8-28
	 */
%>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String actionid = request.getParameter("action_id");
	FlowWfactionInfoBean flowWfactionInfoBean = new FlowWfactionInfoBean();
	FlowInfoDao flowInfodao = (FlowInfoDao)DaoImplClassUtil.getDaoImplClass("flowInfoDaoImpl");
	flowWfactionInfoBean = flowInfodao.findFlowWfactionInfoById(actionid);
	String type = request.getParameter("type");
%>

<%
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="com.chinacreator.xtbg.pub.flowinfoconif.entity.FlowWfactionInfoBean"%>
<%@page import="com.chinacreator.xtbg.pub.flowinfoconif.dao.FlowInfoDao"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%><html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>活动配置</title>

<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-tree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<!-- 引入formvValidatetion -->
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8">
</script>

<script type="text/javascript">
var temp="wewr";
var action_id = '<%=flowWfactionInfoBean.getAction_id()%>';
function paging(action){
	var aid;
	if(action=="btn_next"){
		aid=getParentWindow("").getmodledown();
	}else{
		aid=getParentWindow("").getmodledown();
	}
	var url="actionconfigdetail.jsp?action_id="+ aid;
	location.href = url;
}
function hiddenbtn(){
	//var did=parent.did;
	var did = getParentWindow("").did;
	//alert(did);
	var idss=getParentWindow("").idss;
	
	if(did<2){
		$("#btn_pre").hide();
	}
	if(did==idss){
		$("#btn_next").hide();
	}
}

$(function() {
	hiddenbtn();
	$( "#tabs" ).tabs(); 
});

jQuery(document).ready(function() {
	jQuery("#form1").validationEngine();
});

var init = function() {
	
	setSelectValue("LIMIT_UNIT","<%=flowWfactionInfoBean.getLimit_unit()%>");
}

var saveActionConfigInfo = function() {
	 var jsonparam = "{'action_id':'"+action_id+"','action_name':'"+$('#ACTION_NAME').val()+"',"+
		"'action_alias':'"+$('#ACTION_ALIAS').val()+"','action_limit':'"+$('#ACTION_LIMIT').val()+"',"+
		"'limit_unit':'"+$('#LIMIT_UNIT').val()+"','remark':'"+$('#REMARK').val()+"'}";

	var url = "saveactionconfigform.jsp";
	$("#jsonparam").val(descape(escape(jsonparam)));
	document.all.form1.action = url;
	document.all.form1.target = "hiddenFrame";
	$('#form1').submit();
}

var closeWin = function() {
	parent.JqueryDialog.Close();
}

</script>

</head>
<body onload="init()">
<form action="" id="form1" name="form1" method="post">

<input id="jsonparam" name="jsonparam" type="hidden"/>
<input style="DISPLAY: none" id="ACTION_CODEID" name="ACTION_CODEID" value="" class=cText_out name=Input />
<input style="DISPLAY: none" id="ACTION_ID" name="ACTION_ID" value="" class=cText_out size=12 />
<button id=button4 class="but_y_01" onclick="saveActionConfigInfo()">保存</button>
<button id=button8 class="but_y_01" onclick="removeAlertWindows('',true)">关闭</button>
<input type="button"  id="btn_pre" value="上一条" onclick="paging(this.id)" class="but_y_01" />
<input type="button" id="btn_next" value="下一条" onclick="paging(this.id)" class="but_y_01" />
 <div class="content_02_box" >
		 <div class="content_02_box_title_bg"><span>配置信息</span>
		 </div>
		 <div class="content_02_box_div">
	 <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table_02">
	 <tr >
						<th class="content_02_box_div_table_th">环节名称:</th>
						<td colspan="4" class="content_02_box_div_table_td">
						<input  id="ACTION_NAME"
							name="ACTION_NAME"
							value="<%=flowWfactionInfoBean.getAction_name() %>"
							class="input_152" readOnly  name="Input"/>
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th"><font color=red>*</font>环节别名:</th>
						<td class="content_02_box_div_table_td">
						<input id="ACTION_ALIAS" name="ACTION_ALIAS" class="input_185"
							value="<%=flowWfactionInfoBean.getAction_alias() %>" />
							 </td>
						<th class="content_02_box_div_table_th"
							title=当时限单位为工作日（以d结尾）时，活动时限须输入整数（以d结尾），例如2d。当时限单位为工作小时（以h结尾）时，活动时限须输入整数或一位小数，且小数位只能是5，例如2.5h。
							vAlign=top width="12%" align=left><font color=red>*</font>环节时限:</th>
						<td class="content_02_box_div_table_td" >
						<input id="ACTION_LIMIT"
							name="ACTION_LIMIT" value="<%=flowWfactionInfoBean.getAction_limit() %>"
							class="validate[required,custom[positiveinteger]] input_185"
							title=当时限单位为工作日（以d结尾）时，活动时限须输入整数（以d结尾），例如2d。当时限单位为工作小时（以h结尾）时，活动时限须输入整数或一位小数，且小数位只能是5，例如2.5h。/>
							
							</td>
						<td class="content_02_box_div_table_td">
						<select id="LIMIT_UNIT" name="LIMIT_UNIT" align="center" style="height: 25px;text-align:center;" >
								<option selected value=D>工作日</option>
								<option value=H>工作时</option>
							</select>
						</td>
					</tr>
					<tr>
						<th valign="top" class="content_02_box_div_table_02_th">备注:</th>
						<td colSpan="4" class="content_02_box_div_table_02_td">
						<textarea class="textarea_575"  id="REMARK" name="REMARK"   style="width:99%;height: 40px; margin:2px 0 2px; "><%=flowWfactionInfoBean.getRemark() %></textarea></td>
					</tr>
	 
	 </table>
	 </div>
	 </div>
<!--	</div>-->
<!--	</div>-->

		<table style="WIDTH: 100%;">
			<tr>
				<td>
				<div class="demo">
				<div id="tabs">
					<ul>
						<li><a href="#tabs-1">环节用户信息</a></li>
						<li><a href="#tabs-2">环节扩展信息</a></li>
						<li><a href="#tabs-3">表单配置信息</a></li>
						<li><a href="#tabs-4">环节树配置信息</a></li>
					</ul>
				  <div id="tabs-1">
				    <iframe src="actionuserinfo.jsp?actionid=<%=actionid%>&type=<%=type %>" id="frame1"  frameborder="0" width="100%" height="280"></iframe>
				  </div>
					<div id="tabs-2">
						<iframe src="actionextrainfo.jsp?actionid=<%=actionid%>" id="frame2"  frameborder="0" width="100%" height="200"></iframe>
					</div>
					<div id="tabs-3">
						<iframe src="formconfiginfo.jsp?actionid=<%=actionid%>&type=<%=type %>" id="frame3"  frameborder="0" width="100%" height="200"></iframe>
					</div>
					<div id="tabs-4">
						<iframe src="actionTreeConfig.jsp?actionid=<%=actionid%>" id="frame3"  frameborder="0" width="100%" height="200"></iframe>
					</div>
				</div>
				</div>				
				</td>
			</tr>
		</table>
	</div>
	</div>

</form>
<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>