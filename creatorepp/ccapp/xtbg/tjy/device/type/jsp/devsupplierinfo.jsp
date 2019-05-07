<%--
描述：供应商名录管理界面
作者：邱炼
版本：1.0
日期：2014-02-27
--%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.DevSupplierService"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.impl.DevSupplierServiceImpl"%>
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
	
	Map<String,String> bean = new HashMap<String,String>();
	
	String actionName = request.getParameter("actionName");
	//主键ID
	String devsup_id = request.getParameter("devsup_id");
	
	//类型业务
	DevSupplierService service = new DevSupplierServiceImpl();
	if("insert".equals(actionName)){
	} else {
		bean = service.getDevSupplierBean(devsup_id);
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>供应商名录管理</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<!-- 引入其它 -->
<script src="../../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<!-- 引入jQuery_dialog -->
<script src="../../../../resources/plug/jquery_dialog/jquery_dialog.js"></script>
<!-- 引入公共JS -->
<!-- 引入formvValidatetion -->
<script src="../../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="UTF-8"></script>
<script type="text/javascript"src="../../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script src="../../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="UTF-8"></script>
<script type="text/javascript" src="../../../../resources/plug/ifrom/js/ifrom-min.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script src="../../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery("#form1").validationEngine();
		jQuery("#devsup_mc").focus();
		
		//供方性质
		$("#devsup_gfxz option[value='<%=StringUtil.deNull(bean.get("devsup_gfxz"))%>']").attr('selected', true);
		//供方类别
		$("#devsup_gflb option[value='<%=StringUtil.deNull(bean.get("devsup_gflb"))%>']").attr('selected', true);
		//信誉度
		$("#devsup_xyd option[value='<%=StringUtil.deNull(bean.get("devsup_xyd"))%>']").attr('selected', true);
		//是否有效
		$("input[type=radio][value=<%=StringUtil.deNull(bean.get("devsup_sfyx"))%>]").attr("checked",true);
		
	});
/*
函数:  Ok
说明:  提交添加与修改来文单位
参数:   无
返回值: 无
*/
function Ok() {
	var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
	if (isFlag){
		jQuery("#hidden_action").val("addInfo");
		jQuery("#form1").attr("target","filetypeinfodoJSPhiddenFrame");
		jQuery("#form1").submit();
	}
}
afterSubmitFn=function(result){
	try{
		if(result.indexOf("delete")!=-1){
			alert(result.split(",")[1]);
		}else{
			if(result.split(",").length>1){
					result = result.split(",");
					alert(result[0]);
					getParentWindow("windowId").userSearch();
					removeAlertWindows("windowId",true);
			} else {
				alert(result);
				getParentWindow("windowId").userSearch();
				removeAlertWindows("windowId",true);
			}
			
		}
	}catch(e){alert(e.description);}
};
function closed(){
	removeWindows('',true);
}
	
</script>
<body style="overflow-y:hidden;">
	<form id="form1" action="devsupplierinfodo.jsp" method="post"  >
		<input type="hidden" name="devsup_id" id="devsup_id" value="<%=StringUtil.deNull(bean.get("devsup_id"))%>">
		<input type='hidden' name='action' id="hidden_action"/>
		<input type="hidden" name="windowsId" id="windowsId" value='<%=StringUtil.deNull(request.getParameter("windowsId"))%>'/>
		<div id="users-contain">
			<table  width="100%" border="0" cellspacing="0" cellpadding="0" >
					<tr>
						<th class="content_02_box_div_table_th"><font color="red">*</font>供应商名称：</th>
						<td class="content_02_box_div_table_td">
							<input type="text" name="devsup_mc" id="devsup_mc"  class="validate[required,maxSize[100]] input_188" style="width:90%;height=23px" 
								value="<%=StringUtil.deNull(bean.get("devsup_mc"))%>" >
						</td>
						
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th"><font color="red">*</font>收录时间：</td>
						<td class="content_02_box_div_table_td">
						<input type="text" name="devsup_slsj" id="devsup_slsj" 
							 class="validate[required,maxSize[100]] date_120 Wdate" style="width:160px;height=23px" 
								value="<%=StringUtil.deNull(bean.get("devsup_slsj"))%>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})">
						</td>
						
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable"><font color="red">*</font>供方性质：</td>
						<td class="content_02_box_div_table_td">
							<select style="width: 160px;" id='devsup_gfxz' name='devsup_gfxz' class="validate[required,maxSize[10]]">
								<option value=''>--请选择--</option>
								<option value='sydw'>事业单位</option>
								<option value='qydw'>企业单位</option>
								<option value='gtsh'>个体工商户</option>
							</select>				
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable"><font color="red">*</font>供方类别：</td>
						<td class="content_02_box_div_table_td">
							<select style="width: 160px;" id='devsup_gflb' name='devsup_gflb' class="validate[required,maxSize[10]]">
								<option value=''>--请选择--</option>
								<option value='sccj'>生产厂家 </option>
								<option value='cpzjdl'>产品直接代理</option>
								<option value='cpjx'>产品经销</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable"><font color="red">*</font>供方地址：</td>
						<td class="content_02_box_div_table_td">
							<input style="width:90%;height=23px" type="text" name="devsup_gfdz" class="validate[required,maxSize[100]] input_188"
							id="devsup_gfdz" value="<%=StringUtil.deNull(bean.get("devsup_gfdz"))%>">
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable"><font color="red">*</font>法定代表人：</td>
						<td class="content_02_box_div_table_td">
							<input style="width:90%;height=23px" type="text" name="devsup_fddbr" class="validate[required,maxSize[50]] input_188"
								id="devsup_fddbr" value="<%=StringUtil.deNull(bean.get("devsup_fddbr"))%>">
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable"><font color="red">*</font>联系代表：</td>
						<td class="content_02_box_div_table_td">
							<input style="width:90%;height=23px" type="text" name="devsup_lxdb" class="validate[required,maxSize[25]] input_188"
							id="devsup_lxdb"	value="<%=StringUtil.deNull(bean.get("devsup_lxdb"))%>">
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable"><font color="red">*</font>联系电话：</td>
						<td class="content_02_box_div_table_td">
							<input style="width:90%;height=23px" type="text" name="devsup_lxdh" class="validate[required,maxSize[12],custom[number]] input_188"
							id="devsup_lxdh" value="<%=StringUtil.deNull(bean.get("devsup_lxdh"))%>">
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable">信誉度：</td>
						<td class="content_02_box_div_table_td">
							<select style="width: 160px;" id='devsup_xyd' name='devsup_xyd' class="validate[maxSize[10]]">
								<option value=''>--请选择--</option>
								<option value='xj'>较差 </option>
								<option value='xh'>较好</option>
								<option value='yl'>优良</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable"><font color="red">*</font>是否有效：</td>
						<td class="content_02_box_div_table_td">
							&nbsp;<input type="radio" name="devsup_sfyx" id="devsup_sfyx" checked="checked" value="1"/>&nbsp;是&nbsp;
							 <input type="radio" name="devsup_sfyx" id="devsup_sfyx" value="0"/>&nbsp;否&nbsp;
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable"><font color="red">*</font>提供产品：</td>
						<td class="content_02_box_div_table_td">
							<textarea style="width:90%;" rows="3" cols="7" name="devsup_tgcp" class="validate[required,maxSize[300]]"
							id="devsup_tgcp" ><%=StringUtil.deNull(bean.get("devsup_tgcp"))%></textarea>
						</td>
					</tr>
			</table>
		</div>
		
		<div class="cue_box_foot">
			<input class="but_y_01" type="button" value="返回" onclick="removeAlertWindows('',true)" />
			<input class="but_y_01" type="button" id="sel"  value="完成" onclick="Ok()"/>
		</div>
		
	</form>
	
	<iframe name="filetypeinfodoJSPhiddenFrame" width=0 height=0></iframe>
</body>
</html>