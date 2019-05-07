<%-- 
描述：约稿通知基本信息
作者：肖杰
版本：1.0
日期：2013-09-11
 --%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.core.paper.util.PaperConstants"%>
<%@page import="com.chinacreator.xtbg.core.sysparam.util.SysParamUitl"%>
<%@page import="com.chinacreator.xtbg.core.dict.service.impl.DictServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.dict.service.DictServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<html>
<head>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String curUserId =  accesscontroler.getUserID();
	String curUserName =  accesscontroler.getUserName();
	UserCacheBean usercachebean=UserCache.getUserCacheBean(curUserId);
	String subid = request.getParameter("subid");
	String path = request.getContextPath();//服务器根路径
	String p_msg_contents="";
    String checkpass = SysParamUitl.getSysParamValueIsVALID(PaperConstants.PAPER_MAKE_NOTICE);
    if(!StringUtil.nullOrBlank(checkpass)){
    	p_msg_contents = SysParamUitl.getSysParamValue(checkpass);
    	p_msg_contents=StringUtil.replaceAll(p_msg_contents);
        List<Map<String, String>> listmap = SysParamUitl.getSysParamValueDetail(checkpass);
    }
%>
<title>约稿通知基本信息</title>
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
<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>

<script type="text/javascript">

var path = '<%=path %>';
var subid = '<%=subid %>';
jQuery(function() {
	
});
/*
函数:  addMakeNotice
说明:  添加
参数:   无
返回值: 无
*/
var addMakeNotice = function() {
	if(!jQuery('#form1').validationEngine('validate')){
		return;
	}
	 if(jQuery("#p_msg_type1").attr("checked")=="checked"){
		   jQuery("#p_msg_type1").val("短信");
	   }else{
		   jQuery("#p_msg_type1").val("");
	   } 
	   if(jQuery("#p_msg_type2").attr("checked")=="checked"){
		   jQuery("#p_msg_type2").val("及时信息");
	   }else{
		   jQuery("#p_msg_type2").val("");
	   }
	if((jQuery("#p_msg_type1").attr("checked")=="checked" || jQuery("#p_msg_type2").attr("checked")=="checked")&&jQuery("#p_msg_contents").val()==""){
		alert("请填写短信内容！");
		return;
	}
	if(IsSpace(eWebEditor1.getHTML())){
		alert("请填写约稿内容！");
		return;
	}
    var url = path+"/ajaxServlet?className=com.chinacreator.xtbg.core.paper.action.PaperNoticeAction&method=savePaperNotice";
    ajaxSubmit("确认提交吗？",url);
}
/**
函数:  ajaxSubmit
说明:  ajax访问后台
参数: 
返回值: 无
*/
var ajaxSubmit = function(alertMsg,url){
	
   //ajax方式提交数据
   jQuery.ajax({
       type: "post", 
       url: url,
       contentType: "application/x-www-form-urlencoded; charset=utf-8",
       data : getValue(),
       dataType: "json", 
       success: function (data) {
    	   //操作成功，返回上层界面
    	  
           if(data && data.msg){                
             alert(data.msg,{
                 headerText:'提示',
                 okName:'确认',
                 okFunction:function(){
                    if(data.flag == "true"){
                       removeWindows(subid,true);
                    }
                 }
                 });
           }
       },
       error: function (XMLHttpRequest, textStatus, errorThrown) {
           alert("出现异常，请稍后再试！");
       } 
    });            
     
}
/**
 * 获得要提交的参数
 */ 
function getValue(){
    var params = {};
        params["makebean.p_title"] = jQuery("#p_title").val();
        params["makebean.p_unit_id"] = jQuery("#p_unit_id").val();
        params["makebean.p_unit_name"] = jQuery("#p_unit_name").val();
        params["makebean.p_send_unit_name"] = jQuery("#p_send_unit_name").val();
        params["makebean.p_send_unit_id"] = jQuery("#p_send_unit_id").val();
        params["makebean.p_contents"] = eWebEditor1.getHTML();
        params["makebean.p_msg_type1"] = jQuery("#p_msg_type1").val();
        params["makebean.p_msg_type2"] = jQuery("#p_msg_type2").val();
        params["makebean.p_msg_contents"] = jQuery("#p_msg_contents").val();
        params["makebean.p_create_user_id"] = jQuery("#p_create_user_id").val();
        params["makebean.p_create_user_name"] = jQuery("#p_create_user_name").val();
    //转码
    for(var name in params ){
        params[name] = descape(escape(params[name]));
    }  
    return params;    
}
/*
函数:  back
说明:  返回列表
参数:   无
返回值: 无
*/
function back(){
		var okF = function(){
			removeWindows(subid,true);
		}
		 var p={
				headerText:'提示',
				okName:'确认',
		        okFunction:okF,
		        cancelName:'取消'};
		 alert('返回该页,未保存的信息将会丢失 '+'<br>'+'确定返回？',p);
}
var chooseOrg = function (){
	var s = new jQuery.z_tree();
	  s.treeID='mian';
	  s.treetypestr='checkbox';
	  s.isShowSeacher=true;
	  s.treeName="选取单位";
	  s.isType='unit';
	  s.headerName="选取单位";
	  s.item_id = 'org_id';
	  s.selectedIds=jQuery('#p_unit_id').val();
	  s.type='{"type":"32"}';
	  s.valueKey='unit';
	  s.returnFunction=function(orgObj,arr,o){
		    var ids = "";
			var names = "";
			for(var j=0;j<arr.length;j++){
				if(!arr[j].isParent){
					ids+=","+arr[j].id;
					names+=","+arr[j].name;
				}
			}
			if(arr.length>0){
				ids=ids.substring(1);
				names=names.substring(1);
			}
			jQuery('#p_unit_id').val(ids); 
			jQuery('#p_unit_name').val(names);
			jQuery('#p_unit_name').attr("title",names);
		 }
	  s.init();
}
/* 
函数:  setValue4m_msg_contents
说明:  事件响应方法设置短信模板
*/
function setValue4m_msg_contents(id){
	if(IsSpace(jQuery("#p_title").val())){
		/* alert("请先填写标题");
		return; */
	}
	var title=jQuery("#p_title").val();
	var contents=jQuery("#msg_contents").val();
	if(!IsSpace(title)){
		contents=contents.replaceAll("XXX",title);
	}
	if(id=="model_id"){
		jQuery("#p_msg_contents").val(contents);
	}else{
		if(jQuery("#p_msg_contents").val()==""){
			jQuery("#p_msg_contents").val(contents);//短信模板
		}
	}
}
jQuery (function(){
	jQuery("#p_title_test_id").on("mouseleave",".p_title",function(){
		if(jQuery("#p_msg_type1").attr("checked")=="checked" || jQuery("#p_msg_type2").attr("checked")=="checked" ){
			var title=jQuery("#p_title").val();
			var contents=jQuery("#msg_contents").val();
			if(!IsSpace(title)){
				contents=contents.replaceAll("XXX",title);
				jQuery("#p_msg_contents").val(contents);
			}
		}
	})
});
</script>

</head>
<body style="overflow-y: hidden;" onload="adaptationWH('_top','vcenter',40)">
<form id="form1" action="papermakenoticedo.jsp?subid=<%=subid %>" method="post">
<input type="hidden" name="action" id="action"   />
<input type="hidden" name="p_create_user_id" id="p_create_user_id"  value="<%=usercachebean.getUser_id() %>" />
<input type="hidden" name="p_create_user_name" id="p_create_user_name"  value="<%=usercachebean.getUser_realname() %>" />
<input type="hidden" name="p_send_unit_id" id="p_send_unit_id"  value="<%=usercachebean.getUnit_id() %>" />
<input type="hidden" name="p_send_unit_name" id="p_send_unit_name"  value="<%=usercachebean.getUnit_name() %>" />
<textarea style="display: none" name="msg_contents" id="msg_contents"  > <%=p_msg_contents %></textarea>
<!-- 操作-->
<div class="content_02" style="overflow: hidden;" id="_top">
	<div class="content_02_top" style="margin-bottom: 10px;">
		<input name="fbbt" id="fbbt" value="确定" onclick="addMakeNotice();"  type="button" class="but_y_01" /> 
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
						<th class="content_02_box_div_table_th"><font style="COLOR: red">*</font>标题：</th>
						<td class="content_02_box_div_table_td" id ="p_title_test_id">
							<input type="hidden" name="p_notice_id" id="p_notice_id"  value="" />
							<input  class="validate[required,maxSize[100]] input_188 p_title" name="p_title" id="p_title" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()"  value=""  style="width: 99%"/>
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th"><font style="COLOR: red">*</font>约稿单位：</th>
						<td class="content_02_box_div_table_td" >
							<input type="hidden" name="p_unit_id" id="p_unit_id"  value="" />
							<input  class="validate[required] input_188" name="p_unit_name" id="p_unit_name" title="" value="" onclick="chooseOrg();" style="width: 99%"/>
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th">提醒方式：</th>
						<td class="content_02_box_div_table_td" >
							<div><span style="float:left;display:block;width: 20px">&nbsp;</span>
								<input style="float:left;display:block;margin:7px 2px 0 2px" type="checkbox"  name="p_msg_type1" id="p_msg_type1" onclick="setValue4m_msg_contents(this.id);" />
								<span style="float:left;display:block;width: 50px">短信</span>
								<input style="float:left;display:block;margin:7px 2px 0 2px" type="checkbox"  name="p_msg_type2" id="p_msg_type2" onclick="setValue4m_msg_contents(this.id);"  />
								<span style="float:left;display:block;width: 100px">及时信息</span>
								<!-- <input style="float:left;display:block;width: 100px" type="button" class="but_y_05" value="使用默认模版"/> -->
								<span style="float:left;display:block;width: 100px" id="model_id" onclick="setValue4m_msg_contents(this.id);">使用默认模版</span>
							</div>
						</td>
					</tr>
					<tr>
						<th width="212" valign="top" class="content_02_box_div_table_02_th">提醒内容：</th>
						<td  class="content_02_box_div_table_02_td">
						<textarea class="validate[maxSize[250]] textarea_575" style="width:99%;height:50px" name="p_msg_contents" id="p_msg_contents" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()"  ></textarea>
							
						</td>
					</tr>
					<!-- <tr>
						<th width="212" valign="top" class="content_02_box_div_table_02_th">约稿内容：</th>
						<td  class="content_02_box_div_table_02_td">
							<textarea  style="display:none" id="p_contents" name="p_contents" class="validate[required]" ></textarea>
			                <iframe id="eWebEditor1" src="../../resources/plug/eWebEditor_V4.60/ewebeditor.htm?id=p_contents&style=gray" frameborder="0" scrolling="no" width="100%" height="260"></iframe> 
						</td>
					</tr> -->
				</table>
			</div>
		</div>
		<div class="content_02_box">
		
			<div class="content_02_box_title_bg"><span>内容</span> 
			<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
			<span class="color_red">提示：可以直接粘贴word、excel表格</span>
			<div class="content_02_box_add" id="t2"><span id="selAreaImg" class="tabs_search_text_but"></span></div>
			</div>
		
			<div class="content_02_box_div">
				<table border="0" cellspacing="0" cellpadding="0"
					class="content_02_box_div_table">
					<tr>
						<td colspan="4">
						<textarea style="display: none" name="p_contents" id="p_contents"  class="validate[required]"></textarea> 
						<iframe id="eWebEditor1" src="../../resources/plug/eWebEditor_V4.60/ewebeditor.htm?id=p_contents&style=gray" frameborder="0" 
						scrolling="no" width="100%" height="400"></iframe>
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