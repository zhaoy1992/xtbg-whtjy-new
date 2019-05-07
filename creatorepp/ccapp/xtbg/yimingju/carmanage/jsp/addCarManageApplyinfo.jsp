<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%
String path = request.getContextPath();
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
	String userid = accesscontroler.getUserID();
	String loginUserName = accesscontroler.getUserAccount();
	String username=accesscontroler.getUserName();
	
	String theRootOrgid = DaoUtil.SqlToField("select org_id from td_sm_organization where parent_id='0'");
	String subid= request.getParameter("subid");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<html>
<head>

<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script src="../../../resources/js/util/jsonutil.js" type="text/javascript"></script>
<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入my97时间控件 -->
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 引入formvValidatetion -->
<link rel="stylesheet"href="../../../resources/plug/formvalidation/css/validationEngine.jquery.css"type="text/css" />
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf_8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf_8"></script>
<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../public/flowinfoconfig/resources/js/tree.js" charset="utf-8"></script>


<!-- 公共部分结束 -->

<script type="text/javascript">
$(function(){
	jQuery("#form1").validationEngine();
})

var loginUserName = '<%=loginUserName%>';
var user_id = '<%=userid%>';

/**
 * 保存车辆申请基本信息--saveinfo
 */
var saveinfo = function(){
		//IsSpace($('#nickname').val())?'无昵称':$('#nickname').val();
		var baseinfoJson = "{'apply_person':'"+loginUserName+"','apply_personid':'"+user_id+"',"+
			"'use_reason':'"+$('#use_reason').val()+"','use_starttime':'" + $('#use_starttime').val() + "',"+"'use_endtime':'" + 
			$("#use_endtime").val() + "',"+"'use_name':'" + $('#use_name').val() +"','use_id':'" + $('#use_id').val()+
			"','destination':'" + $('#destination').val()+"'}";
	
		$("#baseinfoJson").val(descape(escape(baseinfoJson)));
		$("#form1").attr("target","hiddenFrame");
		$("#form1").submit();
	}
	

/**
 * 选择用户
 */
function chooseUser() {
	var s = new $.z_tree_leftRigth_old();
		s.treeID='button_envelop_username';
		s.isShowSeacher=true;
		s.treeName="选取人员";
		s.headerName="选取人员";
		s.titelText = "选择人员";
		s.rightHeaderText="已添加人员";
		s.returnFunction=function(orgObj){
			if (!IsSpace(orgObj)) {
				$('#use_id').val(orgObj.ps.id);
				$('#use_name').val(orgObj.ps.name);
			}else{
				$('#use_id').val("");
				$('#use_name').val("");
			}
	}
	s.treeList=[{'url':'<%=path%>' + "/OrgUserYimingTreeServlet",
				 'autoParam':["item_id", "name=item_id", "level=lv"],
				 'leftHeaderText':'按人员选择',
				  valueKey:'ps',
				 'otherParam':{
				 "toporgId":"<%=theRootOrgid%>",
				 "userid":"<%=userid%>",
				 "resourceType":"",
				 "backchooseuserids":$('#use_id').val(),
				 "showLevel":"3"}
			}];
		  s.init();
}

function chooseReportUnits (){
	  var s = new jQuery.z_tree_leftRigth();
	  s.treeID='button_envelop_username';
	  s.isShowSeacher="aa";
	  s.treeName="选取人员";
	  s.headerName="选取人员";
	  s.titelText = "选择人员";
	  s.rightHeaderText="已添加机构和人员";
	  s.selectedIds=$('#use_id').val();
	  s.returnFunction=function(orgObj){
		  if(IsSpace(orgObj.ps) || null ==orgObj.ps )
		  	{
			   jQuery('#use_id').val('');
			   jQuery('#use_name').val('');
			 }else{
			 
				jQuery('#use_id').val(orgObj.ps.id);
				jQuery('#use_name').val(orgObj.ps.name);
			 }
	  }
	  s.treeList=
			  [{
				  leftHeaderText:'按人员选择',
				  valueKey:'ps',
				  selectedIds:jQuery('#use_id').val(),
				  type:'APERSON'
		}];
	  s.init();

}
/* 
 * 返回 
 */
function back(){
	 var url = "<%=path%>/ccapp/xtbg/yimingju/carmanage/jsp/carManageApplyInfoList.jsp";
	 /*location.href = url; */
	var okF = function(){
		removeWindows('<%=subid%>',true);
		location.href = url;
		}
		 var p={
			headerText:'提示',
			okName:'确认',
		    okFunction:okF,
		    cancelName:'取消'
		};
	alert('返回该页,未保存的信息将会丢失 '+'<br>'+'确定返回？',p);
}
/* 
 * 保存---返回 
 */
function saveBack(){
	var url = "<%=path%>/ccapp/xtbg/yimingju/carmanage/jsp/carManageApplyInfoList.jsp";
	location.href = url;
}

</script>

<title>用车申请信息</title>
</head>

<body style="overflow-y: hidden;"  onload="adaptationWH('_top','vcenter',45);">
<form id="form1" name="form1" action="carmanageapplyinfosaveform.jsp" class="formular" method="post">
 <div class="content_02" style="overflow: hidden;" scrolling="yes"  id="_top">
		<!-- 操作-->
		<div class="content_02_top" style="margin-bottom: 10px;"
				id='content_02_top'>
		<input id="savebtn" name="savebtn" type="button" class="but_y_01" onclick="saveinfo();" value="保存" />
		<input id="backbtn" name="backbtn" type="button" class="but_y_01" onclick="back();" value="返回" />
		</div>
 </div>
 
 <!-- ---表格------->
 <div id="vcenter" style="float: left; width: 100%;">
 <div style="float: left; width: 775px; ">
 		<!--------------用车信息-------------->
 <div class="content_02_box_div">
				<div class="content_02_box_title_bg">
					<span>用车信息</span>
				</div>
		<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table">
			<tr>
				<th width="115" class="content_02_box_div_table_th"><span class="color_red">*</span>用&nbsp;车&nbsp;人：</th>
				<td class="content_02_box_div_table_td" colspan="3">
				<input onmouseover="this.title=this.value"  class="validate[required,maxSize[500]] input_150" style="width: 635px;border:0px" 
					id="use_name" name="use_name" value="<%=username %>" onclick='chooseReportUnits()'></input>
			   <input name="" type="button" value="" class="but_x" onclick="chooseReportUnits()"/>
				<input id="use_id" name="use_id" type="hidden" value="<%=userid %>"/>
				<input id="sqrq" name="sqrq" type="hidden" value="" />
				</td>
			</tr>
			
			<tr>
				<th width="115" class="content_02_box_div_table_th"><span class="color_red">*</span>用车事由：</th>
				<td class="content_02_box_div_table_td" colspan="3">
				<input class="validate[required,maxSize[200]] input_title_text"
					id="use_reason" name="use_reason" value=""></input>
				</td>
			</tr>
			
			<tr>
				<th class="content_02_box_div_table_th"><span class="color_red">*</span>开始时间：</th>
				<td width="314" class="content_02_box_div_table_td"><input type="text"
					class="validate[required] date_187" id="use_starttime" name="use_starttime"
					onfocus="WdatePicker({onpicked:function(){this.blur();},dateFmt:'yyyy-MM-dd HH:mm',minDate:'%y-%M-%d',maxDate:'#F{$dp.$D(\'use_endtime\')}'})" />
			  </td>
				
				<th width="119" class="content_02_box_div_table_th">结束时间：</th>
				<td width="227" class="content_02_box_div_table_td"><input type="text"
					class="date_187" id="use_endtime" name="use_endtime"
					onfocus="WdatePicker({onpicked:function(){this.blur();},dateFmt:'yyyy-MM-dd HH:mm',minDate:'#F{$dp.$D(\'use_starttime\')||\'%y-%M-%d\'}'})" />
			  </td>
			</tr>
			
			<tr>
				<th width="115" class="content_02_box_div_table_th"><span class="color_red">*</span>目&nbsp;的&nbsp;地：</th>
				<td class="content_02_box_div_table_td" colspan="3">
				<input class="validate[required,maxSize[500]] input_title_text"
					id="destination" name="destination" value=""></input>
				</td>
			</tr>
		</table>
	</div>
 
 		<!--------------车辆信息-------------->
 	 
 
 
 </div>
</div>

<input id="baseinfoJson" name="baseinfoJson" type="hidden" value="" />
</form>
<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>