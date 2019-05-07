<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%>
<%@page import="com.chinacreator.xtbg.core.guestreception.entity.QueryBean"%>
<%@page import="com.chinacreator.xtbg.core.guestreception.dao.GuestreceptionDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.alibaba.fastjson.JSONArray"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.alibaba.fastjson.JSONArray"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String userid = accesscontroler.getUserID();
	String grinfoId = request.getParameter("grinfo");
	String from = request.getParameter("from");
	String subid = request.getParameter("subid");
	
	GuestreceptionDao guestreceptionDao = (GuestreceptionDao)LoadSpringContext.getApplicationContext().getBean("guestreceptionDaoImpl");
	guestreceptionDao.changeViewState(grinfoId, userid, "4");
	QueryBean queryBean=new QueryBean();
	//基本信息
	String title="";
	String guestorg_name="";
	String dutyuser="";
	String dutyId="";
	String dutyuserphone="";
	String input_starttime="";
	String input_endtime="";
	String guestContact="";
	String guestContactPhone="";
	String content="";
	if(!StringUtil.isBlank(grinfoId)){
		queryBean= guestreceptionDao.queryGuestInfoAll(grinfoId);
		title=queryBean.getGuestreceptionBean().getGrinfo_titile();
		guestorg_name=queryBean.getGuestreceptionBean().getGrinfo_receptionorg();
		dutyuser=	queryBean.getGuestreceptionBean().getGrinfo_dutyofficer();
		dutyId=queryBean.getGuestreceptionBean().getGrinfo_dutyofficerid();
		dutyuserphone=  queryBean.getGuestreceptionBean().getGrinfo_tel();
		input_starttime=queryBean.getGuestreceptionBean().getGrinfo_startime().toString();
		input_endtime=queryBean.getGuestreceptionBean().getGrinfo_endtime().toString();
		guestContact=queryBean.getGuestreceptionBean().getGrinfo_guestcontact();
		guestContactPhone=queryBean.getGuestreceptionBean().getGrinfo_guestphone();
		content=queryBean.getGuestreceptionBean().getGrinfo_content();
	}
	
%>
<style type="text/css">
.aa {
	color: red;
	border: 0px scrollbar;
}
;
</style>

<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js" charset="utf-8"></script>

<!-- 引入my97时间控件 -->
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript" charset="utf-8"></script>

<!-- 引入formvValidatetion -->
<link rel="stylesheet" href="../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>

<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<!-- 公共部分引用结束 -->
<script type="text/javascript">
<%-- var grinfoStatus='<%=grinfoStatus%>'; --%>
//获得登录用户的id
var loginUserID='<%=userid%>';
$(function(){
	copyvalue();
	$("#dayTable").rowspan(0);
	
})
//copy值
function copyvalue(){
	var grinfoid='<%=grinfoId%>';
	if( grinfoid!=null){
		$("#title").html('<%=title%>');
		$("#guestorg_name").html('<%=guestorg_name%>');
		$("#dutyuser").html('<%=dutyuser%>');
		$("#dutyId").html('<%=dutyId%>');
		$("#dutyuserphone").html('<%=dutyuserphone%>');
		$("#input_starttime").html('<%=input_starttime%>');
		$("#input_endtime").html('<%=input_endtime%>');
		$("#guestContact").html('<%=guestContact%>');
		$("#guestContactPhone").html('<%=guestContactPhone%>');
		$("#content").html(replaceTextarea2('<%=content%>'));
		}
}


	//保存textarea换行
	function replaceTextarea1(str){
		var reg=new RegExp("\n","g"); 
		var reg1=new RegExp(" ","g"); 
		str = str.replace(reg,"＜br＞"); 
		str = str.replace(reg1,"＜p＞"); 
		return str; 
	}

	//取出textarea显示换行
	function replaceTextarea2(str){
		var reg=new RegExp("＜br＞","g"); 
		var reg1=new RegExp("＜p＞","g"); 
		str = str.replace(reg,"\n"); 
		str = str.replace(reg1," "); 
		return str; 
	} 
	
	/*
	函数: closedwo 
	说明:  关闭(关闭页面操作)
	参数:   无
	返回值: 无
	*/
	function closed(){
		window.top.window.frames["_document_body_mian_firstPagerAAAS"].document.location.reload();
		removeWindows('<%=subid%>',true);
		}	


	jQuery.fn.rowspan = function(colIdx) { //封装的一个JQuery小插件
		return this.each(function(){
		var that;
		$('tr', this).each(function(row) {
		$('td:eq('+colIdx+')', this).filter(':visible').each(function(col) {
		if (that!=null && $(this).html() == $(that).html()) {
		rowspan = $(that).attr("rowSpan");
		if (rowspan == undefined) {
		$(that).attr("rowSpan",1);
		rowspan = $(that).attr("rowSpan"); }
		rowspan = Number(rowspan)+1;
		$(that).attr("rowSpan",rowspan);
		$(this).hide();
		} else {
		that = this;
		}
		});
		});
		});
		}
	
</script>
</head>
<body style=" overflow-y:hidden;" onload="adaptationWH('_top','vcenter','50')">
	<div class="content_02" style="overflow:hidden;">
	<!-- 栏目 -->
	<div class="content_02_top" style=""  id="_top">
		<input id="backbtn" name="backbtn" type="button" class="but_y_01"
									onClick="removeWindows('<%=subid%>',true,false);closed();" value="返回" />	
								
	</div>
	<div id="vcenter" scrolling="yes" style="float: left; width: 100%; overflow: scroll; height: 650px;">
	<div style="float: left; width: 775px; ">
	<div class="content_02_box">
	<div class="content_02_box_title_bg">
			<span>接待基本信息</span>
	</div>
	<div class="content_02_box_div">
	<!-- 基本信息 -->
		<table  class="content_02_box_div_table" id="queryTable"
			cellspacing="0" cellpadding="0" border="0">
			<tr>
				<th   class="content_02_box_div_table_th" width="100px">
					主题：
				</th>
				<td id="title" class="content_02_box_div_table_td" colspan="5">
					
				</td>
				
			</tr>
			<tr>
				<th  class="content_02_box_div_table_th">
					宾客单位：
				</th>
				<td class="content_02_box_div_table_td"  >
					<div id="guestorg_name" style="width: 100px"></div>
				</td>
				<th class="content_02_box_div_table_th" >
					抵达时间：
				</th>
				<td class="content_02_box_div_table_td" id="input_starttime" style="width: 150px">
				</td>
				<th class="content_02_box_div_table_th">
					离开时间：
				</th>
				<td class="content_02_box_div_table_td" id="input_endtime" style="width: 150px">
				</td>
			</tr>
			<tr>
				<th class="content_02_box_div_table_th">
					联络人：
				</th>
				<td class="content_02_box_div_table_td" id="dutyuser">
				</td>
				<th class="content_02_box_div_table_th">
					联系电话：
				</th>
				<td class="content_02_box_div_table_td" id="dutyuserphone" colspan="4">
				</td>
			</tr>
			<tr>
				<th class="content_02_box_div_table_th">
					来宾联系人：
				</th>
				<td class="content_02_box_div_table_td" id="guestContact">
				</td>
				<th class="content_02_box_div_table_th">
					联系电话：
				</th>
				<td class="content_02_box_div_table_td" id="guestContactPhone" colspan="4">
				</td>
			</tr>
		</table>
		</div>
		</div>
		<!-- 行程安排表 -->
			<div class="content_02_box">
			<div class="content_02_box_title_bg">
			<span>行程安排</span>
			</div>
			<div class="content_02_box_div">
			<table id="dayTable" id="dayTable" class="content_02_box_div_table_02" width="100%" cellspacing="0" cellpadding="0" border="0">
			<tr>
				<td class="content_02_box_div_table_td" >接待时间</td>
				<td class="content_02_box_div_table_td" >日程时间</td>
				<td class="content_02_box_div_table_td" >内容</td>
				<td class="content_02_box_div_table_td" >地点</td>
				<td class="content_02_box_div_table_td" >陪同人员</td>
			</tr>
			<!-- 显示的第一行 -->
			<%
				for (int i = 0; i < queryBean.getTravelList().size(); i++) {
					
			%>
			<tr name="dayrow">
					<td class="content_02_box_div_table_td">
						<%=queryBean.getTravelList().get(i).getTstarttime()%>
					</td>
					<td  class="content_02_box_div_table_td">
						<%=queryBean.getTravelList().get(i).getTtstarttime()%>
					</td>
					<td  class="content_02_box_div_table_td">
						<%=queryBean.getTravelList().get(i).getFromcontent()%>
					</td>
					<td  class="content_02_box_div_table_td">
						<%=queryBean.getTravelList().get(i).getPlace()%>
					</td>
					<td  class="content_02_box_div_table_td">
						<%=queryBean.getTravelList().get(i).getAccompany()%>
					</td>
			</tr>
			<%
				}
			%>
		</table>
		</div>
		</div>
		
		<!-- 宾客名单 -->
		<div class="content_02_box">
		<div class="content_02_box_title_bg">
		<span>来宾名单</span>
		</div>
		<div class="content_02_box_div">
		<table id="guestinfo" class="content_02_box_div_table_02" width="100%" cellspacing="0" cellpadding="0" border="0">
			<tr>
				<td class="content_02_box_div_table_td" >姓名</td>
				<td class="content_02_box_div_table_td" >性别</td>
				<td class="content_02_box_div_table_td" >单位及职务</td>
				<!--  
				<td width="29%"  class="guest_titelF_center">所在单位</td>
				-->
			</tr>
			<%
				for (int i = 0; i < queryBean.getGuestList().size(); i++) {
					
			%>
			<tr name="trguest">
				<td class="content_02_box_div_table_td">
					<%=queryBean.getGuestList().get(i).getGuestname()%>
				</td>
				<td class="content_02_box_div_table_td">
					<%=queryBean.getGuestList().get(i).getGuestsex()%>
				</td>
				<td class="content_02_box_div_table_td">
					<%=queryBean.getGuestList().get(i).getGuestpost()%>
				</td>
			</tr>
			<%
				
				}
			%>
		</table>
		</div>
		</div>
		<!-- 接待人员表 -->
		<div class="content_02_box">
		<div class="content_02_box_title_bg">
			<span>接待人员名单</span>
		</div>
		<div class="content_02_box_div">
		<table id="ptUserList" class="content_02_box_div_table_02" width="100%" cellspacing="0" cellpadding="0" border="0">
			<tr>
				<td class="content_02_box_div_table_td" >姓名</td>
				<td class="content_02_box_div_table_td" >性别</td>
				<!-- 
				<td width="25%" class="guest_titelF_center">所在单位</td>
				 -->
				<td class="content_02_box_div_table_td" >单位及职务</td>
			</tr>
			<!-- 显示的第一行 -->
			<%
			for (int i = 0; i < queryBean.getGuestReceiveList().size(); i++) {
				if(queryBean.getGuestReceiveList().get(i).getPtuserid()!=""){
			%>
			<tr name="pttr">
				<td class="content_02_box_div_table_td">
					<%=queryBean.getGuestReceiveList().get(i).getPtusername()%>
				</td>
				<td class="content_02_box_div_table_td">
					<%=queryBean.getGuestReceiveList().get(i).getPtsex()%>
				</td>
				<!--  
				<td class="guest_Font">
					
				</td>
				-->
				<td class="content_02_box_div_table_td">
					<%=queryBean.getGuestReceiveList().get(i).getPtpost()%>
				</td>
			</tr>
			<%
				}}
			%>
		</table>
		</div>
		</div>
		<!-- 说明备注 -->
		<div class="content_02_box">
			<div class="content_02_box_title_bg">
			<span>说明备注</span>
			</div>
		<div class="content_02_box_div">
		<table class="content_02_box_div_table_02" width="100%" cellspacing="0" cellpadding="0" border="0">
			<tr>
				<th ></th>
				<td class="content_02_box_div_table_td">
					<textarea class="textarea_575" style="width: 99%"  id="content" name="content" readonly="readonly"></textarea>
				</td>
			</tr>	
		</table>
		</div>
		</div>
		<p>&nbsp;</p>
		</div>
		</div>
		</div>
	<iframe name="hiddenFrame" width=0 height=0></iframe>


</body>
</html>
