<%--
描述：外部子系统管理主页面
作者：夏天
版本：1.0
日期：2013-4-28
--%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page contentType="text/html; charset=utf-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="java.util.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<%@page import="com.chinacreator.xtbg.core.subsystemmanage.dao.SubSystemManageDao"%>
<%@page import="com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%><html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
    AccessControl accesscontroler = AccessControl.getAccessControl();
    accesscontroler.checkAccess(request,response);
	String path = request.getContextPath();
	String orgid="";
	String orgname="";
	String creatorid=accesscontroler.getUserID();
	String creator=accesscontroler.getUserName();
	String username="";
	String paramjosns = "";

	String sys_id = request.getParameter("sys_id");//外部子系统管理主键id
	String status=request.getParameter("status");//获得该子系统所属的状态
	String listtype = request.getParameter("listtype");//列表类别
	String currentDateTime1 = new Date().getTime()+"";

	String subid=request.getParameter("subid");
	
	SubSystemManageDao subSystemManageDao = (SubSystemManageDao)LoadSpringContext.getApplicationContext().getBean("subSystemManageDaoImpl");
	Map<String,String> viewMap = subSystemManageDao.findSubSystemInfo(sys_id);
	
%>
<title>JGRID</title>
<link rel="stylesheet" href="../resources/css/sub_sys.css" type="text/css"/>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script> 
<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入formvValidatetion -->
<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<!-- 公共部分引用结束 -->
<script type="text/javascript" src="../resources/js/sub_system_manage.js" charset="utf-8"></script>
<script type="text/javascript">
var sys_id = "<%=sys_id%>";
var listtype = "<%=listtype%>";
var sys_img_url = "<%=viewMap.get("sys_img_url")%>";
var sys_ispublic = "<%=viewMap.get("sys_ispublic")%>";

jQuery(document).ready(function() {

	
});


/*
函数:  Ok
说明:  提交添加与修改(发布操作)
参数:   无
返回值: 无
*/
var Ok = function() {
	saveForm();
}


var saveForm = function(){
	var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
	jQuery("#action_now").val("save");

	if(isFlag){
		var okF = function(){ 
			var url= "subsys_addorupdatedo.jsp?subid=<%=subid%>";
	 
		  	document.all.form1.action=url;
			document.all.form1.target = "hiddenFrame";
			jQuery("#form1").submit();
		}
		var p={
				headerText:'提示',
				okName:'确认',
		        okFunction:okF,
		        cancelName:'取消'
		};
	alert('确定保存该信息吗？ ',p)
	}
}

/*
函数:  sucessBackFun
说明:  与后台交互后的成功回调方法
参数:   无
返回值: 无
*/
var sucessBackFun = function(obj){
	var action = obj.action;
	closed("");
}


//返回
function closed(state){
	if(state == ""){
		removeWindows('<%=subid%>',true);
	}else{
		var okF = function(){
			removeWindows('<%=subid%>',true);
			}
			 var p={
					headerText:'提示',
					okName:'确认',
			        okFunction:okF,
			        cancelName:'取消'
			};
			 alert('返回该页,未保存的信息将会丢失 '+'<br>'+'确定返回？',p);
	}
}	


//是否以机构名义发送
function doorg(obj){
	jQuery("input[name='checkorg']").attr('checked',false);
    jQuery(obj).attr('checked',true);
}
</script>
</head>
<body style="overflow-y:hidden;" onload="adaptationWH('_top','vcenter',85)">
	<form id="form1" action="" method="post" onkeydown="if(event.keyCode == 13){return false;}">
		<input type="hidden" name="sys_id" id="sys_id" value="<%=viewMap.get("sys_id") %>"/> 
		<input type="hidden" name="action_now" id="action_now" /> 
		<!-- table页面跳转 -->
		<input type ="hidden" id ="tablepage" name ="tablepage"/>
<div  class="content_02" style="overflow:hidden;" id="_top">
   <!-- 操作-->
  <div class="content_02_top" style="margin-bottom:10px;" >
   <input name="cgbt" id="cgbt" value="保存" style="display: inline;" onclick="Ok();" type="button" class="but_y_01" />
   <input name="" value="返回" onclick="closed('')" type="button" class="but_y_01" />
	</div>  
	 </div>
	<!-- 表格-->
	<div id="vcenter" style="float:left; width:100%; overflow:scroll" scrolling="yes">
	<div style="float: left; width: 775px; ">
	<div class="content_02_box" >
	 <div class="content_02_box_title_bg"><span>基本信息</span></div>
	 <div class="content_02_box_div">
	   <table  border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table">
         <tr>
           <th width="191" class="content_02_box_div_table_th"><span class="color_red">*</span>子系统名称：</th>
           <td class="content_02_box_div_table_td" colspan="3"><input type="text"  class="validate[required,maxSize[100]] input_title_text" name="sys_name" id="sys_name" value="<%=viewMap.get("sys_name")%>"/></td>
         </tr>
         <tr>
           <th width="191" class="content_02_box_div_table_th">子系统描述：</th>
           <td class="content_02_box_div_table_td" colspan="3"><input type="text"  class="validate[maxSize[500]] input_title_text" name="sys_desc" id="sys_desc" value="<%=viewMap.get("sys_desc")%>"/></td>
         </tr>
         <tr>
           <th width="191" class="content_02_box_div_table_th"><span class="color_red">*</span>子系统访问路径：</th>
           <td class="content_02_box_div_table_td" colspan="3"><input type="text"  class="validate[required,maxSize[1000]] input_title_text" name="sys_url" id="sys_url" value="<%=viewMap.get("sys_url")%>"/></td>
         </tr>
         <tr>
           <th width="191" class="content_02_box_div_table_th"><span class="color_red">*</span>是否为公共系统：</th>
           <td class="content_02_box_div_table_td" colspan="3">&nbsp;
           		<input type="radio"  name="sys_ispublic" value="N" checked="checked">&nbsp;否&nbsp;&nbsp;</input>
           		<input type="radio"  name="sys_ispublic" value="Y">&nbsp;是</input>
           </td>
         </tr>
         <tr>
           <th width="191" class="content_02_box_div_table_th">子系统图片：</th>
           <td class="content_02_box_div_table_td" colspan="3">
           		<div id="image_choose" class="sub_sys_show_main">
		           
		        </div>
           </td>
         </tr> 
</table>
	 </div>
	</div>

	</div></div>
	</form>
	<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>