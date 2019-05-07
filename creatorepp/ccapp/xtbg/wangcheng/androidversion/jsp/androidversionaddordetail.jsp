<%@page import="java.util.Date"%>
<%@page import="com.chinacreator.xtbg.wangcheng.androidversion.dao.imploracle.AndroidVersionDaoImpl"%>
<%@page import="com.chinacreator.xtbg.wangcheng.androidversion.dao.AndroidVersionDao"%>
<%@page import="com.chinacreator.xtbg.wangcheng.androidversion.entity.AndroidVersionBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@ page contentType="text/html; charset=gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String filePath = basePath + "androidversionupload/";
	String id = request.getParameter("id");
	String subid = request.getParameter("subid");
	AndroidVersionBean bean = new AndroidVersionBean();
	String currentDateTime = new Date().getTime()+"";//作为附件上传的id
	String action = "add";
	AndroidVersionDao dao = new AndroidVersionDaoImpl();
	String version_sn ="";//版本序号
	boolean isLook = true;
	if (StringUtil.isBlank(id)) {
		isLook = false;
	} else {
		bean = dao.getAndroidVersionBeanByid(id);
		currentDateTime = StringUtil.deNull(bean.getUpload_path());//得到上传的附件id
		filePath += bean.getVersion_name();
		action = "update";
		version_sn = bean.getVersion_sn();//序号
	}
	if("add".equals(StringUtil.deNull(action))){
		version_sn = String.valueOf(dao.queryMaxXuHao());
	}
%>
<title>JGRID</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script> 
<!-- 引入jQuery UI -->
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入formvValidatetion -->
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/util/HTMLUtil.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js"	type="text/javascript"></script>
<!-- 引入上传控件 -->
<script type="text/javascript" src="../../../resources/plug/fancyupload/mootools-1.2.5-core-jm.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/fancyupload/source/Fx.ProgressBar.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/fancyupload/source/Swiff.Uploader.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/fancyupload/source/FancyUpload3.Attach.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/fancyupload/myfancyupload.js" charset="utf-8"></script>
<!-- 公共部分引用结束 -->
<script type="text/javascript">
var subid = "<%=subid%>";
//选择责任人
function chooseDutyUser(){
	var s = new jQuery.z_tree();
	s.treeID = 'mian';
	s.treetypestr = 'radio';
	s.isShowSeacher = true;
	s.treeName = "选取人员";
	//s.isType='dept';
	s.headerName = "选取人员";
	s.item_id = 'org_id';
	//人员选择框存在值，则指定存在的值 
	s.selectedIds = jQuery('#duty_user_id').val();
	s.type = 'APERSON';
	s.returnFunction = function(orgObj,node){
		if(!IsSpace(orgObj)){
			jQuery('#duty_user_id').val(orgObj.id);
			jQuery('#duty_user_name').val(orgObj.name);		
			//存在父节点，则将父节点添加为相应的人员部门	
			var pNode = null;
			if (node && node[0]){
				pNode = node[0].getParentNode();
				if(pNode){
					jQuery('#duty_dept_id').val(pNode.id);
					jQuery('#duty_dept_name').val(pNode.name);
					jQuery('#duty_dept_name_span').text(pNode.name);//设置纯文本的值
				}
			}
		} else {
			jQuery('#duty_user_id').val("");
			jQuery('#duty_user_name').val("");
		}
	}
	s.init();
}
//验证界面数据完整性
function validateForm(){
	if(jQuery("#form1").validationEngine("validateform")){
		return true;
	}else{
		return false;
	}
}
/*
函数:  Ok
说明:  提交添加与修改
参数:   无
返回值: 无
*/
function Ok() {
	if(validateForm()){
		var file_li = jQuery("#_fileshow").find("li");
		if(file_li.length<=0){
			alert("请上传版本文件");
			return false;
		}
		//checkversionname();
		/**var paramjosn = "";
		alert($("#version_esn").val()+"");
		var versionContent = document.getElementById("version_content").innerHTML;
		paramjosn = "{'version_esn':'" + $("#version_esn").val() + "','upgrade_rangeid':'" + $("#upgrade_rangeid").val() + "','upgrade_rangevalue':'" + $("#upgrade_rangevalue").val()
			+ "','version_sn':'" + $("#version_sn").val()+ "','version_content':'" + versionContent + "','sql_sn':'" + $("#sql_sn").val()+ "'}";
		$("#paramjosn").val(paramjosn);
		*/
		//document.forms(0).submit();
		jQuery('#form1').submit();
	}
}

function closed(){
	if(<%=isLook%>){
		removeWindows(subid,true);
		return ;
	}
	var okF = function(){
		removeWindows(subid,true);
	}
	var p={
		headerText:'提示',
		okName:'确认',
		okFunction:okF,
		cancelName:'取消'
	};
	alert('返回该页,未保存的信息将会丢失 '+'<br>'+'确定返回？',p);
}

function checkversionname(){
	var filename = $("#upfile").val();
	var f = filename.split("\\");
	var fs = f.length;
	var versionname = f[fs-1];
	document.getElementById("versionname").value=versionname;
}


function checkData(){

	if($("#upfile").val()==null || $("#upfile").val()==""){
		alert("版本文件必须上传");
		return false;
	}else if($("#version_esn").val()==null || $("#version_esn").val()==""){
		alert("版本号不能为空");
		return false;
	}
	else if($("#version_sn").val()==null || $("#version_sn").val()==""){
		alert("版本序号不能为空");
		return false;
	}
	else if($("#sql_sn").val()==null || $("#sql_sn").val()==""){
		alert("数据库版本序号不能为空");
		return false;
	}
	return true;
}


function init(){
	//$("#form1").validationEngine();
	if(<%=isLook%>){
		document.getElementById("sel").style.display="none";
		//document.getElementById("upfile").style.display="none";
		jQuery("#version_esn").attr("readonly","readonly");   
		jQuery("#version_sn").attr("readonly","readonly");   
		//$("#sql_sn").attr("readonly","readonly");   
		document.getElementById("version_content").style.height=document.getElementById("version_content").scrollHeight+'px';//自动适应备注textrea的高度
		MyFancyupload.createUpload('_fileshow', '#_filebut', '<%=path%>', '<%=path%>/servlet/FileUpload?buessid=<%=currentDateTime%>', false, '<%=currentDateTime%>');
		//隐藏上传按钮 
		jQuery(".swiff-uploader-box").hide();
	}else{
		MyFancyupload.createUpload('_fileshow', '#_filebut', '<%=path%>', '<%=path%>/servlet/FileUpload?buessid=<%=currentDateTime%>', true, '<%=currentDateTime%>');
		//document.getElementById("version_name").style.display="none";
		//$("#upgrade_rangevalue").val("全部");
	}
	
}

function chooseUser(){
	openTree("upgrade_rangeid","upgrade_rangevalue",true,null);
	if(IsSpace($("#upgrade_rangeid").val())){
		$("#isallrange").attr("checked","checked");
	}else{
		$("#isallrange").removeAttr("checked");
	}
}

function onisallrange(){
	$("#upgrade_rangeid").val("");
	$("#upgrade_rangevalue").val("全部");
}
</script>
</head>
<body onload="init();">
<form id="form1" action="../../../wangcheng/androidversion/jsp/androidversiondo.jsp" method="post" onkeydown="if(event.keyCode == 13){return false;}">
		<input type="hidden" name="version_id" id="version_id" value="<%=StringUtil.deNull(id)%>" />
		<!-- <input type="hidden" name="paramjosn" id="paramjosn" /> -->
		<input type="hidden" name="action" id="action"  value="<%=StringUtil.deNull(action)%>" />
		<input type="hidden" name="upload_path" value="<%=currentDateTime%>" id="upload_path"/>
		<div  class="content_02" style="overflow:hidden;" id="_top">
			<!-- 操作-->
			<div class="content_02_top" style="margin-bottom:10px;" >
				<input id="sel" value="保存" style="display: inline" onclick="Ok()" type="button" class="but_y_01" />
				<input id="resert" value="关闭" onclick="closed()" type="button" class="but_y_01" />
			</div>
		</div>
		<!-- 表格-->
		<div id="vcenter" style="float:left; width:100%; " >
			<div style="float: left;  ">
				<div class="content_02_box" >
					<div class="content_02_box_div">
							<table class="cQueryTableArea">
								<tr>
									<th class="content_02_box_div_table_th" width="50px;">
										<span class="color_red">*</span>版本名称:
									</th>
									<td class="content_02_box_div_table_td" width="90px" >
										<input name="version_name"
											value="<%=StringUtil.deNull(bean.getVersion_name())%>"
											id="version_name" type="text" 
											class="validate[required,maxSize[50]] input_title_text" />
									</td>
									<th class="content_02_box_div_table_th" width="50px;">
										<span class="color_red">*</span>是否强制升级:
									</th>
									<td class="content_02_box_div_table_td" >
										
										<input type="radio" name="is_must_install" value="Y"
											<% if("Y".equalsIgnoreCase(StringUtil.deNull(bean.getIs_must_install()))){%>
											checked <% } %> />
										是
										<input type="radio" name="is_must_install" value="N"
											<% if(!"Y".equalsIgnoreCase(StringUtil.deNull(bean.getIs_must_install()))){%>
											checked <% } %> />
										否
									</td>
								</tr>
								<tr>
									<th class="content_02_box_div_table_th" width="50px;">
										<span class="color_red">*</span>版本号:
									</th>
									<td class="content_02_box_div_table_td"  >
										<input name="version_esn"
											value="<%=StringUtil.deNull(bean.getVersion_esn())%>"
											id="version_esn" type="text"
											class="validate[required,maxSize[30],custom[number]] input_title_text" />
									</td>
								
									<th class="content_02_box_div_table_th" width="50px;">
										<span class="color_red">*</span>版本序号:
									</th>
									<td class="content_02_box_div_table_td" >
										<input name="version_sn" id="version_sn"
											value="<%=StringUtil.deNull(version_sn)%>"
											type="text"
											class="validate[required,custom[number]] input_title_text" readonly="readonly"/>
									</td>
								</tr>
								<tr>
									<th class="content_02_box_div_table_th" width="50px;">
										<span class="color_red">*</span>版本文件:
									</th>	
									<td class="content_02_box_div_table_td"  colspan="3">
									<!-- <input id="upfile" type="file" name="file1" size="30"
											class="multi ui-button ui-button-text-only ui-widget ui-state-default ui-corner-all validate[required]" />
										<input id="version_name" name="version_name"
											value="<%=StringUtil.deNull(bean.getVersion_name())%>"
											readonly type="text" class="cText_out" />
											<input id="version_name" name="version_name" 
											value="<%=StringUtil.deNull(bean.getVersion_name())%>"
											type="text" class="validate[required,maxSize[100]] input_title_text" />
											 -->	
										<%-- <a href="<%=StringUtil.deNull(filePath)%>"><%=StringUtil.deNull(bean.getVersion_name())%>(点击可下载)</a> --%>
									<% if(!isLook){%>
									<a href="#" id="_filebut" style="float:left;">请选择文件&nbsp;&nbsp;&nbsp;</a><br />
									<%}%>
									<ul id="_fileshow"></ul>
									</td>
								</tr>
								<tr>
									<th class="content_02_box_div_table_th" width="50px;">
										版本信息:
									</th>
									<td class="content_02_box_div_table_td" colspan="3">
										<textarea name="version_content" id="version_content" rows="1"
											class="validate[maxSize[500]] textarea_575"
											onkeydown="this.style.height=this.scrollHeight+'px';"><%=StringUtil.deNull(bean.getVersion_content()).replaceAll(
							"<br>", "")%></textarea>
									</td>
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