<%-- 
描述：业务类型top页面
作者：shuqi.liu
版本：1.0
日期：2013-07-30
 --%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.pubconfig.service.impl.FlowBusitypeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.pubconfig.service.FlowBusitypeServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.pubconfig.dao.FlowBusitypeDao"%>
<%@page import="com.chinacreator.xtbg.core.pubconfig.entity.FlowBusitypebean"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.security.AccessControl,com.frameworkset.common.poolman.DBUtil"%>
<%@page import="java.util.*"%>
<html>
<head>
<%
    AccessControl accesscontroler = AccessControl.getAccessControl();
    accesscontroler.checkAccess(request, response);
    String userid = accesscontroler.getUserID();
    String path = request.getContextPath();
    String busitype_code = request.getParameter("busitype_code");
    String type = request.getParameter("type");
    String openwindid = request.getParameter("operwindowid");
    String busitype_type_code = request.getParameter("busitype_type_code"); //业务类型分类编码
    FlowBusitypebean fbb = new FlowBusitypebean();
    FlowBusitypeServiceIfc fbs=new FlowBusitypeServiceImpl();
    if(!StringUtil.isBlank(busitype_code)){
		fbb=fbs.findFlowBusitypeInfoById(busitype_code);
	}
	String optType = "save";
	if(!StringUtil.isBlank(busitype_code)){
		optType = "update";
	}
	
	String sql="select busitype_type_code,busitype_type_name from OA_FLOW_BUSITYPE_TYPE ORDER BY ORDER_NO";
	String commonIdeaList = DictDropDownList.buildSelect(sql, "busitype_type_code", "", "", false, "","width:250px;height:23px;margin: 2px 0 2px;'");
%>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"  type="text/javascript"></script>
<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../resources/plug/formvalidation/jquery.validationEngine.js"  type="text/javascript" charset="utf-8"> </script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript">
jQuery(document).ready(function() {
	adaptationWH('_top','vcenter',20);
    jQuery("#is_valid").val("<%=fbb.getIs_valid() %>");
    if("update"=="<%=optType%>"){
		jQuery("#busitype_code").attr("readonly","readonly");
	}
    jQuery("#busitype_type_code").val('<%=busitype_type_code%>');
});

//保存
var saveFormBusitypeInfo = function() {
    var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
    if(!isFlag){
       return;
    }
    
    var jsonparam = "{'busitype_code':'"+$('#busitype_code').val()+"','busitype_name':'"+$("#busitype_name").val()
                    +"','type_desc':'"+$('#type_desc').val() +"','busitype_type_code':'"+$('#busitype_type_code').val()
                    +"','is_valid':'"+$('#is_valid').val()+"','busitype_order':'"+$('#busitype_order').val()+"'}";
    $("#jsonparam").val(descape(escape(jsonparam)));
    var fm = document.getElementById("form1");
    fm.action = "busitypeconfigdetaildo.jsp?openwindid=<%=openwindid%>";
    fm.target = "hiddenFrame";
    $('#form1').submit();
}

/* 保存成功后返回方法-子页面调用 */
function saveBack(){
    removeWindows('<%=openwindid%>',true);
}
//返回
function backparent(){
	   var url="flowbusitypelist.jsp?busitype_type_code=<%=busitype_type_code%>";
	   location.href=url;
	    
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>业务类型配置详细表单</title>
</head>
<body style="overflow-y: hidden;">
<form id="form1" name="form1" method="post" class="formular">
<input id="optType" name="optType" type="hidden" value="<%= optType%>"/>
<input id="jsonparam" name="jsonparam" type="hidden" />
<div class="content_02" style="overflow: hidden;">
<div class="content_02_top" style="margin-bottom: 10px;" id="_top">
	<input id="saveButton" name="saveButton" type="button" class="but_y_01" value="保存" onClick="saveFormBusitypeInfo();" /> 
	<input name="restoreButton" type="button" class="but_y_01" value="返回" onclick="backparent()"/>
</div>
<div id="vcenter" style="float: left; width: 100%; overflow: scroll; overflow-x: hidden;">
    <table width="100%" border="0" cellspacing="0" cellpadding="0"
    class="content_02_box_div_table_02">
    <tr>
        <th class="content_02_box_div_table_th"><span style="color: red">*</span>业务类型名称：</th>
        <td class="content_02_box_div_table_td">
        	<input type="text" style="width: 99%;" name="busitype_name" id="busitype_name" class="validate[required,maxSize[150]] input_185" value="<%=StringUtil.deNull(fbb.getBusitype_name())%>">
        </td>
        <th class="content_02_box_div_table_th"><span style="color: red">*</span>排序号：</th>
        <td class="content_02_box_div_table_td">
        	<input type="text" style="width: 99%;" name="busitype_order" id="busitype_order" class="validate[required,custom[onlyNumberSp],maxSize[5]] input_185" value="<%=StringUtil.deNull(fbb.getBusitype_order())%>">
        </td>
    </tr>
    <tr>
        <th class="content_02_box_div_table_th"><span style="color: red">*</span>业务类型编码：</th>
        <td class="content_02_box_div_table_td">
         <input type="text" style="width: 99%;" name="busitype_code" id="busitype_code" class="validate[required,maxSize[50]] input_185" value="<%=StringUtil.deNull(fbb.getBusitype_code())%>">
        </td>
        <th class="content_02_box_div_table_th">是否有效：</th>
        <td class="content_02_box_div_table_td"><select id="is_valid"
            style="width: 186px" name="is_valid">
            <option value="Y">是</option>
            <option value="N">否</option>
        </select> 
    </tr>
      <tr>
        <th class="content_02_box_div_table_th"><span style="color: red">*</span>业务类型分类编码：</th>
        <td class="content_02_box_div_table_td" colspan="3">
        <%=commonIdeaList %>
        </td>
    </tr>
    <tr>
        <th class="content_02_box_div_table_th">业务类型描述：</th>
        <td colspan="3" class="content_02_box_div_table_td"><textarea 
            name="type_desc" id="type_desc" class="validate[maxSize[500]] input_575 " style="width:99%;height: 80px;"><%=StringUtil.deNull(fbb.getType_desc())%></textarea>
        </td>
    </tr>
    <!-- end -->
	</table>
</div>

</div>
</form>
<iframe name="hiddenFrame" width=0 height=0 ></iframe>
</body>
</html>