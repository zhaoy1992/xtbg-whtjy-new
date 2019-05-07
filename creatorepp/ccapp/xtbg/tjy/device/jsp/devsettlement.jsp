<%--
描述：政府采购验收结算界面
作者：邱炼
版本：1.0
日期：2014-03-15
--%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.DevEquipmentaccService"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.impl.DevEquipmentaccServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.DevSettleItemService"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.impl.DevSettleItemServiceImpl"%>
<%@page import="antlr.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.core.archive.dao.FlowBusiDataSaveDao"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.ArrayList"%>
<%@page import ="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@ taglib uri="/WEB-INF/archive-taglib.tld" prefix="oa"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	//当前用户信息
	String user_id = accesscontroler.getUserID();
	String user_name = accesscontroler.getUserName();
	
	//当前用户机构
	String org_id = accesscontroler.getChargeOrgId();
	String orgName = accesscontroler.getChargeOrgName();
	
	//录入时间
	String r_creater_time = DateUtil.getCurrentDateTime();

	//主键ID
	String busi_id  = StringUtil.deNull(request.getParameter("busi_id"));
	
	//环节ID
	String action_defid = StringUtil.deNull(request.getParameter("action_defid"));
	
	//取从start传过来的值
	String operType = StringUtil.deNull(request.getParameter("operType"));
	
	//业务类型code
	String busiTypeCode = StringUtil.deNull(request.getParameter("busiTypeCode"));
	
	//正文ID
	String document_id = UUID.randomUUID().toString();
	
	//新增启动第一次的时候  默认设置为第一个环节
	if(action_defid.equals("")){
		action_defid="sbzfcgys_wp1_act1";
	}
	
	//跳转windowId
	String windowsId = StringUtil.deNull(request.getParameter("windowsId"));
	
	//物品明细表
	DevSettleItemService devsettleitemservice = new DevSettleItemServiceImpl();
	List<Map<String,String>> listItems = devsettleitemservice.getDevSettleItem(busi_id);
	//验收单表单
	DevEquipmentaccService devequipmentaccservice = new DevEquipmentaccServiceImpl();
    JSONObject jsonObj = new JSONObject();
%>
<!-- 公共部分开始 -->
<title>政府采购验收结算</title>
	<oa:init>
	<link rel="stylesheet" href="ccapp/oa/archive/css.css" type="text/css" />
	<script type='text/javascript' src='<%=path %>/ccapp/oa/resources/plug/jquery-media/jquery.media.js' charset="utf-8"></script>
	<script type="text/javascript">
	var item_trId = "<%=listItems.size()%>";//采购列表行ID
	//环节ID
	var action_defid="<%=action_defid%>";
	 jQuery(function(){
		 
 		//填写申请环节  设置标题
 		if("sbzfcgys_wp1_act1"==action_defid){
 			//申请时间
			jQuery("#TA_OA_DEVSETTLEMENT__T_APPDATE").val("<%=r_creater_time%>");
			jQuery("#dis_TA_OA_DEVSETTLEMENT__T_APPDATE").val("<%=r_creater_time%>");
 		} 
 		
 		//采购验收单 事件绑定
 		jQuery("#dayTable").on("click",".a_addDev",function(){
 			//父界面行ID
 			var tr_id = jQuery(this).parent().parent().parent().attr("id");
 			addDevEquipmentatcc(tr_id);		
 		})
	 });
	//添加物品
	function Add_Row4NewDay1(){
		var firstTr = jQuery("[name=dayrow]").first().clone();
		
		jQuery(firstTr).find("input[type=text]").val("");
		jQuery(firstTr).attr("id",item_trId++);
		jQuery(firstTr).find("input[type=hidden]").val("");
		jQuery(firstTr).find("textarea").val("");
		firstTr.find("input[type=text]").val("");
		var dayTable = jQuery("#dayTable");
		firstTr.appendTo(dayTable);
		jQuery(firstTr).find(".date_187").each(function(i,e){
			setDataTimeClickShowOrHide($(this).attr("id"),window);
		})
	}
	//删除物品
	function deleteDay(tag,goodsId){
		
		var intable=jQuery(tag).parents("table");
		var tr= jQuery(tag).parents("tr").first();
		var trsize= jQuery(intable).find("tr[name=dayrow]").size();
		if(trsize==1){
			Add_Row4NewDay1();
			jQuery(tr).remove();
		}else{
			jQuery(tr).remove();
		}
	}
	
	/*
	函数:  openSupplier
	说明:  打开供应商的窗口
	参数:   无
	返回值: 无
	*/
	function openSupplier(){
		var path ="<%=path%>/ccapp/xtbg/tjy/device/type/jsp/seldevsupplierlist.jsp?windowsId=windowIds1";
		openAlertWindows('windowIds1',path,'供应商名录',810,400,'25%','25%');
	}
	/*
	函数:  setSupperInfo
	说明:  回填供应商的数据
	参数:   无
	返回值: 无
	*/
	function setSupperInfo(devsup_id,devsup_mc,devsup_slsj,devsup_lxdb,
		 	devsup_gfxz,devsup_gfdz,devsup_fddbr,
		 	devsup_lxdh,devsup_xyd,devsup_tgcp,devsup_gflb,devsup_gflbbh,devsup_xydbh){
		//供应商ID
		jQuery("#TA_OA_DEVSETTLEMENT__T_SUPP_UNITID").val(devsup_id);
		//供应商名称
		jQuery("#TA_OA_DEVSETTLEMENT__T_SUPP_UNIT").val(devsup_mc);
	}
	
	/*
	 函数:  addDevEquipmentatcc
	 说明:  添加采购验收单
	 参数:   tr_id 行ID
	 返回值: 无
	 */
	var addDevEquipmentatcc = function(tr_id) {
		//验收单ID
		var item_reportid = jQuery("#"+tr_id).find("#item_reportid").val();
		//采购验收单信息
		var devquipmentVo = jQuery("#"+tr_id).find("#devquipmentaccVo").val();
		var devquipmentemp = changeTextareaChar2special(_pub.lang.zwzm(devquipmentVo));
		var pageName ="采购验收单";
		var height = window.screen.availHeight-100;
		var width = window.screen.availWidth-100;
		openAlertWindows('windowId2',"../../../tjy/device/jsp/devequipmentacc.jsp?windowsId=windowId2&tr_id="+tr_id+"&t_id="+item_reportid+"&action_defid="+action_defid+"&devquipmentaccVo="+devquipmentemp,pageName,width,height,'1%','1%');
	}
	
	/*
	 函数:  setDevEquimentaccInfo
	 说明:  回填验收单数据
	 参数:   devequipvo  验收单json对象
	 返回值: 无
	 */
	function setDevEquimentaccInfo(devequipvo){
		jQuery("#"+devequipvo.tr_id).find("#item_name").val(devequipvo.t_sbname); 
		jQuery("#"+devequipvo.tr_id).find("#item_type").val(devequipvo.t_ggno)
		jQuery("#"+devequipvo.tr_id).find("#item_count").val(devequipvo.t_sl)
		var t_sbname = devequipvo.t_sbname;//货品名称
		var t_ggno= devequipvo.t_ggno;//型号
		var t_sl= devequipvo.t_sl;//数量
		var  strDevequipvo = getJsonStringNoDescape(devequipvo);
		jQuery("#"+devequipvo.tr_id).find("#devquipmentaccVo").val(strDevequipvo);
	}
</script>

</head>
<body>
<form id="form1" name="form1" action="" method="post" >
	<input type="hidden" id="opt_type"     name="opt_type" /> 
	<input type="hidden" id="busi_id"  name="busi_id"  value="<%=busi_id %>" /> 
	<input type="hidden" id="item_plainid" name="item_plainid"  value="<%=busi_id %>" /> 
	<input type="hidden" id="busiTypeCode" name="busiTypeCode"  value="<%=busiTypeCode%>"/>
	<input type="hidden" id="action_defid" name="action_defid"  value="<%=action_defid%>"/>
	<input id="windowsId" name="windowsId" type="hidden" value="<%=windowsId%>"/>
	<input value="com.chinacreator.xtbg.tjy.device.dao.Impl.DevSettlItemFlowDaoImpl" id="<%=FlowBusiDataSaveDao.CUSTOM_CRUD_CLASSNAME_FLAG%>" 
	name="<%=FlowBusiDataSaveDao.CUSTOM_CRUD_CLASSNAME_FLAG%>" type="hidden"/><%--结算流程业务实现类--%>

<div id="tabs1" style="width:99%">
	<div id="tabs-1">
		<table width="95%" border="0" cellspacing="1" cellpadding="0"
			style="margin-left: 15px; margin-right: 15px; display: inline;">
			<tr>
				<td><oa:flowcommonstart flowType="1" />
				</td>
			</tr>
			<tr>
			<td style="padding-bottom: 10px;">
	<%-- 主表单 begin---%>
	<div class="vcenter" style="float: left; overflow-x: hidden;" scrolling="yes">
			<div style="float: left; width: 996px;">
			<%--shang--%>
			<div class="content_02_box" style="width:996px;">
				<div class="content_02_box_div" style="width: 996px;">
					<table border="0" cellspacing="0" cellpadding="0"
						class="content_02_box_div_table" style="width: 98%;">
						<tr><%--row1--%>
							<th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>申请标题：</th>
							<td class="content_02_box_div_table_td" colspan="3">
								<oa:input
										type="text" column="T_TITLE" table="TA_OA_DEVSETTLEMENT"
										other="class='input_title_text validate[required,maxSize[250]]'" style="width:750px;" />
							</td>
						</tr>
						<tr><%--row2--%>
							<th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>填表时间：</th>
							<td class="content_02_box_div_table_td">
								<oa:date dateFmt='yyyy-MM-dd HH:mm:ss' column="T_APPDATE" table="TA_OA_DEVSETTLEMENT" other="class='input_cx_title_240' readonly='readonly'"  />
								<script>
								jQuery(function(){
									jQuery("#dis_TTA_OA_DEVSETTLEMENT__T_APPDATE").removeAttr("onClick");
								});
								</script>
							</td>
							<th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>供货单位：</th>
							<td class="content_02_box_div_table_td" >
								<oa:input
										type="hidden" column="T_SUPP_UNITID" table="TA_OA_DEVSETTLEMENT"
										other="class='input_cx_title_240 validate[required,maxSize[200]]'"  />
								<oa:input
										type="text" column="T_SUPP_UNIT" table="TA_OA_DEVSETTLEMENT"
										other="class='input_cx_title_240 validate[required,maxSize[100]]'"  />
								<input name="" type="button" value="" class="but_x" onclick="openSupplier();"/>
							</td>
						</tr>
						<tr><%--row3--%>
							<th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>政府采购编号：</th>
							<td class="content_02_box_div_table_td">
								<oa:input
										type="text" column="T_APPORDER_NO" table="TA_OA_DEVSETTLEMENT"
										other="class='input_cx_title_240 validate[required,maxSize[200]]'"  />
							</td>
							<th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>编号：</th>
							<td class="content_02_box_div_table_td" >
								<oa:input
										type="text" column="T_ORDER_NO" table="TA_OA_DEVSETTLEMENT"
										other="class='input_cx_title_240 validate[required,maxSize[200]]'" />
							</td>
						</tr>
					</table>
				</div>
			</div>
			
			<!-- 形成采购货品清单 DIV-->
			<div class="content_02_box" style="width: 996px;">
			<div class="content_02_box_title_bg" style="width: 98%">
			<span>货品结算</span>
			<div class="content_02_box_add">
			<a onclick="Add_Row4NewDay1()" id="addButton"><img src="ccapp/xtbg/resources/images/add.gif"/>添加货品</a>
			</div>
			</div>
			<div class="content_02_box_div" style="width: 996px;">
			<table id="dayTable" class="content_02_box_div_table_02" width="98%" cellspacing="0" cellpadding="0" border="0">
					 	<tr>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span>货品名称</td>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span>型号规格</span></td>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 60px"><span style="color: red">*</span>数量</td>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 80px"><span style="color: red">*</span>单价</td>
							<td class="content_02_box_div_table_th" align="center"style="text-align: center;width: 80px">操作</td>
						</tr>
						 <% 
									 if(listItems.size()>0){
										for(int i=0;i<listItems.size();i++){
											HashMap<String,String> itemMap =(HashMap<String,String>)listItems.get(i); 
											//验收单查询
											Map<String,String> devequipmentMap = devequipmentaccservice.getDevEquipmentaccBean(StringUtil.deNull(itemMap.get("item_reportid")));
											String devequipmentVo = jsonObj.toJSONString(devequipmentMap);
						 %>	 
							  <tr id="<%=i%>" name="dayrow" >
									<td class="content_02_box_div_table_td"> 
										<textarea  id="devquipmentaccVo" name="devquipmentaccVo" style="display: none;"><%=devequipmentVo%></textarea><!--验收单信息json字符窜  -->
										<input type="hidden" id="t_id" name="t_id" value="<%=StringUtil.deNull(itemMap.get("t_id"))%>" /><!-- 货品主键ID -->
										<input type="hidden" id="item_reportid" name="item_reportid" value="<%=StringUtil.deNull(itemMap.get("item_reportid"))%>" /><!-- 验收单ID -->
										
										<input type="text" id="item_name" name="item_name" value="<%=StringUtil.deNull(itemMap.get("item_name"))%>" class="validate[required,maxSize[100]] input_title_text"  style="text-align: center;" />
									</td>
									<td class="content_02_box_div_table_td"> 
											<input type="text" id="item_type" name="item_type" value="<%=StringUtil.deNull(itemMap.get("item_type"))%>" class="validate[required,maxSize[100]] input_title_text" style="text-align: center;"/>
									</td>
									<td class="content_02_box_div_table_td"> 
											<input type="text" id="item_count" name="item_count" value="<%=StringUtil.deNull(itemMap.get("item_count"))%>" class="validate[required,maxSize[50],custom[integer]] input_title_text"  readonly="readonly" style="text-align: center;" />
									</td>
									<td class="content_02_box_div_table_td"> 
											<input type="text" id="item_price" name="item_price" value="<%=StringUtil.deNull(itemMap.get("item_price"))%>"  class="validate[required,maxSize[50],custom[number]] input_title_text" style="text-align: center;" />
									</td>
									<td class="content_02_box_div_table_td"> 
									 <div class="content_02_box_del" style="height:24px; margin:0;float: none;text-align: center;" >
										<a onClick="deleteDay(this,'<%=StringUtil.deNull(itemMap.get("t_id"))%>')" name="deleteButton"> <img src="ccapp/xtbg/resources/images/del.gif" id="del"/>删除</a>
										<a class="a_addDev" > 采购验收单</a>
									 </div>
									</td>
								</tr>  
							 <%
									}
								} else { 
							%>
							<tr id="-1" name="dayrow">
								<td class="content_02_box_div_table_td"> 
										<textarea  id="devquipmentaccVo" name="devquipmentaccVo" style="display: none;"></textarea><!--验收单信息json字符窜  -->
										<input type="text" id="item_name" name="item_name" class="validate[required,maxSize[100]] input_title_text" style="text-align: center;" />
								</td>
								<td class="content_02_box_div_table_td"> 
										<input type="text" id="item_type" name="item_type" class="validate[required,maxSize[100]] input_title_text" style="text-align: center;"/>
								</td>
								<td class="content_02_box_div_table_td"> 
										<input type="text" id="item_count" name="item_count" class="validate[required,maxSize[50],custom[integer]] input_title_text"  readonly="readonly" style="text-align: center;" />
								</td>
								<td class="content_02_box_div_table_td"> 
										<input type="text" id="item_price" name="item_price" class="validate[required,maxSize[50],custom[number]] input_title_text" style="text-align: center;" />
								</td>
								<td class="content_02_box_div_table_td"> 
								 <div class="content_02_box_del" style="height:24px; margin:0;float: none;text-align: center;">
										<a onClick="deleteDay(this,'')"> <img src="ccapp/xtbg/resources/images/del.gif" id="del"/>删除</a>
										<a class="a_addDev" > 采购验收单</a>
								 </div>
														
								</td>
							</tr>
							<%
							 } 
							%>
				</table>
				</div>
			</div>
			<!-- 形成采购货品清单DIV -->
			
			
			<!--审核意见DIV-->
			 <div class="content_02_box" style="width: 995px;"  >
			 	  <table width="98%">
			 	  	<tr>
			 	  		<td class="content_02_box_div_table_td">
						 	<span style="float: left;">技术人员：</span>
							 <oa:view column="T_TECHNOLOGY_YJ" table="TA_OA_DEVSETTLEMENT" 
											style="border: 1;width:99%;overflow: auto;" other="class='validate[maxSize[1000]] textarea_556'" />
						</td>
						<td class="content_02_box_div_table_td">
							 <span style="float: left;">财务人员：</span>
							 <oa:view column="T_FINANCE_YJ" table="TA_OA_DEVSETTLEMENT" 
									style="border: 1;width:97%;overflow: auto;" other="class='validate[maxSize[1000]] textarea_556'" />
						</td>	
					</tr>
				 </table>
			</div>
			<!--审核意见DIV END-->
			</div>
			</div>
			<%-- 主表单 end---%>
			</td>
			</tr>
		</table>
	</div>
</div>	
	
</form>
<IFRAME name=frame1 width=100% height=0> </IFRAME> 
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
	
	//点击完成
	var afterActionSuccessFn=function(){
		getParentWindow('<%=windowsId%>').location.href = "<%=path%>/ccapp/xtbg/tjy/processing/mainhandlist.jsp";
		removeAlertWindows('<%=windowsId%>',true);
		
	};
	//返回按钮
	function returnPage() {
		window.top.window.frames["_document_body_mian_firstPagerAAAS"].document.location.reload();
		removeAlertWindows('<%=windowsId%>',true);
		
	}
	
	
</script>
</body>
</oa:init>
</html>

