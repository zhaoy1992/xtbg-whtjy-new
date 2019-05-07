<%@page language="java" contentType="text/html; charset=gbk"pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String userid = accesscontroler.getUserID();
	String loginUserName = accesscontroler.getUserAccount();
	//获得当前登录用户所属单位信息
	UserCacheBean usercachebean = UserCache.getUserCacheBean(userid);
	String unit_id = usercachebean.getUnit_id();
	String unit_name = usercachebean.getUnit_name();
	String user_name = usercachebean.getUser_name();
	String org_id = usercachebean.getOrg_id();
	String org_name = usercachebean.getOrg_name();
	//获取当前时间
	String time = DateUtil.getCurrentDateString("yyyy-MM-dd");
	

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>固定资产-资产报废界面</title>
</head>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script src="../../../resources/js/util/jsonutil.js" type="text/javascript"></script>

<script type="text/javascript">jQuery.noConflict();</script>

<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>

<!-- 引入my97时间控件 -->
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<!-- 引入formvValidatetion -->
<link rel="stylesheet"href="../../../resources/plug/formvalidation/css/validationEngine.jquery.css"type="text/css" />
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>

<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<!-- 公共部分结束 -->
<script type="text/javascript">
jQuery(function(){

})


/*
函数:  Ok
说明:  提交添加与修改来文单位
参数:   无
返回值: 无
*/
function Ok() {
	var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
	if (isFlag){;
		//jQuery("#form1").attr("target","filetypeinfodoJSPhiddenFrame");
		jQuery("#form1").submit();
	}
}

function openDevAppInfo(){
	var path ="<%=path%>/ccapp/xtbg/tjy/account/jsp/changeaccountlist.jsp?windowsId=windowIds";
    openAlertWindows('windowIds',path,'设备信息',900,450,'25%','25%');
}

function loadInfo(id,num,name,it,manufacturer,t_trsynx){
	jQuery("#t_sb_id").val(id);	
	jQuery("#num").val(num);	
	jQuery("#name").val(name);	
	jQuery("#it").val(it);	
	jQuery("#manufacturer").val(manufacturer);
	jQuery("#t_trsynx").val(t_trsynx);	
}
</script>
<body style="overflow-y: hidden;"  onload="adaptationWH('_top','vcenter',45);">
<form id="form1" name="form1" action="devscrapdo.jsp" class="formular" method="post"> 
	<input id="t_id" name="t_id" type="hidden" value="<%=DaoUtil.getUUID() %>">
	<input id="method" name="method" type="hidden" value="insert">
	<input id="user_id" name="user_id" type="hidden" value="<%=userid %>">
	<input id="user_name" name="user_name" type="hidden" value="<%=user_name %>">
	<input id="org_id" name="org_id" type="hidden" value="<%=org_id %>">
	<input id="org_name" name="org_name" type="hidden" value="<%=org_name %>">
	<div class="content_02" style="overflow: hidden;" scrolling="yes"  id="_top">
			<!-- 操作-->
			<div class="content_02_top" style="margin-bottom: 10px;" id='content_02_top'>
				<input id="savebtn" name="savebtn" type="button" class="but_y_01" onclick="Ok()" value="保存" />
			</div>
	</div>
	 <!-- ---表格------->
 <div id="vcenter" style="float: left; width: 100%;">
 <div style="float: left; width: 775px; ">
 <div class="content_02_box_div">
 	<div class="content_02_box_title_bg">
 		<span>设备报废申请表</span>
	</div>      
	<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table"> 
		<tr>
			<th class="content_02_box_div_table_th"><span class="color_red">*</span>标题：</th>
			<td class="content_02_box_div_table_td" colspan="3">
				<input class="validate[required,maxSize[100]] input_title_text" style="width: 55%;" id="t_title" name="t_title" value="">
			</td>
		</tr>
		<tr>
			<th class="content_02_box_div_table_th"><span class="color_red">*</span>设备编号：</th>
			<td class="content_02_box_div_table_td">
				<input id="t_sb_id" name="t_sb_id" type="hidden" value="">
				<input class="validate[required,maxSize[50]] input_title_text" readonly="readonly" onclick="openDevAppInfo()" style="width: 55%;" id="num" name="num" value="">
			</td>
			<th class="content_02_box_div_table_th">设备名称：</th>
			<td class="content_02_box_div_table_td">
				<input class="validate[required,maxSize[200]] input_title_text" readonly="readonly"  style="width: 55%;" id="t_sb_name" name="t_sb_name" value="">
			</td>
		</tr>
		<tr>
			<th class="content_02_box_div_table_th">型号规格：</th>
			<td class="content_02_box_div_table_td">
				<input class="input_title_text" readonly="readonly" style="width: 55%;" id="it" name="it" value="">
			</td>
			<th class="content_02_box_div_table_th">生产厂家：</th>
			<td class="content_02_box_div_table_td">
				<input class="input_title_text" readonly="readonly" style="width: 55%;" id="manufacturer" name="manufacturer" value="">
			</td>
		</tr>
		<tr>
			<th class="content_02_box_div_table_th">投入使用年限：</th>
			<td class="content_02_box_div_table_td">
				<input class="input_title_text" readonly="readonly" style="width: 55%;" id="t_trsynx" name="t_trsynx" value="">
			</td>
			<th class="content_02_box_div_table_th">报废时间：</th>
			<td class="content_02_box_div_table_td">
				<input type="text" value="<%=time %>" class="validate[required] date_187" id="t_sqrq" name="t_sqrq"onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})"/>
			</td>
		</tr>
		<tr>
			<th class="content_02_box_div_table_th">报废理由：</th>
			<td class="content_02_box_div_table_td" colspan="3">
				<textarea  id="t_bfly" name="t_bfly" class="validate[maxSize[250]] textarea_556" style="border: 1;width:99%;overflow: auto;"></textarea>
			</td>
		</tr>
	</table>                                    

</div>
</div>
</form>
<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>