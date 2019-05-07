<%--
描述：参数值选择页面
作者：肖杰
版本：1.0
日期：2013-7-16
UTF-8
--%>
<%@page import="com.chinacreator.xtbg.core.sysparam.service.impl.SysParamServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.sysparam.service.SysParamServiceIfc"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String p_code=request.getParameter("p_code");
	
	SysParamServiceIfc service = new SysParamServiceImpl();
	List<Map<String, String>> bkbList = service.getSysParamvalueByPcode(p_code);
	
	boolean canEdit = true;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<!-- 引入jQuery -->
	<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript">jQuery.noConflict();</script>
	<!-- 引入jQuery UI -->
	<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
	<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
	<!-- 引入formvValidatetion -->
	<link rel="stylesheet" href="../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
	<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
	<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
	<!-- 引入其它 -->
	<script type="text/javascript" src="../../resources/util/public.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
	<!-- 引入jGrid -->
	<link rel="stylesheet" type="text/css" media="screen" href="../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
	<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"  charset="utf-8" type="text/javascript"></script>
	<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"  charset="utf-8" type="text/javascript"></script>
	
	<script type="text/javascript" src="../../resources/js/util/jsonutil.js" ></script>
	
	<!-- 引入上传控件 -->
	<link   rel="stylesheet" href="../../resources/plug/fancyupload/fancyupload.css" type="text/css" />
	<script type="text/javascript" src="../../resources/plug/fancyupload/mootools-1.2.5-core-jm.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../resources/plug/fancyupload/source/Fx.ProgressBar.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../resources/plug/fancyupload/source/Swiff.Uploader.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../resources/plug/fancyupload/source/FancyUpload3.Attach.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../resources/plug/fancyupload/myfancyupload.js" charset="utf-8"></script>
	</head>
	<body style="margin: 0px;overflow-x:hidden">
<div id='tabs1' style="width:600px;">
<div class="content_02_top" style="margin-bottom:10px;width:100%" id="divA">
	<%if(canEdit){ %>
		<input type="button" class="but_y_01" value="确定" onclick="updateFn('save',this);"/>
		<input type="button" class="but_y_01" value="关闭" onclick="updateFn('close',this);"/>
		<script>
			updateFn = function(flag,inputObj){
				try{
					inputObj.disabled=true;
					if(flag==='save'){
						fld="";
						objs = document.getElementsByName("fldId");
						for(var i = 0 ;i<objs.length;i++){
							
							obj = objs[i];
							if(obj.checked){
								fld = obj.value;
								break;
							}
						}
						if(fld){
							getParentWindow('windowId').toGetTemplatePara(fld);
						}
						removeAlertWindows('windowId',true);
					}else if(flag==='close'){
					    removeAlertWindows('windowId',true);
					}
					inputObj.disabled=false;
				}catch(e){alert(e.description);inputObj.disabled=false;}
			};
		</script>
	<%}else{%>
		<input type="button" class="but_y_01" value="关闭" onclick="updateFn('back',this);" id="btn_update"/>
		<script>
			updateFn = function(flag,inputObj){
				try{
					removeAlertWindows('windowId',true);
				}catch(e){alert(e.description);}
			};
		</script>
	<%}%>
</div>

<div id="vcenter" style="float:left;width:100%; overflow:hidden">
	<div class="content_02_box" style="width:95%;">
		<div class="content_02_box_title_bg" style="width:100%;"><span>参数值列表</span></div>
		<div class="content_02_box_div" style="width:100%;">
			<table id='formTable' border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table" style="width:100%;">
				<%if(bkbList!=null&&bkbList.size()>0){
					for(Map<String,String> bkb : bkbList){
						if(bkb.get("p_id")!=null&&bkb.get("p_name")!=null){
							%>
							<tr>
								<th class="content_02_box_div_table_th" style="width: 10px;">
									<input class="cRadio_out"  type="radio" name="fldId" value="<%=bkb.get("p_value_name") %>"/>
								</th>
								<th class="content_02_box_div_table_th" name="fldname" style="width: 200px;text-align:left">&nbsp;
									<%=bkb.get("p_value_name")%>
								</th>
							</tr>
							<%
						}
					}
				}else{%>
					<tr>
						<th class="content_02_box_div_table_th" style="width: 30px;">
							<input class="cRadio_out"  type="radio" name="fldId" disabled="disabled"/>
						</th>
						<th class="content_02_box_div_table_th"  style="width: 150px;">
							请先添加值表信息
						</th>
					</tr>
				<%}%>
			</table>
		</div>
	</div>
</div>
</div>
	</body>
</html>