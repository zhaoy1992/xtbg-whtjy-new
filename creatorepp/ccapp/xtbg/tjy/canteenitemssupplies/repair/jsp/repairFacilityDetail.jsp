<%--
描述：报修登记-楼道设施详细界面
作者：夏天
版本：1.0
日期：2014-03-07
--%>
<%@page import="com.chinacreator.xtbg.tjy.canteenitemssupplies.service.impl.OsupplieRepairServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.canteenitemssupplies.service.OsupplieRepairService"%>
<%@page import="com.chinacreator.xtbg.tjy.canteenitemssupplies.entity.OsupplieRepairBean"%>
<%@page import="com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%>
<%@page import="com.chinacreator.xtbg.pub.dbbase.dao.XtDbBaseDao"%>
<%@page import="com.chinacreator.xtbg.tjy.canteenitemssupplies.dao.OsupplieRepairDao"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	
	Map<String,String> bean = new HashMap<String,String>();
	
	String actionName = request.getParameter("actionName");
	//主键ID
	String repair_id = request.getParameter("repair_id");
	
	//类型业务
	OsupplieRepairService osupplieRepairService= new OsupplieRepairServiceImpl();
	if("insert".equals(actionName)){
		//当前系统时间
		bean.put("report_time", DateUtil.getCurrentDate());
		bean.put("deal_status", "doing");//设置处理状态为已提交
		bean.put("unit_name", unit_name);//所属单位名称
		bean.put("unit_id", unit_id);//所属单位ID
	} else {
		OsupplieRepairBean osupplieRepairBean = new OsupplieRepairBean();
		osupplieRepairBean.setRepair_id(repair_id);
		bean = osupplieRepairService.getRepairInfo(osupplieRepairBean);
	}
	bean.put("repair_type", "floor");//设置维修类别为楼道设施
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>楼道设施保修维护</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="${pageContext.request.contextPath}/ccapp/xtbg/resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<!-- 引入其它 -->
<script src="${pageContext.request.contextPath}/ccapp/xtbg/resources/js/util/public.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/ccapp/xtbg/resources/js/common/commoncss.js" type="text/javascript"></script>
<!-- 引入jQuery_dialog -->
<script src="${pageContext.request.contextPath}/ccapp/xtbg/resources/plug/jquery_dialog/jquery_dialog.js"></script>
<!-- 引入公共JS -->
<!-- 引入formvValidatetion -->
<script src="${pageContext.request.contextPath}/ccapp/xtbg/resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="UTF-8"></script>
<script type="text/javascript"src="${pageContext.request.contextPath}/ccapp/xtbg/resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script src="${pageContext.request.contextPath}/ccapp/xtbg/resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="UTF-8"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/ccapp/xtbg/resources/plug/ifrom/js/ifrom-min.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/ccapp/xtbg/resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/ccapp/xtbg/resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>

<script src="${pageContext.request.contextPath}/ccapp/oa/resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript">
	jQuery(document).ready(function() {
		if("" != $('#repair_id').val()){
			$("#bj").show();
		}
		jQuery("#form1").validationEngine();
		jQuery("#place_info").focus();
	});
/*
函数:  Ok
说明:  提交添加与修改来文单位
参数:   无
返回值: 无
*/
function Ok() {
	var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
	if (isFlag){
		jQuery("#hidden_action").val("addInfo");
		jQuery("#form1").attr("target","filetypeinfodoJSPhiddenFrame");
		jQuery("#form1").submit();
	}
}
afterSubmitFn=function(result){
	try{
		if(result.indexOf("delete")!=-1){
			alert(result.split(",")[1]);
		}else{
			if(result.split(",").length>1){
					result = result.split(",");
					alert(result[0]);
					getParentWindow("windowId").userSearch();
					removeAlertWindows("windowId",true);
			} else {
				alert(result);
				getParentWindow("windowId").userSearch();
				removeAlertWindows("windowId",true);
			}
			
		}
	}catch(e){alert(e.description);}
};
function closed(){
	removeWindows('',true);
}

/**
 * 选取人员
 */
var chooseReportUnits = function(){
	var s = new $.z_tree();
	  s.treeID='mian';
	  s.treetypestr="radio";
	  s.ischekc="false";
	  s.isShowSeacher=true;
	  s.treeName="选取单位";
	  s.headerName="选取单位";
	  s.isType='dept';
	  s.item_id = 'org_id';
	  s.type="AORG";
	  s.selectedIds=$('#repair_unit').val();
	  s.returnFunction=function(orgObj){
		 $('#repair_unit').val(orgObj.id);
	  	 $('#repair_unitname').val(orgObj.name);
	  }
  	 s.init();
	  
}	
</script>
<body style="overflow-y:hidden;">
	<form id="form1" action="repairDevicedo.jsp" method="post"  >
		<input type="hidden" name="repair_id" id="repair_id" value="<%=StringUtil.deNull(bean.get("repair_id"))%>">
		<input type="hidden" name="deal_status" id="deal_status" value="<%=StringUtil.deNull(bean.get("deal_status"))%>">
		<input type="hidden" name="repair_type" id="repair_type" value="<%=StringUtil.deNull(bean.get("repair_type"))%>">
		<input type="hidden" name="unit_id" id="unit_id" value="<%=StringUtil.deNull(bean.get("unit_id"))%>">
		<input type="hidden" name="unit_name" id="unit_name" value="<%=StringUtil.deNull(bean.get("unit_name"))%>">
		<input type='hidden' name='action' id="hidden_action"/>
		<input type="hidden" name="windowsId" id="windowsId" value='<%=StringUtil.deNull(request.getParameter("windowsId"))%>'/>
		<div id="users-contain">
			<table  width="100%" border="0" cellspacing="0" cellpadding="0" >
					<tr>
						<th class="content_02_box_div_table_th"><font color="red">*</font>报修时间：</th>
						<td class="content_02_box_div_table_td"><input type="text" name="report_time" id="report_time" 
						class="validate[required] date_120 Wdate" style="width: 90px;height :23px;" 
										 onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"
							value="<%=StringUtil.deNull(bean.get("report_time"))%>" >
						</td>
						</td>
						
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th">维修时间：</td>
						<td class="content_02_box_div_table_td"><input type="text" name="repair_time" id="repair_time" 
						 class="date_120 Wdate" style="width: 90px;height :23px;" 
										 onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"
							value="<%=StringUtil.deNull(bean.get("repair_time"))%>">
						</td>
						
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable"><font color="red">*</font>维修单位：</td>
						<td class="content_02_box_div_table_td">
						   <input type="hidden" name="repair_unit" id="repair_unit" value="<%=StringUtil.deNull(bean.get("repair_unit"))%>" >
							<input style="width:90%;height=23px" type="text" name="repair_unitname" class="validate[required,maxSize[50]] input_188"
							id="repair_unitname" value="<%=StringUtil.deNull(bean.get("repair_unitname"))%>">
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable"><font color="red">*</font>故障位置情况：</td>
						<td class="content_02_box_div_table_td"><textarea style="width:98%;height=23px" type="text" name="place_info" class="validate[required,maxSize[50]] textarea_570"
							id="place_info"
							><%=StringUtil.deNull(bean.get("place_info"))%></textarea>
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable">处理结果：</td>
						<td class="content_02_box_div_table_td"><textarea style="width:98%;height=23px" type="text" name="deal_result" class="validate[maxSize[500]] textarea_570"
							id="deal_result"
							><%=StringUtil.deNull(bean.get("deal_result"))%></textarea>
						</td>
					</tr>
			</table>
		</div>
		
		<div class="cue_box_foot">
			<input class="but_y_01" type="button" value="返回" onclick="removeAlertWindows('',true)" />
			<input class="but_y_01" type="button" id="sel"  value="保存" onclick="Ok()"/>
			<input class="but_y_01" type="button" id="bj" style="display:none" value="办结" onclick="$('#deal_status').val('done');Ok();"/>
		</div>
		
	</form>
	
	<iframe name="filetypeinfodoJSPhiddenFrame" width=0 height=0></iframe>
</body>
</html>