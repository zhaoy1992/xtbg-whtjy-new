<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<%@page import="com.chinacreator.xtbg.core.process.processconfig.entity.FlowActionFormDef"%>
<%@page import="com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%><html>

<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>

<head>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String actionid = request.getParameter("actionid");
	FlowActionFormDef flowActionFormBean = new FlowActionFormDef();
	FlowInfoDao flowInfodao = (FlowInfoDao)LoadSpringContext.getApplicationContext().getBean("flowInfoDaoImpl");
	if(!StringUtil.nullOrBlank(actionid)){
		flowActionFormBean = flowInfodao.findFlowWfactionFormDefById(actionid);
	}
	String type = request.getParameter("type");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>环节表单配置</title>
<script type="text/javascript">

function saveFormConfig(){
	var url = "saveactionformconfigform.jsp";
	
	var okF = function(){
			
		params =  {jsonparam : toJasonParam()};
	$.ajax({
		url: url,
		type: 'POST',
		dataType: 'json',
		data: params,
		async : false, //是否为同步：默认是true为异步处理，false为同步处理，如果为同步处理会锁住浏览器，如果此时调试会卡死浏览器，建议调试的时候将此值设为注释掉
		success: function(data){
				alert("操作成功！");
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert("操作失败！");
		}
	});
	}
	okF();
}

function toJasonParam() {
	var jsonparam = "{'form_id':'"+$('#ACT_FM_ID').val()+"','action_id':'"+$('#actionid').val()+"',"+
	"'action_form':'"+$('#ACTION_FORM').val()+"'}";
	return descape(escape(jsonparam));
}
var init = function()
{
	var type = getParentWindow("").type;
		var typeflag = '<%=type%>'
		if(typeflag == 'flag')
		{
				$('#choose').hide();
		}
}
</script>
</head>
<body onload="init();">
<form action="" id="form1" name="form1" method="post">
<input id="jsonparam" name="jsonparam" type="hidden"/>
 <div class="content_02_box" >
		 <div class="content_02_box_title_bg"><span>配置信息</span>
		  <div class="content_02_box_add" >
		         <span id="selAreaImg" class="tabs_search_text_but">
	   				<input type="button" id="choose" name="choose" value="保存" class="but_y_01" 
	   				onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01');
	   				style="display: inline" onclick="saveFormConfig();"/>
	   				</span>
				 </div>
		 </div>
		 <div class="content_02_box_div">
<table  border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table" >
	<tr >
 <th class="content_02_box_div_table_th">表单编号:</th>
 <td class="content_02_box_div_table_td">
		<INPUT class="input_151" type="text"  value="<%=StringUtil.deNull(flowActionFormBean.getAction_form()) %>"
			id="ACTION_FORM" name="ACTION_FORM">
		<INPUT type="hidden" value="<%=StringUtil.deNull(flowActionFormBean.getForm_id()) %>"
			id="ACT_FM_ID" name="ACT_FM_ID"> 
		<INPUT type="hidden" value="<%=StringUtil.deNull(actionid) %>"
			 id="actionid" name="actionid">
			 </td>
	</tr>
</table>
</div>
</div>

</form>
</body>
</html>