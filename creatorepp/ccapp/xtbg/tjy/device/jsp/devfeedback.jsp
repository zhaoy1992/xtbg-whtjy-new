<%--
描述：供方评价界面
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
<title>设备维修界面</title>
	<oa:init>
	<link rel="stylesheet" href="ccapp/oa/archive/css.css" type="text/css" />
	<script type='text/javascript' src='<%=path %>/ccapp/oa/resources/plug/jquery-media/jquery.media.js' charset="utf-8"></script>
	<script type='text/javascript'>
	//环节ID
	var action_defid="<%=action_defid%>";
		 /*
		函数:  openDevSupplier
		说明:  选择供应商
		返回值: 无
		*/
	  function openDevSupplier(){
		  var path ="<%=path%>/ccapp/xtbg/tjy/device/type/jsp/seldevsupplierlist.jsp?windowsId=windowIds1";
			openAlertWindows('windowIds1',path,'供应商名录',810,400,'25%','25%');
     }
		
	  /*
		函数:  setSupperInfo
		说明:  回填供应商
		参数:   
		返回值: 无
		*/
		function setSupperInfo(devsup_id,devsup_mc,devsup_slsj,devsup_lxdb,
			 	devsup_gfxz,devsup_gfdz,devsup_fddbr,
			 	devsup_lxdh,devsup_xyd,devsup_tgcp,devsup_gflb,devsup_gflbbh,devsup_xydbh){
			//标题
			jQuery("#TA_OA_DEVFEEDBACK__T_TITLE").val("【"+devsup_gflb+"】:【"+devsup_mc+"】");
			//供应商ID
			jQuery("#TA_OA_DEVFEEDBACK__DEVSUP_ID").val(devsup_id);
			//供应商名称
			jQuery("#TA_OA_DEVFEEDBACK__T_DEVSUP_MC").val(devsup_mc);   
			//供方性质
			jQuery("#TA_OA_DEVFEEDBACK__T_DEVSUP_GFXZ option[value='"+devsup_gfxz+"']").attr("selected","selected");
			//供方类别
			jQuery("#TA_OA_DEVFEEDBACK__T_DEVSUP_GFLB option[value='"+devsup_gflbbh+"']").attr("selected","selected");
			//供方地址
			jQuery("#TA_OA_DEVFEEDBACK__T_DEVSUP_GFDZ").val(devsup_gfdz);
			//法定代表
			jQuery("#TA_OA_DEVFEEDBACK__T_DEVSUP_FDDBR").val(devsup_fddbr);
			//联系代表
			jQuery("#TA_OA_DEVFEEDBACK__T_DEVSUP_LXDB").val(devsup_lxdb);
			//联系电话
			jQuery("#TA_OA_DEVFEEDBACK__T_DEVSUP_LXDH").val(devsup_lxdh);
			//提供产品
			jQuery("#TA_OA_DEVFEEDBACK__T_DEVSUP_TGCP").val(devsup_tgcp);
			//信誉度
			jQuery("#TA_OA_DEVFEEDBACK__T_DEVSUP_XYD option[value='"+devsup_xydbh+"']").attr("selected","selected");
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
	<input value="com.chinacreator.xtbg.tjy.device.dao.Impl.DevFeedbackFlowDaoImpl" id="<%=FlowBusiDataSaveDao.CUSTOM_CRUD_CLASSNAME_FLAG%>" 
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
					<span>供方评价表</span>
				</div>
				<div class="content_02_box_div" style="width: 900px;">
					<table border="0" cellspacing="0" cellpadding="0"
						class="content_02_box_div_table" style="width: 98%;">
						<tr><%--row1--%>
							<td class="content_02_box_div_table_td" rowspan="6" width="100px;">供方基本情况</td>
							<th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>标题：</th>
							<td class="content_02_box_div_table_td" colspan="3">
								<oa:input type="text" column="T_TITLE" table="TA_OA_DEVFEEDBACK" other="class='validate[required] input_title_text'"  />
							</td>
						</tr>
						<tr><%--row2--%>
							<th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>供方名称：</th>
							<td class="content_02_box_div_table_td" colspan="3">
								<oa:input type="hidden" column="DEVSUP_ID" table="TA_OA_DEVFEEDBACK" other="class='validate[required] input_cx_title_188'"  />
								<oa:input type="text" column="T_DEVSUP_MC" table="TA_OA_DEVFEEDBACK" other="class='validate[required] input_cx_title_188' readonly='readonly'"  />
							    <input type="button" name="btn" id="btn" style="margin-left: 10px;"  value="选择供应商" class="but_y_01" onclick="openDevSupplier();"/>
							</td>
						</tr>
						<tr><%--row3--%>
							<th class="content_02_box_div_table_th">供方性质：</th>
							<td class="content_02_box_div_table_td">
								<oa:select column="T_DEVSUP_GFXZ" table="TA_OA_DEVFEEDBACK"
								optionsql="select '--请选择--' as devsup_gfxz,'--请选择--' as devsup_gfxzmc  from dual  union
										  select 'sydw' as devsup_gfxz,'事业单位' as devsup_gfxzmc  from dual  union
										   select 'qydw' as devsup_gfxz,'企业单位' as devsup_gfxzmc  from dual union
										  select 'gtsh' as devsup_gfxz,'个体工商户' as devsup_gfxzmc  from dual" style="width: 188px;"
										  initDefautValue="" defautValue="" ></oa:select>
							</td>
							<th class="content_02_box_div_table_th">供方类别：</th>
							<td class="content_02_box_div_table_td">
								<oa:select column="T_DEVSUP_GFLB" table="TA_OA_DEVFEEDBACK"
								optionsql="select ' ' as bh,'--请选择--' as mc  from dual  union
										  select 'sccj' as bh,'生产厂家' as mc  from dual  union
										   select 'cpzjdl' as bh,'产品直接代理' as mc  from dual union
										  select 'cpjx' as bh,'产品经销' as mc  from dual" style="width: 188px;"
										  initDefautValue="" defautValue="" ></oa:select>
							</td>
						</tr>
						<tr><%--row4--%>
							<th class="content_02_box_div_table_th">供方地址：</th>
							<td class="content_02_box_div_table_td" height="60px;">
								<oa:input type="text" column="T_DEVSUP_GFDZ" table="TA_OA_DEVFEEDBACK" other="class='input_cx_title_188' readonly='readonly'"  />
							</td>
							<th class="content_02_box_div_table_th">法定代表人：</th>
							<td class="content_02_box_div_table_td">
								<oa:input type="text" column="T_DEVSUP_FDDBR" table="TA_OA_DEVFEEDBACK" other="class='input_cx_title_188' readonly='readonly'"  />
							</td>
						</tr>
						<tr><%--row5--%>
							<th class="content_02_box_div_table_th">联系代表：</th>
							<td class="content_02_box_div_table_td" height="60px;">
								<oa:input type="text" column="T_DEVSUP_LXDB" table="TA_OA_DEVFEEDBACK" other="class='input_cx_title_188' readonly='readonly'"  />
							</td>
							<th class="content_02_box_div_table_th">联系电话：</th>
							<td class="content_02_box_div_table_td" >
								<oa:input type="text" column="T_DEVSUP_LXDH" table="TA_OA_DEVFEEDBACK" other="class='input_cx_title_188' readonly='readonly'"  />
							</td>
						</tr>
						<tr><%--row6--%>
							<th class="content_02_box_div_table_th">提供产品：</th>
							<td class="content_02_box_div_table_td" height="60px;" colspan="3">
								<oa:textarea column="T_DEVSUP_TGCP" table="TA_OA_DEVFEEDBACK" 
									style="border: 1;width:99%;height:70px;overflow: auto;"
									other="class='validate[maxSize[250]] textarea_556' readonly='readonly'" ></oa:textarea>
							</td>
						</tr>
						<tr><%--row7--%>
							<th class="content_02_box_div_table_th" style="height: 70px;width: 50px;" rowspan="12">供应能力评定&nbsp;&nbsp;</th>
							<td class="content_02_box_div_table_th" >
								评定项目：
							</td>
							<td class="content_02_box_div_table_td" height="60px;" colspan="1" style="text-align: center;">
								评定结果
							</td>
							<td class="content_02_box_div_table_td" height="60px;" colspan="2" style="text-align: center;">
								评定部门意见
							</td>
						</tr>
						<tr><%--row8--%>
							<td class="content_02_box_div_table_th" >
								证照提供情况：
							</td>
							<td class="content_02_box_div_table_td" height="60px;"colspan="1">
								<oa:select column="T_ZZTGQK" table="TA_OA_DEVFEEDBACK"
								optionsql="select ' ' as T_ZZTGQK,'--请选择--' as T_ZZTGQKmc  from dual  union
										  select '营业执照' as T_ZZTGQK,'营业执照' as T_ZZTGQKmc  from dual  union
										   select '组织机构代码证' as T_ZZTGQK,'组织机构代码证' as T_ZZTGQKmc  from dual union
										  select '税务登记证' as T_ZZTGQK,'税务登记证' as T_ZZTGQKmc  from dual" style="width: 188px;"
										  initDefautValue="" defautValue="" ></oa:select>
							</td>
							<td class="content_02_box_div_table_td" height="60px;" colspan="2" rowspan="4">
								<p style="float: left;">科技发展部：</p>
								<oa:view column="T_KJFZBSH" table="TA_OA_DEVFEEDBACK" 
								style="border: 1;width:99%;overflow: auto;" other="class='validate[maxSize[1000]] textarea_556'" />
							</td>
						</tr>
						<tr><%--row9--%>
							<td class="content_02_box_div_table_th" >
								业务代表证明：
							</td>
							<td class="content_02_box_div_table_td" height="60px;" colspan="1">
								<oa:select column="T_YWDBZM" table="TA_OA_DEVFEEDBACK"
								optionsql="select ' ' as T_YWDBZM,'--请选择--' as T_YWDBZMmc  from dual  union
										   select '业务代表身份证' as T_YWDBZM,'业务代表身份证' as T_YWDBZMmc  from dual  union
										   select '业务代表授权书' as T_YWDBZM,'业务代表授权书' as T_YWDBZMmc  from dual" style="width: 188px;"
										   initDefautValue="" defautValue="" ></oa:select>
							</td>
						</tr>
						<tr><%--row10--%>
							<td class="content_02_box_div_table_th" >
								资质证明：
							</td>
							<td class="content_02_box_div_table_td" height="60px;" colspan="1">
								<oa:select column="T_ZZMC" table="TA_OA_DEVFEEDBACK"
								optionsql="select ' ' as T_ZZMC,'--请选择--' as T_ZZMCmc  from dual  union
								           select '生产许可证' as T_ZZMC,'生产许可证 ' as T_ZZMCmc  from dual  union
										   select '计量认证' as T_ZZMC,'计量认证' as T_ZZMCmc  from dual union 
										   select 'ISO9001认证' as T_ZZMC,'ISO9001认证' as T_ZZMCmc  from dual union
										   select '其他' as T_ZZMC,'其他' as T_ZZMCmc  from dual" style="width: 188px;"
										   initDefautValue="" defautValue="" ></oa:select>
							</td>
						</tr>
						<tr><%--row11--%>
							<td class="content_02_box_div_table_th" >
								建立业务时间：
							</td>
							<td class="content_02_box_div_table_td" height="60px;" colspan="1">
								<oa:date dateFmt='yyyy-MM-dd HH:mm:ss' column="T_XJSJ" table="TA_OA_DEVFEEDBACK" other="class='input_cx_title_188'"  />
							</td>
						</tr>
						<tr><%--row11--%>
							<td class="content_02_box_div_table_th" >
								产品质量：
							</td>
							<td class="content_02_box_div_table_td" height="60px;" colspan="1">
								<oa:select column="T_ZPZL" table="TA_OA_DEVFEEDBACK"
								optionsql="select ' ' as T_ZPZL,'--请选择--' as cpzlmc  from dual  union
								           select '较差' as T_ZPZL,'较差' as cpzlmc  from dual  union
										   select '较好' as T_ZPZL,'较好' as cpzlmc  from dual union
										   select '优良' as T_ZPZL,'优良' as cpzlmc  from dual" style="width: 188px;"
										   initDefautValue="" defautValue="" ></oa:select>
							</td>
							<td class="content_02_box_div_table_td" height="60px;" colspan="2" rowspan="5">
								<p style="float: left;">产品使用部门/分院：</p>
								<oa:view column="T_CPSYBMSH" table="TA_OA_DEVFEEDBACK" 
								style="border: 1;width:99%;overflow: auto;" other="class='validate[maxSize[1000]] textarea_556'" />
							</td>
						</tr>
						<tr><%--row12--%>
							<td class="content_02_box_div_table_th" >
								信 誉 度：
							</td>
							<td class="content_02_box_div_table_td" height="60px;" colspan="1">
								<oa:select column="T_DEVSUP_XYD" table="TA_OA_DEVFEEDBACK"
								optionsql="select ' ' as bh,'--请选择--' as mc  from dual  union
										  select 'xj' as bh,'较差' as mc  from dual  union
										   select 'xh' as bh,'较好' as mc  from dual union
										  select 'yl' as bh,'优良' as mc  from dual" style="width: 188px;"
										  initDefautValue="" defautValue="" ></oa:select>
							</td>
						</tr>
						<tr><%--row13--%>
							<td class="content_02_box_div_table_th" >
								交    货：
							</td>
							<td class="content_02_box_div_table_td" height="60px;" colspan="1">
								<oa:select column="T_JH" table="TA_OA_DEVFEEDBACK"
								optionsql="select ' ' as jh,'--请选择--' as jhmc  from dual  union
								           select '及时' as jh,'及时' as jhmc  from dual  union
										   select '基本及时' as jh,'基本及时' as jhmc  from dual union
										   select '不及时' as jh,'不及时' as jhmc  from dual" style="width: 188px;"
										   initDefautValue="" defautValue="" ></oa:select>
							</td>
						</tr>
						<tr><%--row14--%>
							<td class="content_02_box_div_table_th" >
								质量或技术保证：
							</td>
							<td class="content_02_box_div_table_td" height="60px;" colspan="1">
								<oa:select column="T_ZLJSBZ" table="TA_OA_DEVFEEDBACK"
								optionsql="select ' ' as zljsbz,'--请选择--' as zljsbzmc  from dual  union
								           select '有' as zljsbz,'有' as zljsbzmc  from dual  union
										   select '无' as zljsbz,'无' as zljsbzmc  from dual union
										   select '合适' as zljsbz,'合适' as zljsbzmc  from dual union
										   select '不合适' as zljsbz,'不合适' as zljsbzmc  from dual" style="width: 188px;"
										   initDefautValue="" defautValue="" ></oa:select>
							</td>
						</tr>
						<tr><%--row15--%>
							<td class="content_02_box_div_table_th" >
								产品验收方式：
							</td>
							<td class="content_02_box_div_table_td" height="60px;" colspan="1">
								<oa:select column="T_ZPYSFS" table="TA_OA_DEVFEEDBACK"
								optionsql="select ' ' as zpysfs,'--请选择--' as zpysfsmc  from dual  union
								           select '合适' as zpysfs,'合适' as zpysfsmc  from dual  union
										   select '基本合适' as zpysfs,'基本合适' as zpysfsmc  from dual union
										   select '不合适' as zpysfs,'不合适' as zpysfsmc  from dual" style="width: 188px;"
										   initDefautValue="" defautValue="" ></oa:select>
							</td>
						</tr>
						<tr><%--row16--%>
							<td class="content_02_box_div_table_th" >
								付款方式：
							</td>
							<td class="content_02_box_div_table_td" height="60px;" colspan="1">
								<oa:select column="T_FKFS" table="TA_OA_DEVFEEDBACK"
								optionsql="select ' ' as fkfs,'--请选择--' as fkfsmc  from dual  union
								           select '合适' as fkfs,'合适' as fkfsmc  from dual  union
										   select '基本合适' as fkfs,'基本合适' as fkfsmc  from dual union
										   select '不合适' as fkfs,'不合适' as fkfsmc  from dual" style="width: 188px;"
										   initDefautValue="" defautValue="" ></oa:select>
							</td>
							<td class="content_02_box_div_table_td" height="60px;" colspan="2" >
								<p style="float: left;">财务部门：</p>
								<oa:view column="T_CWBMYJ" table="TA_OA_DEVFEEDBACK" 
								style="border: 1;width:99%;overflow: auto;" other="class='validate[maxSize[1000]] textarea_556'" />
							</td>
						</tr>
						<tr><%--row17--%>
							<td class="content_02_box_div_table_th" >
								备注：
							</td>
							<td class="content_02_box_div_table_td" height="80px;" colspan="3" >
								<oa:textarea column="T_BZ" table="TA_OA_DEVFEEDBACK" 
									style="border: 1;width:99%;overflow: auto;"
									other="class='validate[maxSize[250]] textarea_556'"></oa:textarea>
							</td>
						</tr>
						<tr><%--row18--%>
							<th class="content_02_box_div_table_th" style="height: 70px;width: 50px;">评价结论&nbsp;&nbsp;</th>
							<td class="content_02_box_div_table_th" colspan="4">
								<p style="float: left;">技术负责人：</p>
								<oa:view column="T_JSFZRYJ" table="TA_OA_DEVFEEDBACK" 
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

