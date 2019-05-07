<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.form.service.Formservice"%>
<%@page import="com.chinacreator.xtbg.core.form.service.impl.FormserviceImpl"%>
<%@page import="com.chinacreator.xtbg.core.form.entity.OaFormConfigBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.*"%>

<html>
<head>
<%
    AccessControl accesscontroler = AccessControl.getAccessControl();
    accesscontroler.checkAccess(request, response);
    String form_id = request.getParameter("form_id");
    Formservice formservice = new FormserviceImpl();
    OaFormConfigBean oaFormConfigBean = formservice.queryFormConfigInfo(form_id);
    String action = "save";
    if(oaFormConfigBean != null){
    	action = "update";
    }
    
%>
<!-- 引入jQuery -->
<script type="text/javascript" src="../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<script src="../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<script src="../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
<script src="../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript"  src="../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript">
jQuery(document).ready(function() {
    jQuery("#formForm").validationEngine();
});

var saveFormInfo = function() {
    var isFlag = jQuery('#formForm').validationEngine('validate'); //是否全部验证通过
    if(!isFlag){
       return;
    }
    var form_width = parseInt($('#form_width').val());
    var tag_width  = parseInt($('#tag_width').val());
    var tag_margins  = parseFloat($('#tag_margins').val())*2;
    
    if(((form_width-tag_margins)%(tag_width+tag_margins))!= 0){
    	var colnum =  parseInt((form_width-tag_margins)/(tag_width+tag_margins))
    	alert("表单宽度跟最小元素宽度将不能生成正确的表单布局，建议宽度"+(((colnum-1)*tag_width)+ (colnum-1+1)*tag_margins)+","+((colnum*tag_width)+ (colnum+1)*tag_margins)+","+(((colnum+1)*tag_width)+ ((colnum+1+1)*tag_margins)) );
    	$('#form_width').focus();
    	return;
    }
    if(form_width-1%(tag_width+1)){
    	
    }
    
    var paramJson = "{'form_id':'<%=form_id%>','form_name':'"+$("#form_name").val()+"',"+
                    "'form_jsp_name':'"+$('#form_jsp_name').val()
                    +"','form_background':'"+$('#form_background').val()
                    +"','form_width':'"+$('#form_width').val()
                    +"','tag_width':'"+$('#tag_width').val()
                    +"','tag_height':'"+$('#tag_height').val()
                    //+"','is_text':'"+$('#is_text').val()
                    +"','tag_margins':'"+$('#tag_margins').val()+"'}";
    jQuery("#paramJson").val(descape(escape(paramJson)));
    var fm = document.getElementById("formForm");
    //jQuery('#action').val("save");
    //document.all.formForm.action = "formconfigdetaildo.jsp";
    document.all.formForm.target = "hiddenFrame";
    jQuery('#formForm').submit();
}

function backparent(){
     var url="formconfiglist.jsp";
     location.href=url;
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>流程信息配置详细表单</title>
</head>
<body  style="overflow-y: hidden;">
<form id="formForm" name="formForm" action = "formconfigdetaildo.jsp" method="post"  class="formular">
<div class="content_02" style="overflow: hidden;">
<div class="content_02_top" style="margin-bottom: 10px;" id="_top">
	<input id="saveButton" name="saveButton" type="button" class="but_y_01" value="保存" onClick="saveFormInfo();" /> 
    <input name="restoreButton" type="button" class="but_y_01" value="返回" onclick="backparent()" /></div>
<div id="vcenter"
    style="float: left; width: 100%; overflow: scroll; overflow-x: hidden;">
<div style="float: left; width: 775px;">
<div class="content_02_box" style="overflow: hidden;">
<div class="content_02_box_title_bg"><span>表单基本配置</span><span style="color: red">（此处定义表单的基本元素，单元格是表单的最小单位）</span></div>
<div class="content_02_box_div">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
    class="content_02_box_div_table_02">
    <tr>
        <th class="content_02_box_div_table_th"><span style="color: red">*</span>表单名称</th>
        <td class="content_02_box_div_table_td"><input type="text"
            name="form_name" id=form_name class="validate[required,maxSize[100]] input_185"
            value="<%=oaFormConfigBean==null?"":StringUtil.deNull(oaFormConfigBean.getForm_name()) %>">
        </td>
        <th class="content_02_box_div_table_th"><span style="color: red">*</span>表单JSP名称</th>
        <td class="content_02_box_div_table_td"><input type="text"
            name="form_jsp_name" id="form_jsp_name" class="validate[required,maxSize[100]] input_185"
            value="<%=oaFormConfigBean==null?"":StringUtil.deNull(oaFormConfigBean.getForm_jsp_name()) %>">
        </td>
    </tr>
    <tr>
        <th class="content_02_box_div_table_th"><span style="color: red">*</span>表单边框颜色</th>
        <td class="content_02_box_div_table_td">
          <select id="form_background" style="width: 186px" name="form_background">
              <option value="red" <%if(oaFormConfigBean!=null){if("red".equals(oaFormConfigBean.getForm_background())){%> selected="selected"  <%}} %>>红色</option>
              <option value="black" <%if(oaFormConfigBean!=null){if("black".equals(oaFormConfigBean.getForm_background())){%> selected="selected"  <%}} %>>黑色</option>
       	 </select>
        </td>
        <th class="content_02_box_div_table_th"><span style="color: red">*</span>单元格间隔PX</th>
        <td class="content_02_box_div_table_td">
            <select id="tag_margins" style="width: 186px" name="tag_margins">
              <option value="0.5" <%if(oaFormConfigBean!=null){if("0.5".equals(oaFormConfigBean.getTag_margins())){%> selected="selected"  <%}} %>>0.5PX </option>
              <option value="1" <%if(oaFormConfigBean!=null){if("1".equals(oaFormConfigBean.getTag_margins())){%> selected="selected"  <%}} %>>1PX</option>
              <option value="2" <%if(oaFormConfigBean!=null){if("2".equals(oaFormConfigBean.getTag_margins())){%> selected="selected"  <%}} %>>2px</option>
       	 	</select>
        </td>
    </tr>
    <tr>
        <th class="content_02_box_div_table_th"><span style="color: red">*</span>最小单元格宽度（PX）</th>
        <td class="content_02_box_div_table_td"><input type="text"
            name="tag_width" id="tag_width" class="validate[required,maxSize[100],custom[positiveinteger]] input_185"
            value="<%=oaFormConfigBean==null?"30":StringUtil.deNull(oaFormConfigBean.getTag_width()) %>">
        </td>
        <th class="content_02_box_div_table_th"><span style="color: red">*</span>最小单元格高度（PX）</th>
        <td class="content_02_box_div_table_td"><input type="text"
            name="tag_height" id="tag_height" class="validate[required,maxSize[100],custom[positiveinteger]] input_185"
            value="<%=oaFormConfigBean==null?"30":StringUtil.deNull(oaFormConfigBean.getTag_height()) %>">
        </td>
    </tr>

    <tr>
    	<th class="content_02_box_div_table_th" title="此处的值必须是（最小单元格宽度*X+(X+1)的值）"><span style="color: red">*</span>表单总宽度</th>
        <td class="content_02_box_div_table_td"><input type="text"
            name=""form_width"" id="form_width" class="validate[required,maxSize[100],custom[positiveinteger]] input_185"
            value="<%=oaFormConfigBean==null?"931":StringUtil.deNull(oaFormConfigBean.getForm_width()) %>">
        </td>
    </tr>
</table>
</div>
</div>

<!-- 查询列表区 --></div>
<p>&nbsp;</p>
<input id="paramJson" name="paramJson" type="hidden" value="" /></div>
<input id=action name="action" type="hidden" value="<%=action %>"/></div>

</div>
</div>
</form>
<iframe name="hiddenFrame" width=0 height=0 />
</body>
</html>