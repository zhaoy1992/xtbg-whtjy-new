<%--
描述：设备政府采购界面
作者：邱炼
版本：1.0
日期：2014-02-24
--%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.impl.DevAppItemServiceImpl"%>
<%@page import="antlr.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.core.archive.dao.FlowBusiDataSaveDao"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.ArrayList"%>
<%@page import ="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.security.AccessControl"%>
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
		action_defid="sbzfcg_wp1_act1";
	}
	
	//跳转windowId
	String windowsId = StringUtil.deNull(request.getParameter("windowsId"));
	
	//物品明细表
	DevAppItemServiceImpl devappitemserviceimpl = new DevAppItemServiceImpl();
	List<Map<String,String>> listItems = devappitemserviceimpl.getDevAppItemBean(busi_id);

%>
<!-- 公共部分开始 -->
<title>设备政府采购</title>
	<oa:init>
	<link rel="stylesheet" href="ccapp/oa/archive/css.css" type="text/css" />
	<script type='text/javascript' src='<%=path %>/ccapp/oa/resources/plug/jquery-media/jquery.media.js' charset="utf-8"></script>
	<script type="text/javascript">
	//环节ID
	var action_defid="<%=action_defid%>";
	 jQuery(function(){
 		//填写申请环节  设置标题
 		if("sbzfcg_wp1_act1"==action_defid){
 			//标题
 			jQuery("#TA_OA_DEVAPPLICATION__T_TITLE").val("【<%=orgName%>】：【<%=user_name%>】");
 		}
	    });
	//添加物品
	function Add_Row4NewDay1(){
		var firstTr = jQuery("[name=dayrow]").first().clone();
		
		jQuery(firstTr).find("input[type=text]").val("");
		
		jQuery(firstTr).find("input[type=hidden]").val("");
		
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
		var tr=jQuery(tag).parents("tr").first();
		var trsize= jQuery(intable).find("tr[name=dayrow]").size();
		if(trsize==1){
			Add_Row4NewDay1();
			jQuery(tr).remove();
		}else{
			jQuery(tr).remove();
		}
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
	<input value="com.chinacreator.xtbg.tjy.device.dao.Impl.DevAppItemFlowDaoImpl" id="<%=FlowBusiDataSaveDao.CUSTOM_CRUD_CLASSNAME_FLAG%>" 
	name="<%=FlowBusiDataSaveDao.CUSTOM_CRUD_CLASSNAME_FLAG%>" type="hidden"/><%--业务--%>

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
				<div class="content_02_box_title_bg" style="width: 98%;">
					<span>申购采购表</span>
				</div>
				<div class="content_02_box_div" style="width: 996px;">
					<table border="0" cellspacing="0" cellpadding="0"
						class="content_02_box_div_table" style="width: 98%;">
						<tr><%--row1--%>
						<oa:input type="hidden" column="T_ORGID" table="TA_OA_DEVAPPLICATION" value="<%= org_id%>"/>
							<th class="content_02_box_div_table_th"><FONT style="COLOR: red" id="bt_id" >*</FONT>申请部门（分院）：</th>
							<td class="content_02_box_div_table_td" >
								<oa:input
										type="text" column="T_ORGNAME" table="TA_OA_DEVAPPLICATION"
										other="class='input_cx_title_240'" value="<%=orgName%>"  />
							</td>
							<th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>填表时间：</th>
							<td class="content_02_box_div_table_td">
								<oa:input
										type="text" column="T_CREATORTIME" table="TA_OA_DEVAPPLICATION"
										other="class='input_cx_title_240 validate[required,maxSize[200]]'" value="<%=r_creater_time%>" />
							</td>
						</tr>
						<tr>
						<%--row2--%>
							<th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>申请标题：</th>
							<td class="content_02_box_div_table_td" colspan="3">
								<oa:input
										type="text" column="T_TITLE" table="TA_OA_DEVAPPLICATION"
										other="class='input_title_text validate[required,maxSize[200]]'" style="width:750px;" />
							</td>
						</tr>
						<%--row3--%>
						<%--发起人ID--%>
						<oa:input type="hidden" column="T_FQRID" table="TA_OA_DEVAPPLICATION" value="<%=user_id %>" />
						<%--发起人名称--%>
						<oa:input type="hidden" column="T_FQRMC" table="TA_OA_DEVAPPLICATION" value="<%=user_name %>" />
					</table>
				</div>
			</div>
			
			<!-- 形成申购物品清单 DIV-->
			<div class="content_02_box" style="width: 996px;">
			<div class="content_02_box_title_bg" style="width: 98%">
			<span>采购申请表</span>
			<div class="content_02_box_add">
			<a onclick="Add_Row4NewDay1()" id="addButton"><img src="ccapp/xtbg/resources/images/add.gif"/>添加物品</a>
			</div>
			</div>
			<div class="content_02_box_div" style="width: 996px;">
			<table id="dayTable" class="content_02_box_div_table_02" width="98%" cellspacing="0" cellpadding="0" border="0">
					 	<tr>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span>物品名称</td>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span>型号规格</span></td>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span>技术参数<br>(测量范围/精度等)</span></td>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span>推荐制造厂家</span></td>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 60px"><span style="color: red">*</span>数量</td>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span>购置理由</td>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 80px"><span style="color: red">*</span>预算费用</td>
							<td class="content_02_box_div_table_th" align="center"style="text-align: center;width: 80px">操作</td>
						</tr>
						 <% 
									 if(listItems.size()>0){
										for(int i=0;i<listItems.size();i++){
											HashMap<String,String> itemMap =(HashMap<String,String>)listItems.get(i); 
						 %>	 
							  <tr id ="dayrow" name="dayrow">
									<td class="content_02_box_div_table_td"> 
										<input type="hidden" id="item_id" name="item_id" value="<%=StringUtil.deNull(itemMap.get("item_id"))%>" />
										<input type="text" id="item_name" name="item_name" value="<%=StringUtil.deNull(itemMap.get("item_name"))%>" class="validate[required,maxSize[100]] input_title_text"  style="text-align: center;" />
									</td>
									<td class="content_02_box_div_table_td"> 
											<input type="text" id="item_type" name="item_type" value="<%=StringUtil.deNull(itemMap.get("item_type"))%>" class="validate[required,maxSize[100]] input_title_text" style="text-align: center;"/>
									</td>
									<td class="content_02_box_div_table_td"> 
											<input type="text" id="item_jscs" name="item_jscs" value="<%=StringUtil.deNull(itemMap.get("item_jscs"))%>" class="validate[required,maxSize[100]] input_title_text" style="text-align: center;" />
									</td>
									<td class="content_02_box_div_table_td"> 
											<input type="text" id="item_tjzccj" name="item_tjzccj" value="<%=StringUtil.deNull(itemMap.get("item_tjzccj"))%>" class="validate[required,maxSize[100]] input_title_text" style="text-align: center;" />
									</td>
									<td class="content_02_box_div_table_td"> 
											<input type="text" id="item_sl" name="item_sl" value="<%=StringUtil.deNull(itemMap.get("item_sl"))%>" class="validate[required,maxSize[50],custom[integer]] input_title_text" style="text-align: center;" />
									</td>
									<td class="content_02_box_div_table_td"> 
											<input type="text" id="item_gzly" name="item_gzly" value="<%=StringUtil.deNull(itemMap.get("item_gzly"))%>" class="validate[required,maxSize[100]] input_title_text" style="text-align: center;" />
									</td>
									<td class="content_02_box_div_table_td"> 
											<input type="text" id="item_ysfy" name="item_ysfy" value="<%=StringUtil.deNull(itemMap.get("item_ysfy"))%>"  class="validate[required,maxSize[50],custom[number]] input_title_text" style="text-align: center;" />
									</td>
									<td class="content_02_box_div_table_td"> 
									 <div class="content_02_box_del" style="height:24px; margin:0;float: none;text-align: center;" >
										<a onClick="deleteDay(this,'<%=StringUtil.deNull(itemMap.get("item_id"))%>')" name="deleteButton"> <img src="ccapp/xtbg/resources/images/del.gif" id="del"/>删除</a>
									 </div>
									</td>
								</tr>  
							 <%
									}
								} else { 
							%>
							<tr  id ="dayrow" name="dayrow">
								<td class="content_02_box_div_table_td"> 
										<input type="text" id="item_name" name="item_name" class="validate[required,maxSize[100]] input_title_text" style="text-align: center;" />
								</td>
								<td class="content_02_box_div_table_td"> 
										<input type="text" id="item_type" name="item_type" class="validate[required,maxSize[100]] input_title_text" style="text-align: center;"/>
								</td>
								<td class="content_02_box_div_table_td"> 
										<input type="text" id="item_jscs" name="item_jscs" class="validate[required,maxSize[100]] input_title_text" style="text-align: center;" />
								</td>
								<td class="content_02_box_div_table_td"> 
										<input type="text" id="item_tjzccj" name="item_tjzccj" class="validate[required,maxSize[100]] input_title_text" style="text-align: center;" />
								</td>
								<td class="content_02_box_div_table_td"> 
										<input type="text" id="item_sl" name="item_sl" class="validate[required,maxSize[50],custom[integer]] input_title_text" style="text-align: center;" />
								</td>
								<td class="content_02_box_div_table_td"> 
										<input type="text" id="item_gzly" name="item_gzly" class="validate[required,maxSize[100]] input_title_text" style="text-align: center;" />
								</td>
								<td class="content_02_box_div_table_td"> 
										<input type="text" id="item_ysfy" name="item_ysfy" class="validate[required,maxSize[50],custom[number]] input_title_text" style="text-align: center;" />
								</td>
								<td class="content_02_box_div_table_td"> 
										 <div class="content_02_box_del" style="height:24px; margin:0;float: none;text-align: center;">
															<a onClick="deleteDay(this,'')"> <img src="ccapp/xtbg/resources/images/del.gif" id="del"/>删除</a>
										 </div>
														
								</td>
							</tr>
							<%
							 } 
							%>
				</table>
				</div>
			</div>
			<!-- 形成申购物品清单DIV -->
			
			
			<!--审核意见DIV-->
			 <div class="content_02_box" style="width: 995px;"  >
			 	  <table width="98%">
			 	  	<tr>
			 	  		<td class="content_02_box_div_table_td">
						 	<span style="float: left;">分院/部门负责人：</span>
							 <oa:view column="T_FYBMFZRYJ" table="TA_OA_DEVAPPLICATION" 
											style="border: 1;width:99%;overflow: auto;" other="class='validate[maxSize[1000]] textarea_556'" />
						</td>
			 	  		<td class="content_02_box_div_table_td">
						 	<span style="float: left;">科技发展部/质量技术室：</span>
							 <oa:view column="T_JSKYJ" table="TA_OA_DEVAPPLICATION" 
											style="border: 1;width:99%;overflow: auto;" other="class='validate[maxSize[1000]] textarea_556'" />
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_td">
							 <span style="float: left;">总工程师/分院技术负责人：</span>
							 <oa:view column="T_ZGCSYJ" table="TA_OA_DEVAPPLICATION" 
									style="border: 1;width:97%;overflow: auto;" other="class='validate[maxSize[1000]] textarea_556'" />
						</td>
						<td  class="content_02_box_div_table_td">
							 <span style="float: left;">院长：</span>
							 <oa:view column="T_YCYJ" table="TA_OA_DEVAPPLICATION" 
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
	
	/*
	函数:  changeSelect
	说明:  选择下一步 隐藏
	参数:   无
	返回值: 无
	*/
	function changeSelect(action_defid,selectAct){
		if(!IsSpace(action_defid)&&action_defid=="sbzfcg_wp1_act6"){//分院/部门审核
			selectAct.find("option[value=sbzfcg_wp1_act2]").attr("selected","selected").change();
			selectAct.find("option[value=sbzfcg_wp1_act1]").remove();
		} else if(!IsSpace(action_defid)&&action_defid=="sbzfcg_wp1_act2"){//科技部审核
			selectAct.find("option[value=sbzfcg_wp1_act3]").attr("selected","selected").change();
			selectAct.find("option[value=sbzfcg_wp1_act6]").remove();
		} else if(!IsSpace(action_defid)&&action_defid=="sbzfcg_wp1_act3"){//总工审核
			selectAct.find("option[value=sbzfcg_wp1_act4]").attr("selected","selected").change();
			selectAct.find("option[value=sbzfcg_wp1_act2]").remove();
		} else if(!IsSpace(action_defid)&&action_defid=="sbzfcg_wp1_act4"){//院长审核
			selectAct.find("option[value=sbzfcg_wp1_act5]").attr("selected","selected").change();
			selectAct.find("option[value=sbzfcg_wp1_act3]").remove();
		}
	}
	
	
</script>
</body>
</oa:init>
</html>

