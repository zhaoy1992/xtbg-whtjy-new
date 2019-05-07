<%--
描述：车辆司机详细信息页面
作者：童佳
版本：1.0
日期：2013-10-24
--%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.entity.DriverBean"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.service.impl.CarDrivaerServiceImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.service.CarDriverService"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.service.DriverSort"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.xtbg.pub.util.*"%>
<%@page import="java.util.*"%>
<%@page import ="java.text.SimpleDateFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
    AccessControl accesscontroler = AccessControl.getAccessControl();
    accesscontroler.checkAccess(request,response);
	String path = request.getContextPath();
	String subid=request.getParameter("subid");
	String driver_id=request.getParameter("driver_id");
	String annexid = new Date().getTime() + "";//附件ID
	
	
	CarDriverService carDriverService = new CarDrivaerServiceImpl();
	DriverBean driverBean = new DriverBean();
	List<DriverBean> list = new ArrayList<DriverBean>();
	if(!StringUtil.isBlank(driver_id)){
		list = carDriverService.findDriverInfoById(driver_id);
		for(int i = 0; i < list.size(); i++){
			driverBean = list.get(i);
		}
		annexid = driverBean.getDriver_fj_id();
	}
	
	DriverSort driverSort = new DriverSort();
	List<Map<String, String>>   sortList = driverSort.getSortList();
	
	
%>
<title>车辆司机详细信息页面</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script> 
<!-- 引入jQuery UI -->
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入formvValidatetion -->
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
<!-- 引入my97时间控件 -->
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<!-- 引入上传控件 -->
<script type="text/javascript" src="../../../resources/plug/fancyupload/mootools-1.2.5-core-jm.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/fancyupload/source/Fx.ProgressBar.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/fancyupload/source/Swiff.Uploader.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/fancyupload/source/FancyUpload3.Attach.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/fancyupload/myfancyupload.js" charset="utf-8"></script>
<!-- 公共部分引用结束 -->
<script type="text/javascript">

var path='<%=path%>';
var annexid='<%=annexid%>';
var driver_id='<%=driver_id%>';

jQuery(function(){
	//附件插件
	MyFancyupload.createUpload('_fileshow', '#_filebut', path, path+'/servlet/FileUpload?buessid='+annexid, true, annexid);
	jQuery("#method").val("add");
	if(!IsSpace(jQuery("#driver_id").val())){
		jQuery("#method").val("update");
	}
	
});


/*
函数:  Ok
说明:  保存信息
参数:   无
返回值: 无
*/
var Ok = function() {
	var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
	jQuery("#driver_bz").val(jQuery("#driver_bz_text").val());
	 if(isFlag){
			var okF = function(){
				var url = "carDriverInfoDo.jsp?subid=<%=subid%>";
				document.all.form1.action = url;
				document.all.form1.target = "hiddenFrame";
				jQuery('#form1').submit();
			}
			var p={
					headerText:'提示',
					okName:'确认',
					okFunction:okF,
					cancelName:'取消'
			};
			alert('确定保存？ ',p)
	}
}


//返回
function closed(){
		var okF = function(){
			removeWindows('<%=subid%>',true);
			window.top.window.frames["_document_body_mian_firstPagerAAAS"].document.location.reload();
			//window.parent.location.reload();
			}
			 var p={
					headerText:'提示',
					okName:'确认',
			        okFunction:okF,
			        cancelName:'取消'
			};
		alert('返回该页,未保存的信息将会丢失 '+'<br>'+'确定返回？',p);
}	

/**
**可选部门
*/
function findCsdwAndPs(){
	jQuery('#driver_org_id').val("");
	jQuery('#driver_org_name').val("");
	var s = new jQuery.z_tree();
	  s.treeID='mian';
	  s.treetypestr= "radio";
	  s.isShowSeacher=true;
	  s.treeName="选取单位";
	  s.isType='dept';
	  s.headerName="选取单位";
	  s.item_id = 'org_id';
	  s.selectedIds=jQuery('#driver_org_id').val();
	  s.type='AORG';
	  s.returnFunction=function(orgObj){
		jQuery('#driver_org_id').val(orgObj.id);
		jQuery('#driver_org_name').val(orgObj.name);
	  }
	  s.init();
}

</script>
</head>
<body style="overflow-y:hidden;" onload="adaptationWH('_top','vcenter',45)">
	<form id="form1" action="" method="post" onkeydown="if(event.keyCode == 13){return false;}">
		<input type="hidden" name="driver_fj_id" id="driver_fj_id" value="<%=annexid%>" />
		<input type="hidden" name="driver_id" id="driver_id" value="<%=driver_id%>" />
		<input type="hidden" name="method" id="method" value="" />
		
		
<div  class="content_02" style="overflow:hidden;" id="_top">
   <!-- 操作-->
  <div class="content_02_top" style="margin-bottom:10px;" >
  <input  value="保存" onclick="Ok();" style="display: inline" type="button" class="but_y_01" />
   <input name="" value="返回" onclick="closed()" type="button" class="but_y_01" />
	</div>  
	 </div>
	 
	<!-- 表格-->
	<div id="vcenter" style="float:left; width:100%; overflow:scroll" scrolling="yes">
	
	
	
	<div style="float: left; width: 775px; ">
	<div class="content_02_box" >
	 <div class="content_02_box_title_bg"><span>基本信息</span></div>
	 <div class="content_02_box_div">
	   <table  border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table">
         <tr>
           <th class="content_02_box_div_table_th"><span class="color_red">*</span>姓名：</th>
           <td class="content_02_box_div_table_td" ><input type="text"  class="validate[required,maxSize[100]] input_title_text" name="driver_name" id="driver_name" value="<%=StringUtil.deNull(driverBean.getDriver_name()) %>" /></td>
           <th class="content_02_box_div_table_th"><span class="color_red">*</span>性别：</th>
           <td class="content_02_box_div_table_td" >
            <select id="driver_sex" name="driver_sex" class="validate[required]">
            <%if(!StringUtil.isBlank(driver_id)){ 
                   if("男".equals(driverBean.getDriver_sex())){
            %>
                   <option value="男" selected="selected">男</option>
                   <option value="女">女</option>
            <%     }else{ %>
                   <option value="男">男</option>
                   <option value="女" selected="selected">女</option> 
            <%       }%>        
            
            <%}else{ %>
               <option value="">--请选择--</option>
               <option value="男">男</option>
               <option value="女">女</option>
               <%} %>
            </select>
          
          </td>
         </tr>
         <tr>
           <th class="content_02_box_div_table_th"><span class="color_red">*</span>驾驶证号：</th>
           <td class="content_02_box_div_table_td" ><input type="text"  class="validate[required,maxSize[100]] input_title_text" name="driver_car_no" id="driver_car_no" value="<%=StringUtil.deNull(driverBean.getDriver_car_no()) %>" /></td>
           <th class="content_02_box_div_table_th"><span class="color_red">*</span>所属部门：</th>
           <td class="content_02_box_div_table_td" >
            <input readonly="readonly" onmouseover="this.title=this.value"
          				 type="text" class="validate[required] input_160" id="driver_org_name" name="driver_org_name" 
			 value="<%=StringUtil.deNull(driverBean.getDriver_org_name()) %>" onclick="findCsdwAndPs();"/>
			 <input name="" type="button" value="" class="but_x" onclick="findCsdwAndPs();" />
			 <input type="hidden" name="driver_org_id" id="driver_org_id" 
			 value="<%=StringUtil.deNull(driverBean.getDriver_org_id()) %>"/>
          </td>
         </tr>
         <tr>
           <th class="content_02_box_div_table_th"><span class="color_red">*</span>出生日期：</th>
           <td class="content_02_box_div_table_td" > 
           <input style="width: 100%" type="text" readonly="readonly" name="driver_ber_date" id="driver_ber_date" class="validate[required] date_187" 
								value="<%=StringUtil.deNull(driverBean.getDriver_ber_time()) %>" 
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})"/>
         </td>
           <th class="content_02_box_div_table_th"><span class="color_red">*</span>驾照类型：</th>
           <td class="content_02_box_div_table_td" >
           <select id="driver_sort_id" name="driver_sort_id" class="validate[required]">
            <%for(int i = 0; i < sortList.size(); i++ ){ 
                 Map<String,String> sortMap = new HashMap<String,String>();
                 sortMap = sortList.get(i);
                 String key = ""+(i+1);
                 if(!StringUtil.isBlank(driver_id)){
                	 if(key.equals(driverBean.getDriver_sort_id())){
            %>
            <option value="<%=key %>" selected="selected"><%=sortMap.get(key) %></option>
            <%       }else{%>
            <option value="<%=key %>"><%=sortMap.get(key) %></option>
            <%         }     %>
            <%   }else{%>
            <option value="<%=key %>"><%=sortMap.get(key) %></option>
            <%    }
            } %>
            </select>
          </td>
         </tr>
         <tr>
           <th class="content_02_box_div_table_th"><span class="color_red">*</span>身份证号：</th>
           <td class="content_02_box_div_table_td" ><input type="text"  class="validate[required,maxSize[40]] input_title_text" name="driver_no" id="driver_no" value="<%=StringUtil.deNull(driverBean.getDriver_no()) %>" /></td>
           <th class="content_02_box_div_table_th"><span class="color_red">*</span>拿照时间：</th>
           <td class="content_02_box_div_table_td" >
           <input style="width: 100%" type="text" readonly="readonly" name="driver_car_date" id="driver_car_date" class="validate[required] date_187" 
								value="<%=StringUtil.deNull(driverBean.getDriver_car_time()) %>" 
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})"/>
          </td>
         </tr>
          <tr>
           <th class="content_02_box_div_table_th">手机号码：</th>
           <td class="content_02_box_div_table_td" >
               <input type="text"  class="validate[maxSize[40]] input_title_text" name="driver_photo" id="driver_photo" value="<%=StringUtil.deNull(driverBean.getDriver_photo()) %>" /></td>
           <th class="content_02_box_div_table_th">住宅电话：</th>
           <td class="content_02_box_div_table_td" >
               <input type="text"  class="validate[maxSize[40]] input_title_text" name="driver_tel" id="driver_tel" value="<%=StringUtil.deNull(driverBean.getDriver_tel()) %>" />
          </td>
         </tr>
          <tr>
           <th class="content_02_box_div_table_th"><span style="color: red">*</span>入职时间：</th>
           <td class="content_02_box_div_table_td" >
           <input style="width: 100%" type="text" readonly="readonly" name="driver_in_date" id="driver_in_date" class="validate[required] date_187" 
								value="<%=StringUtil.deNull(driverBean.getDriver_in_time()) %>" 
								onclick="WdatePicker({maxDate:'#F{$dp.$D(\'driver_out_date\')}',dateFmt:'yyyy-MM-dd'})"/>
           </td>
           <th class="content_02_box_div_table_th">离职时间：</th>
           <td class="content_02_box_div_table_td" >
           <input style="width: 100%" type="text" readonly="readonly" name="driver_out_date" id="driver_out_date" class="validate[] date_187" 
								value="<%=StringUtil.deNull(driverBean.getDriver_out_time()) %>" 
								onclick="WdatePicker({minDate:'#F{$dp.$D(\'driver_in_date\')}',dateFmt:'yyyy-MM-dd'})"/>
          </td>
         </tr>
         <tr>
	         <th class="content_02_box_div_table_th">备注：</th>
		     <td class="content_02_box_div_table_td" colspan="3">
		         <textarea id="driver_bz_text" class="validate[maxSize[200]] textarea_576"><%=StringUtil.deNull(driverBean.getDriver_bz()) %></textarea>
		         <input type="hidden" value="" name="driver_bz" id="driver_bz" class="input_title_text"/>
		     </td>
		 </tr>
</table>
	 </div>
	</div>
	
<div class="content_02_box"  style="width:100%">
<div class="content_02_box_title_bg"  style="width:100%"><span>个人简历</span></div>
<div class="content_02_box_div"  style="width:100%">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	id="content_02_box_div_table_02"  style="width:100%">
	<tr id="fj">
		<th width="212" valign="top">简历附件：</th>
		<td width="560"><a href="#" id="_filebut">请选择文件</a></td>
	</tr>
	<tr>
		<th valign="top">附件列表：</th>
		<td>
		<ul id="_fileshow"></ul>
		&nbsp;</td>
	</tr>
</table>
</div>
</div>

</div>
</div>
</form>
	<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>