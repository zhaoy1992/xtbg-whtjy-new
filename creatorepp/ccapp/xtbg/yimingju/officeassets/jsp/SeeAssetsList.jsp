<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.entity.CollarBean"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.imploracle.CollarStockDaoImpl"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	//当前用户id和姓名
	String userId = accesscontroler.getUserID();
	CollarStockDaoImpl stockDaoImpl= new CollarStockDaoImpl();
	String widowsid = request.getParameter("widowsid");
	String collarState = request.getParameter("collarState");
	String stock_Id = request.getParameter("stock_Id");	
	CollarBean col = new CollarBean();
	col.setStock_Id(stock_Id);
	//领用状态
	col.setState(collarState);
	CollarBean collarBean = new CollarBean();
	collarBean.setStock_Id(stock_Id);
 	if (!StringUtil.isBlank(stock_Id)) {
 		collarBean = stockDaoImpl.findStockBean(col);
 	}
%>
<title>资产信息</title>
<!-- 公共部分开始 -->
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script src="../../../resources/js/util/jsonutil.js" type="text/javascript"></script>
<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入其它JS -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"> </script> 
<script src="../../../resources/js/conference.js" type="text/javascript"></script>
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<link rel="stylesheet" href="../../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<!-- 引入提示 -->
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js" ></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript">
/* 返回 */
function backTo(){
	removeWindows('<%=widowsid%>',true,false);
} 
</script>
</head>
<body style="overflow-y: hidden;">
<form id="conferenceBase" name="conferenceBase" method="post" action="">
	<!-- 会议主键 -->
<div  class="content_02" style="overflow:hidden;" id="content_02_top">
 <!--   操作 -->
  <div class="content_02_top" style="margin-bottom:10px;">
  <input name="" value="返回" type="button" class="but_y_01" onclick="backTo()"/> 
 </div> 
 </div> 
	 
	<!-- 表格-->
<div id="vcenter" style="float:left; width:100%; " >
 <div style="float: left; width: 775px; ">
 
	<div class="content_02_box" >
	 <div class="content_02_box_title_bg">
	 <span>资产信息</span>
	</div>
	<div class="content_02_box_div">
	   <table  border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table">
         <tr>
         <td colspan="4">
		   <table width="100%" border="0" cellspacing="0" cellpadding="0">
 		 <tr>
 			<td colspan="4">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr> <td class="content_02_box_div_table_th">设备名称： </td>
				 <td class="content_02_box_div_table_td">
				<%=StringUtil.deNull(collarBean.getEq_name())%> </td>
			</tr>
			</table>
			</td>
		</tr>
         </table>
		 </td>  
         </tr>
         <tr id="hidetr">
         <td colspan="4">
		   <table width="100%" border="0" cellspacing="0" cellpadding="0">
 		 <tr>
 			<td colspan="4">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr> <td class="content_02_box_div_table_th">类别： </td>
				 <td class="content_02_box_div_table_td">
				<%=StringUtil.deNull(collarBean.getEq_type())%> </td>
			</tr>
			</table>
			</td>
		</tr>
         </table>
		 </td>  
	     </tr>
	      <tr id="hidetr">
         <td colspan="4">
		   <table width="100%" border="0" cellspacing="0" cellpadding="0">
 		 <tr>
 			<td colspan="4">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr> <td class="content_02_box_div_table_th">设备编号：</td>
				 <td class="content_02_box_div_table_td">
				<%=StringUtil.deNull(collarBean.getEq_no())%> </td>
			</tr>
			</table>
			</td>
		</tr>
         </table>
		 </td>  
	     </tr>
	       <tr id="hidetr">
         <td colspan="4">
		   <table width="100%" border="0" cellspacing="0" cellpadding="0">
 		 <tr>
 			<td colspan="4">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr> <td class="content_02_box_div_table_th">型号：</td>
				 <td class="content_02_box_div_table_td">
				<%=StringUtil.deNull(collarBean.getEq_model())%> </td>
			</tr>
			</table>
			</td>
		</tr>
         </table>
		 </td>  
	     </tr>
	       <tr id="hidetr">
         <td colspan="4">
		   <table width="100%" border="0" cellspacing="0" cellpadding="0">
 		 <tr>
 			<td colspan="4">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr> <td class="content_02_box_div_table_th">购买日期：</td>
				 <td class="content_02_box_div_table_td">
				<%=StringUtil.deNull(collarBean.getStock_data())%> </td>
			</tr>
			</table>
			</td>
		</tr>
         </table>
		 </td>  
	     </tr>
	      <tr id="hidetr">
         <td colspan="4">
		   <table width="100%" border="0" cellspacing="0" cellpadding="0">
 		 <tr>
 			<td colspan="4">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr> <td class="content_02_box_div_table_th">供货厂商： </td>
				 <td class="content_02_box_div_table_td">
				<%=StringUtil.deNull(collarBean.getSuppliers())%> </td>
			</tr>
			</table>
			</td>
		</tr>
         </table>
		 </td>  
	     </tr>
	       <tr id="hidetr">
         <td colspan="4">
		   <table width="100%" border="0" cellspacing="0" cellpadding="0">
 		 <tr>
 			<td colspan="4">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr> <td class="content_02_box_div_table_th">售后电话： </td>
				 <td class="content_02_box_div_table_td">
				<%=StringUtil.deNull(collarBean.getEq_phone())%> </td>
			</tr>
			</table>
			</td>
		</tr>
         </table>
		 </td>  
	     </tr>
	      <tr id="hidetr">
         <td colspan="4">
		   <table width="100%" border="0" cellspacing="0" cellpadding="0">
 		 <tr>
 			<td colspan="4">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr> <td class="content_02_box_div_table_th">单价： </td>
				 <td class="content_02_box_div_table_td">
				<%=StringUtil.deNull(collarBean.getEq_price())%> </td>
			</tr>
			</table>
			</td>
		</tr>
         </table>
		 </td>  
	     </tr>
	       <tr id="hidetr">
         <td colspan="4">
		   <table width="100%" border="0" cellspacing="0" cellpadding="0">
 		 <tr>
 			<td colspan="4">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr> <td class="content_02_box_div_table_th">状态： </td>
				 <td class="content_02_box_div_table_td">
				 <%
				 	if("1".equals(StringUtil.deNull(collarBean.getState()))){
				 %>
				 	归还
				 <%
				 	}else if("2".equals(StringUtil.deNull(collarBean.getState()))){
				 %>
				 	领用
				 <% 
				    } else if("3".equals(StringUtil.deNull(collarBean.getState()))){
				  %>
					报废
				 
				 <%
				  }
				 %>
				  </td>
			</tr>
			</table>
			</td>
		</tr>
         </table>
		 </td>  
	     </tr>
	      <tr id="hidetr">
         <td colspan="4">
		   <table width="100%" border="0" cellspacing="0" cellpadding="0">
 		 <tr>
 			<td colspan="4">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr> <td class="content_02_box_div_table_th">领用日期：</td>
				 <td class="content_02_box_div_table_td">
				<%=StringUtil.deNull(collarBean.getCollar_date())%> </td>
			</tr>
			</table>
			</td>
		</tr>
         </table>
		 </td>  
	     </tr>
</table>
  </div>	
  </div>
  </div>  
</div>
</form>
	<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>

