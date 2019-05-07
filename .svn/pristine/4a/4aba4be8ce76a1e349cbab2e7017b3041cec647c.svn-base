<%@page import="com.chinacreator.xtbg.pub.tree.service.impl.ResourceConfigServiceImpl"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="java.util.UUID"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.xtbg.pub.util.DictDropDownList"%>
<%@page import ="java.text.SimpleDateFormat"%>
<%@page import="com.chinacreator.xtbg.pub.tree.dao.ResourceConfigDao"%>
<%@page import="com.chinacreator.xtbg.pub.tree.dao.impl.ResouceConfigDaoImpl"%>
<%@page import="java.util.*"%>
<%@page import="java.net.InetAddress"%>
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.dao.ElectResetDao"%>
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.entity.ElectResetBean"%>
<%@page import="com.chinacreator.xtbg.pub.tree.entity.ResourceRoleUserBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
String path = request.getContextPath();
String userid=accesscontroler.getUserID();
String elect_id=request.getParameter("elect_id");
String theRootOrgid = DaoUtil.SqlToField("select org_id from td_sm_organization where parent_id='0'");
String paramjosns="";
ResourceConfigDao resourceRoleConfigDao = new ResouceConfigDaoImpl();
String subid=request.getParameter("subid");
String sql = "select i.RESET_ID, i.reset_name from SX_TA_OA_ELECTCHECK_RESETTIME i ";
ElectResetDao poeManagerDao = (ElectResetDao)DaoImplClassUtil.getDaoImplClass("electResetDaoImpls");
Map<String,String> map=new HashMap<String,String>();
Map<String,String> parammap=new HashMap<String,String>();
parammap.put("elect_id", elect_id);
map=poeManagerDao.querydetail(parammap);
String infotypeHtml="";
infotypeHtml= DictDropDownList.buildSelect(sql,"electronicreset",map.get("rest_time"),"",true,"");//信息类型下拉框
%>
<title>JGRID</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入my97时间控件 -->
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript" charset="utf-8"></script>

<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>

<!-- 引入formvValidatetion -->
<link rel="stylesheet" href="../../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>

<!-- 引入其它 -->
<script src="../../../../oa/resources/util/public.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="../../../../oa/resources/plug/ifrom/js/ifrom-min.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../../oa/resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../../oa/resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../../oa/resources/plug/ifrom/js/ifrom-ui-alert.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../../oa/resources/plug/ifrom/js/ifrom-ui-newcommonuse.js" charset="utf-8"></script>
<!-- 公共部分引用结束 -->
<script type="text/javascript">

jQuery(document).ready(function() {
	$("#electronicreset").addClass("validate[required]");
	jQuery("#form1").validationEngine();
	chekcRadio("two","<%=map.get("auto_check")%>");
	chekcRadio("one","<%=map.get("isuse")%>");
	var org="<%=map.get("orgname")%>";
	var elect_id="<%=StringUtil.deNull(elect_id)%>";
	if(""==org && ""!=elect_id){
		hideorg();
	}
	
});
//考勤设置提交方法
		function isaddorupdate(){
			if( jQuery("#form1").validationEngine("validateform")){
				
				var url = "isaddorupdate.jsp?action=save";
				var isUse = false;
				var isuse=$("input[name='one']:checked").val();//获得是否使用当前作息时间
				var stak_status=$("input[name='two']:checked").val();//获得是否支持自动考勤
				var reset_id=$('#electronicreset').val();
				$("#reset_time").val(reset_id);
				$("#isauto").val(stak_status);
				$("#isuse").val(isuse);
				
				var okF = function(){
					document.all.form1.action = url;
					document.all.form1.target = "hiddenFrame";
					$('#form1').submit();
						}
						var p={
								headerText:'提示',
								okName:'确认',
						        okFunction:okF,
						        cancelName:'取消'
						};
					alert('确定保存该信息吗？ ',p)
				}
			}
/*
 函数:  setWorkIP
 说明:  设置办公IP
 参数:   无
 返回值: 无
 */
var setWorkIP = function(){
	openAlertWindows('windowId','../../../suxian/electroniccheck/jsp/electworkiplist.jsp','办公IP列表',1000,600,'25%','25%');
}

/*
作者:  黄艺平
时间:  2013-06-19
函数:  adddeptanduser
说明:  弹出公告接收人和接收部门树
参数:   无
返回值: 无
*/
function adddeptanduser() {
	  var s = new jQuery.z_tree_leftRigth();
	  s.treeID='mianDept';
	  s.isShowSeacher="aa";
	  s.treeName="选取部门";
	  s.headerName="选取部门";
	  s.titelText = "选取部门";
	  s.rightHeaderText="已添加机构和人员";
	  s.treetypestr="radio";
	  s.returnFunction=function(orgObj){
		  if(IsSpace(orgObj.dept) || null ==orgObj.dept )
		  	{
			   jQuery('#orgid').val('');
			   jQuery('#orgname').val('');
			 }else{
				jQuery('#orgid').val(orgObj.dept.id);
				jQuery('#orgname').val(orgObj.dept.name);
			 }
	  }
	  s.treeList=
			  [{
				  leftHeaderText:'按部门选择',
				  item_id :'org_id',
				  isType:'dept', 
				  valueKey:'dept',
				  selectedIds:jQuery('#orgid').val(),
				  type:"ADEPT"
			}];
	  s.init();
}
//返回
function urlbakc(){
	window.history.back();
}
//根据value值来选择被选中的radio
function chekcRadio(name,value){
	//debugger;
	var obj=$("[name="+name+"][value="+value+"]");
	$("[name="+name+"][value="+value+"]").attr("checked","checked");
}
//隐藏单位选择
function hideorg(){
	$("#orgtitle").html("");
	$("#orgcontent").html("");
}
</script>

</head>
<body style="overflow-y:hidden;" onload="adaptationWH('_top','vcenter',50)">
    
	<form id="form1" action="" method="post">
	<input type="hidden" id="isauto" name="isauto"/>
	<input type="hidden" id="reset_time" name="reset_time"/>
	<input type="hidden" id="isuse" name="isuse"/>
	<div  class="content_02" style="overflow:hidden;">
   <!-- 操作-->
   <div class="content_02_top" style="margin-bottom:10px;" id="_top">
   <input name="fbbt" id="fbbt" value="确定" type="button" class="but_y_01" style="display: inline" onclick="isaddorupdate();" />
   <input class='but_y_01' id='workIP' type='button' onclick='setWorkIP()' value='设置办公IP' />
   <input class='but_y_01' id='uback' type='button' onclick='urlbakc()' value='返回' />
   
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
           <th class="content_02_box_div_table_th"><span class="color_red">*</span>上班时间：</th>
           <td class="content_02_box_div_table_td"><input type="text" name="start_time" id="start_time"
					class="date_187  validate[required]" type="text" value="<%=StringUtil.deNull(map.get("start_time")) %>"
							onfocus="var end_time=$dp.$('end_time');WdatePicker({onpicked:function(){end_time.focus();},dateFmt:'HH:mm'})" /></td>
           <th class="content_02_box_div_table_th"><span class="color_red">*</span>下班时间：</th>
           <td class="content_02_box_div_table_td"><input type="text"   name="end_time" id="end_time" 
					class="date_187 validate[required]"
								type="text" value="<%=StringUtil.deNull(map.get("end_time")) %>"
								onfocus="WdatePicker({minDate:'#F{$dp.$D(\'start_time\')}',dateFmt:'HH:mm'})" /> </td>
         </tr>
         <tr>
           <th class="content_02_box_div_table_th"><span class="color_red">*</span>上午下班时间：</th>
           <td class="content_02_box_div_table_td"><input type="text" name="am_end_time" id="am_end_time"
					class="date_187  validate[required]" type="text" value="<%=StringUtil.deNull(map.get("am_end_time")) %>"
							onfocus="var pm_start_time=$dp.$('pm_start_time');WdatePicker({onpicked:function(){pm_start_time.focus();},dateFmt:'HH:mm'})" /></td>
           <th class="content_02_box_div_table_th"><span class="color_red">*</span>下午上班时间：</th>
           <td class="content_02_box_div_table_td"><input type="text"   name="pm_start_time" id="pm_start_time" 
					class="date_187 validate[required]"
								type="text" value="<%=StringUtil.deNull(map.get("pm_start_time")) %>"
								onfocus="WdatePicker({minDate:'#F{$dp.$D(\'am_end_time\')}',dateFmt:'HH:mm'})" /> </td>
         </tr>
         <tr>
           <th class="content_02_box_div_table_th"><span class="color_red">*</span>作息时间：</th>
           <td class="content_02_box_div_table_td">
             <%=infotypeHtml %>
            </td>
           
           <th class="content_02_box_div_table_th"><span class="color_red">*</span>自动考勤：</th>
		      <td class="content_02_box_div_table_td">
					                <input type="radio" name="two" value="1" id="r3" checked="checked"/>
					            <font size="2px"> 支持</font> 
					                 <input type="radio" name="two" value="2" />
					            <font size="2px">不支持</font> 
		      </td>
		 </tr>
		 <tr>
		  <th class="content_02_box_div_table_th"><span class="color_red">*</span>是否启用该作息时间：</th>
		      <td class="content_02_box_div_table_td" >
					                <input type="radio" name="one" value="0" id="r3" checked="checked"/>
					            <font size="2px"> 是</font> 
					                 <input type="radio" name="one" value="1" />
					            <font size="2px">否</font> 
		      </td>
		  <th class="content_02_box_div_table_th"  id="orgtitle"><span class="color_red">*</span>选择单位：</th>
		      <td class="content_02_box_div_table_td" id="orgcontent">
	                <input type="text" name="orgname" value="<%=StringUtil.deNull(map.get("orgname")) %>" id="orgname"  onclick="adddeptanduser()" class="input_188 validate[required]"/>
	                <input type="hidden" name="orgid" value="<%=StringUtil.deNull(map.get("orgid")) %>" id="orgid" />
		      </td>
		 </tr>
       </table>
	 </div>
	 
	</div>
	

	
	
</div></div>
	</form>
	<iframe name="hiddenFrame" width=0 height=0></iframe>

</body>
</html>