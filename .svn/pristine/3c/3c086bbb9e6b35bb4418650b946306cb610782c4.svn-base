<%--
　　描述：设置活动环节权限功能操作页面
　　作者：黄海
　　版本：1.0
　　日期：2013-05-28
--%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%>
<%@ page import="java.util.List"%>
<%@ page import="com.alibaba.fastjson.JSONObject"%>
<%@ page import="com.chinacreator.xtbg.core.common.util.DataControlUtil"%>
<%@ page import="com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao"%>
<%@ page import="com.chinacreator.xtbg.core.process.processconfig.entity.ActColStatusBean"%>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String actionId = request.getParameter("actionId");//活动id
String bussinessType = request.getParameter("bussinessType");//业务类型
//特检院OA 中文乱码问题
String action_name = DataControlUtil.pageUnEscape(StringUtil.deNull(request.getParameter("action_name")));//活动名称
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></meta>
<title>配置流程活动表单元素状态</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-tree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript">
/*
	函数:  convertTo01
	说明:  选择框checked属性为true时返回1，否则 返回0
	作者：  黄海
	日期： 2013-05-29
	参数:  obj 选择框对象
	返回值: 1或0
*/
var convertTo01 = function(obj){
	if (obj.attr("checked")){
		return 1;
	}
	return 0;
}


var checkedall = function(obj){
	if(jQuery("#"+obj.id+"").attr("checked")=="checked"){
		jQuery("[name="+obj.id+"]").attr("checked","checked");
	}else{
		jQuery("[name="+obj.id+"]").removeAttr("checked");
	}
}
/*
	函数:  saveActColStatusForm
	说明:  提交组装好的json格式的表单数据至后台
	作者：  黄海
	日期：  2013-05-29
	参数:  无
	返回值: 相关alert提示
*/
var saveActColStatusForm = function(){
	var url = "saveactcolstatusform.jsp";
	var asynFunc = function(){
		var iRecordCount=$("#iRecordCount").val();
		if (iRecordCount<=0){
			return;
		}
		var tableId = $("#table_id_"+iRecordCount).val();
		var tableCode = $("#table_code_"+iRecordCount).val()
		var actionId = $("#actionId").val();
		var sJson = "";
		for(var i=1;i<=iRecordCount;i++){
			sJson+="{"+
				        "'id':'"+$("#id_"+i).val()+"',"+
				        "'action_id':'"+actionId+"',"+
				        "'table_id':'"+tableId+"',"+
				        "'table_code':'"+tableCode+"',"+
				        "'column_id':'"+$("#column_id_"+i).val()+"',"+
				        "'column_code':'"+$("#column_code_"+i).val()+"',"+
				        "'readonly':'"+convertTo01($("#readonly_"+i))+"',"+
				        "'hidden':'"  +convertTo01($("#hidden_"  +i))+"',"+
				        "'disable':'" +convertTo01($("#disable_" +i))+"'," +
				        "'required':'" +convertTo01($("#required_" +i))+"'" +
					"},";
		}
		sJson = "["+sJson.substr(0,sJson.length-1)+"]";//去掉最后一个逗号，再加上[]组装成标准的对象数组
		var params =  {jsonparam : descape(escape(sJson))};
		$.ajax({
			url: url,
			type: 'POST',
			dataType: 'json',
			data: params,
			async : false, 
			success: function(data){
				alert("操作成功");
				window.location.reload();
			},
			error: function(jqXHR, textStatus, errorThrown){
				alert("操作失败!");
				window.location.reload();
			}
		});
	}
	asynFunc();
}

</script>

</head>
<body  style ="overflow-y:scroll;">
<div height="25">&nbsp;</div>
<div>
	<button id=button4 class="but_y_01" onclick="saveActColStatusForm()">保存</button>
	<button id=button8 class="but_y_01" onclick="removeAlertWindows('',true)">关闭</button>
</div>
<form action="" id="form1" name="form1" method="post">
<input type="hidden" id="actionId" value=<%=actionId %> />
<div class="content_02_box" >
	 <div class="content_02_box_title_bg"><span>活动名称：<%=action_name%></span>
	 </div>
	 <div class="content_02_box_div" >
		 <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table_02">
			 <tr >
				<th class="content_02_box_div_table_th" style='text-align: center;'>字段名称</th>
				<th class="content_02_box_div_table_th" style='text-align: center;'>是否只读&nbsp;<span style="vertical-align:-5%"><input type="checkbox" id="readonly" onclick="checkedall(this)"  /></span></th>
				<th class="content_02_box_div_table_th" style='text-align: center; '>是否隐藏&nbsp;<span style="vertical-align:-5%"><input type="checkbox" id="hidden"  onclick="checkedall(this)" /></span></th>
				<th class="content_02_box_div_table_th" style='text-align: center;'>是否禁用&nbsp;<span style="vertical-align:-5%"><input type="checkbox" id="disable" onclick="checkedall(this)"  /></span></th>
				<th class="content_02_box_div_table_th" style='text-align: center;'>是否必选&nbsp;<span style="vertical-align:-5%"><input type="checkbox" id="required"  onclick="checkedall(this)" /></span></th>
			 </tr>
			 <%
			 FlowInfoDao fInfodao = (FlowInfoDao)LoadSpringContext.getApplicationContext().getBean("flowInfoDaoImpl");
			 List<ActColStatusBean> list = fInfodao.findActColStatusList(bussinessType,actionId);
			 int i=0;
			 for (ActColStatusBean model : list) {
				 i++;
			 %>
			 	 <input type="hidden" id="id_<%=i%>"           value="<%=model.getId()%>" >
			 	 <input type="hidden" id="column_id_<%=i%>"    value="<%=model.getColumn_id()%>" >
			 	 <input type="hidden" id="column_code_<%=i%>"  value="<%=model.getColumn_code()%>" >
			 	 <input type="hidden" id="table_id_<%=i%>"     value="<%=model.getTable_id()%>" >
			 	 <input type="hidden" id="table_code_<%=i%>"   value="<%=model.getTable_code()%>" >
				 <tr >
					<td class="content_02_box_div_table_td" style="text-align: center;"><%=model.getColumn_name() %></td>
					<td class="content_02_box_div_table_td" style="text-align: center;"><input type="checkbox" name="readonly" id="readonly_<%=i%>"  value="<%=model.getReadonly()%>" <%=model.getCkd1()%>  /></td>
					<td class="content_02_box_div_table_td" style="text-align: center;"><input type="checkbox" name="hidden" id="hidden_<%=i%>"    value="<%=model.getHidden()%>"   <%=model.getCkd2()%>  /></td>
					<td class="content_02_box_div_table_td" style="text-align: center;"><input type="checkbox" name="disable" id="disable_<%=i%>"   value="<%=model.getDisable()%>"  <%=model.getCkd3()%>  /></td>
					<td class="content_02_box_div_table_td" style="text-align: center;"><input type="checkbox" name="required" id="required_<%=i%>"   value="<%=model.getRequired()%>"  <%=model.getCkd4()%>  /></td>
				 </tr>
			 <%	 
			 }
			 %>
			 <input type="hidden" name="iRecordCount" id="iRecordCount" value="<%=list.size() %>" />
		 </table>
	 </div>
	 <div class="content_02_box_title_bg"></span>
	 </div>
</div>
<p>
    &nbsp;&nbsp;&nbsp;&nbsp;
</p>
</form>

</body>
</html>