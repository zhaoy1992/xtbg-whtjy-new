<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.imploracle.OfficeStockDaoImple"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.imploracle.OfficeConsumeTypeDaoImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.entity.OfficeStock"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.entity.OfficeConsumeTypeBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date" %>
<%@page import="com.chinacreator.business.common.tools.CacheCommonManage"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.ConsumeStockDao"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.imploracle.ConsumeStockDaoImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.entity.OfficeConsumStock"%>


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
	SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
	String time= format.format(new Date());
	String widowsid = request.getParameter("widowsid");
	String whatDo = request.getParameter("whatDo");
	//添加易耗品id
	String stock_id = request.getParameter("stock_id");//获得易耗品id
	ConsumeStockDao consumeStockDao = null;
	OfficeStock officeStock = new OfficeStock();
	OfficeConsumStock officeConsumStock = new OfficeConsumStock();
	if(!StringUtil.isBlank(stock_id)){
		consumeStockDao= new ConsumeStockDaoImpl();
		officeConsumStock = consumeStockDao.queryOfficeConsumStockById(stock_id);
	}
 	OfficeStockDaoImple OfficeStockDao = new OfficeStockDaoImple();
 	List<OfficeConsumeTypeBean> consList = null;
 	OfficeConsumeTypeDaoImpl OfficeConsumeTypeDao = new OfficeConsumeTypeDaoImpl();
 	consList=OfficeConsumeTypeDao.findAll();
 	
 	//贸促会 需求 除了设备名称 其他不做必填项  tao.ren 2013-05-22
 	String userArea=CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");//421003贸促会
%>
<title>易耗品 采购入库单</title>
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
	if('<%=!StringUtil.isBlank(stock_id)%>' == 'true' && "421005" == '<%=userArea%>'){
		$("input").attr("readonly","readonly");
		$("#count").removeAttr("readonly");
		$("#service_phone").removeAttr("readonly");
		$("#service_phone").removeAttr("readonly");
	}
	
});

//添加物品
function Add_Row4NewDay1(){
	var firstTr = $("[name=dayrow]").first().clone();
	
	$(firstTr).find("input[type=text]").val("");
	
	$(firstTr).find("input[type=hidden]").val("");
	
	firstTr.find("input[type=text]").val("");
	
	
	var dayTable = $("#dayTable");
	
	firstTr.appendTo(dayTable);
	
	$(firstTr).find(".date_187").each(function(i,e){
		setDataTimeClickShowOrHide($(this).attr("id"),window);
	})
}
 //删除物品
function deleteDay(tag,goodsId){
	
	var intable=$(tag).parents("table");
	var tr=$(tag).parents("tr").first();
	var trsize= $(intable).find("tr[name=dayrow]").size();
	if(trsize==1){
		Add_Row4NewDay1();
		$(tr).remove();
	}else{
		$(tr).remove();
	}
}

//提交方法
function saveInfo(id){
	if('<%=!StringUtil.isBlank(stock_id)%>' == 'true' && "421005" == '<%=userArea%>'){
		if($("#count").val() <= <%=officeConsumStock.getCount()%>){
			alert('数量必须大于原有值，请重新输入!');
			//$("#count").val("");
			$("#count").focus();
			return ;
		}
	}
	$('#conferenceBase').attr("target","hiddenFrame");
	$('#conferenceBase').submit();
}
/* 返回 */
function backTo(){
	
	var okF = function(){
		removeWindows('<%=widowsid%>',true,false);
		}
		 var p={
			headerText:'提示',
			okName:'确认',
		    okFunction:okF,
		    cancelName:'取消'
		};
	alert('返回该页,未保存的信息将会丢失 '+'<br>'+'确定返回？',p);
} 
</script>
</head>
<body style="overflow-y: hidden;" onload="adaptationWH('content_02_top','vcenter',40)">
<form id="conferenceBase" name="conferenceBase" method="post" action="addOfficeConSumStockDo.jsp" >
	<input type="hidden" name="widowsid" id="widowsid" value='<%=widowsid%>'/>
	<input type="hidden" name="action" value="add"/>
	<input type="hidden" id="stock_id" name="stock_id" value="<%=stock_id%>"/>
	
	<div  class="content_02" style="overflow:hidden;" id="content_02_top">
	<!--   操作 -->
    <div class="content_02_top" style="margin-bottom:10px;">
   		<input id=response_notice onclick='saveInfo()' value="确定" type="button" class="but_y_01"/>
   		<input name="" value="返回" type="button" class="but_y_01" onclick="backTo()"/> 
  	</div> 
  	</div> 
	 
	<!-- 表格-->
	<div id="vcenter" class="content_02" style="float: left; width: 100%; overflow: scroll" scrolling="yes">
	<div style="float: left; width: 775px; ">
	<div class="content_02_box" >
	<div class="content_02_box_title_bg">
		<span>  
				易耗品 采购入库单
		</span>
	</div>
	 <div class="content_02_box_div">
	   <table  border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table" width="100%">
         <tr>
           <th  class="content_02_box_div_table_th" id="content_title_name">入库人：</th>
           <td class="content_02_box_div_table_td">
           		<%=accesscontroler.getUserName()%>
           	</td>
           <th width="191" class="content_02_box_div_table_th">入库日期：</th>
           <td class="content_02_box_div_table_td" >
           		<%=time%>
           		<input type="hidden" id="stock_data" name="stock_data" value="<%=time%>" />
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
	<div class="content_02_box_add">
	<!-- 如果id不为空，并且是望城投项目就不显示 -->
	<%	if(!StringUtil.isBlank(stock_id) && "421005".equals(userArea)){%>
	<%} else { %>
	<a onclick="Add_Row4NewDay1()">
		<img src="../../../resources/images/add.gif"/>
		添加物品
	</a>
	<%} %>
	</div>
	</div>
	<div class="content_02_box_div">
	<%if("421003".equals(userArea)){%>
		<table id="dayTable" class="content_02_box_div_table_02" width="100%" cellspacing="0" cellpadding="0" border="0" width="100%">
			 	<tr>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"> 类别</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 品名</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"> 规格</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"> 数量</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"> 单价(元)</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"> 供货厂商</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"> 售后电话</td>
					<td class="content_02_box_div_table_th" align="center"style="text-align: center;width: 147px">操作</td>
				</tr>
					<tr name="dayrow">
						<td class="content_02_box_div_table_td"> 
										<select name="type_ids" id="type_ids" size="1"
											class="select_188_box"
											style="width: 188px;" >
												<option value="">---请选择---</option>
												
													<%	
														for (int i = 0; i < consList.size(); i++) {
													%>
														<option value="<%=consList.get(i).getOcname_id()%>"><%=consList.get(i).getOcname_name()%></option>
													
													<%
													}
													%>
												
								       </select>
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="con_name" name="con_name" class="validate[required,maxSize[50]] input_title_text"/>
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="con_rules" name="con_rules" class="input_title_text" />
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="count" name="count" class="input_title_text" />
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="con_price" name="con_price" class="input_title_text"/>
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="suppliers" name="suppliers" class="input_title_text" />
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="service_phone" name="service_phone" class="input_title_text" />
						</td>
						<td class="content_02_box_div_table_td"> 
								 <div class="content_02_box_del" style="height:24px; margin:0;float: none;text-align: center;">
													<a onClick="deleteDay(this,'')"> <img src="../../../resources/images/del.gif" id="del"/>删除</a>
								 </div>
												
						</td>
					</tr>
		</table>
	<%}else if("421005".equals(userArea) || "421006".equals(userArea)){%>
		<table id="dayTable" class="content_02_box_div_table_02" width="100%" cellspacing="0" cellpadding="0" border="0" width="100%">
			 	<tr>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px">类别</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 品名</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"> 规格</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 数量</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"> 单价(元)</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"> 供货厂商</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"> 备注 </td>	<!-- 望城专用，这里的备注用电话号码字段，下面的备注改为说明 -->
					<td class="content_02_box_div_table_th" align="center"style="text-align: center;width: 147px">操作</td>
				</tr>
					<tr name="dayrow">
						<td class="content_02_box_div_table_td"> 
										<select name="type_ids" id="type_ids" size="1"
											class="select_188_box validate[required]"
											style="width: 188px;" >
													<%	if(!StringUtil.isBlank(stock_id)){%>
														<option value="<%=StringUtil.deNull(officeConsumStock.getType_id()) %>"><%=officeConsumStock.getType_name()%></option>
													<%	} else {%>
														<option value="">---请选择---</option>
													<%	for (int i = 0; i < consList.size(); i++) {
													%>
														<option value="<%=consList.get(i).getOcname_id()%>"><%=consList.get(i).getOcname_name()%></option>
													
													<%}}%>
												
								       </select>
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="con_name" name="con_name" class="validate[required,maxSize[50]] input_title_text" value="<%=StringUtil.deNull(officeConsumStock.getCon_name()) %>"/>
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="con_rules" name="con_rules" class="input_title_text validate[maxSize[50]]" value="<%=StringUtil.deNull(officeConsumStock.getCon_rules()) %>"/>
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="count" name="count" class="input_title_text validate[custom[positiveinteger],required]" value="<%=StringUtil.deNull(officeConsumStock.getCount()) %>" />
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="con_price" name="con_price" class="input_title_text validate[custom[number]]" value="<%=StringUtil.deNull(officeConsumStock.getCon_price()) %>"/>
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="suppliers" name="suppliers" class="validate[maxSize[50]] input_title_text" value="<%=StringUtil.deNull(officeConsumStock.getSuppliers()) %>" />
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="service_phone" name="service_phone" class="validate[maxSize[100]] input_title_text" value="<%=StringUtil.deNull(officeConsumStock.getService_phone()) %>"/>
						</td>
						<td class="content_02_box_div_table_td"> 
								<%	if(StringUtil.isBlank(stock_id)){%>
								 <div class="content_02_box_del" style="height:24px; margin:0;float: none;text-align: center;">
													<a onClick="deleteDay(this,'')"> <img src="../../../resources/images/del.gif" id="del"/>删除</a>
								 </div>
								<%} %>
												
						</td>
					</tr>
		</table>
	<%}else{ %>
	<table id="dayTable" class="content_02_box_div_table_02" width="100%" cellspacing="0" cellpadding="0" border="0" width="100%">
			 	<tr>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 类别</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 品名</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 规格</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 数量</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 单价(元)</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 供货厂商</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 备注 </td>
					<td class="content_02_box_div_table_th" align="center"style="text-align: center;width: 147px">操作</td>
				</tr>
					<tr name="dayrow">
						<td class="content_02_box_div_table_td"> 
										<select name="type_ids" id="type_ids" size="1"
											class="validate[required] select_188_box"
											style="width: 188px;" >
												<option value="">---请选择---</option>
												
													<%	
														for (int i = 0; i < consList.size(); i++) {
													%>
														<option value="<%=consList.get(i).getOcname_id()%>"><%=consList.get(i).getOcname_name()%></option>
													
													<%
													}
													%>
												
								       </select>
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="con_name" name="con_name" class="validate[required,maxSize[50]] input_title_text"/>
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="con_rules" name="con_rules" class="validate[required,maxSize[50]] input_title_text" />
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="count" name="count" class="validate[custom[positiveinteger],required] input_title_text" />
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="con_price" name="con_price" class="validate[custom[number],required] input_title_text"/>
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="suppliers" name="suppliers" class="validate[required,maxSize[50]] input_title_text" />
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="service_phone" name="service_phone" class="validate[custom[phone],required] input_title_text" />
						</td>
						<td class="content_02_box_div_table_td"> 
								 <div class="content_02_box_del" style="height:24px; margin:0;float: none;text-align: center;">
													<a onClick="deleteDay(this,'')"> <img src="../../../resources/images/del.gif" id="del"/>删除</a>
								 </div>
												
						</td>
					</tr>
		</table>
		<%} %>
		</div>
	  	<div class="content_02_box_div">
	  	 <table  border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table_02" width="100%">
        	 <tr>
        	 <%if("421005".equals(userArea) || "421006".equals(userArea)){ %>
	           <th  class="content_02_box_div_table_02_th" id="content_title_name">说明：</th>
	         <%} else { %>
	           <th  class="content_02_box_div_table_02_th" id="content_title_name">备注：</th>
	         <%} %>
			   <td class="content_02_box_div_table_02_td"> 
						 <textarea type="text" id="remark" name="remark" class="validate[maxSize[100]]"   rows=3 style="width: 98%" ><%=StringUtil.deNull(officeConsumStock.getRemark())%></textarea>
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

