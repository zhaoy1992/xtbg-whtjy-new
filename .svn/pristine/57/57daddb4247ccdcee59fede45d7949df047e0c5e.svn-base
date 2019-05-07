<%--
描述：设备维修申请界面
作者：邱炼
版本：1.0
日期：2014-03-06
--%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.DevAccountInfoService"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.impl.DevAccountServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.DevRepairService"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.impl.DevRepairServiceImpl"%>
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
		action_defid="sbwx_wp1_act1";
		buttonString = "true";
	}
	
	//跳转windowId
	String windowsId = StringUtil.deNull(request.getParameter("windowsId"));
	
	String sbid = UUID.randomUUID().toString();
	
	//仪器设备维修业务
	DevRepairService devrepairservice = new DevRepairServiceImpl();
	//查询设备主键ID
	Map<String,String> devRepairMap = devrepairservice.getDevRepairInfo(busi_id);
	//设备基本信息
	DevAccountInfoService service = new DevAccountServiceImpl();
	Map<String,String> bean = service.getDevAccountBean(StringUtil.deNull(devRepairMap.get("t_sb_id")));
	
%>
<!-- 公共部分开始 -->
<title>设备维修申请界面</title>
	<oa:init>
	<link rel="stylesheet" href="ccapp/oa/archive/css.css" type="text/css" />
	<script type='text/javascript' src='<%=path %>/ccapp/oa/resources/plug/jquery-media/jquery.media.js' charset="utf-8"></script>
	<script type='text/javascript'>
	//环节ID
	var action_defid="<%=action_defid%>";
		 /*
		函数:  openDevAppInfo
		说明:  选择仪器设备物品
		返回值: 无
		*/
	  function openDevAppInfo(){
		//设备维修申请  选择设备 "完好"
    	var path ="<%=path%>/ccapp/xtbg/tjy/device/jsp/devInfoList.jsp?windowsId=windowIds1&dev_state=1&action_defid="+action_defid;
    	openAlertWindows('windowIds1',path,'设备信息',900,450,'25%','25%');
     }
		
	  /*
		函数:  setDevInfo
		说明:  选择仪器设备物品
		参数:   sbid:设备ID,sbname:设备名称      sbcode：设备编号         设备状态：sbstat 设备型号:type
				make_users:制造厂商   technical_parameters:设备参数信息
		返回值: 无
		*/
		function setDevInfo(sbid,sbcode,sbname,sbstat,type,make_users,technical_parameters){
			
			//设备标题
			jQuery("#TA_OA_DEVREPAIR__T_TITLE").val("【"+sbname+"】:【"+type+"】");
			//设备ID
			jQuery("#TA_OA_DEVREPAIR__T_SB_ID").val(sbid);
			//设备名称
			jQuery("#dev_name").val(sbname);   
			//制造单位
			jQuery("#make_users").val(make_users);
			//设备类型
			jQuery("#type").val(type);
			//基本参数
			jQuery("#technical_parameters").val(technical_parameters);
			
		}
	    
	    jQuery(function(){
	    	//控制按钮 只有在新增的流程时才显示
	    	if('fasle' == '<%=buttonString%>'){      
	    		jQuery("#btn").hide();
	    	}
	    	//申请环节
    		if("sbwx_wp1_act1"==action_defid){
    			//设备申请时间
    			jQuery("#TA_OA_DEVREPAIR__T_SQR_SJ").val("<%=r_creater_time%>");
    	    	jQuery("#dis_TA_OA_DEVREPAIR__T_SQR_SJ").val("<%=r_creater_time%>");
    		}
	    	
	    });
	</script>

</head>
<body>
<form id="form1" name="form1" action="" method="post" >
	<input type="hidden" id="opt_type"     name="opt_type" /> 
	<input type="hidden" id="busi_id"  name="busi_id"  value="<%=busi_id %>" /> 
	<input type="hidden" id="busiTypeCode" name="busiTypeCode"  value="<%=busiTypeCode%>"/>
	<input type="hidden" id="action_defid" name="action_defid"  value="<%=action_defid%>"/>
	<input id="windowsId" name="windowsId" type="hidden" value="<%=windowsId%>"/>
	<input id="price" name="price" type="hidden" value=""/>
	<input value="com.chinacreator.xtbg.tjy.device.dao.Impl.DevRepairFlowDaoImpl" id="<%=FlowBusiDataSaveDao.CUSTOM_CRUD_CLASSNAME_FLAG%>" 
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
			<div style="float: left; width: 900px;">
			<%--shang--%>
			<div class="content_02_box" style="width:900px;">
				<div class="content_02_box_title_bg" style="width: 98%;">
					<span>设备维修申请</span>
				</div>
				<div class="content_02_box_div" style="width: 900px;">
					<table border="0" cellspacing="0" cellpadding="0"
						class="content_02_box_div_table" style="width: 98%;">
						<tr><%--row1--%>
							<td class="content_02_box_div_table_td" rowspan="4" width="50px;">
								仪器设备基本情况
							</td>
							<th class="content_02_box_div_table_th"><span class="color_red">*</span>标题：</th>
							<td class="content_02_box_div_table_td" colspan="3">
								<oa:input type="text" column="T_TITLE" table="TA_OA_DEVREPAIR" other="class='input_title_text validate[required]'"  />
								
							</td>
						</tr>
						<tr><%--row2--%>
							<th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>设备名称：<input type="button" name="btn" id="btn" style="float: right;" value="选择设备" class="but_y_01" onclick="openDevAppInfo();"/></th>
							<td class="content_02_box_div_table_td">
								<oa:input type="hidden" column="T_SB_ID" table="TA_OA_DEVREPAIR"  />
								<input type="text" name="dev_name" id="dev_name" readonly="readonly" value="<%=StringUtil.deNull(bean.get("dev_name")) %>" class="validate[required] input_cx_title_240" />
								
							</td>
							<th class="content_02_box_div_table_th">制造单位：</th>
							<td class="content_02_box_div_table_td">
								<input type="text" name="make_users" id="make_users" readonly="readonly" value="<%=StringUtil.deNull(bean.get("make_users")) %>" class="input_cx_title_240"/>
							</td>
						</tr>
						<tr><%--row3--%>
							<!-- 
							<th class="content_02_box_div_table_th">数  量：</th>
							<td class="content_02_box_div_table_td">
								<input type="text" name="dev_name" id="dev_name" readonly="readonly" class="input_cx_title_240"/>
							</td>
							 -->
							<th class="content_02_box_div_table_th"><span
                                    class="color_red">*</span>费用预算：</th>
							<td class="content_02_box_div_table_td">
								<oa:input type="text" column="T_WXFYS" table="TA_OA_DEVREPAIR"
										other="class='input_cx_title_240 validate[required,custom[number]]'" />
							</td>
							<th class="content_02_box_div_table_th"></th>
							<td class="content_02_box_div_table_td">
							</td>
						</tr>
						
						<tr><%--row4--%>
							<th class="content_02_box_div_table_th">基本参数：</th>
							<td class="content_02_box_div_table_td" height="60px;">
								<textarea rows="4" cols="38" id="technical_parameters" name="technical_parameters"><%=StringUtil.deNull(bean.get("technical_parameters")) %></textarea>
							</td>
							<th class="content_02_box_div_table_th"><span
                                    class="color_red">*</span>型号规格：</th>
							<td class="content_02_box_div_table_td">
								<textarea rows="4" cols="38" id="type" name="type"><%=StringUtil.deNull(bean.get("type")) %></textarea>
							</td>
						</tr>
						
						<tr><%--row5--%>
							<th class="content_02_box_div_table_th" style="height: 70px;width: 50px;" >维修&nbsp;&nbsp;<br>申请：</th>
							<td class="content_02_box_div_table_td" colspan=5>
							
								维修内容：<br>
								<oa:textarea
									column="T_WXNR" table="TA_OA_DEVREPAIR"
									style="border: 1;width:99%;overflow: auto;"
									other="class='validate[maxSize[250]] textarea_556'" />
								<%-- 设备管理员ID--%>
								<oa:input type="hidden" column="T_SBSYR_ID" table="TA_OA_DEVREPAIR" value="<%=user_id %>" />
								<p style="margin-left: 440px;">设备使用人/设备管理员：<oa:input style="float:right" type="text" value="<%=user_name %>" column="T_SBSYR_MC" table="TA_OA_DEVREPAIR"
										other="class='input_186' readonly='readonly'" />
								</p>
								<p style="margin-left: 540px;">日期：<oa:date dateFmt='yyyy-MM-dd HH:mm:ss'  style="float:right" column="T_SQR_SJ" table="TA_OA_DEVREPAIR" other="class='input_186' readonly='readonly'"  />
								<script>
								jQuery(function(){
									jQuery("#dis_TA_OA_DEVREPAIR__T_SQR_SJ").removeAttr("onClick");
								});
								</script>
								</p>
							</td>
						</tr>
						<tr><%--row6--%>
							<th class="content_02_box_div_table_th" style="height: 70px;width: 50px;" rowspan="2">审批&nbsp;&nbsp;<br>意见：</th>
							<td class="content_02_box_div_table_td" colspan=5>
								设备责任工程师/分院质量负责人意见：<br>
								<oa:view column="T_FGLDSH" table="TA_OA_DEVREPAIR" 
								style="border: 1;width:99%;overflow: auto;" other="class='validate[maxSize[1000]] textarea_556'" />
							</td>
						</tr>
						<tr><%--row7--%>
							<td class="content_02_box_div_table_td" colspan=5>
								院质量负责人/分院长意见：<br>
								<oa:view column="T_YCSH" table="TA_OA_DEVREPAIR" 
								style="border: 1;width:99%;overflow: auto;" other="class='validate[maxSize[1000]] textarea_556'" />
							</td>
						</tr>
						
					</table>
				</div>
				
			</div>
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

