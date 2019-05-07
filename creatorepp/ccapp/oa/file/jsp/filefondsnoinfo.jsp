<%-- 
描述：档案全宗号基本信息
作者：肖杰
版本：1.0
日期：2013-07-12
 --%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileFondsnoServicImpl"%>
<%@page import="com.chinacreator.xtbg.core.file.service.FileFondsnoServiceIfc"%>
<%@page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<head>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String curUserId =  accesscontroler.getUserID();
	String curUserName =  accesscontroler.getUserName();
	UserCacheBean usercachebean=UserCache.getUserCacheBean(curUserId);
	String subid = request.getParameter("subid");
	String path = request.getContextPath();//服务器根路径
	String f_fonds_id = request.getParameter("f_fonds_id");
	String f_fondsno_name="";
	String f_fondsno="";
	String f_org_id=usercachebean.getUnit_id();
	String f_org_name=usercachebean.getUnit_name();
	String f_fonds_order="";
	String f_fonds_remark="";
	Map<String, String> viewMap = new HashMap<String, String>();
	FileFondsnoServiceIfc fileFondsnoServiceIfc=new FileFondsnoServicImpl();
	if(!StringUtil.isBlank(f_fonds_id)){
		viewMap=fileFondsnoServiceIfc.getFileFondsnoBean(f_fonds_id);
		f_fondsno_name = StringUtil.deNull(viewMap.get("f_fondsno_name"));
		f_fondsno = StringUtil.deNull(viewMap.get("f_fondsno"));
		f_org_id = StringUtil.deNull(viewMap.get("f_org_id"));
		f_org_name = StringUtil.deNull(viewMap.get("f_org_name"));
		f_fonds_order = StringUtil.deNull(viewMap.get("f_fonds_order"));
		f_fonds_remark = StringUtil.deNull(viewMap.get("f_fonds_remark"));
	}
	
	
	
%>
<title>档案全宗号基本信息</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入formvValidatetion -->
<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" ></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>

<script type="text/javascript">

var path = '<%=path %>';

var subid = '<%=subid %>';

/*
函数:  addFileFondsno
说明:  添加
参数:   无
返回值: 无
*/
var addFileFondsno = function() {
	if(!jQuery('#form1').validationEngine('validate')){
		return;
	}
	jQuery("#action").val("addFileFondsno");
	var okF = function(){
		document.all.form1.target = "hiddenFrame";
		jQuery("#form1").submit();
	}
	 var p={
		headerText:'提示',
		okName:'确认',
	    okFunction:okF,
	    cancelName:'取消'
	};
	alert('确定添加吗？',p);

}
/*
函数:  updateFileFondsno
说明:  修改
参数:   无
返回值: 无
*/
var updateFileFondsno = function() {
	if(!jQuery('#form1').validationEngine('validate')){
		return;
	}
	
	jQuery("#action").val("updateFileFondsno");
	var okF = function(){
		document.all.form1.target = "hiddenFrame";
		jQuery("#form1").submit();
	}
	 var p={
		headerText:'提示',
		okName:'确认',
	    okFunction:okF,
	    cancelName:'取消'
	};
	alert('确定修改吗？',p);

}


/*
函数:  back
说明:  返回列表
参数:   无
返回值: 无
*/
function back(){
	removeWindows(subid,true);
		
}
/*
函数:  chooseDept
说明:  弹出部门树
参数:   无
返回值: 无
*/
function chooseDept() {
	var s = new jQuery.z_tree();
    s.treeID = 'mianOrgid';
    s.treetypestr = 'radio';
    s.isShowSeacher = true;
    s.treeName = "选取部门";
    s.headerName = "选取部门";
    s.isType='dept';
    s.valueKey='dept';
    s.item_id = 'org_id';
    s.type = "AORG";
	s.selectIds=jQuery('#f_org_id').val();
	s.returnFunction=function(orgObj){
		if(!IsSpace(orgObj)){
			jQuery('#f_org_id').val(orgObj.id);
			jQuery('#f_org_name').val(orgObj.name);
		}else{
			jQuery('#f_org_id').val("");
					jQuery('#f_org_name').val("");
			}
		}
		s.init();
}
</script>

</head>
<body style="overflow-y: hidden;" onload="adaptationWH('_top','vcenter',40)">
<form id="form1" action="filefondsnodo.jsp?subid=<%=subid %>" method="post">
<input type="hidden" name="action" id="action"   />
<input type="hidden" name="f_org_name" id="f_org_name"  value="<%=usercachebean.getUnit_name() %>" />
<input type="hidden" name="f_dept_id" id="f_dept_id"  value="<%=usercachebean.getOrg_id()%>" />
<input type="hidden" name="f_dept_name" id="f_dept_name"  value="<%=usercachebean.getOrg_name() %>" />

<!-- 操作-->
<div class="content_02" style="overflow: hidden;" id="_top">
	<div class="content_02_top" style="margin-bottom: 10px;">
		<% if(StringUtil.isBlank(f_fonds_id)){%>
		<input name="fbbt" id="fbbt" value="添加" onclick="addFileFondsno();"  type="button" class="but_y_01" /> 
		<% }else{%>
		<input name="fbbt" id="fbbt" value="修改" onclick="updateFileFondsno();"  type="button" class="but_y_01" />
		<% }%>
		<input name="" value="返回" onclick="back()" type="button" class="but_y_01" />
	</div>
</div>
<!-- 操作-->

<!-- 表格-->
<div id="vcenter" style="float: left; width: 100%; overflow: scroll" scrolling="yes">
	<div style="float: left; width: 775px;">
	
		<div class="content_02_box">
			<div class="content_02_box_title_bg"><span>基本信息</span></div>
			<div class="content_02_box_div">
				<table border="0" cellspacing="0" cellpadding="0"
					class="content_02_box_div_table">
					<tr>
						<th class="content_02_box_div_table_th"><font style="COLOR: red">*</font>全宗号名称：</th>
						<td class="content_02_box_div_table_td">
							<input type="hidden" name="f_fonds_id" id="f_fonds_id"  value="<%=f_fonds_id %>" />
							<input  class="validate[required,maxSize[100]] input_188" name="f_fondsno_name" id="f_fondsno_name" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()"  value="<%=f_fondsno_name %>" />
						</td>
						<th class="content_02_box_div_table_th"><font style="COLOR: red">*</font>全宗号：</th>
						<td class="content_02_box_div_table_td" width="192px">
							<input  class="validate[required,maxSize[40]] input_188" name="f_fondsno" id="f_fondsno" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" value="<%=f_fondsno %>" />
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th">所属单位名称：</th>
						<td class="content_02_box_div_table_td">
							<input type="hidden" name="f_org_id" id="f_org_id"  value="<%=f_org_id %>" />
							<input disabled="disabled" class="validate[maxSize[100]] input_188" name="f_org_name" id="f_org_name" value="<%=f_org_name %>" />
						</td>
						<th class="content_02_box_div_table_th">排序号：</th>
						<td class="content_02_box_div_table_td" width="192px">
							<input  class="validate[custom[number]] input_188" name="f_fonds_order" id="f_fonds_order" value="<%=f_fonds_order %>" />
						</td>
					</tr>
					<tr>
						<th width="212" valign="top" class="content_02_box_div_table_02_th">备注：</th>
						<td colspan="3" class="content_02_box_div_table_02_td">
						<textarea class="validate[maxSize[50]] textarea_575" style="width:99%" name="f_fonds_remark" id="f_fonds_remark" value="" ><%=f_fonds_remark %></textarea>
							
						</td>
					</tr>
				</table>
			</div>
		</div>
	
	
	</div>
</div>

</form>

<iframe name="hiddenFrame" width="0" height="0"></iframe>

</body>
</html>