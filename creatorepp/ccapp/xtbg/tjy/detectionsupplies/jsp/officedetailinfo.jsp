<%--
描述：固定资产详细添加界面
作者：邱炼
版本：1.0
日期：2014-02-17
--%>
<%@page import="com.chinacreator.xtbg.core.common.cache.OrgCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.OrgCacheBean"%>
<%@page import="com.chinacreator.xtbg.tjy.detectionsupplies.service.OfficeDetailService"%>
<%@page import="com.chinacreator.xtbg.tjy.detectionsupplies.service.impl.OfficeDetailServiceImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	String user_name = accesscontroler.getUserName();
	String user_id = accesscontroler.getUserID();
	Map<String,String> bean = new HashMap<String,String>();
	
	String actionName = request.getParameter("actionName");
	//主键ID
	String id = request.getParameter("id");
	//org_id
	String org_id = StringUtil.deNull(request.getParameter("org_id"));
	OrgCacheBean orgcachebean= OrgCache.getOrgCacheBean(org_id);
	if(orgcachebean==null){
		orgcachebean = new OrgCacheBean();
	}
	//类型业务
	OfficeDetailService service = new OfficeDetailServiceImpl();
	if("insert".equals(actionName)){
		//ID
		bean.put("id","");
		bean.put("org_id",orgcachebean.getOrg_id());
		bean.put("org_name",orgcachebean.getOrg_name());
		bean.put("unit_id",orgcachebean.getUnit_id());
		bean.put("unit_name",orgcachebean.getUnit_name());
		
	} else {
		bean = service.getOfficeDetailBean(id);
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>固定资产详细添加界面</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<!-- 引入jQuery_dialog -->
<script src="../../../resources/plug/jquery_dialog/jquery_dialog.js"></script>
<!-- 引入公共JS -->
<!-- 引入formvValidatetion -->
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="UTF-8"></script>
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="UTF-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery("#form1").validationEngine();
		jQuery("#code").focus();
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
		jQuery("#form1").attr("target","officedetaildoJSPhiddenFrame");
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
/**
 * 选择类别
 */
function chooseOfType(oftype_id,oftype_name,treetypestr){
	var s = new jQuery.z_tree();
    s.treeID = 'mianUser';
    s.treetypestr = treetypestr;
    s.isShowSeacher = true;
    s.treeName = "选取类别";
    s.headerName = "选取类别";
    s.type = "CHOOSEDETTYPENAME";
    s.isType = "dept";
    s.selectedIds = jQuery("#"+oftype_id).val(),
    s.returnFunction = function(userObj,o) { 
       try{
        if (!IsSpace(userObj)) {
            jQuery('#'+oftype_id).val(o[0].id);
            jQuery('#'+oftype_name).val(o[0].name);
        } else {
            jQuery('#'+oftype_id).val("");
            jQuery('#'+oftype_name).val("");
        }
       }catch(e){
         /**忽略客户端异常信息**/ 
       }
    }
    s.init();
}

/**
 * 选取人员
 */
var chooseRegister = function (userId,userName,treetypestr){
    var s = new jQuery.z_tree();
    s.treeID = 'mianUser';
    s.treetypestr = treetypestr;
    s.isShowSeacher = true;
    s.treeName = "选取人员";
    s.headerName = "选取人员";
    s.type = "APERSON";
    s.selectedIds = jQuery("#"+userId).val(),
    s.returnFunction = function(userObj,o) {            
       try{
        if (!IsSpace(userObj)) {
            jQuery('#'+userId).val(userObj.id);
            jQuery('#'+userName).val(userObj.name);
            if(o&&o.length>0){
            	var orgids = new Array();//当前列表的用户id的数组
            	for(var i=0;i<o.length;i++){
            		orgids.push(o[i].parent_id);
            	}
            }
        } else {
            jQuery('#'+userId).val("");
            jQuery('#'+userName).val("");
        }
       }catch(e){
         /**忽略客户端异常信息**/ 
       }
    }
    s.init();
}
</script>
<body style="overflow-y:hidden;">
	<form id="form1" action="officedetailinfodo.jsp" method="post"  >
		<input type="hidden" name="id" id="id" value="<%=StringUtil.deNull(bean.get("id"))%>">
		<input type="hidden" name="org_id" id="org_id" value="<%=StringUtil.deNull(bean.get("org_id"))%>">
		<input type="hidden" name="org_name" id="org_name" value="<%=StringUtil.deNull(bean.get("org_name"))%>">
		<input type="hidden" name="unit_id" id="unit_id" value="<%=StringUtil.deNull(bean.get("unit_id"))%>">
		<input type="hidden" name="unit_name" id="unit_name" value="<%=StringUtil.deNull(bean.get("unit_name"))%>">
		<input type="hidden" name="receive_user_id" id="receive_user_id" value="<%=StringUtil.deNull(bean.get("receive_user_id"))%>">
		<input type="hidden" name="oftype_id" id="oftype_id" value="<%=StringUtil.deNull(bean.get("oftype_id"))%>">
		<input type="hidden" name="blame_user_id" id="blame_user_id" value="<%=StringUtil.deNull(bean.get("blame_user_id"))%>">
		<input type='hidden' name='action' id="hidden_action"/>
		<input type="hidden" name="windowsId" id="windowsId" value='<%=StringUtil.deNull(request.getParameter("windowsId"))%>'/>
		<div id="users-contain">
			<table  width="100%" border="0" cellspacing="0" cellpadding="0" >
					<tr>
						<th class="content_02_box_div_table_th"><font color="red">*</font>标识卡编号：</th>
						<td class="content_02_box_div_table_td">
							<input type="text" name="code" id="code" class="validate[required,maxSize[100]] input_188" style="height=23px" 
							value="<%=StringUtil.deNull(bean.get("code"))%>" >
						</td>
						</td>
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th"><font color="red">*</font>名称：</td>
						<td class="content_02_box_div_table_td">
							<input type="text" name="name" id="name"  class="validate[required,maxSize[100]] input_188" style="width:90%;height=23px" 
							value="<%=StringUtil.deNull(bean.get("name"))%>">
						</td>
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th"><font color="red">*</font>规格\型号：</td>
						<td class="content_02_box_div_table_td">
							<input type="text" name="type" id="type"  class="validate[required,maxSize[100]] input_188" style="width:90%;height=23px" 
							value="<%=StringUtil.deNull(bean.get("type"))%>">
						</td>
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th"><font color="red">*</font>领取时间：</td>
						<td class="content_02_box_div_table_td">
							<input type="text" name="receive_day" id="receive_day"  class="validate[required,maxSize[100]] date_120 Wdate" style="height=23px" 
							value="<%=StringUtil.deNull(bean.get("receive_day"))%>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})">
						</td>
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th">金额：</td>
						<td class="content_02_box_div_table_td">
							<input type="text" name="money" id="money"  class="validate[maxSize[20],custom[positivenumber]] input_188" style="width:90%;height=23px" 
							value="<%=StringUtil.deNull(bean.get("money"))%>">
						</td>
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th">类别：</td>
						<td class="content_02_box_div_table_td">
							<input type="text" name="oftype_name" id="oftype_name"  class="validate[maxSize[200]] input_188" style="width:90%;height=23px" 
							value="<%=StringUtil.deNull(bean.get("oftype_name"))%>" onclick="chooseOfType('oftype_id','oftype_name','radio')">
							<input name="" type="button" value="" class="but_x" 
								onclick="chooseOfType('oftype_id','oftype_name','radio')"/>
						</td>
						
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th">领用人：</td>
						<td class="content_02_box_div_table_td">
							<input type="text" name="receive_username" id="receive_username"  class="validate[maxSize[100]] input_188" style="width:90%;height=23px" 
							value="<%=StringUtil.deNull(bean.get("receive_username"))%>" onclick="chooseRegister('receive_user_id','receive_username','radio')">
							<input name="" type="button" value="" class="but_x" 
								onclick="chooseRegister('receive_user_id','receive_username','radio')"/>
						</td>
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th">责任人：</td>
						<td class="content_02_box_div_table_td">
							<input type="text" name="blame_username" id="blame_username"  class="validate[maxSize[100]] input_188" style="width:90%;height=23px" 
							value="<%=StringUtil.deNull(bean.get("blame_username"))%>"  onclick="chooseRegister('blame_user_id','blame_username','radio')">
							<input name="" type="button" value="" class="but_x" 
								onclick="chooseRegister('blame_user_id','blame_username','radio')"/>
						</td>
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th">存放位置：</td>
						<td class="content_02_box_div_table_td">
							<textarea style="width:85%;" rows="3" cols="7" name="deposit_place" class="validate[maxSize[250]]"
							id="deposit_place" ><%=StringUtil.deNull(bean.get("deposit_place"))%></textarea>
						</td>
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th">资产用途：</td>
						<td class="content_02_box_div_table_td">
							<textarea style="width:85%;" rows="3" cols="7" name="assetsuse" class="validate[maxSize[250]]"
							id="assetsuse" ><%=StringUtil.deNull(bean.get("assetsuse"))%></textarea>
						</td>
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th">报废处置情况：</td>
						<td class="content_02_box_div_table_td">
							<textarea style="width:85%;" rows="3" cols="7" name="wastedisposal" class="validate[maxSize[250]]"
							id="wastedisposal" ><%=StringUtil.deNull(bean.get("wastedisposal"))%></textarea>
						</td>
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th">备注：</td>
						<td class="content_02_box_div_table_td">
							<textarea style="width:85%;" rows="3" cols="7" name="remarks" class="validate[maxSize[250]]"
							id="r_content" ><%=StringUtil.deNull(bean.get("remarks"))%></textarea>
						</td>
					</tr>
			</table>
		</div>
		
		<div class="cue_box_foot">
			<input class="but_y_01" type="button" value="返回" onclick="removeAlertWindows('',true)" />
			<input class="but_y_01" type="button" id="sel"  value="完成" onclick="Ok()"/>
		</div>
		
	</form>
	
	<iframe name="officedetaildoJSPhiddenFrame" width=0 height=0></iframe>
</body>
</html>