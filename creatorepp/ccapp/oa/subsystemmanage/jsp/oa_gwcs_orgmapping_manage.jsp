<%--
描述：公文传输机构映射配置主页面
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
<%@page import="com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%>
<%@page import="com.chinacreator.xtbg.core.subsystemmanage.dao.SubSystemOrgConfigDao"%><html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
    AccessControl accesscontroler = AccessControl.getAccessControl();
    accesscontroler.checkAccess(request,response);
	String path = request.getContextPath();

	String config_id = request.getParameter("config_id");//配置ID
	if(StringUtil.isBlank(config_id)){
		config_id = StringUtil.getUUID();
	}
	String subid=request.getParameter("subid");
	String currentDateTime1 = new Date().getTime()+"";

	
	SubSystemOrgConfigDao subSystemOrgConfigDao = (SubSystemOrgConfigDao)LoadSpringContext.getApplicationContext().getBean("gwcsOrgConfigDaoImpl");
	Map<String,String> viewMap = subSystemOrgConfigDao.findOaGwcsOrgMappingInfo(config_id);
	
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

<script type="text/javascript">

jQuery(document).ready(function() {
	jQuery("#org_name").attr("readOnly","readOnly").click(chooseOaOrg);
	jQuery("#gwcs_org_name").attr("readOnly","readOnly").click(chooseGwcsOrg);
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
	jQuery("#action_now").val("saveOrgConfig");

	if(isFlag){
		var okF = function(){ 
			var url= "oa_subsys_addorupdatedo.jsp?subid=<%=subid%>";
	 
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

//选择公文传输单位
function chooseGwcsOrg(){
	openAlertWindows('windowIds','<%=path%>/ccapp/oa/subsystemmanage/jsp/selectgwcsorglist.jsp?windowsId=windowIds','选择公文传输机构',800,440,'25%','25%');
}

//回填公文传输地址
function setGwcsOrgInfo(org_id,org_name,org_addr){
	jQuery('#gwcs_org_id').val(org_id);
	jQuery('#gwcs_org_name').val(org_name);
	jQuery('#gwcs_org_addr').val(org_addr);
}

//选取OA单位
function chooseOaOrg(){var s = new jQuery.z_tree();
s.treeID='mian';
s.treetypestr='checkbox';
s.isShowSeacher=true;
s.treeName="选取部门";
s.isType='unit';
s.headerName="选取部门";
s.item_id = 'org_id';
s.selectedIds=jQuery('#org_id').val();
s.type='UNIT';
s.returnFunction=function(orgObj,arr,o){
    var ids = "";
	var names = "";
	for(var j=0;j<arr.length;j++){
			ids+=","+arr[j].id;
			names+=","+arr[j].name;
	}
	if(arr.length>0){
		ids=ids.substring(1);
		names=names.substring(1);
	}
	 jQuery('#org_id').val(ids);
	  jQuery('#org_name').val(names);
 }
s.init();
	
}</script>
</head>
<body style="overflow-y:hidden;" onload="adaptationWH('_top','vcenter',85)">
	<form id="form1" action="" method="post" onkeydown="if(event.keyCode == 13){return false;}">
		<input type="hidden" name="action_now" id="action_now" /> 
		<input type="hidden" name="id" id="id" value="<%=config_id %>" /> 
		<!-- table页面跳转 -->
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
	 <div class="content_02_box_title_bg"><span>配置信息</span></div>
	 <div class="content_02_box_div">
	   <table  border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table">
	  	 <tr>
           <th width="191" class="content_02_box_div_table_th">配置名称：</th>
           <td class="content_02_box_div_table_td" colspan="3">
           <input type="text"  class="validate[required,maxSize[500]] input_title_text" name="config_name" id="config_name" value="<%=viewMap.get("config_name")%>"/>
           </td>
         </tr>
         <tr>
           <th width="191" class="content_02_box_div_table_th"><span class="color_red">*</span>公文传输机构名称名称：</th>
           <td class="content_02_box_div_table_td" colspan="3">
           <input type="text"  class="validate[required,maxSize[100]] input_title_text" name="gwcs_org_name" id="gwcs_org_name" value="<%=viewMap.get("gwcs_org_name")%>"/>
           <input type="hidden" name="gwcs_org_id" id="gwcs_org_id" value="<%=viewMap.get("gwcs_org_id")%>"/>
           <input type="hidden" name="gwcs_org_addr" id="gwcs_org_addr" value="<%=viewMap.get("gwcs_org_addr")%>"/>
           </td>
         </tr>
         <tr>
           <th width="191" class="content_02_box_div_table_th"><span class="color_red">*</span>OA单位名称：</th>
           <td class="content_02_box_div_table_td" colspan="3">
           <input type="text"  class="validate[required,maxSize[500]] input_title_text" name="org_name" id="org_name" value="<%=viewMap.get("org_name")%>"/>
           <input type="hidden"  class="validate[maxSize[500]] input_title_text" name="org_id" id="org_id" value="<%=viewMap.get("org_id")%>"/></td>
         </tr>
         <tr>
           <th width="191" class="content_02_box_div_table_th">文档上传地址：</th>
           <td class="content_02_box_div_table_td" colspan="3">
           <input type="text"  class="validate[maxSize[500]] input_title_text" name="wordtogwcswsdl" id="wordtogwcswsdl" value="<%=viewMap.get("wordtogwcswsdl")%>"/>
           </td>
         </tr>
         <tr>
           <th width="191" class="content_02_box_div_table_th">无章公文传输：</th>
           <td class="content_02_box_div_table_td" colspan="3">
           <input type="text"  class="validate[maxSize[500]] input_title_text" name="archivesendwsdl" id="archivesendwsdl" value="<%=viewMap.get("archivesendwsdl")%>"/>
           </td>
         </tr>
         <tr>
           <th width="191" class="content_02_box_div_table_th">有章公文传输：</th>
           <td class="content_02_box_div_table_td" colspan="3">
           <input type="text"  class="validate[maxSize[500]] input_title_text" name="archiveserversendwsdl" id="archiveserversendwsdl" value="<%=viewMap.get("archiveserversendwsdl")%>"/>
           </td>
         </tr>
         <tr>
           <th width="191" class="content_02_box_div_table_th">联合发文地址：</th>
           <td class="content_02_box_div_table_td" colspan="3">
           <input type="text"  class="validate[maxSize[500]] input_title_text" name="unionarchivesendwsdl" id="unionarchivesendwsdl" value="<%=viewMap.get("unionarchivesendwsdl")%>"/>
           </td>
         </tr>
          <tr>
           <th width="191" class="content_02_box_div_table_th">公文传输盖章地址：</th>
           <td class="content_02_box_div_table_td" colspan="3">
           <input type="text"  class="validate[maxSize[500]] input_title_text" name="gwcsjspaddress" id="gwcsjspaddress" value="<%=viewMap.get("gwcsjspaddress")%>"/>
           </td>
         </tr>
         <tr>
           <th width="191" class="content_02_box_div_table_th">公文地址薄配置路径：</th>
           <td class="content_02_box_div_table_td" colspan="3">
           <input type="text"  class="validate[maxSize[500]] input_title_text" name="gwcs_address_path" id="gwcs_address_path" value="<%=viewMap.get("gwcs_address_path")%>"/>
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