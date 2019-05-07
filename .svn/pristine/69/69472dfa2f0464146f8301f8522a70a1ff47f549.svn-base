<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileLendingServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.file.service.FileLendingServiceIfc"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@ taglib uri="/WEB-INF/archive-taglib.tld" prefix="oa"%>
<%
String path = request.getContextPath();
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);

String busi_id  = StringUtil.deNull(request.getParameter("busi_id"));
//获取借阅人基本信息
String F_USER_ID = accesscontroler.getUserID();
String F_USER_NAME = accesscontroler.getUserName();
UserCacheBean usercachebean=UserCache.getUserCacheBean(F_USER_ID);
String F_UNIT_ID=usercachebean.getUnit_id();
String F_UNIT_NAME=usercachebean.getUnit_name();
String F_ORG_ID = usercachebean.getOrg_id();
String F_ORG_NAME = usercachebean.getOrg_name();
String beanid = request.getParameter("id");
String subid = request.getParameter("subid");
String f_lending_id = StringUtil.getUUID();
Map<String, String> viewMap = new HashMap<String, String>();
FileLendingServiceIfc fileFondsnoServiceIfc=new FileLendingServiceImpl();
if(!StringUtil.isBlank(beanid)){
	viewMap=fileFondsnoServiceIfc.getFileLendingDetailBean(beanid);
	F_USER_ID = StringUtil.deNull(viewMap.get("f_lending_userid"));
	F_USER_NAME  = StringUtil.deNull(viewMap.get("f_lending_username"));
	F_ORG_ID = StringUtil.deNull(viewMap.get("f_org_id"));
	F_UNIT_NAME = StringUtil.deNull(viewMap.get("f_org_name"));
	String f_tel = StringUtil.deNull(viewMap.get("f_tel"));
	String f_creator_time = StringUtil.deNull(viewMap.get("f_creator_time"));
	String f_lending_reason = StringUtil.deNull(viewMap.get("f_lending_reason"));
}
//介质类型下拉框
String sql = "select d.dictdata_value, d.dictdata_name from OA_DICT_DATA d, OA_DICT_TYPE t where t.dict_code = 'jzlx' and d.dict_id = t.dict_id and t.dict_is_valid = 1 and d.dictdata_is_valid = 1";
String selectData = DictDropDownList.buildSelect(sql.toString(),"f_lending_type","","",true,"","");
//阅读权限下拉框
String sql1 = "select odd.dictdata_value, odd.dictdata_name from OA_DICT_DATA odd where odd.dict_id='12' order by odd.dictdata_order";
String selectData1 = DictDropDownList.buildSelect(sql1.toString(),"ydqx","","",true,"","");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
//选择档案
function Add_Row4NewDay1(){
	var f_doc_ids = "";
	$("#dayTable input[name='f_doc_id']").each(function(i,e){
		f_doc_ids=f_doc_ids+ $(e).val() +",";
	});
	f_doc_ids = f_doc_ids.substr(0,f_doc_ids.length-1);
	
	var flag = openAlertWindows('windowId','<%=path%>/ccapp/oa/file/jsp/fileborrowindexadd.jsp?windowsId=windowId&detailIds='+f_doc_ids,'选择借阅档案',850,470,'25%','25%');
	
}
//删除领用设备
function deleteDay(tag,goodsId){
	
	var intable=$(tag).parents("table");
	var tr=$(tag).parents("tr").first();
	var trsize= $(intable).find("tr[id=dayrow]").size();
	if(trsize==1){
		$(tr).find("#detailId").val("");
		$(tr).find("#f_doc_num").val("");
		$(tr).find("#f_file_no").val("");
		$(tr).find("#f_doc_name").val("");
		$(tr).find("#f_file_formtime").val("");
		$(tr).find("#OA_FILE_LENDING_DETAIL__F_LENDING_DAY").val("");
		$(tr).find("#f_lending_type").val("");
		$(tr).find("#ydqx").val("");
	}else{
		$(tr).remove();
	}
}

function addFileProgram(){
	if(jQuery('#dayTable tr').size()<2){
		alert("请选择借阅档案");
		return;
	}
	var flag = true;
	var mess = "";
	//借阅天数必填,阅读权限必填
	jQuery("#dayTable SELECT[name='f_lending_type']").each(function(){
		idCode = this.id.substring(14);
		if(!this.value){
			flag = false;
			mess = "请填写介质类型";
			return;
		}else{
			if(this.value!='1'){
				var kc = jQuery("#f_file_num"+idCode).val();
				if(kc&&!isNaN(kc)&parseInt(kc)>0){
					//OK
				}else{
					flag = false;
					mess = "档案["+jQuery("#f_doc_name"+idCode).val()+"]库存不足";
					return;
				}
			}
		}
	});
	if(flag){
		jQuery("#dayTable SELECT[name='ydqx']").each(function(){
			if(!this.disabled&&!this.value){
				flag = false;
				return;
			}
		});
		if(!flag){
			alert("请填写阅读权限");
		}else{
			if(!jQuery('#form1').validationEngine('validate')){
				return;
			}
			jQuery("#action").val("add");
			document.all.form1.target = "hiddenFrame";
			jQuery("#form1").submit();
			jQuery("#form1").resetSubmit(false);
		}
	}else{
		alert(mess);
	}
}

var back = function(){
	var p={
			headerText:'提示',
			okName:'确认',
	        okFunction:function(){
	        	//removeWindows('windowsId',true);
	        	var url = "fileborrowtabs.jsp";
    			window.location = url,"perspective_content";
	        },
	        cancelName:'取消'
		};
		alert("关闭后，数据将不会保存，确定关闭？",p);
}

var chooseActUsers = function (userId,userName,orgName,treetypestr){
	var s = new jQuery.z_tree();
	s.treeID = 'mianUser';
	s.treetypestr = treetypestr;
	s.isShowSeacher = true;
	s.treeName = "选取人员";
	s.headerName = "选取人员";
	s.type = "APERSON";
	s.selectedIds = jQuery("#"+userId).val(),
	s.returnFunction = function(userObj,o) {
		if (!IsSpace(userObj)) {
			jQuery('#'+userId).val(userObj.id);
			jQuery('#'+userName).val(userObj.name);
			if (orgName!=""){
				jQuery('#'+orgName).val(userObj.returnparentNode);
			}
		} else {
			jQuery('#'+userId).val("");
			jQuery('#'+userName).val("");
			jQuery('#'+orgName).val("");
		}
	}
	s.init();
}

var chooseOrg = function(orgId,orgName) {
	var s = new jQuery.z_tree();
	s.treeID = 'mian';
	s.isShowSeacher = true;
	s.treeName = "选取单位";
	s.isType = 'dept';
	s.headerName = "选取单位";
	s.item_id = 'm_receiver_unit_ids';
	s.selectedIds = jQuery('#m_receiver_unit_ids').val();
	s.type = 'AORG';
	s.returnFunction = function(orgObj) {
		if (!IsSpace(orgObj)) {
			jQuery('#'+orgId).val(orgObj.id);
			jQuery('#'+orgName).val(orgObj.name);
		} else {
			jQuery('#'+orgId).val("");
			jQuery('#'+orgName).val("");
		}
	}
	s.init();
}

<%--增加列表中一行--%>
function addOneRow(model){
	var num = getNextRowId();
	try{
	var firstTr=jQuery("#didiaoTable tr").first().clone();
	jQuery(firstTr).find("#datatr").attr("id","datatr"+num);
	jQuery(firstTr).find("input[name='f_doc_id']").attr("id","f_doc_id"+num).val(model.f_doc_id);
	jQuery(firstTr).find("input[name='f_doc_num']").attr("id","f_doc_num"+num).val(model.f_doc_num);
	jQuery(firstTr).find("input[name='f_doc_name']").attr("id","f_doc_name"+num).val(model.f_doc_name);
	jQuery(firstTr).find("input[name='f_file_no']").attr("id","f_file_no"+num).val(model.f_file_no);
	jQuery(firstTr).find("input[name='f_file_formtime']").attr("id","f_file_formtime"+num).val(model.f_creator_time_str);
	jQuery(firstTr).find("input[name='OA_FILE_LENDING_DETAIL__F_LENDING_DAY']").attr("id","OA_FILE_LENDING_DETAIL__F_LENDING_DAY"+num).val("");
	jQuery(firstTr).find("SELECT[name='f_lending_type']").attr("id","f_lending_type"+num).val("");
	jQuery(firstTr).find("SELECT[name='ydqx']").attr("id","ydqx"+num).attr("disabled","disabled");
	jQuery(firstTr).find("input[name='f_file_num']").attr("id","f_file_num"+num).val(model.f_file_num);
	jQuery(firstTr).find("input[name='ydqxHidden']").attr("id","ydqxHidden"+num);
	jQuery(firstTr).appendTo(jQuery("#dayTable"));
	addFn("f_lending_type"+num,"ydqx"+num);
	}catch(e){alert(e.mess)}
}
addFn=function(a,b){
	jQuery("#"+a).change(function(){
		bObjId = "ydqx"+this.id.substring(14);
		if(this.value=='0'||this.value=='1'){
			jQuery("#"+bObjId).removeAttr("disabled");
		}else{
			jQuery("#"+bObjId).attr("disabled","disabled");
			jQuery("#"+bObjId).val("");
		}
	});
	jQuery("#"+b).change(function(){
		bObjId = "ydqxHidden"+this.id.substring(4);
		jQuery("#"+bObjId).val(this.value);
	});
};
<%--获取下一个行号,支持addOneRow--%>
function getNextRowId(){
	var count = jQuery("#count").val();
	if(count){
		count=parseInt(count)+1;
	}else{
		count = 1;
	}
	jQuery("#count").val(count+"");
	return count;
}
</script>
<title></title>
	<!-- 引入jQuery -->
	<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	<!-- 引入jQuery UI -->
	<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
	<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
	<!-- 引入formvValidatetion -->
	<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
	<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
	<!-- 引入其它 -->
	<script src="../../resources/js/util/public.js" type="text/javascript"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
	<oa:init>
	<link rel="stylesheet" href="<%=path%>/ccapp/oa/archive/css.css" type="text/css" />
	<style type="text/css">
	.but_y_01 {
		float: none;
	}
	
	.but_y_02 {
		float: none;
	}
	
	.input_title_text_noborder{ width:99%; border:0px solid #C6C6C6; height:24px; margin-top:0px; font:12px/24px "宋体"; padding:0px 0px; display:inline;}
	.date_187_noborder{width:189px; height:24px; border:0px solid #C6C6C6; font:12px/24px ""; display:block;overflow:hidden; background:url(../../../resources/images/date_img.jpg) right 1px no-repeat; float:left; display:inline;cursor:pointer; }
	.xz_187_noborder{width:189px; height:26px; border:0px solid #C6C6C6; font:12px/24px ""; display:block;overflow:hidden; background:url(../../../resources/images/xuanze.jpg) right 1px no-repeat; float:left; display:inline;cursor:pointer; }
	.input_185_noborder{width:180px; height:24px; border:0px solid #C6C6C6; font:12px/24px "宋体"; display:block;overflow:hidden;  float:left; padding:0px 2px; display:inline; }
	.texteare_lbjd_noborder{height:24px; border:0px solid #C6C6C6; font:12px/24px "宋体"; display:block;  float:left; padding:0px 2px; display:inline; }
	.input_text_center_wc{text-align: center;} /**使input中的文字居中*/
</style>
</head>
<body>

<form id="form1" name="form1" action="ccapp/oa/file/jsp/fileborrowaddDo.jsp?subid=<%=subid%>" method="post">
<input type="hidden" id="busi_id"      name="busi_id"  value="<%=busi_id %>" />
<input type="hidden" id="action" name="action" /> 
<input type="hidden" id="f_lending_id" name="f_lending_id" value="<%=f_lending_id%>" /> 
<input type="hidden" id="opt_type"     name="opt_type" /> 
<input type="hidden" id="busiTypeCode" name="busiTypeCode" />
<!-- 操作-->
<div class="content_02" style="overflow: hidden;" id="_top">
	<div class="content_02_top" style="margin-bottom: 10px;">
		<input  value="添加" onclick="addFileProgram();"  type="button" class="but_y_01" /> 
		<input name="" value="返回" onclick="back()" type="button" class="but_y_01" />
	</div>
</div>
<%-- 主表单 begin---%>
<div class="vcenter" style="overflow-y:auto;">
		<div style="float: left; width: 900px;">
			<%--shang--%>
			<div class="content_02_box" style="width: 900px;">
				<div class="content_02_box_title_bg" style="width: 900px;">
					<span>档案借阅申请</span>
				</div>
				<div class="content_02_box_div" style="width: 900px;">
					<table border="0" cellspacing="0" cellpadding="0"
						class="content_02_box_div_table" style="width: 100%;">
						<tr>
							<th class="content_02_box_div_table_th"><span class="color_red">*</span>是否内部人员：</th>
							<td class="content_02_box_div_table_td" colspan="3">
								<input type="radio" id="nbuserRadio" name="f_is_nbuser" checked="checked" />是
								<input type="radio" id="wbuserRadio" name="f_is_nbuser"/>否
								<script type="text/javascript">
								jQuery("#wbuserRadio").click(function(){
									jQuery("#user").html(jQuery("#wbuser").html());
								});
								jQuery("#nbuserRadio").click(function(){
									jQuery("#user").html(jQuery("#nbuser").html());
								});
								jQuery("#user").html(jQuery("#nbuser").html());
								</script>
							</td>
						</tr>
						<tr id="user" style="display: block;"><%--row1--%>
							<th class="content_02_box_div_table_th"><span class="color_red">*</span>借阅人：</th>
							<td class="content_02_box_div_table_td">
							<input type="hidden" name="f_lending_userid" id="f_lending_userid" value="<%=F_USER_ID%>">
							<input type="text" id="f_lending_username" readonly="readonly" name="f_lending_username" class="validate[required] input_cx_title_283" onclick="chooseActUsers('f_lending_userid','f_lending_username','m_link_dept_name','radio')" value="<%=F_USER_NAME %>"/>
							</td>
							<th class="content_02_box_div_table_th"><span class="color_red">*</span>所属部门：</th>
							<td class="content_02_box_div_table_td">
							<input type="hidden" name="f_dept_id" id="f_dept_id" value="<%=F_UNIT_ID %>">
						    <input type="text" id="f_dept_name" name="f_dept_name" readonly="readonly" class="validate[required] input_cx_title_283" 
						  	 	onclick="chooseOrg('f_dept_id','f_dept_name','f_dept_id','radio')" value="<%=F_UNIT_NAME %>"/>
								<input type="hidden" name=f_org_name id="f_org_name">
								<input type="hidden" name=f_org_id id="f_org_id">
							</td>
						</tr>
						<tr><%--row2--%>
							<th class="content_02_box_div_table_th">联系电话：</th>
							<td class="content_02_box_div_table_td">
								<input type="text" name="f_tel" id="f_tel" class="input_cx_title_283">
							</td>
							<th class="content_02_box_div_table_th"><span class="color_red">*</span>申请日期：</th>
							<td class="content_02_box_div_table_td">
								<input class="validate[required] date_120 Wdate" type="text" id="f_creator_time" name="f_creator_time" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
							</td>
						</tr>
						<tr><%--row3--%>
							<th class="content_02_box_div_table_th" style="height: 70px"><span class="color_red">*</span>借阅理由：</th>
							<td class="content_02_box_div_table_td" colspan=4>
                                  <textarea class="validate[required] textarea_575" style="width:99%" name="f_lending_reason" id="f_lending_reason" ></textarea>
							</td>
						</tr>
					</table>
				</div>
			</div>
			
			
			<%--xia--%>
			<div class="content_02_box" style="width: 900px;">
				<div class="content_02_box_title_bg" style="width: 900px;">
					<span>借阅的档案清单</span>
					<span style="display: block;float: right;"><a href="javascript:void(0);" onclick="Add_Row4NewDay1();" ><img src="ccapp/oa/file/image/add.gif"/>选择借阅档案&nbsp;</a></span>
					<script>
					</script>
				</div>
				<div class="content_02_box_div" style="width: 900px;">
					<div style="width: 900px" class="cGridArea">
					<table id="dayTable"  width="100%">
					<tr class="content_02_box_div_table user_data_table"  id="user_data_1">
						<td class="content_02_box_div_table_th" style="text-align: center;width: 5%">件号</td>
						<td class="content_02_box_div_table_th" style="text-align: center;width: 15%">档号</td>
						<td class="content_02_box_div_table_th" style="text-align: center;width: 15%">文件标题</td>
						<td class="content_02_box_div_table_th" style="text-align: center;width: 10%">文件形成日期</td>
						<td class="content_02_box_div_table_th" style="text-align: center;width: 10%"><span class="color_red">*</span>借阅天数</td>
						<td class="content_02_box_div_table_th" style="text-align: center;width: 10%"><span class="color_red">*</span>介质类型</td>
						<td class="content_02_box_div_table_th" style="text-align: center;width: 10%">阅读权限</td>
						<td class="content_02_box_div_table_th" style="text-align: center;width: 10%">操作</td>
					</tr>
					
					</table>
					<input type='hidden' name="count" id="count"/>
				</div>
			</div>
		</div>
</div>
<%-- 主表单 end---%>
</form>
<iframe name="hiddenFrame" width="0" height="0"></iframe>
<table >
<tr id="nbuser" style="display: none;"><%--row1--%>
	<th class="content_02_box_div_table_th"><span class="color_red">*</span>借阅人：</th>
	<td class="content_02_box_div_table_td">
	<input type="hidden" name="f_lending_userid" id="f_lending_userid" value="<%=F_USER_ID%>"/>
	<input type="text" id="f_lending_username" readonly="readonly" name="f_lending_username" class="validate[required] input_cx_title_283" onclick="chooseActUsers('f_lending_userid','f_lending_username','m_link_dept_name','radio')" value="<%=F_USER_NAME %>"/>
	</td>
	<th class="content_02_box_div_table_th"><span class="color_red">*</span>所属部门：</th>
	<td class="content_02_box_div_table_td">
		<input type="hidden" name="f_dept_id" id="f_dept_id" value="<%=F_UNIT_ID %>">
	    <input type="text" id="f_dept_name" readonly="readonly" name="f_dept_name"  value="<%=F_UNIT_NAME %>" class="validate[required] input_cx_title_283" 
	  	 	onclick="chooseOrg('f_dept_id','f_dept_name','f_dept_id','radio')"  />
		<input type="hidden" name=f_org_name id="f_org_name">
		<input type="hidden" name=f_org_id id="f_org_id">
</td>
</tr>
<tr id="wbuser" style="display: none;"><%--row1--%>
	<th class="content_02_box_div_table_th"><span class="color_red">*</span>借阅人：</th>
	<td class="content_02_box_div_table_td">
		<input type="text" name="f_lending_username" id="f_lending_username" class="validate[required] input_cx_title_283">
		<input type="hidden" name="f_lending_userid" id="f_lending_userid">
	</td>
	<th class="content_02_box_div_table_th"><span class="color_red">*</span>所属部门：</th>
	<td class="content_02_box_div_table_td">
		<input type="text" name="f_dept_name" id="f_dept_name" class="validate[required] input_cx_title_283">
		<input type="hidden" name="f_dept_id" id="f_dept_id">
		<input type="hidden" name=f_org_name id="f_org_name">
		<input type="hidden" name=f_org_id id="f_org_id">
	</td>
</tr>
</table>

<%--低调table,作为增加行提供模板--%>
<table id='didiaoTable' style="display: none">
<tr id='datatr'>
	<input type="hidden" name="f_doc_id"/>
	<td class="content_02_box_div_table_td" style=" text-align: center;font-weight: bold;">
		<input type='text' class="validate[required] input_title_text" name="f_doc_num"  readonly="readonly"/>
	</td>
	<td class="content_02_box_div_table_td" style=" text-align: center;font-weight: bold;">
		<input type='text' class="input_title_text" name="f_file_no" readonly="readonly"//>
	</td>
	<td class="content_02_box_div_table_td" style=" text-align: center;font-weight: bold;">
		<input type='text' class="validate[required] input_title_text" name="f_doc_name" readonly="readonly"//>
	</td>
	<td class="content_02_box_div_table_td" style=" text-align: center;font-weight: bold;">
		<input type='text' class="validate[required] input_title_text" name="f_file_formtime" readonly="readonly"//>
	</td>
	<td class="content_02_box_div_table_td" style=" text-align: center;font-weight: bold;">
		<input type='text' class="validate[required,custom[onlyNumberSp]] input_title_text" name="OA_FILE_LENDING_DETAIL__F_LENDING_DAY" type="text" />
	</td>
	<td class="content_02_box_div_table_td" style="width:100px; text-align: center;">
		<%=selectData%>
	</td>
	<td class="content_02_box_div_table_td" style="width:100px; text-align: center;">
		<%=selectData1%>
		<input type='hidden' name="ydqxHidden" type="text" />
		<input type='hidden' name="f_file_num" type="text" />
	</td>
	<td class="content_02_box_div_table_td"> 
			 <div class="content_02_box_del" style="height:24px; margin:0;float: none;text-align: center;">
				<a onClick="deleteDay(this,'')"> <img src="ccapp/oa/file/image/buttom_del-02.gif" id="del"/>删除</a>
			 </div>
	</td>
</tr>
</table>
</body>
</oa:init>
</html>