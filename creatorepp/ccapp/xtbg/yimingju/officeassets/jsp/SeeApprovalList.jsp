<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.security.authorization.AuthRole"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.service.impl.PurchaseApplyServiceImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.service.PurchaseApplyServiceIfc"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.entity.PurchaseApplyBean"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.entity.OrderGoods"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@ page import="com.chinacreator.framework.*"%>
<%@ page import="com.chinacreator.framework.ItemQueue.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
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
	//用户是否配置了采购清单菜单
		String modulePath = "module::menu://sysmenu$root";
		MenuHelper menuHelper = new MenuHelper(accesscontroler);
		ModuleQueue moduleQueue = menuHelper.getSubModules(modulePath);
		List<Module> moduleList = moduleQueue.getList();
		String moduleSubId="ymj_cgqdllist";//采购清单module ID
		String flagModule ="";  //采购清单菜单的标记
		for(Module module: moduleList){
			ModuleQueue subModule = module.getSubModules();
			List<Module> subModules = subModule.getList();
			if(subModules.size()> 0){
				for(Module subModule2: subModules){
					ItemQueue queue = subModule2.getItems();
					List<Item> list = queue.getList();
					for(Item queue2:list){
						String moduleId = queue2.getId();
						if(moduleSubId.equals(moduleId)){
							flagModule = "1";
							break;
						}
					}
				}
			} else{
				ItemQueue queue = module.getItems();
				List<Item> list = queue.getList();
				for(Item queue2:list){
					String moduleId = queue2.getId();
					if(moduleSubId.equals(moduleId)){
						flagModule = "1";
						break;
					}
				}
			}
		}
	
	String whatDo = request.getParameter("whatDo");
	String widowsid = "";
	if(request.getParameter("windowId")!=null){
		widowsid=request.getParameter("windowId");
	}else {
		widowsid=request.getParameter("widowsid");
	}
	String apply_id = request.getParameter("apply_id");	
	//service对象
 	PurchaseApplyServiceIfc purchaseApplyServiceIfc = new PurchaseApplyServiceImpl();
 	PurchaseApplyBean purchaseApplyBean = new PurchaseApplyBean();
 	ArrayList<OrderGoods> ordersGoods = new ArrayList<OrderGoods>();
 	if (!StringUtil.isBlank(apply_id)) {
 		purchaseApplyBean = purchaseApplyServiceIfc.getOeBeanById(apply_id);
 		ordersGoods = purchaseApplyServiceIfc.getGoodsBeanById(apply_id);
 	}
 	
 	
 	AuthRole authRoles[] = accesscontroler.getAllRoleofUser(accesscontroler.getUserAccount());
	String rolesNames = "";//查询拥有哪些角色
	StringBuffer buf = new StringBuffer();
	for(int i=0;i<authRoles.length;i++){
		buf.append(authRoles[i].toString()+ ",");
	}   
	rolesNames = buf.toString();
	if(rolesNames.length()>0){
		rolesNames = rolesNames.substring(0,rolesNames.length()-1);
	}
 	//是否拥有资产采购角色
	String purchaseFlag = "0";
	//拥有资产采购角色才分配给这个角色【采购完成】按钮权限
	if(rolesNames.indexOf("资产采购角色")!=-1){
		purchaseFlag = "1";
	}
	//add by jianhua.chen1 望城系统编码，添加个性化东西
	String userArea=CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");	//421005，衡阳系统编码
%>
<title>采购审批查看</title>
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
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
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
<!--公共部分结束  -->
<script type="text/javascript">

jQuery(document).ready(function() {
	//衡阳个性化东西设置
	if("<%=userArea%>" == "421005"){	
		$(".uom").html("计量单位");
	}
	jQuery("#conferenceBase").validationEngine();
});
//提交方法
function saveInfo(id){
	if( jQuery("#conferenceBase").validationEngine("validateform")){
		//采购完成
		var url = "addDetailApprovalDo.jsp?whatDo=1";
		$('#conferenceBase').attr("target","hiddenFrame");
		$('#conferenceBase').attr("action",url);
		$('#conferenceBase').submit();
	}
}

/* 返回 */
function backTo(){
	removeWindows('<%=widowsid%>',true,false);
} 
</script>
</head>
<body style="overflow-y: hidden;" onload="adaptationWH('content_02_top','vcenter',45)">
<form id="conferenceBase" name="conferenceBase" method="post"  >
	<input type="hidden" name="apply_id" id="apply_id" value='<%=StringUtil.deNull(purchaseApplyBean.getApply_id())%>'/>
	<input type="hidden" name="widowsid" id="widowsid" value='<%=StringUtil.deNull(request.getParameter("widowsid"))%>'/>
	<input type="hidden" name="deleteGoodsIds" id="deleteGoodsIds" value=''/>
	
	<div  class="content_02" style="overflow:hidden;" id="content_02_top">
	<!--   操作 -->
    <div class="content_02_top" style="margin-bottom:10px;">
    	<% if("detail".equals(whatDo)){%>
    		<input type="hidden" name="ApprovalStatus" id="ApprovalStatus" value="6"/>
    		<%if("1".equals(flagModule)&&"1".equals(purchaseFlag)){%>
    			<input id="ok" onclick='saveInfo()' value="采购完成" type="button" class="but_y_01"/>
    		<%}%>
   			<input id="notPass" onclick='backTo();' value="返回" type="button" class="but_y_01"/>
    	<%} else{ %>
    		<input id="ok" onclick='backTo()' value="返回" type="button" class="but_y_01"/>
   			<input id="notPass" onclick='prn1_preview_conferceBase();' value="打印" type="button" class="but_y_01"/>
    	<%} %>
  	</div> 
  	</div> 
	 
	<!-- 表格-->
	<div id="vcenter" class="content_02"  style="float: left; width: 100%; overflow: scroll" scrolling="yes">
	<div style="float: left; width: 775px; ">
	<div class="content_02_box" >
	<div class="content_02_box_title_bg"><span>采购申请单</span></div>
	 <div class="content_02_box_div">
	   <table  border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table">
         <tr>
           <th  class="content_02_box_div_table_th" id="content_title_name">申请处室：</th>
           <td class="content_02_box_div_table_td" style="text-align: center;">
           		<input type="text"  value="<%=StringUtil.deNull(purchaseApplyBean.getApply_room())%>" class="input_title_text" readonly="readonly"/>
           	</td>
           <th width="191" class="content_02_box_div_table_th">申请日期：</th>
           <td class="content_02_box_div_table_td"  style="text-align: center;">
           		<%=StringUtil.deNull(purchaseApplyBean.getApply_date())%>
			</td>
         </tr> 
         <tr id="hidetr">
         	 <th  class="content_02_box_div_table_th" id="content_title_name">申请标题：</th>
	         <td colspan="3" class="content_02_box_div_table_td" style="text-align: left;">
					 <%=StringUtil.deNull(purchaseApplyBean.getApply_title())%>
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
	<table id="dayTable" class="content_02_box_div_table_td" width="100%" cellspacing="0" cellpadding="0" border="0">
			 	<tr>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"> 品名</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"> <span class="uom">单位</span></td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"> 数量</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"> 价格（元）</td>
				</tr>
				<% 
							if(ordersGoods.size()>0){
								for(int i=0;i<ordersGoods.size();i++){
									OrderGoods goods =(OrderGoods)ordersGoods.get(i);
				 %>	
				<tr name="dayrow">
					<td class="content_02_box_div_table_td" style="text-align: center;width: 147px"> 
					<input type="hidden" id="goods_id" name="goods_id"  value="<%=goods.getGoods_id()%>" />
							<%=goods.getGoods_name()%>
					</td>
					<td class="content_02_box_div_table_td" style="text-align: center;width: 147px"> 
							<%=goods.getGoods_unit()%>
					</td>
					<td class="content_02_box_div_table_td" style="text-align: center;width: 147px"> 
							<%=goods.getGoods_count()%>
					</td>
					<td class="content_02_box_div_table_td" style="text-align: center;width: 147px"> 
							<%if("0".equals(StringUtil.deNull(goods.getGoods_price()))) {%>
								<input type="text" id="apply_price" name="apply_price" class="validate[required,maxSize[10],custom[number]] input_title_text" style="text-align: center;" value="" />
							<%}else{ %>
								 <% if("6".equals(StringUtil.deNull(purchaseApplyBean.getState()))){ %>
								 	<input type="text" id="apply_price" name="apply_price" readonly="readonly" class="validate[required,maxSize[10],custom[number]] input_title_text" style="text-align: center;" value="<%=goods.getGoods_price()%>" />
								 <% }else { %>
									<input type="text" id="apply_price" name="apply_price" class="validate[required,maxSize[10],custom[number]] input_title_text" style="text-align: center;" value="<%=goods.getGoods_price()%>" /> 
								 <%} %>
								
							<%} %>
							
					</td>
				</tr>
					<%
							}
						}else{
					%>
					<tr name="dayrow">
						<td class="content_02_box_div_table_td"> 
								&nbsp;&nbsp;&nbsp;
						</td>
						<td class="content_02_box_div_table_td"> 
								&nbsp;&nbsp;&nbsp;
						</td>
						<td class="content_02_box_div_table_td"> 
								&nbsp;&nbsp;&nbsp;
						</td>
						<td class="content_02_box_div_table_td"> 
								&nbsp;&nbsp;&nbsp;
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
							<input type="text" value="<%=StringUtil.deNull(purchaseApplyBean.getApply_remarks())%>" readonly="readonly" class="input_title_text"/>
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
   	 <% if("1".equals(StringUtil.deNull(purchaseApplyBean.getApply_UserRoles()))){ %>
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
   	 <% if(!"2".equals(StringUtil.deNull(purchaseApplyBean.getState()))&&!"3".equals(StringUtil.deNull(purchaseApplyBean.getState()))
   			 &&!"3".equals(StringUtil.deNull(purchaseApplyBean.getApply_UserRoles()))){%>
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
								          <td  width="30%"  style="border-left: 1px solid #FF0000; border-right: 1px solid #FF0000; border-bottom: 1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;line-height: 30px;" align="center">品&nbsp;&nbsp;&nbsp;&nbsp;名</td>
										  <td   width="30%" style="border-left: 1px solid #FF0000; border-right: 1px solid #FF0000; border-bottom: 1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;line-height: 30px;" align="center"><span class="uom">单位</span></td>
										  <td   width="20%" style="border-left: 1px solid #FF0000; border-right: 1px solid #FF0000; border-bottom: 1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;line-height: 30px;" align="center">数量</td>
										  <td   width="20%" style="border-left: 1px solid #FF0000; border-right: 1px solid #FF0000; border-bottom: 1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;line-height: 30px;" align="center">价格</td>
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
											         	<%} else{ %>
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
											         			<%} else{ %>
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

