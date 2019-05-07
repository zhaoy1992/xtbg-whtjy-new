<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.agency.entity.AgencyBean"%>
<%@page import="com.chinacreator.xtbg.core.agency.service.impl.AgencyServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.agency.service.AgencyService"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
	String user_id = accesscontroler.getUserID();
	String user_name = accesscontroler.getUserName();
	String user_uname = accesscontroler.getUserAccount();
	String work_id = request.getParameter("work_id");
	AgencyService agencyService = new AgencyServiceImpl();
	AgencyBean  bean = new AgencyBean();
	if (!StringUtil.isBlank(work_id)) {
		bean = agencyService.findAgencyBeanById(work_id);
	}
	
	String sql="select t.busitype_type_name, t.busitype_type_name from OA_FLOW_BUSITYPE_TYPE t order by t.order_no";
	
	String select=DictDropDownList.buildSelect(sql,"work_name","","",false,"");
%>
<title>委托待办</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
	<!-- 引入其它 -->
	<!-- 引入my97时间控件 -->
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="../../resources/util/public.js" type="text/javascript"></script>
<!-- 引入公共JS -->
<!-- 引入formvValidatetion -->
<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="UTF-8"></script>
<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="UTF-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../flowinfoconfig/resources/js/tree.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript">
var work_id = '<%=work_id%>';
var userid = 
	jQuery(document).ready(function() {
		jQuery("#form1").validationEngine();
	});
	jQuery(function() {
		//时间控件
		jQuery('#start_time').click(function(){
			WdatePicker({minDate:'%y-%M-%d'});
		});
		//时间控件
		jQuery('#end_time').click(function(){
			WdatePicker({minDate:'#F{$dp.$D(\'start_time\')}'});
		});
		if(work_id != ''){
			jQuery("#work_name option[value='<%=StringUtil.deNull(bean.getWork_name())%>']").attr("selected","selected");
		}
	});
function selectUserid(){
	var userid = jQuery("#agency_id").val();
	var arr = new Array();
	arr = userid.split(",");
	for(var i =0; i < arr.length; i++){
		if("<%=user_id%>" == arr[i] ){
			alert("不能设置自己为代理人");
			return false;
		}
	}
	return true;
}
	
/*
函数:  Ok
说明:  提交添加与修改来文单位
参数:   无
返回值: 无
*/
function Ok() {
	if(!selectUserid()){
		return false;
	}
	var paramjosn = "";
	if (IsSpace($("#work_id").val())) { //修改
		$("#action").val("add");
	} else {
		$("#action").val("update");
	}
	paramjosn = "{'start_time':'" + $("#start_time").val() + "','end_time':'" + $("#end_time").val() 
	+ "','agency_name':'" + $("#agency_name").val() 
	+ "','agency_id':'"+$("#agency_id").val()
	+"','entrust_name':'"+$("#entrust_name").val()
	+"','entrust_id':'"+$("#entrust_id").val()
	+"','work_type':'"+$("#work_type").val()
	+"','work_name':'"+$("#work_name").val()
	+"','work_id':'"+$("#work_id").val()+"','agency_username':'"+$("#agency_username").val()+"'}";
	$("#paramjosn").val(descape(escape(paramjosn)));
	$("#form1").submit();
}
function closed(){
	parent.JqueryDialog.Close();
}
var chooseReportUnits = function(){
	 var s = new jQuery.z_tree_leftRigth();
	  s.treeID='button_envelop_username';
	  s.isShowSeacher="aa";
	  s.treeName="选取人员";
	  s.headerName="选取人员";
	  s.titelText = "选择人员";
	  s.rightHeaderText="已添加机构和人员";
	  s.returnFunction=function(orgObj){
		  if(IsSpace(orgObj.ps) || null ==orgObj.ps )
		  	{
			  	  jQuery('#agency_name').val('');
			  	  jQuery('#agency_id').val('');
			  	jQuery('#agency_username').val('');
			 }else
			 {
				 jQuery('#agency_id').val(orgObj.ps.id);
				  jQuery('#agency_name').val(orgObj.ps.name);
				  jQuery('#agency_username').val(orgObj.ps.user_name);
			}
	  }
	  s.treeList=
			  [{
				  leftHeaderText:'按人员选择',
				  valueKey:'ps',
				  selectedIds:jQuery('#agency_id').val(),
				  type:"APERSON"
		}];
	  s.init();
}

</script>
<body style="overflow-y:hidden;">
	<form id="form1" action="agencydo.jsp" method="post">
		<input type="hidden" name="entrust_name" id="entrust_name" value="<%=StringUtil.deNull(user_name )%>">
		<input type="hidden" name="entrust_id" id="entrust_id" value="<%=StringUtil.deNull(user_uname )%>"> 
		<input type="hidden" name="paramjosn" id="paramjosn">
		<input type="hidden" name="action" id="action">
		<input type="hidden" nama="work_id" id="work_id" value="<%=work_id %>"/>
		<input type="hidden" name="windowsId" id="windowsId" value=''/>
	<div id="users-contain">
	<table  width="100%" border="0" cellspacing="0" cellpadding="0" >
		<tr>
			<th width="191" class="content_02_box_div_table_th"><span style="color: red">*</span>工作名称:
			</th>
			<td class="content_02_box_div_table_03_n_td">
			<%=select %>
				 <!-- <select style="width: 61%"  id="work_name" >
				    	  <option value="收文">收文</option>
				     	  <option value="发文">发文</option>
				     	  <option value="签呈">签呈</option>
				    	  </select> -->
			</td>
		</tr>
		<tr>
			<th width="191" class="content_02_box_div_table_th"><span style="color: red">*</span>代理人:
			</th>
			<td class="content_02_box_div_table_03_n_td">
			<input readonly="readonly"
	           onmouseover="this.title=this.value"
	           type="text" class=" validate[required] input_160" id="agency_name" name="agency_name" 
				 value="<%=StringUtil.deNull(bean.getAgency_name()) %>" onclick="chooseReportUnits();"/>
				 <input name="" type="button"  class="but_x" onclick="chooseReportUnits()" />
				 <input type="hidden" name="agency_id" id="agency_id" value="<%=StringUtil.deNull(bean.getAgency_id()) %>"/>
				 <input type="hidden" name="agency_username" id="agency_username" value="<%=StringUtil.deNull(bean.getAgency_username()) %>"/>
			</td>
		</tr>
		<tr>
			<th width="191" class="content_02_box_div_table_th"><span style="color: red">*</span>开始时间:
			</th>
			<td class="content_02_box_div_table_03_n_td">
			<input type="text" name="start_time" id="start_time" class="validate[required] date_187 Wdate" 
			style="width: 61%" value="<%=StringUtil.deNull(bean.getStart_time()) %>">
			</td>
		</tr>
		<tr>
			<th width="191" class="content_02_box_div_table_th"><span style="color: red">*</span>结束时间:
			</th>
			<td class="content_02_box_div_table_03_n_td">
			<input type="text" name="end_time" id="end_time" class="validate[required] date_187 Wdate" 
			style="width: 61%" value="<%=StringUtil.deNull(bean.getEnd_time()) %>">
			</td>
		</tr>
		</table>
		</div>
		
		<div class="cue_box_foot">
			<input class="but_y_01" type="button" value="关闭" onclick="removeAlertWindows('',true)" />
			<input class="but_y_01" type="button" id="sel"  value="确定" onclick="Ok()"/>
		</div>
		
	</form>
</body>
</html>