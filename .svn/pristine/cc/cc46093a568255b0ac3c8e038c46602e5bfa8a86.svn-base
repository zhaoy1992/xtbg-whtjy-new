<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.entity.CollarBean"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.imploracle.CollarStockDaoImpl"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="java.util.ArrayList"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort() + path + "/";
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);  
	CollarStockDaoImpl stockDaoImpl= new CollarStockDaoImpl();
	String widowsid = request.getParameter("widowsid");
	String stock_Id = request.getParameter("stock_Id");	
	CollarBean col = new CollarBean();
	col.setStock_Id(stock_Id);
	//领用状态
	col.setState("2");
	CollarBean collarBean = new CollarBean();
	collarBean.setStock_Id(stock_Id);
 	if (!StringUtil.isBlank(stock_Id)) {
 		collarBean = stockDaoImpl.findStockBean(col);
 	}
%>
<title>办公设备 领用登记单修改</title>
<!-- 公共部分开始 -->
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script src="../../../resources/js/util/jsonutil.js" type="text/javascript"></script>
<!-- 引入jQuery UI -->
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入其它JS -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"> </script> 
<script src="../../../resources/js/conference.js" type="text/javascript"></script>
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<link rel="stylesheet" href="../../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="UTF-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="UTF-8"></script>
<!-- 引入提示 -->
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js" ></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery("#conferenceBase").validationEngine();
	});

//提交方法
function saveInfo(id){
	if(jQuery("#conferenceBase").validationEngine("validateform")){
			var url = "updateCollarEqStockDo.jsp?state="+id;
			document.all.conferenceBase.action = url;
			$('#conferenceBase').attr("target","hiddenFrame");
			$('#conferenceBase').submit();
	}
}
/* 返回 */
function backTo(){
	removeWindows('<%=widowsid%>',true,false);
} 
</script>
</head>
<body style="overflow-y: hidden;">
<form id="conferenceBase" name="conferenceBase" method="post"  >
	<input type="hidden" name="stock_Id" id="stock_Id" value='<%=StringUtil.deNull(stock_Id)%>'/>
	<input type="hidden" name="widowsid" id="widowsid" value='<%=StringUtil.deNull(request.getParameter("widowsid"))%>'/>
	<div  class="content_02" style="overflow:hidden;" id="content_02_top">
	<!--   操作 -->
    <div class="content_02_top" style="margin-bottom:10px;">
   		<input name="" value="返回" type="button" class="but_y_01" onclick="backTo()"/> 
   		<input id=response_notice onclick='saveInfo(1)' value="归还" type="button" class="but_y_01"/>
   		<input id=response_notice onclick='saveInfo(3)' value="报废" type="button" class="but_y_01"/>
  	</div> 
  	</div> 
	 
	<!-- 表格-->
	<div id="vcenter" class="content_02" style="overflow:hidden;">
	<div style="float: left; width: 775px; ">
	<div class="content_02_box" >
	<div class="content_02_box_title_bg"><span>办公设备 领用登记单</span></div>
	 <div class="content_02_box_div">
	   <table  border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table">
         <tr>
           <th  class="content_02_box_div_table_th" id="content_title_name">领用人：</th>
           <td class="content_02_box_div_table_td">
           		<input type="text"  class="validate[required] input_155" disabled="disabled" readonly="readonly" id="collar_user" value="<%=StringUtil.deNull(collarBean.getCollar_userName())%>" name="collar_user"/>
           	</td>
           <th width="191" class="content_02_box_div_table_th">领用部门：</th>
           <td class="content_02_box_div_table_td" >
           		<input type="text" id="org_name" name="org_name" disabled="disabled" class="validate[required] input_155" value="<%=StringUtil.deNull(collarBean.getCollar_departName())%>" />
			</td>
			<th width="191" class="content_02_box_div_table_th">领用时间：</th>
           <td class="content_02_box_div_table_td" >
           		<input type="text" class="validate[required] date_187" id="apply_date" name="apply_date" disabled="disabled" value="<%=StringUtil.deNull(collarBean.getCollar_date())%>" />
			</td>
         </tr> 
	 </table>
    </div>
   </div>
   </div> 
  	<!-- 形成安排表 -->
	<div class="content_02_box">
	<div class="content_02_box_title_bg">
	<span>物品列表</span>
	</div>
	<div class="content_02_box_div">
	<table id="dayTable" class="content_02_box_div_table_02" width="100%" cellspacing="0" cellpadding="0" border="0">
			 	<tr>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 设备名称</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 类别</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 设备编号</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 设备型号</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 价格（元）</td>
				</tr>
				<tr name="dayrow">
					
					<td class="content_02_box_div_table_td" style="text-align: center;width: 147px"> 
							<%=StringUtil.deNull(collarBean.getEq_name())%>
							<input type="hidden" id="apply_goods" name="apply_goods" class="input_title_text " value="<%=StringUtil.deNull(collarBean.getEq_name())%>" />
					</td>
					<td class="content_02_box_div_table_td" style="text-align: center;width: 147px"> 
							<%=StringUtil.deNull(collarBean.getEq_type())%>
							<input type="hidden" id="apply_unit" name="apply_unit" class="input_title_text" value="<%=StringUtil.deNull(collarBean.getEq_type())%>" />
					</td>
					<td class="content_02_box_div_table_td" style="text-align: center;width: 147px"> 
							<%=StringUtil.deNull(collarBean.getEq_no())%>
							<input type="hidden" id="apply_count" name="apply_count" class="input_title_text" value="<%=StringUtil.deNull(collarBean.getEq_no())%>" />
					</td>
					<td class="content_02_box_div_table_td" style="text-align: center;width: 147px"> 
							<%=StringUtil.deNull(collarBean.getEq_model())%>
							<input type="hidden" id="apply_unit" name="apply_unit" class="input_title_text" value="<%=StringUtil.deNull(collarBean.getEq_model())%>" />
					</td>
					<td class="content_02_box_div_table_td" style="text-align: center;width: 147px"> 
							<%=StringUtil.deNull(collarBean.getEq_price())%>
							<input type="hidden" id="apply_count" name="apply_count" class="input_title_text" value="<%=StringUtil.deNull(collarBean.getEq_price())%>" />
					</td>
				</tr>
		</table>
		</div>
	  	<div class="content_02_box_div">
	  	 <table  border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table_02" width="100%">
        	 <tr>
	           <th  class="content_02_box_div_table_02_th" id="content_title_name">备注：</th>
			   <td class="content_02_box_div_table_02_td"> 
						 <textarea  id="apply_remarks" name="apply_remarks" disabled="disabled" style="width:99%;height: 60px;border:2px solid #FFF3C9; margin:2px 0 2px;"  rows=3 ><%=StringUtil.deNull(collarBean.getRemark())%></textarea>
			   </td>
         </tr> 
	 </table>
   	 </div>
   	  </div>
   	  </div>
</form>
	<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>

