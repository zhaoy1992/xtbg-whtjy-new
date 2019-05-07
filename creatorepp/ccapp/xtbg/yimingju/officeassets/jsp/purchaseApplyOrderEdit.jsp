<%@page import="antlr.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.imploracle.CollarStockDaoImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.service.impl.PurchaseApplyServiceImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.service.PurchaseApplyServiceIfc"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.entity.PurchaseApplyBean"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.entity.OrderGoods"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.security.authorization.AuthRole"%>
<%@page import="java.util.ArrayList"%>
<%@page import ="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>

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
	String userid = accesscontroler.getUserID();
	String widowsid = "";
	if(request.getParameter("windowId")!=null){
		widowsid=request.getParameter("windowId");
	}else{
		widowsid=request.getParameter("widowsid");
	}
	//申请ID
	String apply_id = request.getParameter("apply_id");	
	//动作ID   1:我的申请单  2：采购审批处室  3:采购审批办公室
	String whatDo = request.getParameter("whatDo");
	
	String mark = request.getParameter("mark");
	
	//service对象
 	PurchaseApplyServiceIfc purchaseApplyServiceIfc = new PurchaseApplyServiceImpl();
 	PurchaseApplyBean purchaseApplyBean = new PurchaseApplyBean();
 	ArrayList<OrderGoods> ordersGoods = new ArrayList<OrderGoods>();
 	if (!StringUtil.isBlank(apply_id)) {
 		purchaseApplyBean = purchaseApplyServiceIfc.getOeBeanById(apply_id);
 		ordersGoods = purchaseApplyServiceIfc.getGoodsBeanById(apply_id);
 	}
 	//处室
 	CollarStockDaoImpl guestreceptionDao=new CollarStockDaoImpl();
 	//部门
 	String[] departs =guestreceptionDao.getDepartByUserID(userid);
 	
 	//当前日期
 	String currentDbTime =new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date());
 	//用户角色判断
	String rolesState ="1";
	String rolesNames = "";//查询是否为办公室审批角色或处室审批角色 办公室一般用户
	AuthRole authRoles[] = accesscontroler.getAllRoleofUser(accesscontroler.getUserAccount());
	StringBuffer buf = new StringBuffer();
	for(int i=0;i<authRoles.length;i++){
		buf.append(authRoles[i].toString()+ ",");
	} 
	rolesNames = buf.toString();
	if(rolesNames.length()>0){
		rolesNames = rolesNames.substring(0,rolesNames.length()-1);
	} 
	
	if(rolesNames.indexOf("处室审批角色")!=-1){
		rolesState = "2";
	} 
	if(rolesNames.indexOf("办公室一般用户角色")!=-1){
		rolesState = "4";
	}
	if(rolesNames.indexOf("办公室审批角色")!=-1){
		rolesState = "3";
	}
	//申请状态
	String approvalStatus = "1";
	//处室审批角色申请-办公室审批
	if("2".equals(rolesState)){
		//处室审批通过
		approvalStatus ="2";
	//办公室一般用户申请-办公室审批
	} else if("4".equals(rolesState)){
		//处室审批通过
		approvalStatus ="2";
	} else if("3".equals(rolesState)){
		//等待采购
		approvalStatus ="4";
	}
%>
<title>采购申请</title>
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
<script>
	jQuery(document).ready(function() {
		jQuery("#conferenceBase").validationEngine();
	});
</script>
<script type="text/javascript">

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
/**
**信息验证
**/
function check(apply_id,apply_goodsId){
	if( jQuery("#conferenceBase").validationEngine("validateform")){
		var url="checkApply.jsp";
		var params =  {apply_id:apply_id,
					   apply_goodsId:apply_goodsId
					  };
		$.ajax({
			url: url,
			type: 'POST',
			dataType:'json',
			data: params,
			async:false,
			success: function(data){
				shoiwSubmit(data);
			},
			error: function(jqXHR, textStatus, errorThrown){
			}
		})
	}
}

function shoiwSubmit(data){
	
	var title = $("#apply_title").val();
	var apply_remarks = $("#apply_remarks").val();
	var apply_goods ="";
	$("input[name=apply_goods]").each(function(i,e){
		apply_goods=apply_goods+ $(e).val() +",";
	});
	
	var apply_unit = "";
	$("input[name=apply_unit]").each(function(i,e){
		apply_unit=apply_unit+ $(e).val() +",";
	});
	var apply_count ="";
	 $("input[name=apply_count]").each(function(i,e){
		 apply_count = apply_count+ $(e).val() +",";
	});
	var apply_price ="";
	 $("input[name=apply_price]").each(function(i,e){
		 apply_price = apply_price+ $(e).val() +",";
	});
	var title1 = data.title;
	var apply_remarks1 = data.apply_remarks;
	var goodName = data.goodName;
	var goodsUint = data.goodsUint;
	var goodsCount = data.goodsCount;
	var goodsPrice = data.goodsPirce;
	if(title ==title1 && apply_remarks1 == apply_remarks&&
	   		apply_goods==goodName&&apply_unit==goodsUint&&
	   		apply_count==goodsCount&&apply_price==goodsPrice){
		
		alert("您尚未作出任何修改，请修改后重新提交！");
	} else {
		var url = "purchaseApplyOrderDo.jsp?ApprovalStatus=<%=approvalStatus%>";
		$('#conferenceBase').attr("target","hiddenFrame");
		$('#conferenceBase').attr("action",url);
		$('#conferenceBase').submit();
	}
}
//提交方法
function saveInfo(id){
	var apply_id = $("#apply_id").val();
	var apply_goodsId="";
	$("input[name=apply_goodsId]").each(function(i,e){
		apply_goodsId=apply_goodsId+ $(e).val() +",";
	});
	check(apply_id,apply_goodsId);
	
}
/* 返回 */
function backTo(){
	removeWindows('<%=widowsid%>',true,false);
} 
</script>
</head>
<body style="overflow-y: hidden;" onload="adaptationWH('content_02_top','vcenter',10)">
<form id="conferenceBase" name="conferenceBase" method="post" >
	<input type="hidden" name="apply_id" id="apply_id" value='<%=StringUtil.deNull(purchaseApplyBean.getApply_id())%>'/>
	<input type="hidden" name="widowsid" id="widowsid" value='<%=StringUtil.deNull(request.getParameter("widowsid"))%>'/>
	<input type="hidden" name="whatDo" id="whatDo" value="<%=whatDo%>"/>
	<input type="hidden" name="andit_userId" id="andit_userId" value="<%=StringUtil.deNull(purchaseApplyBean.getAndit_userId())%>"/>
	
	<div  class="content_02" style="overflow:hidden;" id="content_02_top">
	<!--   操作 -->
    <div class="content_02_top" style="margin-bottom:10px;">
	   	<input id="response_notice" onclick='saveInfo("confirma")' value="确定" type="button" class="but_y_01"/>
   	    <input name="back" value="返回" type="button" class="but_y_01" onclick="backTo()"/> 
  	</div> 
  	</div> 
	 
	<!-- 表格-->
	<div id="vcenter" class="content_02" style="float: left; width: 100%; overflow: scroll" scrolling="yes">
	<div style="float: left; width: 775px; ">
	<div class="content_02_box" >
	<div class="content_02_box_title_bg"><span>采购申请单</span></div>
	 <div class="content_02_box_div">
	   <table  border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table">
         <tr>
           <th  class="content_02_box_div_table_th" id="content_title_name"><font color="red">*</font>申请处室：</th>
           <td class="content_02_box_div_table_td">
           		<%if(StringUtil.isBlank(purchaseApplyBean.getApply_room())){%>
           			<input type="text" style="width: 150px;" class="validate[required,maxSize[10]] input_title_text" id="apply_room" name="apply_room" readonly="readonly"  value="<%=departs[1]%>"/>	
           		<% } else {%>
           			<input type="text" style="width: 150px;" class="validate[required,maxSize[10]] input_title_text" id="apply_room" name="apply_room" readonly="readonly" value="<%=purchaseApplyBean.getApply_room()%>"/>
           		<%} %>
           	</td>
           <th width="191" class="content_02_box_div_table_th"><font color="red">*</font>申请日期：</th>
           <td class="content_02_box_div_table_td" >
           		<input class="input_185" readonly="readonly" type="text" id="apply_date" name="apply_date" value="<%=currentDbTime %>"/>
			</td>
         </tr> 
         <tr id="hidetr">
         	 <th  class="content_02_box_div_table_th" id="content_title_name"><span style="color: red">*</span>申请标题：</th>
	         <td colspan="3" class="content_02_box_div_table_td">
					 <input type="text" id="apply_title" name="apply_title" class="validate[required,maxSize[50]] input_title_text" value="<%=StringUtil.deNull(purchaseApplyBean.getApply_title())%>" />
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
	<a onclick="Add_Row4NewDay1()" id="addButton">
		<img src="../../../resources/images/add.gif"/>
		添加物品
	</a>
	</div>
	</div>
	<div class="content_02_box_div">
	<table id="dayTable" class="content_02_box_div_table_02" width="100%" cellspacing="0" cellpadding="0" border="0">
			 	<tr>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 申请物品</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 单位</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 数量</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px">价格</td>
					<td class="content_02_box_div_table_th" align="center"style="text-align: center;width: 147px">操作</td>
				</tr>
				<% 
							if(ordersGoods.size()>0){
								for(int i=0;i<ordersGoods.size();i++){
									OrderGoods goods =(OrderGoods)ordersGoods.get(i);
				 %>	
				<tr name="dayrow">
					
					<td class="content_02_box_div_table_td"> 
						<input type="hidden" id="apply_goodsId" name="apply_goodsId" class="validate[required] input_title_text" value="<%=goods.getGoods_id()%>" />
							<input type="text" id="apply_goods" name="apply_goods" class="validate[required,maxSize[20]] input_title_text " style="text-align: center;" value="<%=goods.getGoods_name()%>" />
					</td>
					<td class="content_02_box_div_table_td"> 
							<input type="text" id="apply_unit" name="apply_unit" class="validate[required,maxSize[10]] input_title_text" style="text-align: center;" value="<%=goods.getGoods_unit()%>" />
					</td>
					<td class="content_02_box_div_table_td"> 
							<input type="text" id="apply_count" name="apply_count" class="validate[required,maxSize[10],custom[number]] input_title_text" style="text-align: center;" value="<%=goods.getGoods_count()%>" />
					</td>
					<td class="content_02_box_div_table_td"> 
							<%if("0".equals(StringUtil.deNull(goods.getGoods_price()))){ %>
								<input type="text" id="apply_price" name="apply_price" class="validate[maxSize[10],custom[number]] input_title_text" style="text-align: center;" value="" />
							<%} else{ %>
								<input type="text" id="apply_price" name="apply_price" class="validate[maxSize[10],custom[number]] input_title_text" style="text-align: center;" value="<%=goods.getGoods_price()%>" />
							<%} %>
					</td>
					<td class="content_02_box_div_table_td"> 
							 <div class="content_02_box_del" style="height:24px; margin:0;float: none;text-align: center;" >
												<a onClick="deleteDay(this,'<%=goods.getGoods_id()%>')" name="deleteButton"> <img src="../../../resources/images/del.gif" id="del"/>删除</a>
							 </div>
											
					</td>
				</tr>
					<%
							}
						}else{
					%>
					<tr name="dayrow">
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="apply_goods" name="apply_goods" class="validate[required,maxSize[20]] input_title_text" style="text-align: center;" />
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="apply_unit" name="apply_unit" class="validate[required,maxSize[10]] input_title_text" style="text-align: center;"/>
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="apply_count" name="apply_count" class="validate[required,maxSize[10],custom[number]] input_title_text" style="text-align: center;" />
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="apply_price" name="apply_price" class="validate[maxSize[10],custom[number]] input_title_text" style="text-align: center;" />
						</td>
						<td class="content_02_box_div_table_td"> 
								 <div class="content_02_box_del" style="height:24px; margin:0;float: none;text-align: center;">
													<a onClick="deleteDay(this,'')"> <img src="../../../resources/images/del.gif" id="del"/>删除</a>
								 </div>
												
						</td>
					</tr>
					<%
					}
					%>
		</table>
		</div>
	  	<div class="content_02_box_div">
	  	 <table  border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table_02" width="100%">
        	 <tr>
	           <th  class="content_02_box_div_table_02_th" id="content_title_name">备注：</th>
			   <td class="content_02_box_div_table_02_td"> 
						 <textarea  id="apply_remarks" name="apply_remarks" style="width:99%;height: 60px;border:2px solid #FFF3C9; margin:2px 0 2px;"  rows=3 ><%=StringUtil.deNull(purchaseApplyBean.getApply_remarks())%></textarea>
			   </td>
         </tr> 
	 	</table>
   	 	</div>
 		 <div class="content_02_box_div">
	  	 <table  border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table_02" width="100%">
        	 <tr>
	        	<th  class="content_02_box_div_table_th" id="content_title_name">审批状态：</th>
	           <td class="content_02_box_div_table_td">
	           		<% if("2".equals(StringUtil.deNull(purchaseApplyBean.getState()))){%>
	           				处室审批通过
	           		<% } else if("3".equals(StringUtil.deNull(purchaseApplyBean.getState()))){%>
	           				处室审批不通过
	           		<% } else if("4".equals(StringUtil.deNull(purchaseApplyBean.getState()))){%>
	           			      办公室审批通过
	           		<% } else if("5".equals(StringUtil.deNull(purchaseApplyBean.getState()))){%>
	           			      办公室审批不通过
	           		<% } else if("6".equals(StringUtil.deNull(purchaseApplyBean.getState()))){%>
	           			      已采购 
	           		<%}%>
	           	</td>
         </tr> 
	 	</table>
   	 </div>
   	 <% if(!"2".equals(StringUtil.deNull(purchaseApplyBean.getState()))&&!"3".equals(StringUtil.deNull(purchaseApplyBean.getState()))){%>
   	 <div class="content_02_box_div">
	  	 <table  border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table_02" width="100%">
        	 <tr>
	        	<th  class="content_02_box_div_table_th" id="content_title_name">办公室审批意见：</th>
	           <td class="content_02_box_div_table_td" width="191">
	           		<%=StringUtil.deNull(purchaseApplyBean.getOffice_opinion())%>&nbsp;
	           	</td>
	           <th width="191" class="content_02_box_div_table_th">审批日期：</th>
	           <td class="content_02_box_div_table_td" >
	           		<%=StringUtil.deNull(purchaseApplyBean.getOffice_date())%>
				</td>
         </tr> 
	 	</table>
   	 </div>
   	 <% } %>
   	 <% if("1".equals(StringUtil.deNull(purchaseApplyBean.getApply_UserRoles()))){%>
   	 	 <div class="content_02_box_div">
	  	 <table  border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table_02" width="100%">
        	 <tr>
	        	<th  class="content_02_box_div_table_th" id="content_title_name" >处室审批意见：</th>
	           <td class="content_02_box_div_table_td" width="191">
	           		<%=StringUtil.deNull(purchaseApplyBean.getRoom_opinion())%>&nbsp;
	           	</td>
	           <th width="191" class="content_02_box_div_table_th">审批日期：</th>
	           <td class="content_02_box_div_table_td" >
	           		<%=StringUtil.deNull(purchaseApplyBean.getRoom_date())%>
				</td>
         </tr> 
	 	</table>
   	 </div>
   	 <% } %>
   	 	</div>
   	    </div>
</form>
	<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>

