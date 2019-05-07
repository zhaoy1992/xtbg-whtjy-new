<%-- 
描述：档案存放位置基本信息
作者：肖杰
版本：1.0
日期：2013-07-15
 --%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.core.kbm.util.KbmUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileStorageLocationServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.file.service.FileStorageLocationServiceIfc"%>
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
	Object treeNode = StringUtil.deNull(request.getParameter("treeNode"));
	String orgid = StringUtil.deNull(request.getParameter("orgid"));
	String orgname = StringUtil.deNull(request.getParameter("name"));
	String f_storage_id = request.getParameter("f_storage_id");
	String f_storage_shotname="";
	String f_storage_fullname="";
	String f_org_id=usercachebean.getUnit_id();
	String f_org_name=usercachebean.getUnit_name();
	String f_perant_id="";
	
	//得到排序号
	String sql="SELECT NVL(MAX(F_ORDER_NUM),0) FROM OA_FILE_STORAGE_LOCATION";
	String f_order_num=(Integer.parseInt(DaoUtil.sqlToField(sql))+1)+"";
	String f_remark="";
	String f_user_id=curUserId;
	String f_user_name=curUserName;
	String f_storage_urlname="";
	String f_creator_time= StringUtil.convertTimeToString(new Timestamp(System.currentTimeMillis()), "");
	Map<String, String> viewMap = new HashMap<String, String>();
	FileStorageLocationServiceIfc fileStorageLocationServiceIfc=new FileStorageLocationServiceImpl();
	if(!StringUtil.isBlank(f_storage_id)){
		viewMap=fileStorageLocationServiceIfc.getFileStorangeLocationBean(f_storage_id);
		f_storage_shotname = StringUtil.deNull(viewMap.get("f_storage_shotname"));
		f_storage_fullname = StringUtil.deNull(viewMap.get("f_storage_fullname"));
		f_org_id = StringUtil.deNull(viewMap.get("f_org_id"));
		f_org_name = StringUtil.deNull(viewMap.get("f_org_name"));
		f_perant_id = StringUtil.deNull(viewMap.get("f_perant_id"));
		f_order_num = StringUtil.deNull(viewMap.get("f_order_num"));
		f_remark = StringUtil.deNull(viewMap.get("f_remark"));
		f_user_id = StringUtil.deNull(viewMap.get("f_user_id"));
		f_user_name = StringUtil.deNull(viewMap.get("f_user_name"));
		f_creator_time = StringUtil.deNull(viewMap.get("f_creator_time"));
		f_storage_urlname=StringUtil.deNull(viewMap.get("f_storage_urlname"));
	}
	String f_perant_name="";
	if(!StringUtil.isBlank(f_perant_id)){
		viewMap=fileStorageLocationServiceIfc.getFileStorangeLocationBean(f_perant_id);
		f_perant_name= StringUtil.deNull(viewMap.get("f_storage_shotname"));
	}
	if(StringUtil.isBlank(orgid)){
		orgid="0";
		viewMap=fileStorageLocationServiceIfc.getFileStorangeLocationBean(orgid);
		orgname= StringUtil.deNull(viewMap.get("f_storage_shotname"));
	}

	
%>
<title>档案存放位置基本信息</title>
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
函数:  addFileStorage
说明:  添加
参数:   无
返回值: 无
*/
var addFileStorage = function() {
	if(!jQuery('#form1').validationEngine('validate')){
		return;
	}
		
	jQuery("#action").val("addFileStorage");
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
函数:  updateFileStorage
说明:  修改
参数:   无
返回值: 无
*/
var updateFileStorage = function() {
	if(!jQuery('#form1').validationEngine('validate')){
		return;
	}
	jQuery("#action").val("updateFileStorage");
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

</script>

</head>
<body style="overflow-y: hidden;" onload="adaptationWH('_top','vcenter',40)">
<form id="form1" action="filestoragelocationdo.jsp?subid=<%=subid %>" method="post">
<input type="hidden" name="action" id="action"   />
<input type="hidden" name="f_org_name" id="f_org_name"  value="<%=f_org_name %>" />
<input type="hidden" name="f_user_name" id="f_user_name" value="<%=f_user_name %> " />
<input type="hidden" name="f_creator_time" id="f_creator_time"  value="<%=f_creator_time %> "/>
<input type="hidden" name="treeNode" id="treeNode" value="<%=treeNode %>"  />
<input type="hidden" name="f_storage_urlname" id="f_storage_urlname" value="<%=f_storage_urlname %>"  />
<input type="hidden" name="f_dept_id" id="f_dept_id"  value="<%=usercachebean.getOrg_id() %>" />
<input type="hidden" name="f_dept_name" id="f_dept_name"  value="<%=usercachebean.getOrg_name() %>" />

<!-- 操作-->
<div class="content_02" style="overflow: hidden;" id="_top">
	<div class="content_02_top" style="margin-bottom: 10px;">
		<% if(StringUtil.isBlank(f_storage_id)){%>
		<input name="fbbt" id="fbbt" value="添加" onclick="addFileStorage();"  type="button" class="but_y_01" /> 
		<% }else{%>
		<input name="fbbt" id="fbbt" value="修改" onclick="updateFileStorage();"  type="button" class="but_y_01" />
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
						<th class="content_02_box_div_table_th"><font style="COLOR: red">*</font>档案位置简称：</th>
						<td class="content_02_box_div_table_td">
							<input type="hidden" name="f_storage_id" id="f_storage_id"  value="<%=f_storage_id %>" />
							<input  class="validate[required,maxSize[100]] input_188" name="f_storage_shotname" id="f_storage_shotname" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()"  value="<%=f_storage_shotname %>" />
						</td>
						<th class="content_02_box_div_table_th">所属上级位置：</th>
						<td class="content_02_box_div_table_td" width="192px">
						<%if(StringUtil.isBlank(f_perant_id) && !"0".equals(f_storage_id)){ %>
							<input type="hidden" class=" input_188" name="f_perant_id" id="f_perant_id" value="<%=orgid %>" />
							<input disabled="disabled" class="validate[maxSize[40]] input_188" name="orgname" id="orgname" value="<%=orgname %>" />
						<%}else{ %>
							<input type="hidden" class=" input_188" name="f_perant_id" id="f_perant_id" value="<%=f_perant_id %>" />
							<input disabled="disabled" class="validate[maxSize[40]] input_188" name="orgname" id="orgname" value="<%=f_perant_name %>" />
						<%} %>
						</td>
					</tr>
					<tr>
						<th width="212" valign="top" class="content_02_box_div_table_02_th"><font style="COLOR: red">*</font>档案位置全称：</th>
						<td colspan="3" class="content_02_box_div_table_02_td">
						<input  class="validate[required,maxSize[100]] input_188" name="f_storage_fullname" id="f_storage_fullname" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()"  value="<%=f_storage_fullname %>" />
							
						</td>
					</tr>
					<tr>
						<th width="212" valign="top" class="content_02_box_div_table_02_th">备注：</th>
						<td colspan="3" class="content_02_box_div_table_02_td">
						<textarea class="validate[maxSize[50]] textarea_575" style="width:99%" name="f_remark" id="f_remark" value="" ><%=f_remark %></textarea>
							
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th"><font style="COLOR: red">*</font>所属单位：</th>
						<td class="content_02_box_div_table_td">
							<input type="hidden" name="f_org_id" id="f_org_id"  value="<%=f_org_id %>" />
							<input disabled="disabled" class="validate[maxSize[100]] input_188" name="f_org_name" id="f_org_name"  value="<%=f_org_name %>" />
						</td>
						<th class="content_02_box_div_table_th">排序号：</th>
						<td class="content_02_box_div_table_td" width="192px">
							<input  class="validate[custom[number]] input_188" name="f_order_num" id="f_order_num" value="<%=f_order_num %>" />
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th"><font style="COLOR: red">*</font>登记人：</th>
						<td class="content_02_box_div_table_td">
							<input type="hidden" name="f_user_id" id="f_user_id"  value="<%=f_user_id %>" />
							<input disabled="disabled" class="validate[required,maxSize[100]] input_188" name="f_user_name" id="f_user_name"  value="<%=f_user_name %>" />
						</td>
						<th class="content_02_box_div_table_th"><font style="COLOR: red">*</font>登记时间：</th>
						<td class="content_02_box_div_table_td" width="192px">
							<input disabled="disabled"  class="validate[required] input_188" name="f_creator_time" id="f_creator_time" value="<%=f_creator_time %>" />
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