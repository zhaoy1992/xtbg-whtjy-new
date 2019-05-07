<%-- 
	描述：望城 人事管理，更新人员信息页面
		这个页面只做查看和更新功能
	作者：陈建华
	版本：1.0
	日期：2013-5-27
 --%>
<%@page import="com.chinacreator.sysmgrcore.entity.User"%>
<%@page import="java.util.Date"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.pub.directory.service.impl.DirectoryServiceImpl"%>
<%@page import="com.chinacreator.xtbg.pub.directory.service.DirectoryServiceIfc"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.xtbg.pub.directory.dao.imploracle.DirectoryDaoImpl"%>
<%@page import="com.chinacreator.xtbg.pub.directory.dao.imploracle.UserDataDaoImpl"%>
<%@page import="com.chinacreator.xtbg.pub.directory.dao.UserDataDao"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

<title>JGRID</title>

<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String userid= request.getParameter("typeid");
	String attachment_id = new Date().getTime()+"";
	String path = request.getContextPath();
	String orgid=request.getParameter("orgid");
	String id = request.getParameter("typeid");
	DirectoryServiceIfc directoryServiceIfc = new DirectoryServiceImpl();
	User user=new User();
	user=directoryServiceIfc.getuserinfo(id);
	if(!StringUtil.isBlank(user.getUserAndSn().getAttachmentid())){
		attachment_id=user.getUserAndSn().getAttachmentid();
	}
	String readonly = request.getParameter("readonly");	//是否只读，1：只读，0：可编辑
	readonly = readonly == null ? "1" : readonly;
	
	DirectoryDaoImpl directoryDaoImpl = new DirectoryDaoImpl();	//用原来的字典
	//性别选择
	String sex= directoryDaoImpl.selecthtml("1", user.getUserSex(),"sex");
	//政治面貌
	String politics=directoryDaoImpl.selecthtml("2", user.getUserAndSn().getPolitics(), "politics");
	//学历
	String education=directoryDaoImpl.selecthtml("9", user.getUserAndSn().getEducation(), "education");
	//学位选择
	String degree=directoryDaoImpl.selecthtml("10", user.getUserAndSn().getDegree(), "degree");
	
	//婚姻选择
	String ismarry= directoryServiceIfc.createSelectHtml("v_wc_ismarry",user.getUserAndSn().getIsmarry(),"ismarry");
	//职称类别选择
	String titletype= directoryServiceIfc.createSelectHtml("v_wc_titletype",user.getUserAndSn().getTitletype(),"titletype");
	//职称等级选择
	String titles= directoryServiceIfc.createSelectHtml("v_wc_titles",user.getUserAndSn().getTitles(),"titles");
	//外国语言选择
	String languagetype= directoryServiceIfc.createSelectHtml("v_wc_languagetype",user.getUserAndSn().getLanguagetype(),"languagetype");
	//外语水平(等级)选择
	String languagelevel= directoryServiceIfc.createSelectHtml("v_wc_languagelevel",user.getUserAndSn().getLanguagelevel(),"languagelevel");
	//人员类型选择
	String usertype= directoryServiceIfc.createSelectHtml("v_wc_usertype",user.getUserAndSn().getUsertype(),"usertype");
	//健康状态
	String health_state = directoryServiceIfc.createSelectHtml("v_wc_health_state",user.getUserAndSn().getHealth_state(),"health_state");
%>
<style type="text/css">
.input_title_text_noborder{ width:99%; border:0px solid #C6C6C6; height:24px; margin-top:0px; font:12px/24px "宋体"; padding:0px 0px; display:inline;}
.date_187_noborder{width:189px; height:24px; border:0px solid #C6C6C6; font:12px/24px ""; display:block;overflow:hidden; background:url(../../../resources/images/date_img.jpg) right 1px no-repeat; float:left; display:inline;cursor:pointer; }
.xz_187_noborder{width:189px; height:26px; border:0px solid #C6C6C6; font:12px/24px ""; display:block;overflow:hidden; background:url(../../../resources/images/xuanze.jpg) right 1px no-repeat; float:left; display:inline;cursor:pointer; }
.input_185_noborder{width:180px; height:24px; border:0px solid #C6C6C6; font:12px/24px "宋体"; display:block;overflow:hidden;  float:left; padding:0px 2px; display:inline; }
.texteare_lbjd_noborder{height:24px; border:0px solid #C6C6C6; font:12px/24px "宋体"; display:block;  float:left; padding:0px 2px; display:inline; }
.input_text_center_wc{text-align: center;} /**使input中的文字居中*/
</style>
<!-- 公共部分开始 -->
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script> 
<!-- 引入my97时间控件 -->
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript" charset="utf-8"></script>
<!-- 引入jQuery UI -->
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入formvValidatetion -->
<link rel="stylesheet" href="../../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<!-- 引入上传控件 -->
<script type="text/javascript" src="../../../resources/plug/fancyupload/mootools-1.2.5-core-jm.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/fancyupload/source/Fx.ProgressBar.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/fancyupload/source/Swiff.Uploader.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/fancyupload/source/FancyUpload3.Attach.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/fancyupload/myfancyupload.js" charset="utf-8"></script>
<!-- 公共部分结束 -->
<script language="javascript" src="../../../resources/plug/Lodop/LodopFuncs.js"></script>
<object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
	<embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0 pluginspage="install_lodop.exe"></embed>
</object>
<script type="text/javascript">
var readonly = "<%=readonly%>" ;
var ajax_url = "<%=path%>"+"/ccapp/xtbg/public/directory/jsp/";
jQuery(function() {
	if(readonly == 1){
		jQuery("#resert").css("display","none");
		jQuery("select").each(function(){		//把所有的select都转换为显示值
			var selectVar = jQuery(this).find("option:selected").text();
			jQuery(this).parent().html(selectVar);
		});
		jQuery("input:text").attr("readonly","readonly");
		jQuery("#birthday,#worktime,#jointime,.arg1,.arg3").attr("onfocus","");
		jQuery(".addOneTr").html("");
		MyFancyupload.createUpload('_fileshow', '#_filebut', '<%=path%>', '<%=path%>/servlet/FileUpload?buessid=<%=attachment_id%>', false, '<%=attachment_id%>');
		jQuery("#_filebut").hide();
		jQuery(".swiff-uploader-box").hide();
		jQuery("#user_photo").hide();
		jQuery(".deleteOneTr").text("");
	} else {
		MyFancyupload.createUpload('_fileshow', '#_filebut', '<%=path%>', '<%=path%>/servlet/FileUpload?buessid=<%=attachment_id%>', true, '<%=attachment_id%>');
	}
	listUserData("<%=userid%>");	//加载简历数据
	//添加一行的事件
	jQuery(".addOneTr").on("click",function(){
		var dataTable =  jQuery(this).parent().next("table");
		var dataTr = dataTable.find("tr:eq(1)").clone(true);
		dataTr.attr("data_id"," ").find("input").val("");	//将表格中的input清空
		dataTable.append(dataTr);		//添加行到表格
	});
	//删除一行的事件
	jQuery(".content_02_box_div_table").on("click",".deleteOneTr",function(){
		if(readonly != 1){
			var dataTr = jQuery(this).parent().parent();
			if(IsSpace(dataTr.attr("data_id"))){
				if(dataTr.parent().find("tr").length > 2){
					dataTr.remove();
				}
			} else {
				var okF = function(){
					if(dataTr.parent().find("tr").length > 2){
						deleteUserData(dataTr.attr("data_id"),function(code){
							if(code == 0 ){
								dataTr.remove();
							}
						})
					} else {
						deleteUserData(dataTr.attr("data_id"),function(code){
							if(code == 0 ){
								dataTr.attr("data_id"," ").find("input").val("");	//将表格中的input清空
							}
						})
					}
				}
				var p={
					headerText:'提示',
					okName:'确认',
				    okFunction:okF,
				    cancelName:'取消'
				};
				alert('确定要删除？',p);
			}
		}
	});
	jQuery(".user_data_table").on("focusout","input[type=text]",function(){
		var tmp_input = jQuery(this);
		var input_val = tmp_input.val();
		if(input_val.length > 50){
			input_val = input_val.substring(0,10);
			tmp_input.val(input_val);
			alert("最多只能输入50个字符");
		}
	});
});
function updatesubmit(){
	var isFlag = jQuery('#form1').validationEngine('validate');  //是否全部验证通过
	if(isFlag){
		if(jQuery("#userrealname").val() == ""){
			alert("用户姓名不能为空!");
		} else {
			getUesrDate();
			jQuery("#form1").submit();
		}
	}else{
		jQuery("body").scrollTop(0);
		return;
	}
}
function closed(){
	removeAlertWindows('',true);
}
//上传文件
function viewmypic(a) {
   jQuery("#sshowimg").val(jQuery("#imgfile").val());
   var str = a.value;
   if(/\.(gif|jpg|jpeg|png|GIF|JPG|PNG)$/.test(str))
   {
		var Preview = document.getElementById("Preview");         
		jQuery('#showimg').hide();
		jQuery('#csimg').hide();
		//注意，如果要用这个插件的功能，需要将浏览器的安全级别调到最低
		Preview.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = a.value; 
		Preview.style.width = "200px";             
		Preview.style.height = "240px";
		
		savePic();
   } else {
   		alert("请选择正确的照片格式,支持 gif/jpg/jpeg/png");
   }
}

/*
 * 说明：文件上传事件 参数：无 返回值：无 作者：jichang.long
 */
function savePic(){
		var f=jQuery("sshowimg").val();
		var real =jQuery("#imgfile");// BMP、JPG、JPEG、PNG、GIF
			var cloned = real.clone(true);
			real.hide();
			cloned.insertAfter(real);
			jQuery("#form_up").empty();
			real.appendTo("#form_up");
			if(""!=""){
			var okF = function(){
				jQuery("#form_up").submit(); 
			}
			 var p={
				headerText:'提示',
				okName:'确认',
			    okFunction:okF,
			    cancelName:'取消'
			};
			alert('点击确定,以前照片将会丢失.',p);
			}else{
				jQuery("#form_up").submit(); 
			}
}

/**
 * 保存信息--saveinfo
 */
var saveinfo = function(){
	if(jQuery("#sshowimg").val()==""){
		alert("请选择图片！");
		return;
	}else{
		savePicThenInfo();
	}
}
var savePicThenInfo=function(){
	if(''!=""){
		  jQuery("#action").val("update");
	}else{
		  jQuery("#action").val("save");
	}
		jQuery("#form1").attr("target","hiddenFrame");
		jQuery("#form1").submit();
}
function fn_browse(){
	jQuery("#imgfile").trigger("click");
} 
//得到用户的简历数据
function getUesrDate(){
	var userData = "";
	jQuery(".user_data_table").each(function(){
		var tmp_table = jQuery(this);
		var datatype = tmp_table.attr("datatype");
		var user_id = jQuery("#userid").val();
		tmp_table.find("tr:gt(0)").each(function(){
			var arr = new Array();
			var tmp_tr = jQuery(this);
			arr.push(tmp_tr.attr("data_id"));
			arr.push(user_id);
			arr.push(datatype);
			var arg1 = tmp_tr.find(".arg1").val();
			var arg2 = tmp_tr.find(".arg2").val();
			var arg3 = tmp_tr.find(".arg3").val();
			var arg4 = tmp_tr.find(".arg4").val();
			var arg5 = tmp_tr.find(".arg5").val();
			if(IsSpace(arg5)){
				arg5 = " ";
			}
			if(IsSpace(arg1) && IsSpace(arg2) && IsSpace(arg3) && IsSpace(arg4) && IsSpace(arg5)){
				//当一行数据所有的都为空时，什么都不做
			} else {
				arr.push(arg1);
				arr.push(arg2);
				arr.push(arg3);
				arr.push(arg4);
				arr.push(arg5);
				userData += arr.join("@#@")+"##@##";	//每个数据都以特殊字符分割	
			}
		})
	});
	jQuery("#userdata").val(userData);
}
//查询用户简历数据
function listUserData(tmp_user_id){
	if(!IsSpace(tmp_user_id)){
		jQuery.ajax({
			url:ajax_url+'handleofuserdata.jsp',
			type:'post',dataType:'json',
			data:{"method":"list","user_id":tmp_user_id},
			success:function(data){
				if(data.code.index == 0){
					jQuery.each(data.result,function(key,value){
						var tmp_type = value.type;
						var tmp_data_id = jQuery("#user_data_"+tmp_type).find("tr:eq(1)").attr("data_id");
						if(IsSpace(tmp_data_id)){
							var tmp_tr = jQuery("#user_data_"+tmp_type).find("tr:eq(1)");
							tmp_tr.attr("data_id",value.id);
							tmp_tr.find(".arg1").val(value.arg1);
							tmp_tr.find(".arg2").val(value.arg2);
							tmp_tr.find(".arg3").val(value.arg3);
							tmp_tr.find(".arg4").val(value.arg4);
							tmp_tr.find(".arg5").val(value.arg5);
						} else {
							var tmp_tr = jQuery("#user_data_"+tmp_type).find("tr:eq(1)").clone(true);
							tmp_tr.attr("data_id",value.id);
							tmp_tr.find(".arg1").val(value.arg1);
							tmp_tr.find(".arg2").val(value.arg2);
							tmp_tr.find(".arg3").val(value.arg3);
							tmp_tr.find(".arg4").val(value.arg4);
							tmp_tr.find(".arg5").val(value.arg5);
							jQuery("#user_data_"+tmp_type).append(tmp_tr);		//添加行到表格
						}
					})
				} else {
					//查询出错，屏蔽错误消息
					//alert("查询数据失败！errorCode["+data.code.index+"]");
				}
			}
		});
	}
}
function deleteUserData(tmp_data_id,callback){
	if(!IsSpace(tmp_data_id)){
		jQuery.ajax({
			url:ajax_url+'handleofuserdata.jsp',
			type:'post',dataType:'json',
			data:{"method":"delete","id":tmp_data_id},
			success:function(data){
				if(data.code.index == 0){
					alert("删除成功！");
				} else {
					alert("删除失败！！errorCode["+data.code.index+"]");
				}
				callback(data.code.index);
			}
		});
	} else {
		alert("无数据id，不能删除数据！");
	}
}
function printView(){
	openAlertWindows('printWindowId','../../directory/jsp/printUserInfoForWc.jsp?user_id=<%=userid%>',"人员档案信息打印预览",800,530,'5%','25%');
}
</script>
</head>
<body style="overflow-x:auto;" class="vcenter">
	<form id="form1" action="updateUserInfo.jsp" method="post" class="formular">
		<div >
			<table class="content_02_box_div_table">
				<tr>
					<td class="content_02_box_title_bg" style="width: 772px">基本资料</td>
				</tr>
			</table>
			<div>
				<table  style="width: 780px">
					<tr style="border: none">
						<td colspan="2" align="left" style="border: none">
							&nbsp;&nbsp;编号：<input class="validate[maxSize[50]]" type="text" style="border:none;width: 120px;height: 25px;line-height: 25px;" id="usernumber" name="usernumber" value="<%=StringUtil.deNull(user.getUserAndSn().getUsernumber()) %>"/>
						</td>
							
						<td colspan="3" align="right" style="border: none"><span>人员类型：</span><span><%=usertype %></span>&nbsp;&nbsp;</td>
					</tr>
					<tr style="border-top: 1px solid #ccc;">
						<td class="content_02_box_div_table_th_wc" style="border-top: 1px solid #ccc;">姓名：</td>
						<td class="content_02_box_div_table_td_wc" style="border-top: 1px solid #ccc;">
							<input class="input_title_text_noborder validate[required,maxSize[50]]" type="text" id="userrealname" name="userrealname" type="text" value="<%=StringUtil.deNull(user.getUserRealname()) %>"/>
						</td>
						<td class="content_02_box_div_table_th_wc" style="border-top: 1px solid #ccc;">性别：</td>
						<td class="content_02_box_div_table_td_wc" style="border-top: 1px solid #ccc;"><%=sex %></td>
						<td class="content_02_box_div_table_td_wc" rowspan="7" style="border-top: 1px solid #ccc;">
						<%if(!StringUtil.isBlank(StringUtil.deNull(user.getUserAndSn().getImage_parth()))){%>
							<div id="Preview" style="filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale);">
							</div>
							<img  width="200px" id="csimg" height="240px" height="220" src="../../../../../<%=StringUtil.deNull(user.getUserAndSn().getImage_parth())%>" />
							<input id="sshowimg" style="display:none;" value="<%=StringUtil.deNull(user.getUserAndSn().getImage_parth())%>"/>
						<%}else{%>
							<div id="Preview" style="filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale);">
							</div>
							<img  width="200px" id="csimg" height="240px" height="220" src="../resources/images/noneimg.jpg" />
							<input id="sshowimg" style="display:none;" value=""/>
						<%} %>
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th_wc">民族：</td>
						<td class="content_02_box_div_table_td_wc">
							<input class="input_title_text_noborder validate[maxSize[40]]" type="text" id="nation" name="nation" type="text" value="<%=StringUtil.deNull(user.getUserAndSn().getNation()) %>"/>
						</td>
						<td class="content_02_box_div_table_th_wc">籍贯：</td>
						<td class="content_02_box_div_table_td_wc">
							<input class="input_title_text_noborder validate[maxSize[40]]" type="text" id="natives" name="natives" type="text" value="<%=StringUtil.deNull(user.getUserAndSn().getNatives()) %>"/>
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th_wc">出生日期：</td>
						<td class="content_02_box_div_table_td_wc">
							<input class="input_title_text_noborder" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" id="birthday" name="birthday" type="text" readonly="readonly" value="<%=StringUtil.deNull(user.getUserAndSn().getBirthday()) %>" />
						</td>
						<td class="content_02_box_div_table_th_wc">政治面貌：</td>
						<td class="content_02_box_div_table_td_wc"><%=politics %></td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th_wc">健康状态：</td>
						<td class="content_02_box_div_table_td_wc"><%=health_state %></td>
						<td class="content_02_box_div_table_th_wc">婚姻状态：</td>
						<td class="content_02_box_div_table_td_wc"><%=ismarry %></td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th_wc">血型：</td>
						<td class="content_02_box_div_table_td_wc">
							<input class="input_title_text_noborder validate[maxSize[50]]" type="text" id="blood_type" name="blood_type" type="text" value="<%=StringUtil.deNull(user.getUserAndSn().getBlood_type())%>"/>
						</td>
						<td class="content_02_box_div_table_th_wc">视力：</td>
						<td class="content_02_box_div_table_td_wc">
							<input class="input_title_text_noborder validate[maxSize[50]]" type="text" id="vision" name="vision" type="text" value="<%=StringUtil.deNull(user.getUserAndSn().getVision())%>"/>
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th_wc">身高：</td>
						<td class="content_02_box_div_table_td_wc">
							<input class="input_title_text_noborder validate[maxSize[50]]" type="text" id="stature" name="stature" type="text" value="<%=StringUtil.deNull(user.getUserAndSn().getStature())%>"/>
						</td>
						<td class="content_02_box_div_table_th_wc">身份证号：</td>
						<td class="content_02_box_div_table_td_wc">
							<input class="input_title_text_noborder validate[maxSize[50]]" type="text" id="idcard" name="idcard" type="text" value="<%=StringUtil.deNull(user.getUserIdcard())%>"/>
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th_wc">学历：</td>
						<td class="content_02_box_div_table_td_wc"><%=education %></td>
						<td class="content_02_box_div_table_th_wc">毕业院校：</td>
						<td class="content_02_box_div_table_td_wc">
							<input class="input_title_text_noborder validate[maxSize[80]]" type="text" id="school" name="school" type="text" value="<%=StringUtil.deNull(user.getUserAndSn().getSchool())%>"/>
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th_wc">学位：</td>
						<td class="content_02_box_div_table_td_wc">
							<%=degree %>
						</td>
						<td class="content_02_box_div_table_th_wc">专业：</td>
						<td class="content_02_box_div_table_td_wc" colspan="2">
							<input class="input_title_text_noborder validate[maxSize[40]]" type="text" id="specialty" name="specialty" type="text" value="<%=StringUtil.deNull(user.getUserAndSn().getSpecialty()) %>"/>
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th_wc">掌握外国语言：</td>
						<td class="content_02_box_div_table_td_wc"><%=languagetype %></td>
						<td class="content_02_box_div_table_th_wc">外语水平等级：</td>
						<td class="content_02_box_div_table_td_wc" colspan="2"><%=languagelevel %></td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th_wc">职称类型：</td>
						<td class="content_02_box_div_table_td_wc">
							<%=titletype %>
						</td>
						<td class="content_02_box_div_table_th_wc">职称等级：</td>
						<td class="content_02_box_div_table_td_wc" colspan="2">
							<%=titles %>
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th_wc">参加工作时间：</td>
						<td class="content_02_box_div_table_td_wc">
							<input class="input_title_text_noborder" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" 
										id="worktime" name="worktime" readonly="readonly"
										type="text" value="<%=StringUtil.deNull(user.getUserAndSn().getWorktime())%>"/>
						</td>
						<td class="content_02_box_div_table_th_wc">加入本单位时间：</td>
						<td class="content_02_box_div_table_td_wc" colspan="2">
							<input class="input_title_text_noborder" type="text" readonly="readonly"
										onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" id="jointime" name="jointime"	
										type="text" value="<%=StringUtil.deNull(user.getUserAndSn().getJointime())%>"/>
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th_wc">移动电话：</td>
						<td class="content_02_box_div_table_td_wc">
							<input class="input_title_text_noborder validate[maxSize[50]]" type="text" id="user_mobiletel1" name="user_mobiletel1" type="text" value="<%=StringUtil.deNull(user.getUserMobiletel1())%>"/>
						</td>
						<td class="content_02_box_div_table_th_wc">户籍地址：</td>
						<td class="content_02_box_div_table_td_wc" colspan="2">
							<input class="input_title_text_noborder validate[maxSize[200]]" type="text" id="nativesaddress" name="nativesaddress" type="text" value="<%=StringUtil.deNull(user.getUserAndSn().getNativesaddress())%>"/>
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th_wc">家庭电话：</td>
						<td class="content_02_box_div_table_td_wc">
							<input class="input_title_text_noborder validate[maxSize[50]]" type="text" id="user_hometel" name="user_hometel" type="text" value="<%=StringUtil.deNull(user.getUserHometel())%>"/>
						</td>
						<td class="content_02_box_div_table_th_wc">家庭住址：</td>
						<td class="content_02_box_div_table_td_wc" colspan="2">
							<input class="input_title_text_noborder validate[maxSize[200]]" type="text" id="homeadress" name="homeadress" type="text" value="<%=StringUtil.deNull(user.getUserAddress())%>"/>
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th_wc">职位：</td>
						<td>
							<input class="input_title_text_noborder validate[maxSize[50]]" type="text" id="duties" name="duties" type="text" value="<%=StringUtil.deNull(user.getUserAndSn().getDuties())%>"/>
						</td>
						<td class="content_02_box_div_table_th_wc">电子邮件：</td>
						<td class="content_02_box_div_table_td_wc" colspan="2">
							<input class="input_title_text_noborder validate[maxSize[50]]" type="text" id="email" name="email" type="text" value="<%=StringUtil.deNull(user.getUser_email())%>"/>
						</td>
						
					</tr>
					<tr>
						<td class="content_02_box_div_table_th_wc">人事档案存放处：</td>
						<td class="content_02_box_div_table_td_wc" colspan="3">
							<input class="input_title_text_noborder validate[maxSize[200]]" type="text" id="userfilespace" name="userfilespace" type="text" value="<%=StringUtil.deNull(user.getUserAndSn().getUserfilespace())%>"/>
						</td>
					</tr>
				</table>
			</div>
			
			<div class="content_02_box_title_bg" style="width: 770px;margin-top: 15px;">
				<div style="margin-left: 10px;float: left">学习简历</div>
				<div class="addOneTr" style="margin-right: 10px;float: right;cursor: pointer;">添加</div>
			</div>
			<table class="content_02_box_div_table user_data_table" width="100%" border="0" cellspacing="0" cellpadding="0" datatype="1" id="user_data_1">
				<tr>
					<th class="content_02_box_div_table_th" style="width:20%; text-align: center;font-weight: bold;">起止时间</th>
					<th class="content_02_box_div_table_th" style="width:30%; text-align: center;font-weight: bold;">学习/培训单位</th>
					<th class="content_02_box_div_table_th" style="width:20%; text-align: center;font-weight: bold;">身份/职务</th>
					<th class="content_02_box_div_table_th" style="width:20%; text-align: center;font-weight: bold;">相关证书</th>
					<th class="content_02_box_div_table_th" style="width:10%; text-align: center;font-weight: bold;">操作</th>
				</tr>
				<tr data_id=" ">
					<td class="content_02_box_div_table_td"><input class="input_title_text_noborder input_text_center_wc arg1" type="text"/></td>
					<td class="content_02_box_div_table_td"><input class="input_title_text_noborder input_text_center_wc arg2" type="text" /></td>
					<td class="content_02_box_div_table_td"><input class="input_title_text_noborder input_text_center_wc arg3" type="text" /></td>
					<td class="content_02_box_div_table_td"><input class="input_title_text_noborder input_text_center_wc arg4" type="text" /></td>
					<td class="content_02_box_div_table_td" style="text-align: center;"><a class="deleteOneTr" href="####">删除</a></td>
				</tr>
			</table>
			
			<div class="content_02_box_title_bg" style="width: 770px;margin-top: 15px;">
				<div style="margin-left: 10px;float: left">工作简历</div>
				<div class="addOneTr" style="margin-right: 10px;float: right;cursor: pointer;">添加</div>
			</div>
			<table class="content_02_box_div_table user_data_table" width="100%" border="0" cellspacing="0" cellpadding="0" datatype="2" id="user_data_2">
				<tr>
					<th class="content_02_box_div_table_th" style="width:15%; text-align: center;font-weight: bold;">起止时间</th>
					<th class="content_02_box_div_table_th" style="width:25%; text-align: center;font-weight: bold;">工作单位</th>
					<th class="content_02_box_div_table_th" style="width:15%; text-align: center;font-weight: bold;">职务</th>
					<th class="content_02_box_div_table_th" style="width:10%; text-align: center;font-weight: bold;">月薪</th>
					<th class="content_02_box_div_table_th" style="width:25%; text-align: center;font-weight: bold;">证明人及电话</th>
					<th class="content_02_box_div_table_th" style="width:10%; text-align: center;font-weight: bold;">操作</th>
				</tr>
				<tr data_id=" ">
					<td class="content_02_box_div_table_td"><input class="input_title_text_noborder input_text_center_wc arg1" type="text" /></td>
					<td class="content_02_box_div_table_td"><input class="input_title_text_noborder input_text_center_wc arg2" type="text" /></td>
					<td class="content_02_box_div_table_td"><input class="input_title_text_noborder input_text_center_wc arg3" type="text" /></td>
					<td class="content_02_box_div_table_td"><input class="input_title_text_noborder input_text_center_wc arg4" type="text" /></td>
					<td class="content_02_box_div_table_td"><input class="input_title_text_noborder input_text_center_wc arg5" type="text" /></td>
					<td class="content_02_box_div_table_td" style="text-align: center;"><a class="deleteOneTr" href="####">删除</a></td>
				</tr>
			</table>
			
			<div class="content_02_box_title_bg" style="width: 770px;margin-top: 15px;">
				<div style="margin-left: 10px;float: left">家庭主要成员</div>
				<div class="addOneTr" style="margin-right: 10px;float: right;cursor: pointer;">添加</div>
			</div>
			<table class="content_02_box_div_table user_data_table" width="100%" border="0" cellspacing="0" cellpadding="0" datatype="3" id="user_data_3">
				<tr>
					<th class="content_02_box_div_table_th" style="width:15%; text-align: center;font-weight: bold;">关系</th>
					<th class="content_02_box_div_table_th" style="width:15%; text-align: center;font-weight: bold;">姓名</th>
					<th class="content_02_box_div_table_th" style="width:15%; text-align: center;font-weight: bold;">出生年月</th>
					<th class="content_02_box_div_table_th" style="width:30%; text-align: center;font-weight: bold;">工作单位及职务</th>
					<th class="content_02_box_div_table_th" style="width:15%; text-align: center;font-weight: bold;">联系方式</th>
					<th class="content_02_box_div_table_th" style="width:10%; text-align: center;font-weight: bold;">操作</th>
				</tr>
				<tr data_id=" ">
					<td class="content_02_box_div_table_td"><input class="input_title_text_noborder input_text_center_wc arg1" type="text" /></td>
					<td class="content_02_box_div_table_td"><input class="input_title_text_noborder input_text_center_wc arg2" type="text" /></td>
					<td class="content_02_box_div_table_td"><input class="input_title_text_noborder input_text_center_wc arg3" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/></td>
					<td class="content_02_box_div_table_td"><input class="input_title_text_noborder input_text_center_wc arg4" type="text" /></td>
					<td class="content_02_box_div_table_td"><input class="input_title_text_noborder input_text_center_wc arg5" type="text" /></td>
					<td class="content_02_box_div_table_td" style="text-align: center;"><a class="deleteOneTr" href="####">删除</a></td>
				</tr>
			</table>
			
			<div class="content_02_box_title_bg" style="width: 770px;margin-top: 15px;">
				<div style="margin-left: 10px;float: left">奖惩记录</div>
				<div class="addOneTr" style="margin-right: 10px;float: right;cursor: pointer;">添加</div>
			</div>
			<table class="content_02_box_div_table user_data_table" width="100%" border="0" cellspacing="0" cellpadding="0" datatype="4" id="user_data_4">
				<tr>
					<th class="content_02_box_div_table_th" style="width:20%; text-align: center;font-weight: bold;">时间</th>
					<th class="content_02_box_div_table_th" style="width:30%; text-align: center;font-weight: bold;">奖惩名称</th>
					<th class="content_02_box_div_table_th" style="width:40%; text-align: center;font-weight: bold;">因何授奖或惩处</th>
					<th class="content_02_box_div_table_th" style="width:10%; text-align: center;font-weight: bold;">操作</th>
				</tr>
				<tr data_id=" ">
					<td class="content_02_box_div_table_td"><input class="input_title_text_noborder input_text_center_wc arg1" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/></td>
					<td class="content_02_box_div_table_td"><input class="input_title_text_noborder input_text_center_wc arg2" type="text" /></td>
					<td class="content_02_box_div_table_td"><input class="input_title_text_noborder input_text_center_wc arg3" type="text" /></td>
					<td class="content_02_box_div_table_td" style="text-align: center;"><a class="deleteOneTr" href="####">删除</a></td>
				</tr>
			</table>
			
			<div class="content_02_box_title_bg" style="width: 770px;margin-top: 15px;">
				<div style="margin-left: 10px;float: left">其他信息</div>
			</div>
			<table class="content_02_box_div_table" width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<th class="content_02_box_div_table_th" style="width:10%; text-align: center;font-weight: bold;">证&nbsp;&nbsp;&nbsp;&nbsp;书</th>
					<td class="content_02_box_div_table_td">
						<input class="input_title_text_noborder" type="text" id="certificate" name="certificate" type="text" value="<%=StringUtil.deNull(user.getUserAndSn().getCertificate())%>"/>
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" style="width:10%; text-align: center;font-weight: bold;">备&nbsp;&nbsp;&nbsp;&nbsp;注</th>
					<td class="content_02_box_div_table_td">
						<input class="input_title_text_noborder" type="text" id="remark" name="remark" type="text" value="<%=StringUtil.deNull(user.getUserAndSn().getRemark())%>"/>
					</td>
				</tr>
				<tr id="user_photo">
					<th class="content_02_box_div_table_th" style="width:10%; text-align: center;font-weight: bold;">照片上传</th>
					<td class="content_02_box_div_table_td"><input type="file" id="imgfile" name="imgfile" onchange="viewmypic(this)" class="input_188" /></td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" style="width:10%; text-align: center;font-weight: bold;">附&nbsp;&nbsp;&nbsp;&nbsp;件</th>
					<td class="content_02_box_div_table_td">
						<a href="#" id="_filebut">&nbsp;请选择文件</a>
						<ul id="_fileshow"></ul>
					</td>
				</tr>
			</table>
		</div>
		<div class="hidden_print_div">
			<table class="cue_box_foot">
				<tr>
					<td>
						<input class="but_h_01" type="button" value="打印预览" onclick="printView()" />
						<input class="but_h_01" type="button" id="resert" value="保存" onclick="updatesubmit()" />
					</td>
				</tr>
			</table>
		</div>
		<input id="action" name="action" type="hidden" value="" />
		<input id="attachmentid" name="attachmentid" type="hidden" value="<%=attachment_id %>"  />
		<input id="orgid" name="orgid" type="hidden" value="<%=orgid%>"  />
		<input type="hidden" name="userid" id="userid" value="<%=userid%>" />
		<input type="hidden" name="userdata" id="userdata" />
	</form>
	<form action="uploadimage.jsp?attachment_ids=<%=attachment_id %>" target="hiddenFrame" method="post" enctype="multipart/form-data" name="form_up" id="form_up">
	</form>
	<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>