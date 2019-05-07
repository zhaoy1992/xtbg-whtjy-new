<%-- 
	描述：望城人事档案打印页面
	作者：陈建华
	版本：1.0
	日期：2013-7-23
 --%>
<%@page import="com.chinacreator.sysmgrcore.entity.User"%>
<%@page import="java.util.Date"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.pub.directory.service.impl.DirectoryServiceImpl"%>
<%@page import="com.chinacreator.xtbg.pub.directory.service.DirectoryServiceIfc"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.xtbg.pub.directory.dao.imploracle.DirectoryDaoImpl"%>
<%
	String path = request.getContextPath();
	String userid = request.getParameter("user_id");
	DirectoryServiceIfc directoryServiceIfc = new DirectoryServiceImpl();
	User user=new User();
	user=directoryServiceIfc.getuserinfo(userid);
	
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
	String titletype= directoryServiceIfc.createSelectHtml("v_wc_titletype",user.getUserSex(),"titletype");
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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>JGRID</title>
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
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
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
<style type="text/css">
	body{font-size: 12px;}
</style>
<script type="text/javascript">
	var ajax_url = "<%=path%>"+"/ccapp/xtbg/public/directory/jsp/";
	jQuery(function(){
		jQuery("select").each(function(){		//把所有的select都转换为显示值
			var selectVar = jQuery(this).find("option:selected").text();
			jQuery(this).parent().html(selectVar);
		});
		listUserData(<%=userid%>);
	})
	
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
								tmp_tr.find(".arg1").html(value.arg1);
								tmp_tr.find(".arg2").html(value.arg2);
								tmp_tr.find(".arg3").html(value.arg3);
								tmp_tr.find(".arg4").html(value.arg4);
								tmp_tr.find(".arg5").html(value.arg5);
							} else {
								var tmp_tr = jQuery("#user_data_"+tmp_type).find("tr:eq(1)").clone(true);
								tmp_tr.attr("data_id",value.id);
								tmp_tr.find(".arg1").html(value.arg1);
								tmp_tr.find(".arg2").html(value.arg2);
								tmp_tr.find(".arg3").html(value.arg3);
								tmp_tr.find(".arg4").html(value.arg4);
								tmp_tr.find(".arg5").html(value.arg5);
								jQuery("#user_data_"+tmp_type).append(tmp_tr);		//添加行到表格
							}
						});
						jQuery(".user_data").each(function(){
							var tmp_table = jQuery(this);
							var num = tmp_table.find("tr").length;
							if(num < 6){
								for(var i = 6-num;i > 0;i--){
									var tmp_tr = tmp_table.find("tr:eq(1)").clone(true);
									tmp_tr.find("td").html("&nbsp;");
									tmp_table.append(tmp_tr);
								}
							} else {
								tmp_table.find("th:eq(0)").attr("rowspan",num);								
							}
						});
					} else {
						//查询出错，屏蔽错误消息
						//alert("查询数据失败！errorCode["+data.code.index+"]");
					}
				}
			});
		}
	}
	function backTo(){
		removeAlertWindows('printWindowId',true);
	}
</script>
</head>
<body style="overflow-y: auto;margin: 0;padding: 0;">
	<div id="print_div">
		<div style="width: 50px;height:auto; float: left;">&nbsp;</div>
		<div style="width: 640px;height:auto; float: left;">
			<table width="100%" style="margin:50px 0 15px 0;" cellspacing="0" cellpadding="0">
				<tr style="border: none">
					<td colspan="5" align="center" style="border: none"><h1>人员档案信息</h1></td>
				</tr>
				<tr><td colspan="5">&nbsp;</td></tr>
				<tr style="border: none">
					<td colspan="2" align="left" style="border: none">&nbsp;&nbsp;编号：<%=StringUtil.deNull(user.getUserAndSn().getUsernumber()) %></td>
					<td colspan="3" align="right" style="border: none">人员类型：<span><%=usertype %></span>&nbsp;&nbsp;</td>
				</tr>
			</table>
			<table width="100%" border="1" style="border:1px solid #000;" bordercolor="#000" cellspacing="0" cellpadding="0">
				<tr>
					<td style="text-align: right;width: 20%;height: 47px;line-height: 25px;padding-right: 10px;">姓名</td>
					<td style="text-align: left;width: 20%;height: 47px;line-height: 25px;padding-left: 10px;"><%=StringUtil.deNull(user.getUserRealname()) %></td>
					<td style="text-align: right;width: 20%;height: 47px;line-height: 25px;padding-right: 10px;">性别</td>
					<td style="text-align: left;width: 20%;height: 47px;line-height: 25px;padding-left: 10px;"><%=sex %></td>
					<td rowspan="4" width="20%">
						<%if(!StringUtil.isBlank(StringUtil.deNull(user.getUserAndSn().getImage_parth()))){%>
							<div id="Preview" style="filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale);">
							</div>
							<img  width="150px" id="csimg" height="190px" src="../../../../../<%=StringUtil.deNull(user.getUserAndSn().getImage_parth())%>" />
						<%}else{%>
							<div id="Preview" style="filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale);">
							</div>
							<img  width="150px" id="csimg" height="180px" src="../resources/images/noneimg.jpg" />
						<%} %>
					</td>
				</tr>
				
				<tr>
					<td style="text-align: right;width: 20%;height: 47px;line-height: 25px;padding-right: 10px;">民族</td>
					<td style="text-align: left;width: 20%;height: 47px;line-height: 25px;padding-left: 10px;"><%=StringUtil.deNull(user.getUserAndSn().getNation()) %></td>
					<td style="text-align: right;width: 20%;height: 47px;line-height: 25px;padding-right: 10px;">籍贯</td>
					<td style="text-align: left;width: 20%;height: 47px;line-height: 25px;padding-left: 10px;"><%=StringUtil.deNull(user.getUserAndSn().getNatives()) %></td>
				</tr>
				
				<tr>
					<td style="text-align: right;width: 20%;height: 47px;line-height: 25px;padding-right: 10px;">出生日期</td>
					<td style="text-align: left;width: 20%;height: 47px;line-height: 25px;padding-left: 10px;"><%=StringUtil.deNull(user.getUserAndSn().getBirthday()) %></td>
					<td style="text-align: right;width: 20%;height: 47px;line-height: 25px;padding-right: 10px;">政治面貌</td>
					<td style="text-align: left;width: 20%;height: 47px;line-height: 25px;padding-left: 10px;"><%=politics %></td>
				</tr>
				
				<tr>
					<td style="text-align: right;width: 20%;height: 47px;line-height: 25px;padding-right: 10px;">健康状态</td>
					<td style="text-align: left;width: 20%;height: 47px;line-height: 25px;padding-left: 10px;"><%=health_state %></td>
					<td style="text-align: right;width: 20%;height: 47px;line-height: 25px;padding-right: 10px;">婚姻状态</td>
					<td style="text-align: left;width: 20%;height: 47px;line-height: 25px;padding-left: 10px;"><%=ismarry %></td>
				</tr>
				
				<tr>
					<td style="text-align: right;width: 20%;height: 47px;line-height: 25px;padding-right: 10px;">血型</td>
					<td style="text-align: left;width: 20%;height: 47px;line-height: 25px;padding-left: 10px;"><%=StringUtil.deNull(user.getUserAndSn().getBlood_type())%></td>
					<td style="text-align: right;width: 20%;height: 47px;line-height: 25px;padding-right: 10px;">视力</td>
					<td style="text-align: left;width: 20%;height: 47px;line-height: 25px;padding-left: 10px;" colspan="2"><%=StringUtil.deNull(user.getUserAndSn().getVision())%></td>
				</tr>
				
				<tr>
					<td style="text-align: right;width: 20%;height: 47px;line-height: 25px;padding-right: 10px;">身高</td>
					<td style="text-align: left;width: 20%;height: 47px;line-height: 25px;padding-left: 10px;"><%=StringUtil.deNull(user.getUserAndSn().getStature())%></td>
					<td style="text-align: right;width: 20%;height: 47px;line-height: 25px;padding-right: 10px;">身份证号</td>
					<td style="text-align: left;width: 20%;height: 47px;line-height: 25px;padding-left: 10px;" colspan="2"><%=StringUtil.deNull(user.getUserIdcard())%></td>
				</tr>
				
				<tr>
					<td style="text-align: right;width: 20%;height: 47px;line-height: 25px;padding-right: 10px;">学历</td>
					<td style="text-align: left;width: 20%;height: 47px;line-height: 25px;padding-left: 10px;"><%=education %></td>
					<td style="text-align: right;width: 20%;height: 47px;line-height: 25px;padding-right: 10px;">毕业院校</td>
					<td style="text-align: left;width: 20%;height: 47px;line-height: 25px;padding-left: 10px;" colspan="2"><%=StringUtil.deNull(user.getUserAndSn().getSchool())%></td>
				</tr>
				
				<tr>
					<td style="text-align: right;width: 20%;height: 47px;line-height: 25px;padding-right: 10px;">学位</td>
					<td style="text-align: left;width: 20%;height: 47px;line-height: 25px;padding-left: 10px;"><%=degree %></td>
					<td style="text-align: right;width: 20%;height: 47px;line-height: 25px;padding-right: 10px;">专业</td>
					<td style="text-align: left;width: 20%;height: 47px;line-height: 25px;padding-left: 10px;" colspan="2"><%=StringUtil.deNull(user.getUserAndSn().getSpecialty()) %></td>
				</tr>
				
				<tr>
					<td style="text-align: right;width: 20%;height: 47px;line-height: 25px;padding-right: 10px;">掌握何种外国语言</td>
					<td style="text-align: left;width: 20%;height: 47px;line-height: 25px;padding-left: 10px;"><%=languagetype %></td>
					<td style="text-align: right;width: 20%;height: 47px;line-height: 25px;padding-right: 10px;">外语水平（等级）</td>
					<td style="text-align: left;width: 20%;height: 47px;line-height: 25px;padding-left: 10px;" colspan="2"><%=languagelevel %></td>
				</tr>
				
				<tr>
					<td style="text-align: right;width: 20%;height: 47px;line-height: 25px;padding-right: 10px;">职称类型</td>
					<td style="text-align: left;width: 20%;height: 47px;line-height: 25px;padding-left: 10px;"><%=titletype %></td>
					<td style="text-align: right;width: 20%;height: 47px;line-height: 25px;padding-right: 10px;">职称等级</td>
					<td style="text-align: left;width: 20%;height: 47px;line-height: 25px;padding-left: 10px;" colspan="2"><%=titles %></td>
				</tr>
				
				<tr>
					<td style="text-align: right;width: 20%;height: 47px;line-height: 25px;padding-right: 10px;">参加工作时间</td>
					<td style="text-align: left;width: 20%;height: 47px;line-height: 25px;padding-left: 10px;"><%=StringUtil.deNull(user.getUserAndSn().getWorktime())%></td>
					<td style="text-align: right;width: 20%;height: 47px;line-height: 25px;padding-right: 10px;">加入本单位时间</td>
					<td style="text-align: left;width: 20%;height: 47px;line-height: 25px;padding-left: 10px;" colspan="2"><%=StringUtil.deNull(user.getUserAndSn().getJointime())%></td>
				</tr>
				
				<tr>
					<td style="text-align: right;width: 20%;height: 47px;line-height: 25px;padding-right: 10px;">移动电话</td>
					<td style="text-align: left;width: 20%;height: 47px;line-height: 25px;padding-left: 10px;"><%=StringUtil.deNull(user.getUserMobiletel1())%></td>
					<td style="text-align: right;width: 20%;height: 47px;line-height: 25px;padding-right: 10px;">户籍地址</td>
					<td style="text-align: left;width: 20%;height: 47px;line-height: 25px;padding-left: 10px;" colspan="2"><%=StringUtil.deNull(user.getUserAndSn().getNativesaddress())%></td>
				</tr>
				
				<tr>
					<td style="text-align: right;width: 20%;height: 47px;line-height: 25px;padding-right: 10px;">家庭电话</td>
					<td style="text-align: left;width: 20%;height: 47px;line-height: 25px;padding-left: 10px;"><%=StringUtil.deNull(user.getUserHometel())%></td>
					<td style="text-align: right;width: 20%;height: 47px;line-height: 25px;padding-right: 10px;">家庭住址</td>
					<td style="text-align: left;width: 20%;height: 47px;line-height: 25px;padding-left: 10px;" colspan="2"><%=StringUtil.deNull(user.getUserAddress())%></td>
				</tr>
				
				<tr style="page-break-after:always;">
					<td style="text-align: right;width: 20%;height: 47px;line-height: 25px;padding-right: 10px;">电子邮件</td>
					<td style="text-align: left;width: 20%;height: 47px;line-height: 25px;padding-left: 10px;"><%=StringUtil.deNull(user.getUser_email())%></td>
					<td style="text-align: right;width: 20%;height: 47px;line-height: 25px;padding-right: 10px;">人事档案存放处</td>
					<td style="text-align: left;width: 20%;height: 47px;line-height: 25px;padding-left: 10px;" colspan="2"><%=StringUtil.deNull(user.getUserAndSn().getUserfilespace())%></td>
				</tr>
			</table>
			<br/><br/><br/>
			<table class="user_data" datatype="1" id="user_data_1" width="100%" border="1" style="border:1px solid #000;" bordercolor="#000" cellspacing="0" cellpadding="0">
				<tr style="width:35px;height: 30px;">
					<th rowspan="6" style="width: 35px;">学习简历</th>
					<th style="width: 120px;">起止时间</th>
					<th style="width: 240px;">学习/培训单位</th>
					<th style="width: 120px;">身份/职务</th>
					<th style="width: 120px;">相关证书</th>
				</tr>
				<tr style="height: 30px;" data_id=" ">
					<td class="arg1" style="width: 120px;text-align:center;word-wrap:break-word;word-break:break-all;">&nbsp;</td>
					<td class="arg2" style="width: 240px;text-align:center;word-wrap:break-word;word-break:break-all;"></td>
					<td class="arg3" style="width: 120px;text-align:center;word-wrap:break-word;word-break:break-all;"></td>
					<td class="arg4" style="width: 120px;text-align:center;word-wrap:break-word;word-break:break-all;"></td>
				</tr>
			</table>
			<table class="user_data" datatype="2" id="user_data_2" width="100%" border="1" style="border:1px solid #000" bordercolor="#000" cellspacing="0" cellpadding="0">
				<tr style="width:35px; height: 30px;">
					<th rowspan="6" style="width: 35px;border-top: none;">工作简历</th>
					<th style="width: 120px;border-top: none;">起止时间</th>
					<th style="150px;border-top: none;">工作单位</th>
					<th style="width: 90px;border-top: none;">职务</th>
					<th style="width: 90px;border-top: none;">月薪</th>
					<th style="width: 150px;border-top: none;">证明人及电话</th>
				</tr>
				<tr style="height: 30px;" data_id=" ">
					<td class="arg1" style="width: 120px;text-align:center;word-wrap:break-word;word-break:break-all;">&nbsp;</td>
					<td class="arg2" style="width: 150px;text-align:center;word-wrap:break-word;word-break:break-all;"></td>
					<td class="arg3" style="width: 90px;text-align:center;word-wrap:break-word;word-break:break-all;"></td>
					<td class="arg4" style="width: 90px;text-align:center;word-wrap:break-word;word-break:break-all;"></td>
					<td class="arg5" style="width: 150px;text-align:center;word-wrap:break-word;word-break:break-all;"></td>
				</tr>
			</table>
			<table class="user_data" datatype="3" id="user_data_3" width="100%" border="1" style="border:1px solid #000;" bordercolor="#000" cellspacing="0" cellpadding="0">
				<tr style="35px; height: 30px;border-top: none;">
					<th rowspan="6" style="width: 35px;border-top: none;">家庭主要成员</th>
					<th style="width: 60px;border-top: none;">关系</th>
					<th style="width: 60px;border-top: none;">姓名</th>
					<th style="width: 100px;border-top: none;">出生年月</th>
					<th style="width: 270px;border-top: none;">工作单位及职务</th>
					<th style="width: 110px;border-top: none;">联系方式</th>
				</tr>
				<tr style="height: 30px;" data_id=" ">
					<td class="arg1" style="width: 60px;text-align:center;word-wrap:break-word;word-break:break-all;">&nbsp;</td>
					<td class="arg2" style="width: 60px;text-align:center;word-wrap:break-word;word-break:break-all;"></td>
					<td class="arg3" style="width: 100px;text-align:center;word-wrap:break-word;word-break:break-all;"></td>
					<td class="arg4" style="width: 270px;text-align:center;word-wrap:break-word;word-break:break-all;" ></td>
					<td class="arg5" style="width: 110px;text-align:center;word-wrap:break-word;word-break:break-all;"></td>
				</tr>
			</table>
			<table class="user_data" datatype="4" id="user_data_4" width="100%" border="1" style="border:1px solid #000;" bordercolor="#000" cellspacing="0" cellpadding="0">
				<tr style="width:35px; height: 30px;border-top: none;">
					<th rowspan="6" style="width: 35px;border-top: none;">奖惩记录</th>
					<th style="width: 120px;border-top: none;">时间</th>
					<th style="width: 180px;border-top: none;">奖惩名称</th>
					<th style="width: 300px;border-top: none;">因何授奖或惩处</th>
				</tr>
				<tr style="height: 30px;" data_id=" ">
					<td class="arg1" class="arg1"style="width: 120px;text-align:center;word-wrap:break-word;word-break:break-all;">&nbsp;</td>
					<td class="arg2" style="width: 180px;text-align:center;word-wrap:break-word;word-break:break-all;"></td>
					<td class="arg3" style="width: 300px;text-align:center;word-wrap:break-word;word-break:break-all;"></td>
				</tr>
			</table>
			<table width="100%" border="1" style="border:1px solid #000;" bordercolor="#000" cellspacing="0" cellpadding="0">
				<tr style="height: 50px;border-top: none;">
					<th style="width: 35px;border-top: none;">证书</th>
					<td style="border-top: none;">&nbsp;<%=StringUtil.deNull(user.getUserAndSn().getCertificate())%></td>
				</tr>
				<tr style="height: 50px;">
					<th style="width: 35px;">备注</th>
					<td>&nbsp;<%=StringUtil.deNull(user.getUserAndSn().getRemark())%></td>
				</tr>
			</table>
		</div>
		<div style="width: 60px;height:auto; float: left;">&nbsp;</div>
	</div>
	<div class="cue_box_foot">
		<input class="but_h_01" type="button" value="打印" onclick="prn1_preview()" />
		<input class="but_h_01" type="button" value="返回" onclick="backTo()" />
	</div>
</body>
</html>
<script type="text/javascript">
	var LODOP; //声明为全局变量 
	function prn1_preview() {
		//设置字体大小和显示位置
		//打字份数赋值		
		CreateOneFormPage();	
		LODOP.PREVIEW();
	};

	function CreateOneFormPage(){
		LODOP=getLodop(document.getElementById('LODOP'),document.getElementById('LODOP_EM'));  
		LODOP.PRINT_INIT("打印人员档案信息");
		LODOP.SET_PRINT_STYLE("FontSize",9);
		LODOP.SET_PRINT_STYLE("FontName","宋体");
        jQuery("#print_efficacy").text(jQuery("#sendEfficacy").val());
		LODOP.ADD_PRINT_TEXT(0,0,260,39,"");
		LODOP.ADD_PRINT_HTM(0,0,800,980,document.getElementById("print_div").innerHTML);
	};
</script>