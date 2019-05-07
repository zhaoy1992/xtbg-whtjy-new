
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page
	import="com.chinacreator.xtbg.wangcheng.virtualappmanager.entity.AppStoreBean"%>
<%@page
	import="com.chinacreator.xtbg.wangcheng.virtualappmanager.service.impl.AppStoreServiceImpl"%>
<%@page
	import="com.chinacreator.xtbg.wangcheng.virtualappmanager.service.AppStoreServiceIfc"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@ page contentType="text/html; charset=gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<%
			String appid = request.getParameter("appid");
			AppStoreServiceIfc service = new AppStoreServiceImpl();
			AppStoreBean appstoreBean = new AppStoreBean();
			if (!StringUtil.isBlank(appid)) {
				appstoreBean = service.getAppStoreBeanById(appid);
			}

			//获取图标
			HashMap<String, String> appIconMap = service.getAppIconMap();
			if (appIconMap == null) {
				appIconMap = new HashMap<String, String>();
			}

			//获取应用类别
			HashMap<String, String> appTypeMap = service.getAppTypeMap();
			if (appTypeMap == null) {
				appTypeMap = new HashMap<String, String>();
			}

			//获取class类
			HashMap<String, String> appClassNameMap = service.getClassNameMap();
			if (appClassNameMap == null) {
				appClassNameMap = new HashMap<String, String>();
			}
			String subid =request.getParameter("subid");//获得父页面传过来的id
		%>
		<title>JGRID</title>


<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入formvValidatetion -->
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<!-- 引入图片imageselect下拉框js add by yin.liu -->
<script type="text/javascript"
	src="../resources/script/imageselect.js"></script>
<link href="../resources/css/imageselect.css" media="screen"
			rel="stylesheet" type="text/css" />



<script type="text/javascript">
var subid = "<%=subid%>";
/**
 * 初始化图标下拉框
 */
$(document).ready(function(){
	$('select[name=img]').ImageSelect({dropdownWidth:250});
});

function closed(){
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
//验证界面数据完整性
function validateForm(){
	if($("#form1").validationEngine("validateform")){
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
		var paramjosn = "";
		if (IsSpace($("#appid").val())) { //修改
			$("#action").val("add");
		} else {
			$("#action").val("update");
		}
		paramjosn = "{'appid':'" + $("#appid").val() + "','name':'" + $("#name").val() + "','img':'" + $("#img").val() + "','description':'" + $("#description").val() + "','classname':'" + $("#classname").val() + "','applocation':'" + $("#applocation").val() + "','apptype':'" + $("#apptype").val() + "'}";
		$("#paramjosn").val(paramjosn);
		document.all.form1.target = "hiddenFrame";
		document.getElementById("form1").submit();
	}
}
function init(){
	document.getElementById("description").style.height=document.getElementById("description").scrollHeight+'px';//自动适应备注textrea的高度

}
</script>
	<body onload="init();">
		<form id="form1" action="../../../wangcheng/virtualappmanager/jsp/addorupdateappstoredo.jsp" method="post" name="form1"
			onkeydown="if(event.keyCode == 13){return false;}">
			<div class="content_02" style="overflow: hidden;" id="_top">
				<input type="hidden" name="appid" id="appid"
					value="<%=StringUtil.deNull(appstoreBean.getAppid())%>" />
				<input type="hidden" name="paramjosn" id="paramjosn" />
				<input type="hidden" name="action" id="action" />
				<!-- 操作-->
				<div class="content_02_top" style="margin-bottom: 10px;">
					<input id="sel" value="保存" style="display: inline" onclick="Ok()"
						type="button" class="but_y_01" />
					<input id="reset" value="返回" onclick="closed()" type="button"
						class="but_y_01" />
				</div>
			</div>
			<!-- 表格-->
			<div id="vcenter" style="float: left; width: 100%; overflow: hidden;">
				<div style="float: left; width: 775px;">
					<div class="content_02_box">
						<div class="content_02_box_div">
							<table border="0" cellspacing="0" cellpadding="0"
								class="content_02_box_div_table">
								<tr>
									<th class="content_02_box_div_table_th" width="20%">
										<span class="color_red">*</span>应用名称:
									</th>
									<td class="content_02_box_div_table_td" width="30%">
										<input type="text" name="name" id="name"  class="validate[required,maxSize[100]] input_title_text"
											value="<%=StringUtil.deNull(appstoreBean.getName())%>" />
									</td>
									<th class="content_02_box_div_table_th" width="20%" rowspan="3">
										图标：
									</th>
									<td class="content_02_box_div_table_td" width="30%" rowspan="3">
										<select id="img" name="img" style="width: 100%; height: 10px">
											<%
												Iterator<String> it = appIconMap.keySet().iterator();
												String currentImg = StringUtil.deNull(appstoreBean.getImg());
												while (it.hasNext()) {
													String keyname = it.next();
													String keyvalue = appIconMap.get(keyname);

													if (currentImg.equals(keyname)) {
											%>
											<option selected="selected" value="<%=keyname%>"><%=keyvalue%></option>
											<%
												} else {
											%>
											<option value="<%=keyname%>"><%=keyvalue%></option>
											<%
												}

												}
											%>
										</select>
										<%-- <input type="text" name="img" id="img"
					value="<%=StringUtil.deNull(appstoreBean.getImg())%>"> --%>

									</td>
								</tr>
								<tr>
									<th class="content_02_box_div_table_th">
										<span class="color_red">*</span>应用编码：
									</th>
									<td class="content_02_box_div_table_td">
										<input type="text" name="applocation" id="applocation" class="validate[required,maxSize[100]] input_title_text"
											value="<%=StringUtil.deNull(appstoreBean.getApplocation())%>" />
									</td>


								</tr>
								<tr>
									<th class="content_02_box_div_table_th">
										应用类别：
									</th>
									<td class="content_02_box_div_table_td">
										<select id="apptype" name="apptype" style="width: 187px;">
											<%
												Iterator<String> typeit = appTypeMap.keySet().iterator();
												String currentAppType = StringUtil
														.deNull(appstoreBean.getApptype());
												while (typeit.hasNext()) {
													String keyname = typeit.next();
													String keyvalue = appTypeMap.get(keyname);

													if (currentAppType.equals(keyname)) {
											%>
											<option selected="selected" value="<%=keyname%>"><%=keyvalue%></option>
											<%
												} else {
											%>
											<option value="<%=keyname%>"><%=keyvalue%></option>
											<%
												}

												}
											%>
										</select>
										<%-- <input type="text" name="apptype" id="apptype"
					value="<%=StringUtil.deNull(appstoreBean.getApptype())%>" /> --%>
									</td>
								</tr>
								<tr style="display: none">
									<th class="content_02_box_div_table_th">
										应用class类：
									</th>
									<td class="content_02_box_div_table_td" colspan="3">
										<select id="classname" name="classname" style="width: 98%">
											<%
												Iterator<String> classnameit = appClassNameMap.keySet().iterator();
												String currentClassName = StringUtil.deNull(appstoreBean
														.getClassname());
												while (classnameit.hasNext()) {
													String keyname = classnameit.next();
													String keyvalue = appClassNameMap.get(keyname);

													if (currentClassName.equals(keyname)) {
											%>
											<option selected="selected" value="<%=keyname%>"><%=keyname%>&nbsp;&nbsp;[<%=keyvalue%>]
											</option>
											<%
												} else {
											%>
											<option value="<%=keyname%>"><%=keyname%>&nbsp;&nbsp;[<%=keyvalue%>]
											</option>
											<%
												}

												}
											%>
										</select>
										<%-- <input type="text" style="width: 97%" name="classname" id="classname"
					value="<%=StringUtil.deNull(appstoreBean.getClassname())%>" /> --%>
									</td>

								</tr>
								<tr>
									<th class="content_02_box_div_table_th">
										描叙：
									</th>
									<td class="content_02_box_div_table_td" colspan="3">
										<textarea rows="3" cols="" name="description" id="description"
											onkeydown="this.style.height=this.scrollHeight+'px';"
											class="validate[maxSize[500]] textarea_575"
											><%=StringUtil.deNull(appstoreBean.getDescription())%></textarea>
										<%-- <input type="text" style="width: 97%" name="description" id="description"
					value="<%=StringUtil.deNull(appstoreBean.getDescription())%>" /> --%>
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