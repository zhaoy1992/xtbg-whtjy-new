<%@page import="antlr.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.imploracle.CollarStockDaoImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.service.impl.PurchaseApplyServiceImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.service.PurchaseApplyServiceIfc"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.entity.PurchaseApplyBean"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.entity.OrderGoods"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.chinacreator.security.authorization.AuthRole"%>
<%@page import ="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.business.common.tools.CacheCommonManage"%>

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
	//add by jianhua.chen1 望城系统编码，添加个性化东西
	String userArea=CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");	//421005，衡阳系统编码
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

<script language="javascript" src="../../../resources/plug/Lodop/LodopFuncs.js"></script>
<object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
	<embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0 pluginspage="install_lodop.exe"></embed>
</object>

<script>
	jQuery(document).ready(function() {
		//衡阳个性化东西设置
		if("<%=userArea%>" == "421005"){	
			$(".uom").html("计量单位");
		}
		
		//打印按钮屏蔽
		$("#print").hide();
		
		jQuery("#conferenceBase").validationEngine();
		
		//已采购 审批通过 
		if("<%=mark%>"=="1"){
			//屏蔽确定按钮
			$("#ok,#notPass").hide();
			//确定按钮
			$("#response_notice").hide();
			//标题
			$("#apply_title").attr("readonly","true");
			//备注
			$("#apply_remarks").attr("readonly","true");
			//物品
			$("#apply_goods").attr("readonly","true");
			//数量
			$("#apply_count").attr("readonly","true");
			//单位
			$("#apply_unit").attr("readonly","true");
			//添加物品按钮
			$("#addButton").attr("disabled","true");
			// 删除按钮
			$("[name=deleteButton]").attr("disabled","true");
			// 审批意见
			$("#spyj").hide();
			
			//打印按钮显示
			$("#print").show();
			
		}
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

//提交方法
function saveInfo(id){
	if( jQuery("#conferenceBase").validationEngine("validateform")){
		//处室审批
		if('1'=='<%=StringUtil.deNull(purchaseApplyBean.getState())%>'){
			whatDo =2;
			$('#whatDo').val(whatDo);
		}
		//办公室审批
		if('2'=='<%=StringUtil.deNull(purchaseApplyBean.getState())%>'){
			whatDo =3;
			$('#whatDo').val(whatDo);
		}
		
		var whatDo = $('#whatDo').val();
		//我的采购单
		if(whatDo==1){
			var url = "purchaseApplyOrderDo.jsp?ApprovalStatus=<%=approvalStatus%>";
			$('#conferenceBase').attr("target","hiddenFrame");
			$('#conferenceBase').attr("action",url);
			$('#conferenceBase').submit();
	
		//采购审批(处室)
		}else if(whatDo==2){
			if(id=="ok"){//审批通过
				var url = "purchaseApplyOrderDo.jsp?ApprovalStatus=2";
			} else if(id=="notPass"){//审批不通过
				var url = "purchaseApplyOrderDo.jsp?ApprovalStatus=3";
			}
		}
		//采购审批(办公室)
		else if(whatDo==3){
			if(id=="ok"){//审批通过
				var url = "purchaseApplyOrderDo.jsp?ApprovalStatus=4";
			} else if(id=="notPass"){//审批不通过
				var url = "purchaseApplyOrderDo.jsp?ApprovalStatus=5";
			}
		}
		
		var okF = function(){
			$('#conferenceBase').attr("target","hiddenFrame");
			$('#conferenceBase').attr("action",url);
			$('#conferenceBase').submit();
		}
		
		 var p={
					headerText:'提示',
					okName:'确认',
				    okFunction:okF,
				    cancelName:'取消'
				};
		 //审批通过
		if(id=="ok"){
			alert('确定要审批通过吗？',p);
		
		//审批不通过
		} else if(id=="notPass"){
			alert('确定要审批不通过吗？',p);		
		}
	}
}
/* 返回 */
function backTo(){
	window.top.window.frames["_document_body_mian_firstPagerAAAS"].document.location.reload();
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
    	<% if("1".equals(whatDo)){ %>	
	   		<input id="response_notice" onclick='saveInfo("confirma")' value="确定" type="button" class="but_y_01"/>
   	    <%}  if("2".equals(whatDo)||("3".equals(whatDo))){ %>
	   	     <input id="ok" onclick='saveInfo("ok")' value="通过" type="button" class="but_y_01"/>
	   		 <input id="notPass" onclick='saveInfo("notPass")' value="不通过" type="button" class="but_y_01"/>
   	    <% }%>
   	    <input name="back" value="返回" type="button" class="but_y_01" onclick="backTo()"/> 
   	    <input id="print" onclick='prn1_preview_conferceBase();' value="打印" type="button" class="but_y_01" />
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
           		<%if(StringUtil.isBlank(purchaseApplyBean.getApply_date())){ %>
           			<input class="input_185" readonly="readonly" type="text" id="apply_date" name="apply_date" value="<%=currentDbTime %>"/>
           		<%} else {%>
           			<input class="input_185" readonly="readonly" type="text" id="apply_date" name="apply_date" value="<%=purchaseApplyBean.getApply_date()%>"/>
           		<%} %>
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
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> <span class="uom">单位</span></td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 数量</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"> 价格（元）</td>
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
							<%} else { %>
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
								<input type="text" id="apply_price" name="apply_price" class="validate[maxSize[20],custom[number]] input_title_text" style="text-align: center;" />
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
						 <textarea  id="apply_remarks" class="validate[maxSize[100]]"  name="apply_remarks" style="width:99%;height: 60px;border:2px solid #FFF3C9; margin:2px 0 2px;"  rows=3 ><%=StringUtil.deNull(purchaseApplyBean.getApply_remarks())%></textarea>
			   </td>
         </tr> 
	 	</table>
   	 	</div>
   	 	<% if("1".equals(StringUtil.deNull(purchaseApplyBean.getState()))){	//采购审批(处室)%>
   	 		 <div class="content_02_box_div" id="spyj">
	  	 	 <table  border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table_02" width="100%">
	        	 <tr>
		           <th  class="content_02_box_div_table_02_th" id="content_title_name">审批意见：</th>
				   <td class="content_02_box_div_table_02_td"> 
							 <textarea  id="room_opinion" name="room_opinion" class="validate[maxSize[50]]"  rows=3 style="width:99%;height: 60px;border:2px solid #FFF3C9; margin:2px 0 2px;" ><%=StringUtil.deNull(purchaseApplyBean.getRoom_opinion())%></textarea>
				   </td>
	        	 </tr> 
			 </table>
  	 		 </div>
  	 		 <p>&nbsp;</p>
   			 <p>&nbsp;</p>
   	 	<% } else if("2".equals(StringUtil.deNull(purchaseApplyBean.getState()))){%>
   	 		 <% if("1".equals(StringUtil.deNull(purchaseApplyBean.getApply_UserRoles()))){%>
		  	 	 <div class="content_02_box_div">
				  	 <table  border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table_02" width="100%">
			        	 <tr>
				           <th  class="content_02_box_div_table_02_th" id="content_title_name">处室审批意见：</th>
						   <td class="content_02_box_div_table_02_td" width="191">
						   				<input type="hidden"   name="room_opinion" id="room_opinion" value="<%=StringUtil.deNull(purchaseApplyBean.getRoom_opinion())%>"/> 
									 	  <%=StringUtil.deNull(purchaseApplyBean.getRoom_opinion())%>
						   </td>
						    <th  class="content_02_box_div_table_02_th" id="content_title_name">审批时间：</th>
						   <td class="content_02_box_div_table_02_td"> 
						   				<input type="hidden" name="room_Date" id="room_Date" value="<%=StringUtil.deNull(purchaseApplyBean.getRoom_date())%>"/>
									 	  <%=StringUtil.deNull(purchaseApplyBean.getRoom_date())%>
						   </td>
			        	 </tr> 
					 </table>
		   		 </div>
		   		 <%} %>
   			 <div class="content_02_box_div">
	  		 <table  border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table_02" width="100%">
        		 <tr>
		           <th  class="content_02_box_div_table_02_th" id="content_title_name">审批状态：</th>
				   <td class="content_02_box_div_table_02_td"> 
				   			<% 
				   				if("2".equals(StringUtil.deNull(purchaseApplyBean.getState()))){
				   			%>
				   				处室审批通过
				   			<% } else if("4".equals(StringUtil.deNull(purchaseApplyBean.getState()))){%>
				   				办公室审批不通过
				   			<%} else if("6".equals(StringUtil.deNull(purchaseApplyBean.getState()))){ %>
				   				已采购
				   			<% }%>
				   </td>
       		  </tr> 
			 </table>
   		 	</div>
   		 	<div class="content_02_box_div">
	  	       <table  border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table_02" width="100%">
        	      <tr>
		              <th  class="content_02_box_div_table_02_th" id="content_title_name">办公室审批意见：</th>
				      <td class="content_02_box_div_table_02_td"> 
				  		   <textarea  name="office_opinion" id="office_opinion" class="validate[maxSize[50]]" rows=3 style="width: 98%"><%=StringUtil.deNull(purchaseApplyBean.getOffice_opinion())%></textarea>
				      </td>
        		 </tr> 
	          </table>
   	         </div>
   		 <p>&nbsp;</p>
   		 <p>&nbsp;</p>
   	 	<%} %>
   	 	
   	 	</div>
   	    </div>
</form>
	<iframe name="hiddenFrame" width=0 height=0></iframe>

<form id="print_conferenceBase" name="print_conferenceBase">
	<table  width="83%" id="print_table" style="font-size:12pt;display:none; font-family:宋体;margin:0px; border-spacing: 0px; border-collapse: 0px;">
         <tr>
			<td align="center"  >
				<strong style="font-size:24pt; font-family:方正小标宋简体;color: red ;line-height: 30px;">采购申请单</strong>
				<br></br>
			</td>
		</tr>
		<tr >
			<td>
				<table style="border-collapse:collapse;background:#ffffff;padding:0px;color: #FF0000; margin: 0px;border: 1px solid #FF0000;font-size: 12pt;font-family:宋体;width:100%;" id="queryTable1" >
					 <tr >
			            <td width="50%" align="left" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">申请处室： &nbsp;	
							<font style="font-size:10.5pt; font-family:宋体;color:#000000;">
								<%=StringUtil.deNull(purchaseApplyBean.getApply_room())%>
							</font>
			            </td>
			            <td width="50%"  style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;line-height:20px;" height="20">申请日期：&nbsp;	
							<font style="font-size:10.5pt; font-family:宋体;color:#000000;">
							<%=StringUtil.deNull(purchaseApplyBean.getApply_date())%>
							</font>           
			            </td>
            		 </tr>
			      <tr style="height:100px">
			            <td colspan="2" width="35%" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;line-height:20px;" >申请标题：
						<font style="font-size:10.5pt; font-family:宋体;color:#000000;">
						 <%=StringUtil.deNull(purchaseApplyBean.getApply_title())%>
						</font>
			
			            </td>
            
         			</tr>
		  <tr style="height:50px">
            <td colspan="3" width="35%" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;line-height:20px;" >备注：
			<font style="font-size:10.5pt; font-family:宋体;color:#000000;">
			 <%=StringUtil.deNull(purchaseApplyBean.getApply_remarks())%>
			</font>

            </td>
            
          </tr>
          <tr style="height:40px">
            <td colspan="3" width="50%" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;line-height:20px;" >审批状态：
			<font style="font-size:10.5pt; font-family:宋体;color:#000000;">
					<% if("1".equals(StringUtil.deNull(purchaseApplyBean.getState()))){%>
	           				等待处室审批
	           		<% }else if("2".equals(StringUtil.deNull(purchaseApplyBean.getState()))){%>
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
			</font>
            </td>
          </tr>
          <tr style="height:100px">
	            <td  width="50%" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;line-height:20px;" >处室审批意见：
					<font style="font-size:10.5pt; font-family:宋体;color:#000000;">
					 <%=StringUtil.deNull(purchaseApplyBean.getRoom_opinion())%>
					</font>
	            </td>
	            <td colspan="3" width="50%" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;line-height:20px;" >审批日期：
					<font style="font-size:10.5pt; font-family:宋体;color:#000000;">
					 <%=StringUtil.deNull(purchaseApplyBean.getRoom_date())%>
					</font>
	            </td>
         	</tr>
           <tr style="height:100px">
	            <td  width="50%" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;line-height:20px;" >办公室审批意见：
					<font style="font-size:10.5pt; font-family:宋体;color:#000000;">
					 <%=StringUtil.deNull(purchaseApplyBean.getOffice_opinion())%>
					</font>
	            </td>
	            <td colspan="3" width="50%" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;line-height:20px;" >审批日期：
					<font style="font-size:10.5pt; font-family:宋体;color:#000000;">
					 <%=StringUtil.deNull(purchaseApplyBean.getOffice_date())%>
					</font>
	            </td>
         	</tr>
           
           <tr>
				<td align="center" colspan="2" >
					<strong style="font-size:15pt; font-family:方正小标宋简体;color: red ;line-height: 30px;">物品列表</strong>
				</td>
		   </tr>
			          <table style="border-collapse:collapse;background:#ffffff;padding:0px;color: #FF0000; margin: 0px;border-left: 1px solid #FF0000; border-right: 1px solid #FF0000; border-bottom: 1px solid #FF0000;font-size: 12pt;font-family:宋体;width:100%;" >
								       <tr>
								          <td  width="40%"  style="border-left: 1px solid #FF0000; border-right: 1px solid #FF0000; border-bottom: 1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;line-height: 30px;" align="center">品&nbsp;&nbsp;&nbsp;&nbsp;名</td>
										  <td   width="40%" style="border-left: 1px solid #FF0000; border-right: 1px solid #FF0000; border-bottom: 1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;line-height: 30px;" align="center"><span class="uom">单位</span></td>
										  <td   width="20%" style="border-left: 1px solid #FF0000; border-right: 1px solid #FF0000; border-bottom: 1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;line-height: 30px;" align="center">数量</td>
										  <td   width="20%" style="border-left: 1px solid #FF0000; border-right: 1px solid #FF0000; border-bottom: 1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;line-height: 30px;" align="center">价格（元）</td>
								       </tr>
								           <% 
											if(ordersGoods.size()>0){
													if(ordersGoods.size()< 8 ){
													for(int i=0;i<ordersGoods.size();i++){
														OrderGoods goods =(OrderGoods)ordersGoods.get(i);
												    %>	
											          <tr>
											           	<td width="30%" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;line-height: 30px;" align="center"><font style="font-size:10.5pt; font-family:宋体;color:#000000;"><%=StringUtil.deNull(goods.getGoods_name()) %></font></td>
													    <td width="30%" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;line-height: 30px;" ><font style="font-size:10.5pt; font-family:宋体;color:#000000;"><%=StringUtil.deNull(goods.getGoods_unit()) %></font></td>
													    <td width="20%" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;line-height: 30px;" ><font style="font-size:10.5pt; font-family:宋体;color:#000000;"><%=StringUtil.deNull(goods.getGoods_count()) %></font></td>
													    <%if("0".equals(StringUtil.deNull(goods.getGoods_price()))){ %>
															<td width="20%" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;line-height: 30px;" ><font style="font-size:10.5pt; font-family:宋体;color:#000000;">&nbsp;</font></td>
														<%} else { %>
															 <td width="20%" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;line-height: 30px;" ><font style="font-size:10.5pt; font-family:宋体;color:#000000;"><%=StringUtil.deNull(goods.getGoods_price()) %></font></td>
														<%} %>
											          </tr>
										          	<%}%>
										          	<%for(int i=0;i<8-ordersGoods.size();i++){ %>
										          	 <tr>
											           	<td width="30%" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;line-height: 30px;" align="center"><font style="font-size:10.5pt; font-family:宋体;color:#000000;">&nbsp;</font></td>
													    <td width="30%" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;line-height: 30px;" ><font style="font-size:10.5pt; font-family:宋体;color:#000000;">&nbsp;</font></td>
													    <td width="20%" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;line-height: 30px;" ><font style="font-size:10.5pt; font-family:宋体;color:#000000;">&nbsp;</font></td>
											          	 <td width="20%" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;line-height: 30px;" ><font style="font-size:10.5pt; font-family:宋体;color:#000000;">&nbsp;</font></td>
											          </tr>
										          	<%} %>
													<% }else{%>
														<%for(int i=0;i<ordersGoods.size();i++){
															OrderGoods goods =(OrderGoods)ordersGoods.get(i);	
														%>
														
															 <tr>
													           	<td width="30%" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;line-height: 30px;" align="center"><font style="font-size:10.5pt; font-family:宋体;color:#000000;"><%=StringUtil.deNull(goods.getGoods_name()) %></font></td>
															    <td width="30%" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;line-height: 30px;" ><font style="font-size:10.5pt; font-family:宋体;color:#000000;"><%=StringUtil.deNull(goods.getGoods_unit()) %></font></td>
															    <td width="20%" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;line-height: 30px;" ><font style="font-size:10.5pt; font-family:宋体;color:#000000;"><%=StringUtil.deNull(goods.getGoods_count()) %></font></td>
													        	 <%if("0".equals(StringUtil.deNull(goods.getGoods_price()))){ %>
																	<td width="20%" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;line-height: 30px;" ><font style="font-size:10.5pt; font-family:宋体;color:#000000;">&nbsp;</font></td>
																<%} else { %>
																	 <td width="20%" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;line-height: 30px;" ><font style="font-size:10.5pt; font-family:宋体;color:#000000;"><%=StringUtil.deNull(goods.getGoods_price()) %></font></td>
																<%} %>
													         </tr>
													<% }}}else { %>
										          		<% for(int j = 0;j< 9; j++ ){ %>
										          			<tr>
													    		<td width="30%" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;line-height: 30px;">&nbsp;</td>
													   			 <td width="30%"  style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;line-height: 30px;" >&nbsp;</td>
													   			 <td width="20%"  style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;line-height: 30px;" >&nbsp;</td>
													  			 <td width="20%"  style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;line-height: 30px;" >&nbsp;</td>
													  		</tr>
										          		<%} %>
												 	<%} %>
								</table>
								
							</table>
			
					
			</td>
		</tr>
         
    </table>
    
	
</form>
<script language="javascript" type="text/javascript">
     var LODOP; //声明为全局变量 
	
	function prn1_preview_conferceBase() {
		jQuery("#print_table").show();
		CreateOneFormPage();	
		LODOP.PREVIEW();	
		jQuery("#print_table").hide();
	};

	function CreateOneFormPage(){
		LODOP=getLodop(document.getElementById('LODOP'),document.getElementById('LODOP_EM'));  
		LODOP.PRINT_INIT("打印控件功能演示_Lodop功能_表单一");

		LODOP.SET_PRINT_STYLE("Bold",1);
		LODOP.ADD_PRINT_TEXT(50,231,260,39,"");
		LODOP.ADD_PRINT_HTM(60,45,800,980,document.getElementById("print_conferenceBase").innerHTML);
	};	                     
	
</script>
</body>
</html>

