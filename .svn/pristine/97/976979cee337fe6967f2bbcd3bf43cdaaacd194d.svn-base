<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page
	import="com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%>

<%@page
	import="com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page
	import="com.chinacreator.xtbg.core.common.tree.entity.FlowActionTreeConfigBean"%><html>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);

	String actionid = request.getParameter("actionid");
	FlowActionTreeConfigBean flowActionTreeConfigBean = new FlowActionTreeConfigBean();
	FlowInfoDao flowInfodao = (FlowInfoDao) LoadSpringContext.getApplicationContext().getBean("flowInfoDaoImpl");
	if (!StringUtil.nullOrBlank(actionid)) {
		flowActionTreeConfigBean = flowInfodao.findFlowWfactionTreeConfigById(actionid);
	}
	String tree_role = "allPeople";
	String tree_nodetype = "checkbox";
	String config_id = "";
	if(flowActionTreeConfigBean != null ){
		tree_role = flowActionTreeConfigBean.getTree_role();
		tree_nodetype = flowActionTreeConfigBean.getTree_nodetype();
		config_id = flowActionTreeConfigBean.getConfig_id();
	}
%>

<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<script src="../../../resources/plug/jquery_dialog/jquery_dialog.js"></script>
<!-- 引入其它 -->
<script src="../../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>环节树配置信息</title>
<script type="text/javascript">
var action_id = '<%=actionid%>';

var init = function() {
        $("input[name=tree_role][value=<%=tree_role%>]").attr("checked",'checked');
        $("input[name=tree_nodetype][value=<%=tree_nodetype%>]").attr("checked",'checked');
}

function saveActionTreeConfigInfo(){
    var url = "saveactionTreeConfigform.jsp";
    document.all.form1.action = url;
    document.all.form1.target = "hiddenFrame";
    document.all.form1.submit();
}

</script>
</head>
<body onload="init()">
<form id=form1 name=form1 method="post">
 <input type=hidden value="<%=config_id%>" id="config_id" name="config_id" /> 
 <input type=hidden value="<%=actionid%>" id="action_id" name="action_id" />
 <input id="jsonparam" name="jsonparam" type="hidden" />
<div class="content_02_box">
<div class="content_02_box_title_bg"><span>配置信息</span>
<div class="content_02_box_add"><span id="selAreaImg"
	class="tabs_search_text_but"> <input type="button" id="choose"
	name="choose" value="保存" class="but_y_01"
	onMouseOver="$(this).attr(
	'class','but_y_02');" onMouseOut="$(this).attr(
	'class','but_y_01');"
                    style="display: inline"
	onclick="saveActionTreeConfigInfo();" /> </span></div>
</div>
<div class="content_02_box_div">
<TABLE id=actexttab class="content_box_text myTable">
	<TR>
		<TH class="content_02_box_div_table_th" width="100" title="动态选择人员树的权限">人员树的权限</TH>
		<TD class="content_02_box_div_table_td" width="300" style="lign-height:25px">所有人员:<input type="radio"
			name="tree_role" value="allPeople" checked="checked">
			<br/> 配置人员:<input
			type="radio" name="tree_role" value="configPeople"></TD>
		<TH class="content_02_box_div_table_th" width="100" title="动态选择人员树的节点勾选类型">人员树的节点勾选类型</TH>
		<TD class="content_02_box_div_table_td" width="300">复选框:<input type="radio"
			name="tree_nodetype" value="checkbox" checked="checked"> 
			<br/>单选框:<input
			type="radio" name="tree_nodetype" value="radio"></TD>
	</TR>

</TABLE>
</div>
</div>
</form>
<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>