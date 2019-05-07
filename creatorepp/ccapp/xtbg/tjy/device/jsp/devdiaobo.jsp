<%@page import="com.chinacreator.xtbg.tjy.device.service.impl.DevInfoItemServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.DevInfoItemService"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.impl.DevBorrowServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.DevBorrowService"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.impl.DevAccountServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.DevAccountInfoService"%>
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
	// 选择设备按钮控制
	String buttonString = "fasle";
	//新增启动第一次的时候  默认设置为第一个环节
	if(action_defid.equals("")){
		action_defid="sbjygh_wp1_act1";
		buttonString = "true";
	}
	//跳转windowId
	String windowsId = StringUtil.deNull(request.getParameter("windowsId"));
	//配件明细信息
	List<Map<String,String>> listItems = new ArrayList<Map<String,String>>();
	//设备基本信息
	DevAccountInfoService service = new DevAccountServiceImpl();
	//设备借用，归还信息
	DevBorrowService devborrowservice= new DevBorrowServiceImpl();
	Map<String,String> devborrowInfo = devborrowservice.getDevTransferInfo(busi_id);
	//根据设备借用，归还信息中的设备ID  查询出设备编号
	Map<String,String> bean = service.getDevAccountBean(StringUtil.deNull(devborrowInfo.get("t_sb_id")));
	//根据设备编号查询出 配件信息
	DevInfoItemService itemService = new DevInfoItemServiceImpl();
	listItems = itemService.getDevInfoItemBean(StringUtil.deNull(bean.get("dev_code")));
	//设备基本信息
	Map<String,String> dev_info = service.getDevAccountBean(StringUtil.deNull(devborrowInfo.get("t_sb_id")));
	//设备状态
	String dev_stock ="";
	if(!StringUtil.isBlank(dev_info.get("dev_stockflag"))){
		//在库
		if("1".equals(dev_info.get("dev_stockflag"))){
			dev_stock ="在库";
		}else if("2".equals(dev_info.get("dev_stockflag"))){//借出
			dev_stock="借出";
		} else if("3".equals(dev_info.get("dev_stockflag"))){
			dev_stock="出租";
		} else if("4".equals(dev_info.get("dev_stockflag"))){
			dev_stock="调拨";
		}else{
			dev_stock="";
		}
	}
%>
<!-- 公共部分开始 -->
<title>设备借用归还界面</title>
	<oa:init>
	<link rel="stylesheet" href="ccapp/oa/archive/css.css" type="text/css" />
	<script type='text/javascript' src='<%=path %>/ccapp/oa/resources/plug/jquery-media/jquery.media.js' charset="utf-8"></script>
 	<script type='text/javascript' src='<%=path %>/ccapp/xtbg/resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js' charset="utf-8"></script>
	<script type="text/javascript">
	//环节ID
	var action_defid="<%=action_defid%>";
	var busiTypeCode = "<%=busiTypeCode%>";
	  jQuery(function(){
    		//控制按钮 只有在新增的流程时才显示
	    	if('fasle' == '<%=buttonString%>'){      
	    		jQuery("#btn").hide();
	    	}
    		
	    	//出租日期
			jQuery("#TA_OA_DEVTRANSFER__T_SBDC_DATE").val("<%=r_creater_time%>");
    		
    		//申请部门审核
			if("sbjygh_wp1_act1"==action_defid){
				//租用单位
				jQuery("#TA_OA_DEVTRANSFER__T_LYORG_MC").val("<%=orgName%>");
    			jQuery("#TA_OA_DEVTRANSFER__T_LYORG_ID").val("<%=org_id%>");
    			//经办人
    			jQuery("#TA_OA_DEVTRANSFER__T_JBR_ID").val("<%=user_id%>");
    			jQuery("#TA_OA_DEVTRANSFER__T_JRE_MC").val("<%=user_name%>");
			}else if("sbjygh_wp1_act2"==action_defid){
    			//申请部门审核人ID
    			jQuery("#TA_OA_DEVTRANSFER__T_SHY_ID").val("<%=user_id%>");
    			//申请部门审核人名称
    			jQuery("#TA_OA_DEVTRANSFER__T_SHY_MC").val("<%=user_name%>");
    		}else if("sbjygh_wp1_act3"==action_defid){
    			//后勤保障部审核人ID
    			jQuery("#TA_OA_DEVTRANSFER__T_SHHQR_ID").val("<%=user_id%>");
    			//后勤保障部审核人名称
    			jQuery("#TA_OA_DEVTRANSFER__T_SHHQR_MC").val("<%=user_name%>");
    		}
	    });
	 /*
	函数:  openDevAppInfo
	说明:  选择仪器设备物品
	返回值: 无
	*/
	  function openDevAppInfo(){
    	var path ="<%=path%>/ccapp/xtbg/tjy/device/jsp/devInfoList.jsp?windowsId=windowIds1&dev_stockflag=1&dev_state=1&action_defid=<%=action_defid%>&busi_id=<%=busi_id%>";
    	openAlertWindows('windowIds1',path,'设备信息',900,450,'25%','25%');
     }
	
	/*
	函数:  setDevInfo
	说明:  选择仪器设备物品
	参数:   sbid:设备ID,sbname:设备名称      sbcode：设备编号         设备状态：sbstat 设备型号:type
	返回值: 无
	setDevInfo(id,dev_code,dev_name,dev_stockflag,type,make_users,technical_parameters,
			arrive_time,custos_userid,custos_username,jieyong_orgmc,jieyonguser,t_lydate,guihid,user_orgname);
	*/
	function setDevInfo(sbid,sbcode,sbname,sbstat,type,make_users,technical_parameters,
			arrive_time,custos_userid,custos_username,jieyong_orgmc,jieyonguser,t_lydate,guihid,user_orgname,user_orgid){
		//设备标题
		jQuery("#TA_OA_DEVTRANSFER__T_TITLE").val("【"+sbname+"】:【"+type+"】");
		//设备ID
		jQuery("#TA_OA_DEVTRANSFER__T_SB_ID").val(sbid);
		//设备编号
		jQuery("#dev_code").val(sbcode);
		//设备名称
		jQuery("#dev_name").val(sbname);   
		//设备状态
		if(sbstat=="1"){
			sbstat="在库";
		}
		jQuery("#dev_stockflag").val(sbstat);
		//原使用人
		jQuery("#TA_OA_DEVTRANSFER__T_SB_USER_MC").val(custos_username);
		jQuery("#TA_OA_DEVTRANSFER__T_SB_USER_ID").val(custos_userid);
		//调出部门
		jQuery("#TA_OA_DEVTRANSFER__T_SBDC_ORGNAME").val(user_orgname);
		jQuery("#TA_OA_DEVTRANSFER__T_SBDC_ORGID").val(user_orgid);
		
		resultDevInfoItem(sbid);
	}
	
	/*
	函数:  resultDevInfoItem
	说明:  填充配件列表
	参数:   无
	返回值: 无
	*/
	function resultDevInfoItem(sbid){
		jQuery("[name=dayrow]").remove();
		//填充配件列表
		var url="<%=path%>/ccapp/xtbg/tjy/device/jsp/ajaxdeviteminfo.jsp";
		var params =  {t_sb_id:sbid};
		jQuery.ajax({
			url: url,
			type: 'POST',
			dataType:'json',
			data: params,
			async:false,
			success: function(data){
				for(var i=0;i<data.maps.length;i++){
					//配件名称
					var parts_name =data.maps[i].parts_name;
					//规格
					var parts_type =data.maps[i].parts_type;
					//数量
					var parts_count =data.maps[i].parts_count;
					
					//填充配件列表
					var firstTr = document.createElement("TR");
					firstTr.name="dayrow";
					//配件名称
					var firstTd = document.createElement("td");//创建一个td
					firstTd.setAttribute("class","content_02_box_div_table_td");
					var input1 =document.createElement("input");
					input1.setAttribute("value",parts_name);
					input1.setAttribute("class","input_title_text");
					input1.setAttribute("style","text-align: center;");
					firstTd.appendChild(input1);
					firstTr.appendChild(firstTd);//
					//配件型号
					var firstTd1 = document.createElement("td");//创建一个td
					firstTd1.setAttribute("class","content_02_box_div_table_td");
					var input2 =document.createElement("input");
					input2.setAttribute("value",parts_type);
					input2.setAttribute("class","input_title_text");
					input2.setAttribute("style","text-align: center;");
					firstTd1.appendChild(input2);
					firstTr.appendChild(firstTd1);//
					//配件数量
					var firstTd2 = document.createElement("td");//创建一个td
					firstTd2.setAttribute("class","content_02_box_div_table_td");
					var input3 =document.createElement("input");
					input3.setAttribute("value",parts_count);
					input3.setAttribute("class","input_title_text");
					input3.setAttribute("style","text-align: center;");
					firstTd2.appendChild(input3);
					firstTr.appendChild(firstTd2);//
					var dayTable = document.getElementById("dayTable");
					dayTable.appendChild(firstTr);
				}
			},
			error: function(jqXHR, textStatus, errorThrown){
			}
		})
	}
	
	/**
	  * 选取人员
	  */
	 var chooseOrg = function (userId,userName,treetypestr,type,showTips){
	     var s = new jQuery.z_tree();
	     s.treeID = 'mianUser';
	     s.treetypestr = treetypestr;
	     s.isShowSeacher = true;
	     s.treeName = showTips;
	     s.headerName = showTips;
	     s.type = type;
	     s.selectedIds = jQuery("#"+userId).val(),
	     s.isType = "dept";
	     s.returnFunction = function(userObj,o) {    
	        try{
	         if (!IsSpace(userObj)) {
	             jQuery('#'+userId).val(o[0].id);
	             jQuery('#'+userName).val(o[0].name);
	         } else {
	             jQuery('#'+userId).val("");
	             jQuery('#'+userName).val("");
	         }
	        }catch(e){
	          /**忽略客户端异常信息**/ 
	        }
	     }
	     s.init();
	 }
	
	 /**
	  * 选取人员
	  */
	 var chooseRegister = function (userId,userName,treetypestr,type,showTips){
	     var s = new jQuery.z_tree();
	     s.treeID = 'mianUser';
	     s.treetypestr = treetypestr;
	     s.isShowSeacher = true;
	     s.treeName = showTips;
	     s.headerName = showTips;
	     s.type = type;
	     s.selectedIds = jQuery("#"+userId).val(),
	     s.returnFunction = function(userObj,o) {            
	        try{
	         if (!IsSpace(userObj)) {
	             jQuery('#'+userId).val(userObj.id);
	             jQuery('#'+userName).val(userObj.name);
	             if(o&&o.length>0){
	             	var orgids = new Array();//当前列表的用户id的数组
	             	for(var i=0;i<o.length;i++){
	             		orgids.push(o[i].parent_id);
	             	}
	             }
	         } else {
	             jQuery('#'+userId).val("");
	             jQuery('#'+userName).val("");
	         }
	        }catch(e){
	          /**忽略客户端异常信息**/ 
	        }
	     }
	     s.init();
	 }
	</script>

</head>
<body>
<form id="form1" name="form1" action="" method="post" >
	<input type="hidden" id="opt_type" name="opt_type" /> 
	<input type="hidden" id="busi_id"  name="busi_id"  value="<%=busi_id %>" /> 
	<input type="hidden" id="busiTypeCode" name="busiTypeCode"  value="<%=busiTypeCode%>"/>
	<input type="hidden" id="action_defid" name="action_defid"  value="<%=action_defid%>"/>
	<input id="windowsId" name="windowsId" type="hidden" value="<%=windowsId%>"/>
	<input value="com.chinacreator.xtbg.tjy.device.dao.Impl.DevTransferFlowDaoImpl" id="<%=FlowBusiDataSaveDao.CUSTOM_CRUD_CLASSNAME_FLAG%>" 
	name="<%=FlowBusiDataSaveDao.CUSTOM_CRUD_CLASSNAME_FLAG%>" type="hidden"/><%--业务--%>
<div id="tabs1" style="width:90%">
	<div id="tabs-1">
		<table width="95%" border="0" cellspacing="1" cellpadding="0"
			style="margin-left: 15px; margin-right: 15px; display: inline;">
			<tr>
				<td>
				<oa:flowcommonstart flowType="1" />
				<!-- 申请部门审核人ID -->
				<oa:input type="hidden" column="T_SHY_ID" table="TA_OA_DEVTRANSFER"/>
				<!-- 申请部门审核人名称 -->
				<oa:input type="hidden" column="T_SHY_MC" table="TA_OA_DEVTRANSFER"/>
				<!-- 后勤保障部门审核人ID -->
				<oa:input type="hidden" column="T_SHHQR_ID" table="TA_OA_DEVTRANSFER"/>
				<!-- 后勤保障部门审核人名称 -->
				<oa:input type="hidden" column="T_SHHQR_MC" table="TA_OA_DEVTRANSFER"/>
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
					<span>设备基本情况</span>
				</div>
				<div class="content_02_box_div" style="width: 996px;">
					<table border="0" cellspacing="0" cellpadding="0"
						class="content_02_box_div_table" style="width: 98%;">
						<tr><%--row1--%>
							<th class="content_02_box_div_table_th"><FONT style="COLOR: red" id="bt_id" >*</FONT>标题：</th>
							<td class="content_02_box_div_table_td" colspan="3">
								<oa:input
										type="text" column="T_TITLE" table="TA_OA_DEVTRANSFER"
										other="class='input_title_text validate[required,maxSize[200]]'" style="width:750px;" />
							</td>
						</tr>
						<tr><%--row2--%>
							<th class="content_02_box_div_table_th"><FONT style="COLOR: red" id="bt_id" >*</FONT>设备编号：</th>
							<td class="content_02_box_div_table_td" >
								<oa:input type="hidden" column="T_SB_ID" table="TA_OA_DEVTRANSFER"  />
								<input type="text" name="dev_code" id="dev_code" readonly="readonly" value="<%=StringUtil.deNull(bean.get("dev_code"))%>" 
										onclick="openDevAppInfo();"  class="validate[required] input_cx_title_240"/>&nbsp;&nbsp;&nbsp;
								<input type="button" name="btn" id="btn" value="选择设备" class="but_y_01" onclick="openDevAppInfo();"/>
							</td>
							<th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>设备名称：</th>
							<td class="content_02_box_div_table_td">
								<input type="text" name="dev_name" id="dev_name" value="<%=StringUtil.deNull(bean.get("dev_name"))%>"  class="validate[required] input_cx_title_240"/>
							</td>
						</tr>
						<tr>
						<%--row3--%>
							<th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>状态：</th>
							<td class="content_02_box_div_table_td" colspan="3">
								<input type="text" name="dev_stockflag" readonly="readonly" value="<%=dev_stock%>" id="dev_stockflag" class="input_cx_title_240"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
			
			<!-- 形成配件列表清单 DIV-->
			<div class="content_02_box" id="appListItem1" style="width: 996px;">
			<div class="content_02_box_title_bg" style="width: 98%">
			<span>配件列表</span>
			<div class="content_02_box_add">
			</div>
			</div>
			<div class="content_02_box_div" style="width: 996px;">
			<table id="dayTable" class="content_02_box_div_table_02" width="98%" cellspacing="0" cellpadding="0" border="0">
				 	<tr>
						<td class="content_02_box_div_table_th" style="text-align: center;width: 120px">配件名称</td>
						<td class="content_02_box_div_table_th" style="text-align: center;width: 60px">规格</span></td>
						<td class="content_02_box_div_table_th" style="text-align: center;width: 50px">数量</span></td>
					</tr>
					 <% 
						if(listItems.size()>0){
							for(int i=0;i<listItems.size();i++){
								HashMap<String,String> itemMap =(HashMap<String,String>)listItems.get(i); 
					 %>	 
						  <tr id ="dayrow" name="dayrow">
								<td class="content_02_box_div_table_td"> 
									<input type="hidden" id="id" name="id" value="<%=StringUtil.deNull(itemMap.get("id"))%>" />
									<input type="text" id="parts_name" name="parts_name" readonly="readonly" value="<%=StringUtil.deNull(itemMap.get("parts_name"))%>" class="input_title_text"  style="text-align: center;" />
								</td>
								<td class="content_02_box_div_table_td"> 
										<input type="text" id="parts_type" name="parts_type"  readonly="readonly" value="<%=StringUtil.deNull(itemMap.get("parts_type"))%>" class="input_title_text" style="text-align: center;"/>
								</td>
								<td class="content_02_box_div_table_td"> 
										<input type="text" id="parts_count" name="parts_count"  readonly="readonly" value="<%=StringUtil.deNull(itemMap.get("parts_count"))%>" class="input_title_text" style="text-align: center;" />
								</td>
							</tr>  
						 <%
								}
							} else { 
						%>
						<tr  id ="dayrow" name="dayrow">
							<td class="content_02_box_div_table_td"> 
									<input type="text" id="parts_name" name="parts_name"  readonly="readonly" class="input_title_text" style="text-align: center;" />
							</td>
							<td class="content_02_box_div_table_td"> 
									<input type="text" id="parts_type" name="parts_type"  readonly="readonly" class="input_title_text" style="text-align: center;"/>
							</td>
							<td class="content_02_box_div_table_td"> 
									<input type="text" id="parts_count" name="parts_count"  readonly="readonly" class="input_title_text" style="text-align: center;" />
							</td>
						</tr>
						<%
						 } 
						%>
				</table>
				</div>
			</div>
			<!-- 形成配件列表清单DIV -->
			
			<!-- 领用记录 DIV-->
			<div class="content_02_box" id="appListItem1" style="width: 996px;">
			<div class="content_02_box_title_bg" style="width: 98%">
			<span>设备调拨记录</span>
			<div class="content_02_box_add">
			</div>
			</div>
			<div class="content_02_box_div" style="width: 996px;">
				<table id="dayTable" class="content_02_box_div_table_02" width="98%" cellspacing="0" cellpadding="0" border="0">
					 	<tr>
							<td class="content_02_box_div_table_th" >调出部门：</td>
							<td class="content_02_box_div_table_td" >
								<oa:input type="hidden" column="T_SBDC_ORGID" table="TA_OA_DEVTRANSFER"  />
								<oa:input type="text" column="T_SBDC_ORGNAME" table="TA_OA_DEVTRANSFER" 
									other="class='input_cx_title_188' readonly='readonly' onclick=chooseOrg('TA_OA_DEVTRANSFER__T_SBDC_ORGID','TA_OA_DEVTRANSFER__T_SBDC_ORGNAME','radio','AORG','选取单位')"  />
								
							</td>
							<td class="content_02_box_div_table_th">原使用人：</td>
							<td class="content_02_box_div_table_th">
								<oa:input type="hidden" column="T_SB_USER_ID" table="TA_OA_DEVTRANSFER" />
								<oa:input type="text" column="T_SB_USER_MC" table="TA_OA_DEVTRANSFER" 
								other="class='input_cx_title_188' readonly='readonly' onclick=chooseRegister('TA_OA_DEVTRANSFER__T_SB_USER_ID','TA_OA_DEVTRANSFER__T_SB_USER_MC','radio','APERSON','选取人员')"  />
							</td>
							<td class="content_02_box_div_table_th">调出日期：</td>
							<td class="content_02_box_div_table_th">
								<oa:date dateFmt='yyyy-MM-dd HH:mm:ss' column="T_SBDC_DATE" table="TA_OA_DEVTRANSFER" 
								other="class='input_cx_title_188' readonly='readonly'"  />
							</td> 
						</tr>
				</table>
				</div>
			</div>
			<!-- 领用记录DIV -->
			<!-- 归还记录 DIV-->
			<div class="content_02_box" id="appListItem1" style="width: 996px;">
			<div class="content_02_box_title_bg" style="width: 98%">
			<div class="content_02_box_add">
			</div>
			</div>
			<div class="content_02_box_div" style="width: 996px;">
				<table id="dayTable" class="content_02_box_div_table_02" width="98%" cellspacing="0" cellpadding="0" border="0">
					 	<tr>
							<td class="content_02_box_div_table_th" >调入部门：</td>
							<td class="content_02_box_div_table_td" >
								<oa:input type="hidden" column="T_LYORG_ID" table="TA_OA_DEVTRANSFER"  />
								<oa:input type="text" column="T_LYORG_MC" table="TA_OA_DEVTRANSFER" 
									other="class='input_cx_title_188' readonly='readonly' onclick=chooseOrg('TA_OA_DEVTRANSFER__T_LYORG_ID','TA_OA_DEVTRANSFER__T_LYORG_MC','radio','AORG','选取单位')"  />
							</td>
							<td class="content_02_box_div_table_th">现使用人：</td>
							<td class="content_02_box_div_table_td">
								<oa:input type="hidden" column="T_JBR_ID" table="TA_OA_DEVTRANSFER" />
								<oa:input type="text" column="T_JRE_MC" table="TA_OA_DEVTRANSFER" 
								other="class='input_cx_title_188' readonly='readonly' onclick=chooseRegister('TA_OA_DEVTRANSFER__T_JBR_ID','TA_OA_DEVTRANSFER__T_JRE_MC','radio','APERSON','选取人员')"  />
							</td>
						</tr>
				</table>
				</div>
			</div>
			<!-- 归还记录DIV -->
			<!--审核意见DIV-->
			 <div class="content_02_box" style="width: 996px;"  >
			 	  <table width="98%">
			 	  	<tr>
			 	  		<td class="content_02_box_div_table_td">
						 	<span style="float: left;">申请部门审核：</span>
							 <oa:view column="T_SQBMSH" table="TA_OA_DEVTRANSFER" 
											style="border: 1;width:99%;overflow: auto;" other="class='validate[maxSize[1000]] textarea_556'" />
						</td>
						<td class="content_02_box_div_table_td">
						 	<span style="float: left;">后勤保障部审核：</span>
							 <oa:view column="T_HQBZBSH" table="TA_OA_DEVTRANSFER" 
											style="border: 1;width:99%;overflow: auto;" other="class='validate[maxSize[1000]] textarea_556'" />
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

