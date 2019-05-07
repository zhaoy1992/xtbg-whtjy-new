<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.pub.jqueryupload.filebuess.entity.FileInfoBean"%>
<%@page import="com.chinacreator.xtbg.pub.jqueryupload.filebuess.dao.impl.FiletransfersSysDaoImpl"%>
<%@page import="com.chinacreator.xtbg.pub.jqueryupload.filebuess.dao.FiletransfersSysDao"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageCarBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.dao.CarManageCarDao"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.entity.CarImageBeam" %>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String userid = accesscontroler.getUserID();
	String loginUserName = accesscontroler.getUserAccount();
	//获得当前登录用户所属单位信息
	UserCacheBean usercachebean = UserCache.getUserCacheBean(userid);
	String unit_id = usercachebean.getUnit_id();
	String unit_name = usercachebean.getUnit_name();
	
	String theRootOrgid = DaoUtil.SqlToField("select org_id from td_sm_organization where parent_id='0'");
	String subid = request.getParameter("subid");
	String car_id = request.getParameter("car_id");
	String attachment_id = new Date().getTime()+"";
	CarManageCarBean carManageCarBean = new CarManageCarBean();
	CarImageBeam cb = new CarImageBeam();
	// 车辆信息 carManageCarDaoImplymj
	CarManageCarDao carManageCarDao = (CarManageCarDao)DaoImplClassUtil.getDaoImplClass("carManageCarDaoImplymj");
	if(!StringUtil.nullOrBlank(car_id)){
		carManageCarBean = carManageCarDao.findCarManageCarByCarID(car_id);
	}else{
		carManageCarBean.setUnit_id(unit_id);
		carManageCarBean.setUnit_name(unit_name);
	}
	List<CarImageBeam> fileList = null;
	if (!StringUtil.isBlank(carManageCarBean.getCar_photoid())) {
		attachment_id=carManageCarBean.getCar_photoid();
		FiletransfersSysDao filesysDao = new FiletransfersSysDaoImpl();
	 	fileList = carManageCarDao.getCarImageBeamlist(carManageCarBean.getCar_photoid());
	 	for(int i =0;i<fileList.size();i++)
	 	{
	 		cb=fileList.get(i);
	 	}
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>新车登记-添加界面</title>
</head>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script src="../../../resources/js/util/jsonutil.js" type="text/javascript"></script>

<script type="text/javascript">jQuery.noConflict();</script>

<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>

<!-- 引入my97时间控件 -->
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<!-- 引入formvValidatetion -->
<link rel="stylesheet"href="../../../resources/plug/formvalidation/css/validationEngine.jquery.css"type="text/css" />
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>

<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<!-- 公共部分结束 -->

<script type="text/javascript">
jQuery(function(){
	jQuery("#form1").validationEngine();
	//jQuery("#btn_uploadfile").click(function() {
	
//	});
})

/*
 * 说明：文件上传事件 参数：无 返回值：无 作者：jichang.long
 */
function savePic(){
	//var f=document.getElementById("imgfile").value;
	var f=jQuery("sshowimg").val();
    //if(f==null)
  //  { 
   //     alert("请选择图片");
  //      return;
  //  }
  //  else 
   //     if(!/\.(gif|jpg|jpeg|png|GIF|JPG|PNG)$/.test(f))
  //  {
  //    alert("图片类型必须是.gif,jpeg,jpg,png")
  //    return;
  //  }else{
		var real =jQuery("#imgfile");// BMP、JPG、JPEG、PNG、GIF
		 
			var cloned = real.clone(true);
			real.hide();
			cloned.insertAfter(real);
			jQuery("#form_up").empty();
			real.appendTo("#form_up");
			if('<%=StringUtil.deNull(car_id)%>'!=""){
			var okF = function(){
				jQuery("#form_up").submit(); 
				}
				 var p={
					headerText:'提示',
					okName:'确认',
				    okFunction:okF,
				    cancelName:'取消'
				};
			alert('点击确定,以前照片将会丢失.',p);
			}else{
				jQuery("#form_up").submit(); 
			}
//	    }
}
/*
 * 说明：文件上传后事件 参数：无 返回值：无 作者：jichang.long
 */
function optResult(bSucceed, path, oldname) {  
	if(bSucceed){
		filePath=path;
	}
	// alert(oldname);
}
var loginUserName = '<%=loginUserName%>';
var user_id = '<%=userid%>';

/**
 * 保存车辆申请基本信息--saveinfo
 */
var saveinfo = function(){
	//if(jQuery("#sshowimg").val()==""){
	//	alert("请选择图片！");
	//	return;
	//}else{
		savePicThenInfo();
	//}
}

var savePicThenInfo=function(){
	if('<%=StringUtil.deNull(car_id)%>'!=""){
		  jQuery("#action").val("update");
	}else{
		  jQuery("#action").val("save");
	}
		jQuery("#form1").attr("target","hiddenFrame");
		jQuery("#form1").submit();
	
}
/**
 * 选择用户
 */
function chooseUser() {
	  var s = new jQuery.z_tree_leftRigth();
	  s.treeID='button_envelop_username';
	  s.isShowSeacher=true;
	  s.treeName="选取人员";
	  s.headerName="选取人员";
	  s.titelText = "选择人员";
	  s.rightHeaderText="已添加人员";
	  s.returnFunction=function(orgObj){
		  if (!IsSpace(orgObj)) {
				jQuery('#driver_id').val(orgObj.ps.id);
				jQuery('#driver').val(orgObj.ps.name);
			}else{
				jQuery('#driver_id').val("");
				jQuery('#driver').val("");
			}
	  }
	  s.treeList=
			  [{
				  'leftHeaderText':'按人员选择',
				  valueKey:'ps',
				  selectedIds:jQuery('#userId').val(),
				  type:'APERSON'	
		}];
	  s.init();
}
	
/* 
 * 返回 
 */
function back(){
	 var url = "<%=path%>/ccapp/xtbg/yimingju/carmanage/jsp/carRecordList.jsp";
	 /*location.href = url; */
	var okF = function(){
		removeWindows('<%=subid%>',true);
		location.href = url;
		}
		 var p={
			headerText:'提示',
			okName:'确认',
		    okFunction:okF,
		    cancelName:'取消'
		};
	alert('返回该页,未保存的信息将会丢失 '+'<br>'+'确定返回？',p);
}
/* 
 * 保存---返回 
 */
function saveBack(){
	var url = "<%=path%>/ccapp/xtbg/yimingju/carmanage/jsp/carRecordList.jsp";
	location.href = url;
}
function viewmypic(a) {
	//document.form1.sshowimg.value = document.form1.imgfile.value;
	jQuery("#sshowimg").val(jQuery("#imgfile").val());
   var str = a.value;
	//str=str.substring(str.lastIndexOf(".")+1);
   if(/\.(gif|jpg|jpeg|png|GIF|JPG|PNG)$/.test(str))
   {
		var Preview = document.getElementById("Preview");         
		jQuery('#showimg').hide();
		jQuery('#csimg').hide();
		Preview.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = a.value; 
		Preview.style.width = "200px";             
		Preview.style.height = "240px";
   }
   savePic();
}

</script>
<body style="overflow-y: hidden;"  onload="adaptationWH('_top','vcenter',45);"><!-- 
<form id="form2" name="form2" action="uploadimage.jsp?attachment_ids=<%=attachment_id %>" class="formular" method="post" enctype="multipart/form-data">
	<input type="text"" name="attachment_ids" value="<%=attachment_id%>" /> 
	<input type="file" id="imgfile1" name="imgfile1" style="display: none;">
</form>
 -->
<form id="form1" name="form1" action="carmanagecarsaveform.jsp" class="formular" method="post">
<input type="hidden" name="unit_name" id="unit_name" value='<%=StringUtil.deNull(carManageCarBean.getUnit_name())%>'/>
<input type="hidden" name="unit_id" id="unit_id" value='<%=StringUtil.deNull(carManageCarBean.getUnit_id())%>'/>
<div class="content_02" style="overflow: hidden;" scrolling="yes"  id="_top">
		<!-- 操作-->
		<div class="content_02_top" style="margin-bottom: 10px;"
				id='content_02_top'>
		<input id="savebtn" name="savebtn" type="button" class="but_y_01" onclick="saveinfo();" value="保存" />
		<input id="backbtn" name="backbtn" type="button" class="but_y_01" onclick="back();" value="返回" />
		</div>
 </div>
 
 <!-- ---表格------->
 <div id="vcenter" style="float: left; width: 100%;">
 <div style="float: left; width: 775px; ">
 		<!--------------车辆信息-------------->
 <div class="content_02_box_div">
				<div class="content_02_box_title_bg">
					<span>车辆信息</span>
				</div>                                           
		<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table">
			<tr>
				<th class="content_02_box_div_table_th"><span class="color_red">*</span>车牌号：</th>
				<td class="content_02_box_div_table_td">
				<input class="validate[required,maxSize[15]] input_title_text" style="width: 55%;" onclick=""
					id="car_num" name="car_num" value="<%=StringUtil.deNull(carManageCarBean.getCar_num()) %>"></input>
				</td>
				<td rowspan="8" width="25%" class="content_02_box_div_table_td">
					<%if(cb.getImage_parth()!=null){
					%>
					<img alt="车辆照片" id="showimg"  width="200px" height="240px" src="../../../../../<%=cb.getImage_parth()%>">
					<div id="Preview" style="filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale);">
					</div>
					<input id="sshowimg" style="display:none;" value="<%=cb.getImage_parth()%>"/>
					<%}else{%>
					<div id="Preview" style="filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale);">
					</div>
					<img  width="200px" id="csimg" height="240px" height="220" src="../image/u=2193430612,633948572&fm=11&gp=0.jpg">
					<input id="sshowimg" style="display:none;" value=""/>
					<%} %>
				</td>
			</tr>
			<tr>
				<th class="content_02_box_div_table_th"><span class="color_red">*</span>购买日期：</th>
				<td class="content_02_box_div_table_td">
				<input type="text" value="<%=StringUtil.deNull(carManageCarBean.getBuy_time()) %>"
					class="validate[required] date_187" id="buy_time" name="buy_time"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})" />
				</td>
			</tr>
			
			<tr>
				<th class="content_02_box_div_table_th"><span class="color_red">*</span>品牌：</th>
				<td class="content_02_box_div_table_td">
				<input class="validate[required,maxSize[15]] input_title_text" style="width: 55%;"
					id="car_brand" name="car_brand" value="<%=StringUtil.deNull(carManageCarBean.getCar_brand()) %>"></input>
				</td>
			</tr>
			
			<tr>
				<th class="content_02_box_div_table_th"><span class="color_red">*</span>型号：</th>
				<td class="content_02_box_div_table_td">
				<input class="validate[required,maxSize[15]] input_title_text" style="width: 55%;"
					id="car_type" name="car_type" value="<%=StringUtil.deNull(carManageCarBean.getCar_type()) %>"></input>
				</td>
			</tr>
			
			<tr>
				<th class="content_02_box_div_table_th"><span class="color_red">*</span>颜色：</th>
				<td class="content_02_box_div_table_td">
				<input class="validate[required,maxSize[25]] input_title_text" style="width: 55%;"
					id="color" name="color" value="<%=StringUtil.deNull(carManageCarBean.getColor()) %>"></input>
				</td>
			</tr>
			
			<tr>
				<th class="content_02_box_div_table_th"><span class="color_red">*</span>购买价格：</th>
				<td class="content_02_box_div_table_td">
				<input  width="60px;"   style="border: 0 none" class="validate[required,custom[number],maxSize[10]]" maxlength="8"
					id="buy_money" name="buy_money" value="<%=StringUtil.deNull(carManageCarBean.getBuy_money()) %>"></input>&nbsp;元
				</td>
			</tr>
			
			<tr>
				<th class="content_02_box_div_table_th">车架号：</th>
				<td class="content_02_box_div_table_td">
				<input class="validate[maxSize[25]] input_title_text" style="width: 55%;"
					id="card" name="card" value="<%=StringUtil.deNull(carManageCarBean.getCard()) %>"></input>
				</td>
			</tr>
			
			<tr>
				<th class="content_02_box_div_table_th">发动机号：</th>
				<td class="content_02_box_div_table_td">
				
				<input class="validate[maxSize[25]] input_title_text" style="width: 55%;"
					id="fdj_num" name="fdj_num" value="<%=StringUtil.deNull(carManageCarBean.getFdj_num()) %>"></input>
				</td>
			</tr>
			
			<tr>
				<th class="content_02_box_div_table_th"><span class="color_red">*</span>司机：</th>
				<td class="content_02_box_div_table_td" nowrap="nowrap">
				<input onmouseover="this.title=this.value"  class="validate[required,maxSize[500]] input_150" style="width: 300px;border:0px" 
					id="driver" name="driver" value="<%=StringUtil.deNull(carManageCarBean.getDriver()) %>"  readOnly onclick='chooseUser()'></input>
				<!--  <input onmouseover="this.title=this.value" class="validate[required,maxSize[250]]" style="width:400px; height:24px; border:1px solid #C6C6C6; font:12px/24px ; display:block;overflow:hidden;  float:left; padding:0px 0px; display:inline;"
					id="driver" name="driver" value="<%=StringUtil.deNull(carManageCarBean.getDriver()) %>" ></input>-->
				<input name="" type="button" value="" class="but_x" onclick="chooseUser()" />
				<input name="driver_id" id="driver_id" value="<%=StringUtil.deNull(carManageCarBean.getDriver_id()) %>" type="hidden" />
				</td>
			</tr>
			<tr>
				<th class="content_02_box_div_table_th">照片上传：</th>
				<td class="content_02_box_div_table_td">
					<input type="file" id="imgfile" name="imgfile" onchange="viewmypic(this)" class="input_188">
					<!-- <input type="button"   id="btn_uploadfile" value="上 传" class="but_y_01">
				 		-->
				 </td>
			</tr>
			<tr>
				<th class="content_02_box_div_table_th">备注：</th>
				<td class="content_02_box_div_table_td">
				<textarea  class="validate[maxSize[250]] textarea_575" cols="3" style="width: 100%;"
					id="remark" name="remark"><%=StringUtil.deNull(carManageCarBean.getRemark()) %></textarea>
				</td>
			</tr>
		</table>
	</div>
	</div>
</div>
<input id="baseinfoJson" name="baseinfoJson" type="hidden" value="" />
<input id="action" name="action" type="hidden" value="" />
<input type="hidden" name="buessid" id="buessid" value="<%=attachment_id%>">
<input type="hidden" name="attachment_id" value="<%=attachment_id%>" /> 
<input id="car_id" name="car_id" type="hidden" value="<%=StringUtil.deNull(carManageCarBean.getCar_id()) %>" />
</form>
<form action="uploadimage.jsp?attachment_ids=<%=attachment_id %>" target="hiddenFrame" method="post" enctype="multipart/form-data" name="form_up" id="form_up">
	</form>
<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>