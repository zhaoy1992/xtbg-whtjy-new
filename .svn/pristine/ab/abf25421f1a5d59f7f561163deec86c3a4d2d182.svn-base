<%@page import="com.chinacreator.business.common.tools.CacheCommonManage"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.pub.directory.entity.DirectoryBean"%>
<%@page
	import="com.chinacreator.xtbg.pub.directory.service.impl.DirectoryServiceImpl"%>
<%@page import="com.chinacreator.xtbg.pub.directory.service.DirectoryServiceIfc"%>
<%@ page contentType="text/html; charset=utf-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.pub.tree.dao.ResourceConfigDao"%>
<%@page import="com.chinacreator.xtbg.pub.tree.dao.impl.ResouceConfigDaoImpl"%>
<%@page import="com.chinacreator.xtbg.pub.tree.entity.ResourceRoleUserBean"%><html>
<head>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String urls = request.getParameter("urls");
	String orgid = request.getParameter("orgid");
	String typeid = request.getParameter("typeid");
	String wId=request.getParameter("widowsid");
	String userid = accesscontroler.getUserID();
	String department = "";
	String departmentid = "";
	
	ResourceConfigDao resourceRoleConfigDao = new ResouceConfigDaoImpl();
	if(!StringUtil.nullOrBlank(orgid)){
		ResourceRoleUserBean rruBean = resourceRoleConfigDao.queryParentOrg(orgid);
		
		department = rruBean.getOrgname();
		departmentid = rruBean.getOrgid();
	}
	String orgname = DaoUtil.SqlToField("select org_name from td_sm_organization where org_id = '"+orgid+"'");
	DirectoryServiceIfc directoryServiceIfc = new DirectoryServiceImpl();
	DirectoryBean directoryBean = new DirectoryBean();
	if (!StringUtil.isBlank(typeid)) {
		directoryBean = directoryServiceIfc.getTypeBeanById(typeid.trim(),"manage");
	}
	String path = request.getContextPath();
	String theRootOrgid = DaoUtil.SqlToField("select org_id from td_sm_organization where parent_id='0'");
	//当前系统使用地点
	String userArea=CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");
	//当前用户的id，用户名，真实姓名
	String userId = accesscontroler.getUserID();
	String userName = accesscontroler.getUserAccount();
	String userRealName = accesscontroler.getUserName();
	String currentUserName = userRealName;
	String currentUserId = userId;
	
%>
<title>JGRID</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入my97时间控件 -->
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
	
<!-- 引入formvValidatetion -->
<link rel="stylesheet" href="../../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="UTF-8"></script>

<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<!-- 公共部分引用结束 -->

<script type="text/javascript">
jQuery(document).ready(function() {
	// binds form submission and fields to the validation engine
	jQuery("#form1").validationEngine();
});
$(function() {

	if('<%=urls%>'=='have'){
		$("#sel").hide();
		$("#directorystate").hide();
		$("#directorystatetd").html("");
	}
	$("#directorystate").val('<%=StringUtil.deNull(directoryBean.getDirectorystate())%>');
	$("#directorysex").val('<%=StringUtil.deNull(directoryBean.getDirectorysex())%>');
	$("#education").val('<%=StringUtil.deNull(directoryBean.getEducation())%>');
	$("#politics").val('<%=StringUtil.deNull(directoryBean.getPolitics())%>');
	$("#degree").val('<%=StringUtil.deNull(directoryBean.getDegree())%>');
	showElement();
});

/* 根据使用地点显示相应控件 */
function showElement(){
	var areaCode="<%=userArea%>";
	var selectHtml="<select class='select_188_box'  style='width: 180px;' id='directorylevel'>"+
		"<option value=''>--请选择--</option>"+
		"<option value='副厅级'>副厅级</option>"+
		"<option value='正处级'>正处级</option>"+
		"<option value='副处级'>副处级</option>"+
		"<option value='正科级'>正科级</option>"+
		"<option value='副科级'>副科级</option>"+
		"<option value='科员'>科员</option>"+
		"<option value='其他'>其他</option>"+
	    "</select>";
	var radioHtml="<input type='radio' value='是' name='department'>是"+	
				  "<input type='radio' value='否' name='department' checked='checked'>否";    
	if("431003"==areaCode) {
		$("#level").html(selectHtml);
		if(<%=!StringUtil.isBlank(directoryBean.getDirectorylevel())%>){
			//alert(222)
			$("#directorylevel").val("<%=directoryBean.getDirectorylevel()%>");
			$("#directorylevel").addClass("validate[required]");
		}
		$("#office").html("<span class='red'>*</span>所属单位党政一把手");
		$("#officeName").html(radioHtml);
		if(<%=!StringUtil.isBlank(directoryBean.getDepartment())%>){
			//alert(11)
			if("是"=="<%=directoryBean.getDepartment()%>"){
				//alert(333)
				$("[name=department][value=否]").removeAttr("checked");
				$("[name=department][value=是]").attr("checked","checked");
				
			}else{
				$("[name=department][value=是]").removeAttr("checked");
				$("[name=department][value=否]").attr("checked","checked");
			} 
		}
	}   
	
}
/*
函数:  Ok
说明:  提交添加与修改名录管理
参数:   无
返回值: 无
*/
function Ok() {
	var paramjosn = "";
	if (IsSpace($("#directoryid").val())) { //修改
		$("#action").val("add");
	} else {
		$("#action").val("update");
	}

	var departmentStr = $("#department").val();
	if("431003"=='<%=userArea%>') {
		departmentStr = $("[name=department][checked=checked]").val();
	}
	//alert($("[name=department][checked=checked]").val())
	paramjosn = "{'directoryid':'" + $("#directoryid").val() + "','directoryname':'" + $("#directoryname").val() + "',"+
	"'directoryyear':'" + $("#directoryyear").val() + "',"+
	"'directorysex':'" + $("#directorysex").val() + "',"+
	"'directorystate':'" + $("#directorystate").val() + "',"+
	"'education':'" + $("#education").val() + "',"+
	"'degree':'" + $("#degree").val() + "','seniority':'',"+
	"'school':'" + $("#school").val() + "','nation':'" + $("#nation").val() + "',"+
	"'politics':'" + $("#politics").val() + "','natives':'" + $("#natives").val() + "',"+
	"'specialty':'','mobile':'" + $("#mobile").val() + "',"+
	"'homeadress':'" + $("#homeadress").val() + "','workphone':'" + $("#workphone").val() + "',"+
	"'workadress':'" + $("#workadress").val() + "','homephone':'" + $("#homephone").val() + "',"+
	"'email':'" + $("#email").val() + "','duty':'" + $("#duty").val() + "',"+
	"'resume':'" + $("#resume").val() + "','orgid':'<%=orgid %>',"+
	"'directorylevel':'" + $("#directorylevel").val() + "',"+
	"'idnumber':'" + $("#idnumber").val() + "','worktime':'" + $("#worktime").val() + "',"+
	"'joinparttime':'" + $("#joinparttime").val() + "','post':'" + $("#post").val() + "',"+
	"'orgname':'" + $("#orgname").val() + "','duties':'" + $("#duties").val() + "',"+
	"'department':'"+departmentStr+"','directory_sn':'" + $("#directory_sn").val() + "','deptName':'"+$("#deptname").val()+ "','deptId':'"+$("#deptid").val()+ "','mobile2':'"+$("#mobile2").val()+"'}";
	
	$("#paramjosn").val(escape(paramjosn));
	$("#form1").attr("target","hiddenFrame");
	$("#form1").submit();
}

/*
函数:  validateAddRoom
说明:  校验电话号码是否正确
参数:   无
返回值: 无
*/
function validateMobile(id){
	var mobile = document.getElementById(id).value;
	if(!isEleNull(id)){
		var pattern=/(^0{0,1}1[3|4|5|6|7|8|9][0-9]{9}$)/; 
		if(!pattern.test(mobile)) 
		{ 
			alert("提示:请输入正确11位有效的手机号码!");
			return false; 
		}
	}
	return true;
}

/*
 * 方法说明：某个元素的值是否为空 参数： 返回：true or false
 */
function isEleNull(id){
	var eleValue = document.getElementById(id).value;
	if(eleValue.replace(/(^\s*)|(\s*$)/,"") == ""){
		return true;
	}
	return false;
}

/* 
 * 关闭 *
 */
function closed(){
	var url = "<%=path%>/ccapp/xtbg/public/directory/jsp/directorylist.jsp?orgid=<%=orgid%>";
	
	var okF = function(){
		<%-- removeWindows('<%=request.getParameter("widowsid")%>') --%>
		location.href = url;
		}
		var p={
				headerText:'提示',
				okName:'确认',
		        okFunction:okF,
		        cancelName:'取消'
		};
		
	alert('关闭该页,未保存的信息将会丢失 '+'<br>'+'确定返回？',p);
}
function saveBack(){
	var url = "<%=path%>/ccapp/xtbg/public/directory/jsp/directorylist.jsp?orgid=<%=orgid%>";
	location.href = url;
}

var chooseOrg = function (objId,objName){
	 
	var s = new $.z_tree();
	  s.treeID='mian';
	  s.treetypestr="radio";
	  s.isShowSeacher=true;
	  s.treeName="选取单位";
	  s.isType='dept';
	  s.headerName="选取单位";
	  s.item_id = 'org_id';
	  s.selectedIds=$('#'+objId).val();
	  s.type='{"type":"5"}';
	 
	  s.returnFunction=function(orgObj){
		
		$('#'+objId).val(orgObj.id);
		$('#'+objName).val(orgObj.name);
	  }
    
     s.init();
}

var chooseDept = function (objId,objName){
	 
	var s = new $.z_tree();
	  s.treeID='mian';
	  s.isShowSeacher=true;
	  s.treeName="选取单位";
	  s.isType='dept';
	  s.headerName="选取单位";
	  s.item_id = 'org_id';
	  s.selectedIds=$('#'+objId).val();
	  s.type='{"type":"5"}';
	 
	  s.returnFunction=function(orgObj){
		$('#'+objId).val(orgObj.id);
		$('#'+objName).val(orgObj.name);
	  }
    
     s.init();
}

function resetform(){
	$(":input",".content_02_box_div_table").not("#orgname,#orgid,#department").val("");
}

window.onload = function () {
	setDataTimeClickShowOrHide('joinparttime',window);
	setDataTimeClickShowOrHide('worktime',window);
	setDataTimeClickShowOrHide('directoryyear',window);
	
	adaptationWH("_top","vcenter");
}
</script>
</head>
<body style="overflow-y:hidden;">
	<form id="form1" action="addorupdatedirectorydo.jsp" method="post" class="formular">
		<input type="hidden" name="directoryid" id="directoryid"
			value="<%=StringUtil.deNull(directoryBean.getDirectoryid())%>">
		<input type="hidden" name="orgid" id="orgid"
			value="<%=StringUtil.nullOrBlank(directoryBean.getOrgid())?orgid:directoryBean.getOrgid()%>">
		<!-- <input type="hidden" name="orgname" id="orgname"
			value="<%=StringUtil.deNull(directoryBean.getOrgname())%>"> -->
		<input type="hidden" name="duties" id="duties"
			value="<%=StringUtil.deNull(directoryBean.getDuties())%>">
		<input type="hidden" name="paramjosn" id="paramjosn"> <input
			type="hidden" name="action" id="action">
		<input type="hidden" name="widowsid" id="widowsid"
			value="<%=StringUtil.deNull(request.getParameter("widowsid"))%>">
<!-- 操作按钮  -->
<div style="overflow: hidden;">
	<div class="content_02_top"  id="_top">
		<div class="content_02_top"  id='content_02_top'>
			<input class="but_y_01" type="button" id="sel"  value="保存" onclick="Ok()"/>
			<input class="but_y_01" type="reset" id="resert" value="返回" onclick="saveBack()"/>
		</div>
	</div>		
</div>		
	<!-- 表格  -->
<div id="vcenter" style="float:left; width:100%; overflow:scroll" scrolling="yes">


<div style="float: left; width: 775px; ">	
<div class="content_02_box">
	<table class="content_02_box_div_table">
      <tr>
        <td class="content_02_box_title_bg">基本资料</td>
         </tr>
    </table>
    
    <div class="content_02_box_div">
	<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table" >
			<tr>
				<th class="content_02_box_div_table_th" >身份证：</th>
				<td class="content_02_box_div_table_td" width="180px;" >
				<input class="validate[checkidcard,maxSize[18]] input_188" style="width: 180px;"  type="text" name="idnumber"
					id="idnumber"
					value="<%=StringUtil.deNull(directoryBean.getIdnumber())%>"></td>
					
				<th class="content_02_box_div_table_th"><span class="color_red" >*</span>姓名：</th>
				<td class="content_02_box_div_table_td" width="180px;">
				<input class="validate[required,maxSize[16]] input_188" style="width: 180px;" type="text" name="directoryname"
					id="directoryname"
					value="<%=StringUtil.deNull(directoryBean.getDirectoryname())%>"></td>
			</tr>
			
			<tr>
				<th class="content_02_box_div_table_th">性别：</th>
				<td class="content_02_box_div_table_td" width="180px;" >
				<select id='directorysex' name='directorysex' onchange='' class="select_188_box" style="width: 180px;">
				<option value='男'>男</option>
				<option value='女'>女</option>
				</select></td>
				<th class="content_02_box_div_table_th">出生年月：</th>
				<td class="content_02_box_div_table_td"  width="180px;">
				<input class="date_187" style="width: 180px;" readonly="readonly" type="text" name="directoryyear"
					id="directoryyear" onclick="WdatePicker()"
					value="<%=StringUtil.deNull(directoryBean.getDirectoryyear())%>"></td>
			</tr>
			
			<tr>
				<th class="content_02_box_div_table_th">民族：</th>
				<td class="content_02_box_div_table_td" width="180px;" >
				<input class="validate[maxSize[16]] input_188" style="width: 180px;" type="text" name="nation"
					id="nation"
					value="<%=StringUtil.deNull(directoryBean.getNation())%>">				</td>
				<th class="content_02_box_div_table_th">籍贯：</th>
				<td class="content_02_box_div_table_td"  width="180px;">
				<input class="validate[maxSize[16]] input_188" style="width: 180px;" type="text" name="natives"
					id="natives"
					value="<%=StringUtil.deNull(directoryBean.getNatives())%>">				</td>
			</tr>
			<tr>
				<th class="content_02_box_div_table_th">政治面貌：</th>
				<td class="content_02_box_div_table_td" width="180px;" >
				<select id='politics' name='politics' class="select_188_box" style="width: 180px;">
					<option value=''>--请选择--</option>
					<option value='1'>中共党员</option>
					<option value='2'>中共预备党员</option>
					<option value='3'>共青团员</option>
					<option value='4'>民革党员</option>
					<option value='5'>民盟盟员</option>
					<option value='6'>民建会员</option>
					<option value='7'>民进会员</option>
					<option value='8'>农工党党员</option>
					<option value='9'>致公党党员</option>
					<option value='10'>九三学社社员</option>
					<option value='11'>台盟盟员</option>
					<option value='12'>无党派民主人士</option>
					<option value='13'>群众</option>
				</select></td>
				<th class="content_02_box_div_table_th" >职务：</th>
				<td class="content_02_box_div_table_td"  width="180px;">
				<input class="validate[maxSize[50]] input_188" style="width: 180px;" type="text" name="post"
					id="post"
					value="<%=StringUtil.deNull(directoryBean.getPost())%>">				</td>
			</tr>
			<tr>
				<th class="content_02_box_div_table_th"><span class="color_red">*</span>所属单位：</th>
				<td class="content_02_box_div_table_td" width="180px;" >
				<input type="hidden" name="orgid" id="org_id" value="<%=StringUtil.nullOrBlank(directoryBean.getOrgname())?departmentid:directoryBean.getOrgid()%>" />
				<input class="validate[required,maxSize[50]] xz_187" style="width: 180px;" type="text" name="orgname"
					id="orgname" size=13 onclick="chooseOrg('org_id','orgname')" readonly="readonly"
					value="<%=StringUtil.nullOrBlank(directoryBean.getOrgname())?department:directoryBean.getOrgname()%>">
				</td>
				
				<th class="content_02_box_div_table_th" id="office">所在科室：</th>
				<td class="content_02_box_div_table_td"  width="180px;" id="officeName">
				<input class="validate[maxSize[50]] input_188" style="width: 180px;"  type="text" name="department"
					id="department" 
					value="<%=StringUtil.nullOrBlank(directoryBean.getDepartment())?orgname:directoryBean.getDepartment()%>">
				
			   </td>
			</tr>
			<tr>
				<th class="content_02_box_div_table_th">兼职单位：</th>
				<td class="content_02_box_div_table_td" colspan="3" >
				<input type="hidden" name="deptid" id="deptid" value="<%=StringUtil.nullOrBlank(directoryBean.getDeptId())?"":directoryBean.getDeptId()%>" />
				<input class="xz_187" style="width: 100%;" type="text" name="deptname"
					id="deptname" size=13 onclick="chooseDept('deptid','deptname')" readonly="readonly"
					value="<%=StringUtil.nullOrBlank(directoryBean.getDeptName())?"":directoryBean.getDeptName()%>">
				</td>
			</tr>
			<tr>
				<th class="content_02_box_div_table_th" >级别：</th>
				<td class="content_02_box_div_table_td"  width="180px;" id="level">
				<input class="validate[maxSize[16]] input_188" style="width: 180px;" type="text" name="directorylevel"
					id="directorylevel"
					value="<%=StringUtil.deNull(directoryBean.getDirectorylevel())%>">
									</td>
				<th class="content_02_box_div_table_th" >学历：</th>
				<td class="content_02_box_div_table_td"  width="180px;">
				<select id='education' name='education' style="width: 180px;" class="select_188_box" style="width: 188px;">
					<option value=''>--请选择--</option>
					<option value='phd'>研究生</option>
					<option value='undergraduate'>本科</option>
					<option value='specialist'>专科</option>
					<option value='highschool'>高中</option>
					<option value='secondary'>中专</option>
					<option value='juniorhighschool'>初中</option>
					<option value='primaryschool'>小学</option>
					<option value='other'>其他</option>
				</select>
				</td>
			</tr>
			<tr>
				<th class="content_02_box_div_table_th" >毕业院校：</th>
				<td class="content_02_box_div_table_td"   >
				<input class="validate[maxSize[50]] input_188" style="width: 180px;" type="text" name="school"
					id="school"
					value="<%=StringUtil.deNull(directoryBean.getSchool())%>">				</td>
				<th class="content_02_box_div_table_th" >参加工作时间：</th>
				<td class="content_02_box_div_table_td"   width="180px;">
				<input class="date_187" readonly="readonly" style="width: 180px;"  type="text" name="worktime"
					id="worktime" onclick="WdatePicker()"
					value="<%=StringUtil.deNull(directoryBean.getWorktime())%>">				</td>
			</tr>
			<tr>
				<th class="content_02_box_div_table_th" >入党时间：</th>
				<td class="content_02_box_div_table_td"  width="180px;" >
				<input class="date_187" readonly="readonly" style="width: 180px;" type="text" name="joinparttime"
					id="joinparttime" onclick="WdatePicker()"
					value="<%=StringUtil.deNull(directoryBean.getJoinparttime())%>">				</td>
				<th class="content_02_box_div_table_th" >学位：</th>
				<td class="content_02_box_div_table_td"  width="180px;" >
					<select id='degree' name='degree' class="select_188_box" style="width: 180px;">
						<option value=''>--请选择--</option>
						<option value='xueshi'>学士</option>
						<option value='shoushi'>硕士</option>
						<option value='boshi'>博士</option>
					</select>
				</td>
			</tr>
			<tr id="directorystatetd">
				<th class="content_02_box_div_table_th"  >在职状态：</th>
				<td class="content_02_box_div_table_td"  width="180px;" >
				<select id='directorystate' name='directorystate' class="select_188_box" style="width: 180px;">
					<option value=''>--请选择--</option>
					<option value='jobing'>在职</option>
					<option value='departure'>离职</option>
					<option value='retirement'>退休</option>
				</select>
				</td>
				<th class="content_02_box_div_table_th" >排序：</th>
				<td class="content_02_box_div_table_td"  width="180px;" >
				<input class="validate[custom[positiveinteger]] input_188" style="width: 180px;" type="text" name="directory_sn"
					id="directory_sn"
					value="<%=StringUtil.deNull(directoryBean.getDirectory_sn())%>"></td>
			</tr>
	</table>
	</div>
	</div>
	
	<div class="content_02_box">
	<table class="content_02_box_div_table">
	      <tr>
	        <td class="content_02_box_title_bg">联系方式</td>
	         </tr>
	    </table>
	    
	   <div class="content_02_box_div">
		<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table" >
			<tr>
				<th class="content_02_box_div_table_th"  >办公手机：</th>
				<td class="content_02_box_div_table_td" >
				<input class="validate[custom[phone]],validate[maxSize[16]]] input_188" type="text" name="mobile"
					id="mobile"
					value="<%=StringUtil.deNull(directoryBean.getMobile())%>">				</td>
				<th class="content_02_box_div_table_th"  >常用手机：</th>
				<td class="content_02_box_div_table_td" >
				<input class="validate[maxSize[16],custom[phone]] input_188"  type="text" name="mobile2"
					id="mobile2" 
					value="<%=StringUtil.deNull(directoryBean.getMobile2())%>">				</td>
			</tr>
			<tr>
				<th class="content_02_box_div_table_th"  >办公地址：</th>
				<td class="content_02_box_div_table_td" >
				<input class="validate[maxSize[50]] input_188"  type="text" name="workadress"
					id="workadress"
					value="<%=StringUtil.deNull(directoryBean.getWorkadress())%>">				</td>
				<th class="content_02_box_div_table_th"  >办公电话：</th>
				<td class="content_02_box_div_table_td"  >
				<input class="validate[maxSize[16]] input_188"  type="text" name="workphone"
					id="workphone"
					value="<%=StringUtil.deNull(directoryBean.getWorkphone())%>">				</td>
				
			</tr>
			<tr>
				<th class="content_02_box_div_table_th"  >住宅地址：</th>
				<td class="content_02_box_div_table_td"  >
				<input class="validate[maxSize[50]] input_188"  type="text" name="homeadress"
					id="homeadress"
					value="<%=StringUtil.deNull(directoryBean.getHomeadress())%>">				</td>
				<th class="content_02_box_div_table_th"  >住宅电话：</th>
				<td class="content_02_box_div_table_td" >
				<input class="validate[maxSize[16]] input_188"  type="text" name="homephone"
					id="homephone"
					value="<%=StringUtil.deNull(directoryBean.getHomephone())%>">				</td>
				
			</tr>
			<tr>
				<th class="content_02_box_div_table_th"  >电子邮箱：</th>
				<td class="content_02_box_div_table_td"  >
				<input class="validate[maxSize[50],custom[email]] input_188" type="text" name="email"
					id="email"
					value="<%=StringUtil.deNull(directoryBean.getEmail())%>">				</td>
				<th class="content_02_box_div_table_th"></th>
				<td class="content_02_box_div_table_td"></td>
			</tr>
			
			<tr>
				<th class="content_02_box_div_table_th" colspan="1">工作职责：</th>
				<td colspan="3" class="content_02_box_div_table_td" >
					<textarea class="validate[maxSize[500]] textarea_575" cols="3" style="width: 99%;"  name="duty" id="duty"><%=StringUtil.deNull(directoryBean.getDuty())%></textarea></td>
			
			<tr>
				<th class="content_02_box_div_table_th" colspan="1">个人履历：</th>
				<td colspan="3" class="content_02_box_div_table_td">
					<textarea class="validate[maxSize[500]] textarea_575" cols="3" style="width: 99%;"  name="resume" id="resume"><%=StringUtil.deNull(directoryBean.getResume())%></textarea></td>
			</tr>
		</table>
		</div>
		</div>	
		</div>
		</div>
	</form>
		<iframe name="hiddenFrame" width="0" height="0"></iframe>
</body>
</html>