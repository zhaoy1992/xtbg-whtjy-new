<%--
描述：设备基本信息管理界面
作者：邱炼
版本：1.0
日期：2014-03-03
--%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.impl.DevSupplierServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.DevSupplierService"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.entity.CarImageBeam"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.dao.CarManageCarDao"%>
<%@page import="com.chinacreator.xtbg.pub.jqueryupload.filebuess.dao.FiletransfersSysDao"%>
<%@page import="com.chinacreator.xtbg.pub.jqueryupload.filebuess.dao.impl.FiletransfersSysDaoImpl"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.DevInfoItemService"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.impl.DevInfoItemServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.DevAccountInfoService"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.impl.DevAccountServiceImpl"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	
	//设备基础信息表
	Map<String,String> bean = new HashMap<String,String>();
	//配件明细信息
	List<Map<String,String>> listItems = new ArrayList<Map<String,String>>();
	//采购验收表
	Map<String,String> eqAccBean =new HashMap<String,String>();
	//申请采购信息
	Map<String,String> appBean =new HashMap<String,String>();
	//供应商信息
	Map<String,String> suppBean =new HashMap<String,String>();
	
	String actionName = request.getParameter("actionName");
	//主键ID
	String id = request.getParameter("id");
	//附件ID
	String dev_attach_id = "";
	//设备信息业务
	DevAccountInfoService service = new DevAccountServiceImpl();
	//配件业务
	DevInfoItemService itemService = new DevInfoItemServiceImpl();
	CarManageCarDao carManageCarDao = (CarManageCarDao)DaoImplClassUtil.getDaoImplClass("carManageCarDaoImplymj");
	String attachment_id = new Date().getTime()+"";
	//设备图片
	CarImageBeam cb = new CarImageBeam();
	if("insert".equals(actionName)){
		//附件ID
		dev_attach_id = new Date().getTime()+"";
		//当前系统时间
		bean.put("creat_time", DateUtil.getCurrentDate());
		//当前登记人ID
		bean.put("creater_userid", accesscontroler.getUserID());
		//当前登记人名称
		bean.put("creater_username", accesscontroler.getUserName());
		
	} else {
		//基本信息
		bean = service.getDevAccountBean(id);
		listItems = itemService.getDevInfoItemBean(bean.get("dev_code"));
		//附加ID
		dev_attach_id = StringUtil.deNull(bean.get("dev_attach_id"));
		if(StringUtil.isBlank(dev_attach_id)) {
			dev_attach_id = new Date().getTime()+"";
		}
		//设备图片ID
		attachment_id = bean.get("dev_photoid");
		List<CarImageBeam> fileList = null;
		if (!StringUtil.isBlank(bean.get("dev_photoid"))) {
			FiletransfersSysDao filesysDao = new FiletransfersSysDaoImpl();
		 	fileList = carManageCarDao.getCarImageBeamlist(bean.get("dev_photoid"));
		 	for(int i =0;i<fileList.size();i++)
		 	{
		 		cb = fileList.get(i);
		 	}
		} else {
			attachment_id = new Date().getTime()+"";
		}
		//根据设备主键ID 查询设备采购验证信息查询
		eqAccBean =	service.getDevEquipmentacc(id);
		//根据申请明细表ID 查询申请采购信息
		if(!StringUtil.isBlank(eqAccBean.get("item_id"))){
			//申请明细表ID
			String item_id = eqAccBean.get("item_id");
			appBean = service.getDevEqAppInfo(item_id);
		}
		
		//查询供应商数据
		DevSupplierService devsupplierservice = new DevSupplierServiceImpl();
		//供应商ID
		String devsup_id = bean.get("devsup_id");
		suppBean = devsupplierservice.getDevSupplierBean(devsup_id);
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>设备基本信息管理</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js" charset="UTF-8"></script>
<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入jQuery UI -->
	<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript" charset="UTF-8"></script>
<!-- 引入jQuery UI -->
<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript" charset="UTF-8"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript" charset="UTF-8"></script>
<!-- 引入jQuery_dialog -->
<script src="../../../resources/plug/jquery_dialog/jquery_dialog.js" charset="UTF-8"></script>
<!-- 引入公共JS -->
<!-- 引入formvValidatetion -->
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="UTF-8"></script>
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
	<link rel="stylesheet" href="../../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="UTF-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript" src="../resources/devaccountinfo.js" charset="utf-8"></script>
<!-- 引入上传控件 -->
<link rel="stylesheet" href="../../../resources/plug/fancyupload/fancyupload.css" type="text/css" />
<script type="text/javascript" src="../../../resources/plug/fancyupload/mootools-1.2.5-core-jm.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/fancyupload/source/Fx.ProgressBar.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/fancyupload/source/Swiff.Uploader.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/fancyupload/source/FancyUpload3.Attach.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/fancyupload/myfancyupload.js" charset="utf-8"></script>
<script type="text/javascript">
var path = "<%=path%>";
//执行操作
var actionName ="<%=actionName%>";
//主键id
var t_id = "<%=StringUtil.deNull(bean.get("id"))%>";
//采购申请表ID
var item_plainid = "<%=StringUtil.deNull(appBean.get("item_plainid"))%>";
//采购验收表主键ID
var equipmentaccId = "<%=StringUtil.deNull(eqAccBean.get("t_id"))%>";

jQuery(document).ready(function() {
	jQuery("#form1").validationEngine();
	 MyFancyupload.createUpload('_fileshow', '#_filebut', '<%=path%>', '<%=path%>/servlet/FileUpload?buessid=<%=dev_attach_id%>', true, "<%=dev_attach_id%>");
	jQuery("#dev_code").focus();
	jQuery('#tabs1').tabs();
	
	//维修借用信息  使用状态和完好状态
	jQuery("#dev_stockflag option[value='<%=StringUtil.deNull(bean.get("dev_stockflag"))%>']").attr('selected', true);
	jQuery("#dev_state option[value='<%=StringUtil.deNull(bean.get("dev_state"))%>']").attr('selected', true);
	
	//采购申请表ID 为空时，采购按钮为不可用
	if(item_plainid==""){
		jQuery("#btnApplica").hide();
	}
	
	//采购验收表主键ID为空时，验收详情按钮为不可用
	if(equipmentaccId==""){
		jQuery("#btnEqAct").hide();
	}
	
});

changeIndex = function(index){
	//基本信息
	if(index===1){
	//采购验收信息	
	}else if(index==2){
	//维修借用信息
	}else if(index===3){
	//检定检查信息
	}else if(index===4){
		
	}
};


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
	jQuery("#devsup_id").val(devsup_id);
	//供应商名称
	jQuery("#suppliername").val(devsup_mc);
	//收录时间
	jQuery("#recruitdate").val(devsup_slsj);
	//法定代表人
	jQuery("#devsup_fddbr").val(devsup_fddbr);
	//联系代表
	jQuery("#devsup_lxdb").val(devsup_lxdb);
	//联系电话
	jQuery("#devsup_lxdh").val(devsup_lxdh);
	
}

/*
函数:  openApplicaForm
说明:  点击采购按钮 打开采购详情界面
参数:   无
返回值: 无
*/
function openApplicaForm(){
	var url ="<%=path%>/ccapp/xtbg/tjy/device/jsp/devapplication.jsp?busi_id="+item_plainid+"&list_type=worklis&operType=yiban&actiontype_code=04&busiTypeCode=uuid_720&template_id=&Template=word";
	var height = window.screen.availHeight;
	var width = window.screen.availWidth;
	url= url+"&height="+height+"&width="+width;
	url= url+"&windowsId=windowIds1";
	openAlertWindows('windowIds1',url,"采购申请详情",width,height,'0%','0%');
}

/*
函数:  openEquipAccForm
说明:  点击采购按钮 打开验收采购详情界面
参数:   无
返回值: 无
*/
function openEquipAccForm(){
	var url ="<%=path%>/ccapp/xtbg/tjy/device/jsp/devequipmentacc.jsp?t_id="+equipmentaccId+"&isShow=true";
	var height = window.screen.availHeight;
	var width = window.screen.availWidth;
	url= url+"&height="+height+"&width="+width;
	url= url+"&windowsId=windowIds1";
	openAlertWindows('windowId2',url,"验收采购详情",width,height,'0%','0%');
}

</script>
<body style="overflow-y:auto;" class="vcenter">
	<form id="form1" action="devaccountinfodo.jsp" method="post"  >
		<input type='hidden' name='action' id="hidden_action"/>
		<input type="hidden" name="dev_photoid" id="dev_photoid" value="<%=attachment_id%>"/>
		<input type="hidden" name="id" id="id" value="<%=StringUtil.deNull(bean.get("id"))%>"/>
		<input type="hidden" name="windowsId" id="windowsId" value='<%=StringUtil.deNull(request.getParameter("windowsId"))%>'/>
		<input type="hidden" name="dev_attach_id" id="dev_attach_id" value="<%=StringUtil.deNull(dev_attach_id)%>"/>
		<input type="hidden" name="dev_oldcode" id="dev_oldcode" value="<%=StringUtil.deNull(bean.get("dev_code")) %>"/>
		<div class="content_02" style="overflow: hidden;" id="_top"><!-- 操作-->
			<div class="content_02_top" style="margin-bottom: 10px;">
				<input name="save" id="save" value="保存"  onclick="Ok();" type="button" class="but_y_01" /> 
				<input name="" value="返回" onclick="closed()" type="button" class="but_y_01" />
			</div>
		</div>
		<div id="tabs1" style="width:99%;overflow-x:hidden;">
			<div id="titleids">
				<ul>
					<li><a href="#tabs-1" onClick="changeIndex(1)">基本信息</a></li>
					<li><a href="#tabs-2" onClick="changeIndex(2)">采购验收信息</a></li>
					<li><a href="#tabs-3" onClick="changeIndex(3)">维修借用信息</a></li>
					<li><a href="#tabs-4" onClick="changeIndex(4)">检定检查信息</a></li>
				</ul>
			</div>
		<!-- tab1 设备基本信息start -->
		<div id="tabs-1">
			<div id="app_table1" class="content_02_box_title_bg" style="width: 780px;margin-top: 10px;" >
					<span>基本信息</span>
			</div>
		 <div id="users-contain" style="width: 780px;">
			<table  width="100%" border="0" cellspacing="0" cellpadding="0" >
					<tr>
						<th class="content_02_box_div_table_th" style="width: 300px;" ><span style="color: red;">*</span>设备编号：</th>
						<td class="content_02_box_div_table_td" colspan="2">
							<input type="text" name="dev_code" id="dev_code" class="validate[required,maxSize[50]] input_cx_title_188" value="<%=StringUtil.deNull(bean.get("dev_code")) %>" />
						</td>
						<td class="content_02_box_div_table_td" colspan="3" rowspan="5">
							<%if(cb.getImage_parth()!=null){%>
								<img alt="设备照片" style="margin-left: 80px;" id="showimg"  width="250px" height="160px" src="../../../../../<%=cb.getImage_parth()%>">
								<div id="Preview" style="filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale);">
								</div>
								<input id="sshowimg" style="display:none;" value="<%=cb.getImage_parth()%>"/>
							<%}else{%>
								<div id="Preview" style="filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale);">
								</div>
								<img  width="250px" style="margin-left: 80px;" id="csimg" height="160px"  src="../image/u=2193430612,633948572&fm=11&gp=0.jpg">
								<input id="sshowimg" style="display:none;" value=""/>
							<%}%>
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th"><span style="color: red;">*</span>设备名称：</th>
						<td class="content_02_box_div_table_td"  colspan="2">
							<input type="text" name="dev_name" id="dev_name" class="validate[required,maxSize[100]] input_cx_title_188"  value="<%=StringUtil.deNull(bean.get("dev_name")) %>" />
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th">设备型号：</th>
						<td class="content_02_box_div_table_td" colspan="2">
							<input type="text" name="type" id="type" value="<%=StringUtil.deNull(bean.get("type")) %>" class="validate[maxSize[100]] input_cx_title_188"  />
						</td>
					</tr>	
					<tr>
						<th class="content_02_box_div_table_th">制造厂：</th>
						<td class="content_02_box_div_table_td" colspan="2">
							<input type="text" name="make_users" id="make_users"  value="<%=StringUtil.deNull(bean.get("make_users")) %>" class="validate[maxSize[100]] input_cx_title_188" />
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th">照片上传：</th>
						<td class="content_02_box_div_table_td" colspan="2">
							<input type="file" id="imgfile" name="imgfile" onchange="viewmypic(this)" class="input_188">
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th">出厂编号：</th>
						<td class="content_02_box_div_table_td"  colspan="2">
							<input type="text" name="factory_no" id="factory_no"  value="<%=StringUtil.deNull(bean.get("factory_no")) %>" class="validate[maxSize[50]] input_cx_title_188" />
						</td>
						<th class="content_02_box_div_table_th">图    纸：</th>
						<td class="content_02_box_div_table_td"  colspan="2">
							<input type="text" name="car_photo" id="car_photo"  value="<%=StringUtil.deNull(bean.get("car_photo")) %>" class="validate[maxSize[50]] input_cx_title_188"/>
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th">产品合格证编号：</th>
						<td class="content_02_box_div_table_td" colspan="2">
							<input type="text" name="product_no" id="product_no"  value="<%=StringUtil.deNull(bean.get("product_no")) %>" class="validate[maxSize[100]] input_cx_title_188" />
						</td>
						<th class="content_02_box_div_table_th">质量证明书编号：</th>
						<td class="content_02_box_div_table_td"  colspan="2">
							<input type="text" name="quality_no" id="quality_no"  value="<%=StringUtil.deNull(bean.get("quality_no")) %>" class="validate[maxSize[100]] input_cx_title_188" />
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th">出厂日期：</th>
						<td class="content_02_box_div_table_td">
							<input type="text" name="creat_date" id="creat_date"  value="<%=StringUtil.deNull(bean.get("creat_date")) %>"  class="date_120 Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
						</td>
						<th class="content_02_box_div_table_th">到货日期：</th>
						<td class="content_02_box_div_table_td">
							<input type="text" name="arrive_time" id="arrive_time"  value="<%=StringUtil.deNull(bean.get("arrive_time")) %>" class="date_120 Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
						</td>
						<th class="content_02_box_div_table_th">价格：</th>
						<td class="content_02_box_div_table_td">
							<input type="text" name="price" id="price"  value="<%=StringUtil.deNull(bean.get("price")) %>"  class="validate[custom[number],maxSize[30]] input_cx_title_150"/>
						</td>
						
					</tr>
					<tr>
						<th class="content_02_box_div_table_th">设备主要&nbsp;&nbsp;<br>技术参数：</th>
						<td class="content_02_box_div_table_td" colspan="5">
							<textarea style="width: 99%" rows="6" cols="12" name="technical_parameters" class="validate[maxSize[400]]"
								id="remark" ><%=StringUtil.deNull(bean.get("technical_parameters"))%></textarea>
						</td>
					</tr>
				</table>
			</div>
			<!-- 说明书附件DIV -->
			<div class="content_02_box">
				<div class="content_02_box_title_bg"><span>其他信息</span></div>
				<div class="content_02_box_div">
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						id="content_02_box_div_table_02">
						<tr id="fj">
							<th width="212" valign="top">说明书附件：</th>
							<td width="560"><a href="#" id="_filebut">请选择文件</a></td>
						</tr>
						<tr>
							<th valign="top">说明书附件列表：</th>
							<td>
							<ul id="_fileshow"></ul>
							&nbsp;</td>
						</tr>
					</table>
				</div>
			</div>
			<!-- 说明书附件DIV-->
			<!-- 形成配件列表清单 DIV-->
			<div class="content_02_box" id="appListItem1" style="width: 780px;">
			<div class="content_02_box_title_bg" style="width: 98.9%">
			<span>配件列表</span>
			<div class="content_02_box_add">
			<a onclick="Add_Row4NewDay1()" id="addButton"><img src="<%=path%>/ccapp/xtbg/resources/images/add.gif"/>添加配件</a>
			</div>
			</div>
			<div class="content_02_box_div" style="width: 780px;">
			<table id="dayTable" class="content_02_box_div_table_02" width="99%" cellspacing="0" cellpadding="0" border="0">
					 	<tr>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 120px">配件名称</td>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 60px">规格</span></td>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 50px">数量</span></td>
							<td class="content_02_box_div_table_th" align="center"style="text-align: center;width:30px">操作</td>
						</tr>
						 <% 
									 if(listItems.size()>0){
										for(int i=0;i<listItems.size();i++){
											HashMap<String,String> itemMap =(HashMap<String,String>)listItems.get(i); 
						 %>	 
							  <tr id ="dayrow" name="dayrow">
									<td class="content_02_box_div_table_td"> 
										<input type="hidden" id="id" name="id" value="<%=StringUtil.deNull(itemMap.get("id"))%>" />
										<input type="text" id="parts_name" name="parts_name" value="<%=StringUtil.deNull(itemMap.get("parts_name"))%>" class="validate[maxSize[150]] input_title_text"  style="text-align: center;" />
									</td>
									<td class="content_02_box_div_table_td"> 
											<input type="text" id="parts_type" name="parts_type" value="<%=StringUtil.deNull(itemMap.get("parts_type"))%>" class="validate[maxSize[150]] input_title_text" style="text-align: center;"/>
									</td>
									<td class="content_02_box_div_table_td"> 
											<input type="text" id="parts_count" name="parts_count" value="<%=StringUtil.deNull(itemMap.get("parts_count"))%>" class="validate[maxSize[10]] input_title_text" style="text-align: center;" />
									</td>
									<td class="content_02_box_div_table_td"> 
									 <div class="content_02_box_del" style="height:24px; margin:0;float: none;text-align: center;" >
										<a onClick="deleteDay(this,'<%=StringUtil.deNull(itemMap.get("id"))%>')" name="deleteButton"> <img src="<%=path%>/ccapp/xtbg/resources/images/del.gif" id="del"/>删除</a>
									 </div>
									</td>
								</tr>  
							 <%
									}
								} else { 
							%>
							<tr  id ="dayrow" name="dayrow">
								<td class="content_02_box_div_table_td"> 
										<input type="text" id="parts_name" name="parts_name" class="validate[maxSize[150]] input_title_text" style="text-align: center;" />
								</td>
								<td class="content_02_box_div_table_td"> 
										<input type="text" id="parts_type" name="parts_type" class="validate[maxSize[150]] input_title_text" style="text-align: center;"/>
								</td>
								<td class="content_02_box_div_table_td"> 
										<input type="text" id="parts_count" name="parts_count" class="validate[maxSize[10]] input_title_text" style="text-align: center;" />
								</td>
								<td class="content_02_box_div_table_td"> 
										 <div class="content_02_box_del" style="height:24px; margin:0;float: none;text-align: center;">
															<a onClick="deleteDay(this,'')"> <img src="<%=path%>/ccapp/xtbg/resources/images/del.gif" id="del"/>删除</a>
										 </div>
														
								</td>
							</tr>
							<%
							 } 
							%>
				</table>
				</div>
			</div>
			<!-- 形成配件列表清单DIV -->
			<div id="users-contain_info1" style="width: 780px;" >
				<table  width="100%" border="0" cellspacing="0" cellpadding="0" >
					<tr>
						<th class="content_02_box_div_table_th"><span style="color: red;">*</span>设备保管部门：</th>
						<td class="content_02_box_div_table_td">
							<input type="hidden" name="user_orgid" id="user_orgid" value="<%=StringUtil.deNull(bean.get("user_orgid"))%>">
							<input type="text" name="user_orgname" id="user_orgname" class="validate[maxSize[50]] input_160" style="height=23px" 
							value="<%=StringUtil.deNull(bean.get("user_orgname"))%>" onclick="chooseOrgUnits()">
							<input name="" type="button" value="" class="but_x" onclick="chooseOrgUnits()"/>
						</td>
						<th class="content_02_box_div_table_th"><span style="color: red;">*</span>保管人：</th>
						<td class="content_02_box_div_table_td" width="192px">
							<input type="hidden" name="custos_userid" id="custos_userid" value="<%=StringUtil.deNull(bean.get("custos_userid"))%>">
							<input type="text" name="custos_username" id="custos_username" class="validate[maxSize[50]] input_160" style="height=23px" 
							value="<%=StringUtil.deNull(bean.get("custos_username"))%>" onclick="chooseUserUnits()">
							<input name="" type="button" value="" class="but_x" onclick="chooseUserUnits()"/>
						</td>
						
					</tr>
					<tr>
						<th class="content_02_box_div_table_th">备注：</th>
						<td class="content_02_box_div_table_td" colspan="3">
							<textarea style="width:99%;" rows="5" cols="12" name="remark" class="validate[maxSize[400]]"
							id="remark" ><%=StringUtil.deNull(bean.get("remark"))%></textarea>
						</td>
						
					</tr>
					<tr>
						<th class="content_02_box_div_table_th">登记人：</th>
						<td class="content_02_box_div_table_td">
							<input type="hidden" name="creater_userid" id="creater_userid"  value="<%=StringUtil.deNull(bean.get("creater_userid")) %>" />
							<input type="text" name="creater_username" readonly="readonly" id="creater_username1"  value="<%=StringUtil.deNull(bean.get("creater_username")) %>" class="input_title_text" />
						</td>
						<th class="content_02_box_div_table_th">登记日期：</th>
						<td class="content_02_box_div_table_td" width="192px">
							<input type="text" name="creat_time" readonly="readonly" id="creat_time" value="<%=StringUtil.deNull(bean.get("creat_time")) %>" class="input_title_text" />
						</td>
						
					</tr>	
			</table>
		</div>
		</div>
		<!-- tab1 设备基本信息end -->
		<!-- tab2采购验收信息start -->
		<div id="tabs-2">
			<div id="app_table2" class="content_02_box_title_bg" style="width: 780px;margin-top: 10px;">
				<span>采购验收信息</span>
				<span><input type="button" id="btnApplica" onclick="openApplicaForm();" class="but_y_01" value="采购详细"></span>
				<span><input type="button" id="btnEqAct" onclick="openEquipAccForm();" class="but_y_01" value="验收详细"></span>
			</div>
		 	<div id="users-contain2" style="width: 780px;">
				<table  width="100%" border="0" cellspacing="0" cellpadding="0" >
						<tr>
							<th class="content_02_box_div_table_th" style="width: 300px;" >采购计划：</th>
							<td class="content_02_box_div_table_td" colspan="2">
								<input type="text" name="dev_code" id="dev_code" class="validate[maxSize[50]] input_cx_title_188" value="<%=StringUtil.deNull(appBean.get("t_fqrmc")) %>" readonly="readonly"/>
							</td>
							<th class="content_02_box_div_table_th" style="width: 300px;" >采购批准：</th>
							<td class="content_02_box_div_table_td" >
								<input type="text" name="dev_code" id="dev_code" class="validate[maxSize[50]] input_cx_title_188" value="<%=StringUtil.deNull(appBean.get("item_pzrmc")) %>" readonly="readonly"/>
							</td>
						</tr>
						<tr>
							<th class="content_02_box_div_table_th" style="width: 300px;" >金额：</th>
							<td class="content_02_box_div_table_td" colspan="2">
								<input type="text" name="dev_code" id="dev_code" class="validate[maxSize[50]] input_cx_title_188" value="<%=StringUtil.deNull(appBean.get("item_ysfy")) %>" readonly="readonly"/>
							</td>
							<th class="content_02_box_div_table_th" style="width: 300px;" >交货日期：</th>
							<td class="content_02_box_div_table_td" >
								<input type="text" name="dev_code" id="dev_code" class="validate[maxSize[50]] input_cx_title_188" value="<%=StringUtil.deNull(eqAccBean.get("t_dhdate")) %>" readonly="readonly"/>
							</td>
						</tr>
						<tr>
							<th class="content_02_box_div_table_th" style="width: 300px;" >验收结论：</th>
							<td class="content_02_box_div_table_td" colspan="2">
								<input type="text" name="dev_code" id="dev_code" class="validate[maxSize[50]] input_cx_title_188" value="<%=StringUtil.deNull(eqAccBean.get("t_ysjl")) %>" readonly="readonly"/>
							</td>
							<th class="content_02_box_div_table_th" style="width: 300px;" >签字日期：</th>
							<td class="content_02_box_div_table_td" >
								<input type="text" name="dev_code" id="dev_code" class="validate[maxSize[50]] input_cx_title_188" value="<%=StringUtil.deNull(eqAccBean.get("t_gfysr_date")) %>"  readonly="readonly"/>
							</td>
						</tr>
						<tr>
							<th class="content_02_box_div_table_th" style="width: 300px;" >供应商名称：</th>
							<td class="content_02_box_div_table_td" colspan="2">
								<input type="hidden" name="devsup_id" id="devsup_id" value="<%=StringUtil.deNull(suppBean.get("devsup_id")) %>" /> 
								<input type="text" name="suppliername" id="suppliername" value="<%=StringUtil.deNull(suppBean.get("devsup_mc")) %>" class="validate[required,maxSize[100]] input_160" style="width: 155px;" onclick="openSupplier();" readonly="readonly"/>
								<input name="" type="button" value="" class="but_x" onclick="openSupplier();"/>
							</td>
							<th class="content_02_box_div_table_th" style="width: 300px;" >收录时间：</th>
							<td class="content_02_box_div_table_td" >
								<input type="text" name="recruitdate" id="recruitdate" value="<%=StringUtil.deNull(suppBean.get("devsup_slsj")) %>" class="validate[required,maxSize[50]] input_cx_title_188"  readonly="readonly" />
							</td>
						</tr>
						<tr>
							<th class="content_02_box_div_table_th">法定代表人：</th>
							<td class="content_02_box_div_table_td" colspan="2">
								<input type="text" name="devsup_fddbr" class="input_cx_title_188"  readonly="readonly"
								id="devsup_fddbr" value="<%=StringUtil.deNull(suppBean.get("devsup_fddbr"))%>">
							</td>
							<th class="content_02_box_div_table_th">联系代表：</th>
							<td class="content_02_box_div_table_td" >
								<input type="text" name="devsup_lxdb" class="input_cx_title_188" readonly="readonly"
									id="devsup_lxdb" value="<%=StringUtil.deNull(suppBean.get("devsup_lxdb"))%>">
							</td>
						</tr>	
						<tr>
							<th class="content_02_box_div_table_th">联系电话：</th>
							<td class="content_02_box_div_table_td" colspan="2">
								<input type="text" name="devsup_lxdh" class="input_cx_title_188" readonly="readonly"
								id="devsup_lxdh" value="<%=StringUtil.deNull(suppBean.get("devsup_lxdh"))%>">
							</td>
							<th class="content_02_box_div_table_th"></th>
							<td class="content_02_box_div_table_td" colspan="2">
							</td>
						</tr>
					</table>
			</div>
		</div>	
		<!-- tab2采购验收信息end -->
		<!-- tab3维修借用信息start -->
		<div id="tabs-3">
			<div id="braow_tab3" class="content_02_box_title_bg" style="width: 780px;margin-top: 10px;">
				<span>维修借用信息</span>
			</div>
		 	<div id="users-contain3" style="width: 780px;">
				<table  width="100%" border="0" cellspacing="0" cellpadding="0" >
						<tr>
							<th class="content_02_box_div_table_th" style="width: 200px;" >使用状态：</th>
							<td class="content_02_box_div_table_td" colspan="2">
								<select style="width: 160px;" id='dev_stockflag' name='dev_stockflag' class="validate[required,maxSize[10]]">
									<option value='1'>在库</option>
									<option value='2'>借出</option>
								</select>	
							</td>
							<th class="content_02_box_div_table_th" style="width: 200px;" >完好状态：</th>
							<td class="content_02_box_div_table_td" >
								<select style="width: 160px;" id='dev_state' name='dev_state' class="validate[required,maxSize[10]]">
									<option value='1'>完好</option>
									<option value='2'>在修</option>
									<option value='3'>报废</option>
									<option value='4'>损耗</option>
									<option value='5'>停用</option>
								</select>	
							</td>
						</tr>
					</table>
			</div>
			<!-- 借用记录列表清单 DIV-->
			<div id="div_borrow" class="content_02_box_div"  style="width: 780px;"> 
				<iframe
					frameborder="0"
					style="padding: 0px; border: 0px; width: 780px; height: 200px"
					id="devborrow" name="devborrow"
					src="seldevborrowlist.jsp?t_sb_id=<%=StringUtil.deNull(bean.get("id"))%>"></iframe>
			</div>
			<!-- 借用记录列表清单DIV -->
			<!-- 借用记录列表清单 DIV-->
			<div id="div_chuzu" class="content_02_box_div"  style="width: 780px;"> 
				<iframe
					frameborder="0"
					style="padding: 0px; border: 0px; width: 780px; height: 200px"
					id="devchuzu" name="devchuzu"
					src="seldevchuzulist.jsp?t_sb_id=<%=StringUtil.deNull(bean.get("id"))%>"></iframe>
			</div>
			<!-- 借用记录列表清单DIV -->
			<!-- 维修记录列表清单 DIV-->
			 <div id="div_repair" class="content_02_box_div"  style="width: 780px;"> 
				<iframe
					frameborder="0"
					style="padding: 0px; border: 0px; width: 780px; height: 200px"
					id="devrepair" name="devrepair"
					src="seldevrepairlist.jsp?t_sb_id=<%=StringUtil.deNull(bean.get("id"))%>"></iframe>
			</div>
			<!-- 维修记录列表清单DIV -->
			
		</div>
		<!-- tab3维修借用信息end -->
		<!--tab4检定检查信息start-->
		<div id="tabs-4">
		 	<!-- 检定记录列表清单 DIV-->
			<div id="div_appraisa" class="content_02_box_div"  style="width: 780px;"> 
				<iframe
					frameborder="0"
					style="padding: 0px; border: 0px; width: 780px; height: 200px"
					id="devappraisa" name="devappraisa"
					src="seldevappraisallist.jsp?t_sb_id=<%=StringUtil.deNull(bean.get("id"))%>"></iframe>
			</div>
			<!-- 检定记录列表清单DIV -->
			<!-- 校准记录列表清单 DIV-->
			<div id="div_calibratere" class="content_02_box_div"  style="width: 780px;"> 
				<iframe
					frameborder="0"
					style="padding: 0px; border: 0px; width: 780px; height: 200px"
					id="devcalibratere" name="devcalibratere"
					src="seldevcalibratelist.jsp?t_sb_id=<%=StringUtil.deNull(bean.get("id"))%>"></iframe>
			</div>
			<!-- 校准记录列表清单DIV -->
			<!-- 核查记录列表清单 DIV-->
			<div id="div_checkinfo" class="content_02_box_div"  style="width: 780px;"> 
				<iframe
					frameborder="0"
					style="padding: 0px; border: 0px; width: 780px; height: 200px"
					id="devcheckinfo" name="devcheckinfo"
					src="seldevcheckinfolist.jsp?t_sb_id=<%=StringUtil.deNull(bean.get("id"))%>"></iframe>
			</div>
			<!-- 核查记录列表清单DIV -->
			<!-- 比对记录列表清单 DIV-->
			 <div id="div_compare" class="content_02_box_div"  style="width: 780px;"> 
				<iframe
					frameborder="0"
					style="padding: 0px; border: 0px; width: 780px; height: 200px"
					id="divcompare" name="divcompare"
					src="seldevcomparelist.jsp?t_sb_id=<%=StringUtil.deNull(bean.get("id"))%>"></iframe>
			</div>
			<!-- 比对记录列表清单DIV -->
			<!-- 标对记录列表清单 DIV-->
			 <div id="div_subject" class="content_02_box_div"  style="width: 780px;"> 
				<iframe
					frameborder="0"
					style="padding: 0px; border: 0px; width: 780px; height: 200px"
					id="divsubject" name="divsubject"
					src="seldevsubjectlist.jsp?t_sb_id=<%=StringUtil.deNull(bean.get("id"))%>"></iframe>
			</div>
			<!-- 标对记录列表清单DIV -->
			</div>
		</div>	
		<!--tab4检定检查信息end-->	
	 </div>
	</form>
	<form action="<%=path%>/ccapp/xtbg/yimingju/carmanage/jsp/uploadimage.jsp?attachment_ids=<%=attachment_id %>" target="filetypeinfodoJSPhiddenFrame1" method="post" enctype="multipart/form-data" name="form_up" id="form_up">
	</form>
	<iframe name="filetypeinfodoJSPhiddenFrame" width=0 height=0></iframe>
	<iframe name="filetypeinfodoJSPhiddenFrame1" width=0 height=0></iframe>
	
</body>
</html>