<%--
描述：设备报废界面
作者：邱炼
版本：1.0
日期：2014-03-07
--%>
<%@page import="com.chinacreator.core.util.TimeUtil"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.impl.DevScrapServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.DevScrapService"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.DevAccountInfoService"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.impl.DevAccountServiceImpl"%>
<%@page import="antlr.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
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
	Date date = new Date();
	String t_sqrq = DateUtil.getFormatTime(date);
	//申请报废业务
	DevScrapService devscrapservice = new DevScrapServiceImpl();
	//查询设备主键ID
	Map<String,String> devScrapMap = devscrapservice.getDevScrapInfo(busi_id);
	//设备基本信息
	DevAccountInfoService service = new DevAccountServiceImpl();
	Map<String,String> bean = service.getDevAccountBean(StringUtil.deNull(devScrapMap.get("t_sb_id")));
	
%>
<!-- 公共部分开始 -->
<title>设备报废申请表</title>
	<oa:init>
	<link rel="stylesheet" href="ccapp/oa/archive/css.css" type="text/css" />
	<script src="<%=path%>/ccapp/oa/resources/style/lightblue/js/support-public-import.js" type="text/javascript"></script>
	<script src="<%=path%>/ccapp/oa/resources/style/lightblue/js/support-jqgrid-import.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js"charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script> 
	<script type='text/javascript'>
	//环节ID
	var action_defid="<%=action_defid%>";
		 /*
		函数:  openDevAppInfo
		说明:  选择仪器设备物品
		返回值: 无
		*/
	  function openDevAppInfo(){
		//设备选择   状态是选择  "在修"
    	var path ="<%=path%>/ccapp/xtbg/tjy/device/jsp/devInfoList.jsp?windowsId=windowIds1&dev_state=2&frompage=devscrap2";
    	openAlertWindows('windowIds1',path,'设备信息',900,450,'25%','25%');
     }
		
	  /*
		函数:  setDevInfo
		说明:  选择仪器设备物品
		参数:   sbid:设备ID,sbname:设备名称      sbcode：设备编号         设备状态：sbstat 设备型号:type
				make_users:制造厂商   technical_parameters:设备参数信息  arrive_time：到货日期
		返回值: 无
		*/
		function setDevInfo(sbid,sbcode,sbname,sbstat,type,make_users,technical_parameters,arrive_time){
			//设备标题
			jQuery("#t_title").val("【"+sbname+"】"+"："+"【"+type+"】");
			//设备ID
			jQuery("#t_sb_id").val(sbid);
			//设备编号
			jQuery("#dev_code").val(sbcode);
			//设备名称
			jQuery("#dev_name").val(sbname);   
			//制造单位
			jQuery("#make_users").val(make_users);
			//设备类型
			jQuery("#type").val(type);
			//基本参数
			jQuery("#technical_parameters").val(technical_parameters);
			//投入使用年限
			 var now= new Date();   
			var year = now.getFullYear();
			if(IsSpace(arrive_time)==false){
				//使用投入时间
				var trsynxStr="";
				//投入使用年限=当前年份-到货年份
				var trsynxyear = parseInt(year)- parseInt(arrive_time.substring(0,4));
				//显示字符串“少于1年”
				if(trsynxyear==0){
					trsynxStr = "少于1年";
				} else{
					trsynxStr = "使用了"+trsynxyear+"年";
				}
				jQuery("#t_trsynx").val(trsynxStr);
			}
		}
	    
	    jQuery(function(){
	    	//控制按钮 只有在新增的流程时才显示
	    	if('fasle' == '<%=buttonString%>'){      
	    		jQuery("#btn").hide();
	    	}
	    	//申请环节
    		if("sbwx_wp1_act1"==action_defid){
    			//设备申请时间
    			jQuery("#TA_OA_DEVSCRAP__T_SQRQ").val("<%=r_creater_time%>");
    	    	jQuery("#dis_TA_OA_DEVSCRAP__T_SQRQ").val("<%=r_creater_time%>");
    		}
	    });
	    
	    function getDevScrapBean() {
	        var devScrapJsonObj = {
		        t_title: jQuery("#TA_OA_DEVSCRAP__T_TITLE").val(),
		        t_sb_id: jQuery("#TA_OA_DEVSCRAP__T_SB_ID").val(),
		        t_trstnx: jQuery("#TA_OA_DEVSCRAP__T_TRSYNX").val(),
		        t_bfly: jQuery("#TA_OA_DEVSCRAP__T_BFLY").val()
	        }
	        return devScrapJsonObj;
	      }
	    
	    function save(){
	    	if(jQuery("#t_title").val()==""){
				alert("请选择要报废的设备");
				return false；
			}
	    	if(jQuery("#t_bfly").val()==""){
				alert("请填写报废理由");
				return false；
			}
	    	jQuery("#action").val("addScrap");
	    	var okF = function(){
	    		document.all.form1.target = "frame1";
	    		jQuery("#form1").submit();
	    		shuax();
	    	}
	    	 var p={
	    		headerText:'提示',
	    		okName:'确认',
	    	    okFunction:okF,
	    	    cancelName:'取消'
	    	};
	    	alert('确定保存？',p);
				//jQuery("#form1").submit();

	    }
	    function shuax(){
			//window.location.reload();//刷新当前页面.
			setTimeout(function(){
				window.location.reload();
			},2000);
		}
	    function shuaxin(){
			window.location.reload();//刷新当前页面.
		}
	</script>

</head>
<body>
<form id="form1" name="form1" action="<%=path%>/ccapp/xtbg/tjy/device/jsp/devinfodo.jsp" method="post" >
	<input type="hidden" id="action"  name="action" /> 
	<input type="hidden" id="busi_id"  name="busi_id"  value="<%=busi_id %>" /> 
	<input type="hidden" id="busiTypeCode" name="busiTypeCode"  value="<%=busiTypeCode%>"/>
	<input type="hidden" id="action_defid" name="action_defid"  value="<%=action_defid%>"/>
	<input id="windowsId" name="windowsId" type="hidden" value="<%=windowsId%>"/>
	<input id="price" name="price" type="hidden" value=""/>

<div id="tabs1" style="width:99%">
	<div id="tabs-1">
		<table width="95%" border="0" cellspacing="1" cellpadding="0"
			style="margin-left: 15px; margin-right: 15px; display: inline;">
			<tr>
				<td>
				<input type="button" onclick="save()" class="but_y_01" value="保存" />
				<input type="button" onclick="shuaxin()" class="but_y_01" value="刷新" />
				
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
					<span>设备报废申请表</span>
				</div>
				<div class="content_02_box_div" style="width: 900px;">
					<table border="0" cellspacing="0" cellpadding="0"
						class="content_02_box_div_table" style="width: 98%;">
						<tr><%--row1--%>
							<td class="content_02_box_div_table_td" rowspan="4" width="50px;">
								仪器设备设施基本情况
							</td>
							<th class="content_02_box_div_table_th">标题：</th>
							<td class="content_02_box_div_table_td" colspan="3">
								<input type="text" name="t_title" id="t_title"   class="input_title_text" />
							</td>
						</tr>
						<tr><%--row2--%>
							<th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>设备编号：
							<input type="button" name="btn" id="btn" style="float: right;" value="选择设备" class="but_y_01" onclick="openDevAppInfo();"/></th>
							<td class="content_02_box_div_table_td">
								<input type="hidden" name="t_sb_id" id="t_sb_id"   />
								<input type="text" name="dev_code" id="dev_code" readonly="readonly"  class="validate[required] input_cx_title_240" />
								
							</td>
							<th class="content_02_box_div_table_th">设备名称：</th>
							<td class="content_02_box_div_table_td">
								<input type="text" name="dev_name" id="dev_name" readonly="readonly"  class="input_cx_title_240" />
								
							</td>
						</tr>
						<tr><%--row3--%>
							<th class="content_02_box_div_table_th">型号规格：</th>
							<td class="content_02_box_div_table_td">
								<textarea rows="2" cols="38" id="type" name="type"></textarea>
							</td>
							<th class="content_02_box_div_table_th">制造单位：</th>
							<td class="content_02_box_div_table_td">
								<input type="text" name="make_users" id="make_users" readonly="readonly"  class="input_cx_title_240"/>
							</td>
						</tr>
						
						<tr><%--row4--%>
							<th class="content_02_box_div_table_th">投入使用年限：</th>
							<td class="content_02_box_div_table_td">
								<input type="text" name="t_trsynx" id="t_trsynx" readonly="readonly"  class="input_186"/>
							</td>
							<th class="content_02_box_div_table_th">基本参数：</th>
							<td class="content_02_box_div_table_td" height="60px;">
								<textarea rows="4" cols="38" id="technical_parameters" name="technical_parameters"></textarea>
							</td>
						</tr>
						<tr><%--row5--%>
							<th class="content_02_box_div_table_th" style="height: 70px;width: 50px;" >设备&nbsp;&nbsp;</br>报废&nbsp;&nbsp;</br>说明：</th>
							<td class="content_02_box_div_table_td" colspan=5>
							
								报废理由：<br>
							
									<textarea  id="t_bfly" name="t_bfly" class="validate[maxSize[250]] textarea_556" style="border: 1;width:99%;overflow: auto;"></textarea>
								
								<p style="margin-left: 540px;">日期：
								<input type="text" name="t_sqrq" id="t_sqrq" readonly="readonly"  style="width:186px; height:24px; border:0; font:12px/24px; display:block;overflow:hidden;  float:right; padding:0px 2px; display:inline; " value="<%=t_sqrq %>" />
								<script>
								</script>
								</p>
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
<iframe name="frame1" width=0 height=0></iframe> 
</body>
</oa:init>
</html>

