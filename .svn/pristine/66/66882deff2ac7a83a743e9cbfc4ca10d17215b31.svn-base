<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@ taglib uri="/WEB-INF/archive-taglib.tld" prefix="oa"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.chinacreator.xtbg.core.archive.dao.FlowBusiDataSaveDao"%>
<%@page import="com.chinacreator.xtbg.core.file.service.FileDestroyService"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileDestroyServiceImpl"%>

<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
String path = request.getContextPath();
String windowsId = request.getParameter("windowsId");
//mypath
String mypath = request.getServletPath();
mypath = mypath.substring(0,mypath.lastIndexOf("/")+1);
mypath = request.getContextPath()+mypath;
//
String busi_id  = StringUtil.deNull(request.getParameter("busi_id"));
String backurl = StringUtil.deNull(request.getParameter("backurl"));

//流程控制
String jsptype = StringUtil.deNull(request.getParameter("jsptype"));
String dagly_id = StringUtil.deNull(request.getParameter("dagly_id"));
String operType = StringUtil.deNull(request.getParameter("operType"));
String action_id = request.getParameter("action_defid");
if(StringUtil.nullOrBlank(action_id)){
	action_id = "danganxiaohui_wp1_act1";
}
boolean canedit = false; //流程环节控制 
boolean isflow = false; //是否显示流程  
String openType = "111";
if(action_id.equals("danganxiaohui_wp1_act1")&&!operType.equals("yiban")){
	canedit = true;
}
if(jsptype.equals("")||jsptype==null){ 
	isflow = true;  //  这里是流程
}else{
	canedit =false;  //这里是 查看 数据 信息
}
if(!canedit){
	openType="011";
}
//获取借阅人基本信息
String F_USER_ID = accesscontroler.getUserID();
String F_USER_NAME = accesscontroler.getUserName();
UserCacheBean usercachebean=UserCache.getUserCacheBean(F_USER_ID);
String F_UNIT_ID=usercachebean.getUnit_id();
String F_UNIT_NAME=usercachebean.getUnit_name();
String F_ORG_ID = usercachebean.getOrg_id();
String F_ORG_NAME = usercachebean.getOrg_name();

//根据主表ID 取销毁清单数据
List<Map<String,String>> list = new ArrayList<Map<String,String>>();
FileDestroyService service = new FileDestroyServiceImpl();
if(!StringUtil.deNull(busi_id).equals("")){
	list = service.getFiledestoryDetail(busi_id);
}
Date dt=new Date();
SimpleDateFormat matter1=new SimpleDateFormat("yyyy-MM-dd");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<oa:init>
<!-- 引入jGrid -->
<script src="<%=mypath %>../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"  charset="utf-8" type="text/javascript"></script>
<script src="<%=mypath %>../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"  charset="utf-8" type="text/javascript"></script>

<script type="text/javascript" src="<%=mypath %>../resources/js/filedoc.js"></script>

<!-- 打印需要导入的内容、方法 -->
<script language="javascript" src="<%=mypath %>../../resources/plug/Lodop/LodopFuncs.js"></script> 
<object  id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>  
<!-- 是专为 FireFox 浏览器设计的代码  -->
<embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0 pluginspage="<%=path %>/resources/plug/Lodop/Lodopinstall_lodop.exe"></embed>
</object>

<title>移民局发文</title>

	<link rel="stylesheet" href="ccapp/oa/archive/css.css" type="text/css" />
<script type="text/javascript">
var canediat = "<%=isflow%>";
var action_id = "<%=action_id%>";
	jQuery(function() {
		jQuery("#tabs1").tabs();
		if(canediat=="false"){
			jQuery("#isshow").hide();
		}else{
			jQuery("#back").hide();
		}
		if(action_id=="danganxiaohui_wp1_act2" || action_id=="danganxiaohui_wp1_act3"){
			jQuery("select[name='f_isagree_destroyShow']").addClass("validate[required]").removeAttr("disabled");
		}
		openPrint();
		
	});
	initHtmlObj = function (){
		/*---
		jQuery("#tabs-1 input[type='button'][class='but_y_01']").hide();
		jQuery("#OA_FILE_DESTROY__F_DESTROY_TITLE").attr("readOnly","readOnly");
		jQuery("#OA_FILE_DESTROY__F_DESTROY_TITLE").attr("readOnly","readOnly");
		jQuery("#_filebut").hide();
		jQuery(".swiff-uploader-box").hide();
		*/
		jQuery("#_filebut").parent().css("padding-top","0");
	}
	function Add_Row4NewDay1(){
		var f_doc_id = "";
		jQuery("input[name=f_doc_id]").each(function(i,e){
			f_doc_id=f_doc_id+ jQuery(e).val() +",";
		});
		f_doc_id = f_doc_id.substr(0,f_doc_id.length-1);
		url = '<%=path%>/ccapp/oa/file/jsp/filedestroylist.jsp?windowsId=windowId&f_doc_ids='+f_doc_id;
		var flag = openAlertWindows('windowId',url, '选择档案文件' ,1020,530,'10%','10%');
	}

	//删除
	function deleteDay(tag,goodsId){
		var intable=jQuery(tag).parents("table");
		var tr=jQuery(tag).parents("tr").first();
		var trsize= jQuery(intable).find("tr[id=dayrow]").size();
		if(trsize==1){
			jQuery(tr).find("#f_doc_id").val("");
			jQuery(tr).find("#f_doc_year").val("");
			jQuery(tr).find("#f_file_no").val("");
			jQuery(tr).find("#f_doc_name").val("");
			jQuery(tr).find("#f_file_time").val("");
			jQuery(tr).find("#f_doc_yi_deadline").val("");
			jQuery(tr).find("#f_doc_deadline").val("");
			jQuery(tr).find("#f_type_remark").val("");
		}else{
			jQuery(tr).remove();
		}
	}

	var className="com.chinacreator.xtbg.core.file.entity.FileDestroyexportBean";
	function exportExcel(){
		var id = jQuery("#f_doc_ids").val();
		var url = getCurrentFilePath()+"/exportexcel.jsp?windowId=windowId_paperTJ"; 
		    var html = new Array();
		if(jQuery("#hiddenFrame").size()==0){
			html.push('<iframe id="hiddenFrame"  name="hiddenFrame" width=0 height=0></iframe>');
		}
		if(jQuery("#downFrom").size()>0){
			jQuery("#downFrom").remove();
		}
		
	    html.push('<form id="downFrom" name="downFrom" method="post" action="'+url+'" target="hiddenFrame">');
       	html.push("<input type='hidden' name='className' value='"+className+"' /> ");
       	html.push("<input type='hidden' name='busi_id' value='<%=busi_id%>' /> ");
       	
	    html.push('</form>');
	    //加载到body，提交后再删除
	    jQuery(html.join("")).appendTo("body").submit();
	}
	function resetSubmit(){
		jQuery("#form1").resetSubmit(false);
	}
	function addOneRow(model){
		var num = getNextRowId();
		var htmlStr = jQuery("#didiaoTable").html();
		htmlStr=htmlStr.replace("(dayrows_id)","dayrows-"+num);
		htmlStr=htmlStr.replace("(f_doc_id_id)","f_doc_id-"+num);
		htmlStr=htmlStr.replace("(f_doc_id_value)",model.f_doc_id);
		htmlStr=htmlStr.replace("(f_detail_id_id)","f_detail_id-"+num);
		htmlStr=htmlStr.replace("(f_detail_id_value)","_");
		htmlStr=htmlStr.replace("(f_doc_year_id)","f_doc_year-"+num);
		htmlStr=htmlStr.replace("(f_doc_year_value)",model.f_doc_year);
		htmlStr=htmlStr.replace("(f_file_no_id)","f_file_no-"+num);
		htmlStr=htmlStr.replace("(f_file_no_value)","&nbsp;"+model.f_file_no);
		htmlStr=htmlStr.replace("(f_doc_name_id)","f_doc_name-"+num);
		htmlStr=htmlStr.replace("(f_doc_name_value)",model.f_doc_name);
		htmlStr=htmlStr.replace("(f_file_time_id)","f_file_time-"+num);
		htmlStr=htmlStr.replace("(f_isagree_destroy_id)","f_isagree_destroy-"+num);
		htmlStr=htmlStr.replace("(f_isagree_destroyShow_id)","f_isagree_destroyShow-"+num);
		if(model.f_file_time_str){
			htmlStr=htmlStr.replace("(f_file_time_value)",""+model.f_file_time_str);
		}else{
			htmlStr=htmlStr.replace("(f_file_time_value)","&nbsp;");
		}
		htmlStr=htmlStr.replace("(f_doc_deadline_id)","f_doc_deadline-"+num);
		htmlStr=htmlStr.replace("(f_doc_deadline_value)","&nbsp;"+model.f_doc_deadline_name);
		htmlStr=htmlStr.replace("(f_doc_yi_deadline_id)","f_doc_yi_deadline-"+num);
		htmlStr=htmlStr.replace("(f_doc_yi_deadline_value)","&nbsp;"+model.f_doc_yi_deadline);
		htmlStr=htmlStr.replace("(f_type_remarks_id)","f_type_remarks-"+num);
		if(model.f_type_remark){
			htmlStr=htmlStr.replace("(f_type_remarks_value)",model.f_type_remark);
		}else{
			htmlStr=htmlStr.replace("(f_type_remarks_value)","&nbsp;");
		}
		
		htmlStr=htmlStr.replace("(del_id)","del-"+num);
		
		jQuery(htmlStr).appendTo(jQuery("#dayTable"));
		jQuery("#f_detail_id-"+num).val("");
	}
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

	function back(url){
		window.location = url,"perspective_content";
	}
	
</script>
</head>
<body >
<form id="form1" name="form1" action="" method="post" onsubmit="javascript:return false;">
<input type="hidden" id="busi_id"      name="busi_id"  value="<%=busi_id %>" /> 
<input type="hidden" id="opt_type"     name="opt_type" /> 
<input type="hidden" id="busiTypeCode" name="busiTypeCode" />
<input id="windowsId" name="windowsId" type="hidden" value="<%=windowsId%>"/>
<input value="<%=dagly_id%>" id="dagly_id" name="dagly_id" type="hidden"/><%--业务--%>
<input value="<%=action_id%>" id="action_defid" name="action_defid" type="hidden"/><%--业务--%>
<input value="com.chinacreator.xtbg.core.file.dao.imploracle.FileDestroyDaoImpl" type="hidden" id="<%=FlowBusiDataSaveDao.CUSTOM_CRUD_CLASSNAME_FLAG%>" name="<%=FlowBusiDataSaveDao.CUSTOM_CRUD_CLASSNAME_FLAG%>" />
<div id="isshow">
<oa:flowcommonstart flowType="1" />
</div>
<div class="content_02_top" style="margin-bottom: 10px;" id="back">
	<input name="" value="返回" onclick="back('<%=backurl%>')" type="button" class="but_y_01" />
</div>
<div id="tabs1" style="width:99%;overflow-x:hidden;">
	<div id="titleids">
		<ul>
			<li><a href="#tabs-1" >审签单</a></li>
			<li><a href="#tabs-2" >销毁清册</a></li>
		</ul>
	</div>
	<%--'tabs-1' begin：合同审签表--%>
<div id="tabs-1">
<table width="50%" border="0" cellspacing="1" cellpadding="0" style="margin-left: 15px; margin-right: 15px; display: inline;">
	<tr>
		<td style="padding-bottom: 10px;">
			<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="f_main">
				<tr>
					<td colspan="7">
						<div align="center"><span style="font-size: 20px; color: #ff0000;  line-height: 30px;"><strong>档案销毁申请单</strong></span> </div></td>
				</tr>
				<tr>
					<td colspan="7" class="hongse" style="margin: 0;padding: 0;line-height: 20px;"> 
						 <oa:view column="F_LD_IDEAS" table="OA_FILE_DESTROY" title="领导批示：" style="border: 1;width:99%;overflow: auto;" other="class='textarea_556'" />
					</td>
				</tr>
				<tr>
					<td style="margin: 0;padding: 0;line-height: 20px;width: 70%" rowspan="3" colspan="5">
						 <oa:view column="F_HQLD_IDEAS" table="OA_FILE_DESTROY" title="会签单位意见：" style="border: 1;width:99%;overflow: auto;" other="class='textarea_575'" />
					</td>
					<th style="width:10%" class="content_02_box_div_table_th">主办单位：</th>
					<td style="width:20%;">
						<oa:date dateFmt="yyyy-MM-dd" column="f_apply_time" table="OA_FILE_DESTROY" defaultValue="sysDate" style="display:none"/>
						<oa:input type="hidden" column="f_dept_name" table="OA_FILE_DESTROY" value="<%=F_UNIT_NAME%>"/>
						<oa:input type="hidden" column="f_dept_id" table="OA_FILE_DESTROY" value="<%=F_UNIT_ID%>"/>
						<oa:input type="text" column="f_org_name" table="OA_FILE_DESTROY" value="<%=F_ORG_NAME %>"    other='style="width:98%;margin-top:10px;" class="validate[maxSize[25]] input_title_text" '/>
						<oa:input type="hidden" column="f_org_id" table="OA_FILE_DESTROY" value="<%=F_ORG_ID %>"/>
				  </td>
				</tr>
				<tr>
					<th style="width:10%" class="content_02_box_div_table_th">负责人：</th>
					<td style="width:20%">
						<oa:input type="text" column="f_check_username" table="OA_FILE_DESTROY"  other='style = "width:98%;margin-top:10px;" class="validate[maxSize[25]] input_title_text"'  value="<%=accesscontroler.getUserName()%>"  />
					</td>
				</tr>
				<tr>
					<th style="width:10%" class="content_02_box_div_table_th">拟稿人：</th>
					<td style="width:20%">
						<oa:input type="text" column="f_apply_username" table="OA_FILE_DESTROY" value="<%=accesscontroler.getUserName() %>"  other='style = "margin-top:10px;width:98%;" class="validate[maxSize[25]] input_title_text" '   />
						<oa:input type="hidden" column="f_apply_userid" table="OA_FILE_DESTROY" value="<%=accesscontroler.getUserID() %>"	 />
					</td>
				</tr>
				<tr>
					<th style="width:10%" class="content_02_box_div_table_th"><span style="color: red;">*</span>标题：</th>
					<td style="width:90%" colspan="6">
						<oa:input type="text" column="F_DESTROY_TITLE" table="OA_FILE_DESTROY" other='style="margin-top:3px;width:98%;" class="validate[required,maxSize[25]] input_title_text" '/>
					</td>
				</tr>
				<tr>
					<th style="width:10%;vertical-align: top" class="content_02_box_div_table_th">附件：</th>
					<td style="width:90%" class="content_02_box_div_table_td" colspan="6">
						<oa:affixbut butName='请选择文件' column='F_ATTACH_ID' table='OA_FILE_DESTROY' operType="<%=openType%>"/>
					</td>
                </tr>
				<tr>
					<th class="content_02_box_div_table_th">附件列表：</th>
					<td class="content_02_box_div_table_td" colspan="6" id="_fileshow"></td>
				</tr>
			</table>
        	 <div class="content_02_box_title_bg" ><span>销毁正文</span> 
					<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
					<span class="color_red">提示：可以直接粘贴word、excel表格</span>
					<div class="content_02_box_add" id="t2"><span id="selAreaImg" class="tabs_search_text_but"></span></div>
			</div>
			<div class="content_02_box_div">
				<table border="0" cellspacing="0" cellpadding="0"
					class="content_02_box_div_table">
					<tr>
						<td colspan="4">
							<oa:eWebEditor1  column="f_destroy_reason"  table="OA_FILE_DESTROY" id="n_content" style="gray"/> 
						</td>
					</tr>
				</table>
			</div>
		</td>
	</tr>
</table>
	</div>

	<div id="tabs-2">
			<div class="content_02_box" style="width: 900px;">
				<div class="content_02_box_title_bg" style="width: 900px;">
					<span>销毁清单</span>
					<span style="display: block;float: right;"><a href="javascript:void(0);" onclick="exportExcel();" ><img src="ccapp/oa/file/image/add.gif"/>输出到excel&nbsp;</a></span>
					<%if(canedit){%>
					<span style="display: block;float: right;"><a href="javascript:void(0);" onclick="Add_Row4NewDay1();" ><img src="ccapp/oa/file/image/add.gif"/>添加待销毁的文件&nbsp;</a></span>
					<%} %>
					<script>
					</script>
				</div>
				<div class="content_02_box_div" style="width: 900px;">
					<div style="width: 900px" class="cGridArea">
					<table id="dayTable"  width="100%">
					<tr class="content_02_box_div_table user_data_table"  id="user_data_1">
						<td class="content_02_box_div_table_th" style="text-align: center;width: 6%">档案年份</td>
						<td class="content_02_box_div_table_th" style="text-align: center;width: 20%">档号</td>
						<td class="content_02_box_div_table_th" style="text-align: center;width: 20%">标题</td>
						<td class="content_02_box_div_table_th" style="text-align: center;width: 10%">归档日期</td>
						<td class="content_02_box_div_table_th" style="text-align: center;width: 6%">保管期限</td>
						<td class="content_02_box_div_table_th" style="text-align: center;width: 8%">已保管期限</td>
						<td class="content_02_box_div_table_th" style="text-align: center;width: 10%">备注</td>
						<td class="content_02_box_div_table_th" style="text-align: center;width: 8%">是否销毁</td>
						<%if(canedit){%>
						<td class="content_02_box_div_table_th" style="text-align: center;width: 6%">操作</td>
						<%} %>
					</tr>
					<%int i = 0;%>
					<%for(Map<String,String> map : list){%>
					<%i++;%>
					<tr id="dayrows-<%=i%>">
						<td class="content_02_box_div_table_td" style=" text-align: center;font-weight: bold;">
							<input type="hidden" name="f_doc_id" id="<%="f_doc_id-"+i%>" value="<%=StringUtil.deNull(map.get("f_doc_id"))%>"/>
							<input type="hidden" name="f_detail_id" id="<%="f_detail_id-"+i%>" value="<%=StringUtil.deNull(map.get("f_detail_id"))%>"/>
							<input type="hidden" name="f_user_id" id="f_user_id" value="<%=F_USER_ID %>"/>
							<input type="hidden" name="f_user_name" id="f_user_name" value="<%=F_USER_NAME%>"/>
							<input type="hidden" name="f_destroy_time" id="f_destroy_time" value="<%=matter1.format(dt)%>"/>
							<input type='text' class="input_title_text" name="f_doc_year" id="<%="f_doc_year-"+i%>" readonly="readonly" value="<%=StringUtil.deNull(map.get("f_doc_year"))%>"/>
						</td>
						<td class="content_02_box_div_table_td" style=" text-align: center;font-weight: bold;">
							<input type='text' class="input_title_text" name="f_file_no" id="<%="f_file_no-"+i%>" readonly="readonly" readonly="readonly" value="<%=StringUtil.deNull(map.get("f_file_no"))%>"/>
						</td>
						<td class="content_02_box_div_table_td" style=" text-align: center;font-weight: bold;">
							<input type='text' class="input_title_text" name="f_doc_name" id="<%="f_doc_name-"+i%>" readonly="readonly" value="<%=StringUtil.deNull(map.get("f_doc_name"))%>"/>
						</td>
						<td class="content_02_box_div_table_td" style=" text-align: center;font-weight: bold;">
							<input type='text' class="input_title_text" name="f_file_time" id="<%="f_file_time-"+i%>" readonly="readonly" value="<%=StringUtil.deNull(map.get("f_file_time"))%>"/>
						</td>
						<td class="content_02_box_div_table_td" style=" text-align: center;font-weight: bold;">
							<input type='text' class="input_title_text" name="f_doc_deadline" id="<%="f_doc_deadline-"+i%>"  type="text" readonly="readonly" value="<%=StringUtil.deNull(map.get("f_doc_deadline"))%>"/>
						</td>
						<td class="content_02_box_div_table_td" style="width:100px; text-align: center;">
							<input type='text' class="input_title_text" name="f_doc_yi_deadline" id="<%="f_doc_yi_deadline-"+i%>" readonly="readonly"/ value="<%=StringUtil.deNull(map.get("f_doc_deadlines"))%>">
						</td>
						<td class="content_02_box_div_table_td" style="width:100px; text-align: center;">
							<input type='text' class="input_title_text" name="f_type_remarks" id="<%="f_type_remarks-"+i%>" readonly="readonly" value="<%=StringUtil.deNull(map.get("f_type_remark"))%>"/>
						</td>
						<td class="content_02_box_div_table_td" style="width:100px; text-align: center;" >
							<select id="<%="f_isagree_destroyShow-"+i%>" name="f_isagree_destroyShow" disabled="disabled">
											<option value="" <%="".equals(map.get("f_isagree_destroy"))?("selected=\"selected\""):""%>>请选择</option>
											<option value="1" <%="1".equals(map.get("f_isagree_destroy"))?("selected=\"selected\""):""%>>同意销毁</option>
											<option value="2" <%="2".equals(map.get("f_isagree_destroy"))?("selected=\"selected\""):""%>>不同意销毁</option>
							</select>
							<input name="f_isagree_destroy" id="<%="f_isagree_destroy-"+i%>"  type='hidden'/>
							<script type="text/javascript">
								jQuery("#<%="f_isagree_destroy-"+i%>").val("<%=StringUtil.deNull(map.get("f_isagree_destroy"))%>");
								jQuery("#<%="f_isagree_destroyShow-"+i%>").change(function(){
									cObjId = "f_isagree_destroy-"+this.id.substring(22);
									jQuery("#"+cObjId).val(this.value);
								});
							</script>
						</td>
						<%if(canedit){%>
						<td class="content_02_box_div_table_td"> 
								 <div class="content_02_box_del" style="height:24px; margin:0;float: none;text-align: center;">
									<a onClick="deleteDay(this,'')"> <img src="ccapp/oa/file/image/buttom_del-02.gif" id="<%="del-"+i%>"/>删除</a>
								 </div>
						</td>
						<%}} %>
					</tr>
					</table>
					<input type='hidden' value="<%=i%>" name="count" id="count"/>
				</div>
			</div>
		</div>
	</div>
</div>
</form>
<IFRAME name=frame1 width=100% height=0> </IFRAME> 
<table id='didiaoTable' style="display: none">
<tr id="(dayrows_id)">
	<td class="content_02_box_div_table_td" style="text-align: center;font-weight: bold;">
		<input type="hidden" name="f_doc_id" id="(f_doc_id_id)" value="(f_doc_id_value)"/>
		<input type="hidden" name="f_detail_id" id="(f_detail_id_id)" value="(f_detail_id_value)"/>
		<input type="hidden" name="f_user_id" id="f_user_id" value="<%=F_USER_ID %>"/>
		<input type="hidden" name="f_user_name" id="f_user_name" value="<%=F_USER_NAME%>"/>
		<input type="hidden" name="f_destroy_time" id="f_destroy_time" value="<%=matter1.format(dt)%>"/>
		<input type='text' class="input_title_text" name="f_doc_year" id="(f_doc_year_id)" readonly="readonly" value="(f_doc_year_value)"/>
	</td>
	<td class="content_02_box_div_table_td" style=" text-align: center;font-weight: bold;">
		<input type='text' class="input_title_text" name="f_file_no" id="(f_file_no_id)" readonly="readonly" value="(f_file_no_value)"/>
	</td>
	<td class="content_02_box_div_table_td" style=" text-align: center;font-weight: bold;">
		<input type='text' class="input_title_text" name="f_doc_name" id="(f_doc_name_id)" readonly="readonly" value="(f_doc_name_value)"/>
	</td>
	<td class="content_02_box_div_table_td" style=" text-align: center;font-weight: bold;">
		<input readonly="readonly" type='text' class=" input_title_text" name="f_file_time" id="(f_file_time_id)"  value="(f_file_time_value)"/>
	</td>
	<td class="content_02_box_div_table_td" style=" text-align: center;font-weight: bold;">
		<input type='text' class="input_title_text" name="f_doc_deadline" id="(f_doc_deadline_id)"  type="text" readonly="readonly" value="(f_doc_deadline_value)"/>
	</td>
	<td class="content_02_box_div_table_td" style="width:100px; text-align: center;">
		<input type='text' class="input_title_text" name="f_doc_yi_deadline" id="(f_doc_yi_deadline_id)" readonly="readonly"/ value="(f_doc_yi_deadline_value)">
	</td>
	<td class="content_02_box_div_table_td" style="width:100px; text-align: center;">
		<input type='text' class="input_title_text" name="f_type_remarks" id="(f_type_remarks_id)" readonly="readonly" value="(f_type_remarks_value)"/>
	</td>
	<td class="content_02_box_div_table_td" style="width:100px; text-align: center;">
		<select id="(f_isagree_destroyShow_id)" name="f_isagree_destroyShow" disabled="disabled">
				<option value="0">请选择</option>
				<option value="1">同意销毁</option>
				<option value="2">不同意销毁</option>
		</select>
		<input name="f_isagree_destroy" id="(f_isagree_destroy_id)"  type='hidden'/>
	</td>
	<%if(canedit){%>
	<td class="content_02_box_div_table_td"> 
			 <div class="content_02_box_del" style="height:24px; margin:0;float: none;text-align: center;">
				<a onClick="deleteDay(this,'')"> <img src="ccapp/oa/file/image/buttom_del-02.gif" id="<%="del-"+i%>"/>删除</a>
			 </div>
	</td>
	<%} %>
</tr>
</table>

<%-------------- -------------- -------------- --------------%>
<form id="print_id" style='display:none'>
<table  width="620px;" border="0" cellspacing="1" cellpadding="0"  style="margin-left: 15px;margin-right: 15px; display: inline;">
<tr><td style="padding-bottom:10px;">
				<table width="620px;" border="0" align="center" cellpadding="0"
					cellspacing="1" class="f_main"
					style="font-family: 楷体; font-size: 14px; line-height: 30px; background: #ff0000;">
					<tr>
						<td colspan="7"
							style='border: 1px solid #fff; background: #ffffff; padding: 0px 10px; line-height: 30px; vertical-align: top;'
							align="center">
							<span
								style="font-size: 20px; color: #ff0000; line-height: 30px;">
								档案销毁申请单 </span>
						</td>
					</tr>
					<tr>
						<td colspan="7"
							style='height: 90px; border: 1px solid #fff; background: #ffffff; padding: 0px 10px; line-height: 30px; vertical-align: top;'>
							<span style="color: #ff0000; line-height: 30px;">领导批示： <div id='show_OA_FILE_DESTROY__F_LD_IDEAS'></div>
							</span>
						</td>
					</tr>
					<tr>
						<td rowspan=3 colspan="5"
							style='height: 90px; width: 60%; line-height: 30px; vertical-align: top; background: #fff;'>
							<span style="color: #ff0000; line-height: 30px;">会签单位意见： <div id='show_OA_FILE_DESTROY__F_HQLD_IDEAS'></div>
							</span>
						</td>
						<td
							style='width: 15%; line-height: 30px; vertical-align: middle; background: #fff; border-right: 1px solid #f00;'>
							<span style="color: #ff0000; line-height: 30px;">主办单位：
							</span>
						</td>
						<td
							style='width: 25%; line-height: 30px; vertical-align: middle; background: #fff; border-right: 1px solid #f00;'>
							<span style="color: #ff0000; line-height: 30px;"><div id='show_OA_FILE_DESTROY__F_ORG_NAME'></div>
							</span>
						</td>
					</tr>
					<tr>
						<td
							style='width: 10%; line-height: 30px; vertical-align: middle; background: #fff; border-right: 1px solid #f00;'>
							<span style="color: #ff0000; line-height: 30px;">负责人：</span>
						</td>
						<td
							style='width: 20%; line-height: 30px; vertical-align: middle; background: #fff; border-right: 1px solid #f00;'>
							<span style="color: #ff0000; line-height: 30px;"><div id='show_OA_FILE_DESTROY__F_CHECK_USERNAME'></div>
							</span>
						</td>
					</tr>
					<tr>
						<td
							style='width: 10%; line-height: 30px; vertical-align: middle; background: #fff; border-right: 1px solid #f00;'>
							<span style="color: #ff0000; line-height: 30px;">拟稿人：</span>
						</td>
						<td
							style='width: 20%; line-height: 30px; vertical-align: middle; background: #fff; border-right: 1px solid #f00;'>
							<span style="color: #ff0000; line-height: 30px;"><div id='show_OA_FILE_DESTROY__F_APPLY_USERNAME'></div>
							</span>
						</td>
					</tr>
					<tr>
						<td
							style='width: 15%; line-height: 30px; vertical-align:right; background: #fff;'>
							<span style="color: #ff0000; line-height:30px;text-align:right;margin:auto;">标题：</span>
						</td>
						<td colspan="6"
							style='width: 90%; line-height: 30px; vertical-align: middle; background: #fff;'>
							<span style="color: #ff0000; line-height: 30px;"><div id='show_OA_FILE_DESTROY__F_DESTROY_TITLE'></div>
							</span>
						</td>
					</tr>
					<!--tr>
						<td
							style='width: 15%; line-height: 30px; vertical-align: middle; background: #fff;'>
							<span style="color: #ff0000; line-height: 30px;">附件列表：</span>
						</td>
						<td colspan="6"
							style='width: 90%; line-height: 30px; vertical-align: middle; background: #fff;'>
							<span style="color: #ff0000; line-height: 30px;">
							<script>document.write(jQuery("#_fileshow").html());</script>
							</span>
						</td>
					</tr-->
					<tr>
						<td colspan="7"
							style='width: 90%; line-height: 30px; vertical-align: middle; background: #fff;' >
							<span style="color: #ff0000; line-height: 30px;" id="dayin_eWebEditor1">
								
							</span>
						</td>
					</tr>
				</table>
				<br/>
			<table width="620px;" border="0" align="center" cellpadding="0"
					cellspacing="1" class="f_main"
					style="font-family: 楷体; font-size: 14px; line-height: 30px; background: #ff0000;">
			<tr>
				<td colspan="8"
					style='border: 1px solid #fff; background: #ffffff; padding: 0px 10px; line-height: 30px; vertical-align: top;'
					align="center">
					<span
						style="font-size: 20px; color: #ff0000; line-height: 30px;">
						销毁清册</span>
				</td>
			</tr>
			<tr class="content_02_box_div_table user_data_table"  id="user_data_1">
			<td width="10%" style='border:1px solid #fff; background:#ffffff;text-align:center; line-height:30px; vertical-align:top;'><span style="color: #ff0000; line-height: 30px;">档案年份</td>
			<td width="10%" style='border:1px solid #fff; background:#ffffff;text-align:center; line-height:30px; vertical-align:top;'><span style="color: #ff0000; line-height: 30px;">档号</td>
			<td width="15%" style='border:1px solid #fff; background:#ffffff;text-align:center; line-height:30px; vertical-align:top;'><span style="color: #ff0000; line-height: 30px;">标题</td>
			<td width="15%" style='border:1px solid #fff; background:#ffffff;text-align:center; line-height:30px; vertical-align:top;'><span style="color: #ff0000; line-height: 30px;">归档日期</td>
			<td width="15%" style='border:1px solid #fff; background:#ffffff;text-align:center; line-height:30px; vertical-align:top;'><span style="color: #ff0000; line-height: 30px;">保管期限</td>
			<td width="15%" style='border:1px solid #fff; background:#ffffff;text-align:center; line-height:30px; vertical-align:top;'><span style="color: #ff0000; line-height: 30px;">已保管期限</td>
			<td width="10%" style='border:1px solid #fff; background:#ffffff;text-align:center; line-height:30px; vertical-align:top;'><span style="color: #ff0000; line-height: 30px;">备注</td>
			<td width="10%" style='border:1px solid #fff; background:#ffffff;text-align:center; line-height:30px; vertical-align:top;'><span style="color: #ff0000; line-height: 30px;">是否销毁</td>
			</tr>
			<%if(list.size()>0){ %>
			<%for(Map<String,String> map : list){%>
			<tr>
				<td width="10%" style='border:1px solid #fff; background:#ffffff;text-align:center; line-height:30px; vertical-align:top;'><span style="color: #ff0000; line-height: 30px;"><%=StringUtil.deNull(map.get("f_doc_year"))%></td>
				<td width="10%" style='border:1px solid #fff; background:#ffffff;text-align:center; line-height:30px; vertical-align:top;'><span style="color: #ff0000; line-height: 30px;"><%=StringUtil.deNull(map.get("f_file_no"))%></td>
				<td width="15%" style='border:1px solid #fff; background:#ffffff;text-align:center; line-height:30px; vertical-align:top;'><span style="color: #ff0000; line-height: 30px;"><%=StringUtil.deNull(map.get("f_doc_name"))%></td>
				<td width="15%" style='border:1px solid #fff; background:#ffffff;text-align:center; line-height:30px; vertical-align:top;'><span style="color: #ff0000; line-height: 30px;"><%=StringUtil.deNull(map.get("f_file_time"))%></td>
				<td width="15%" style='border:1px solid #fff; background:#ffffff;text-align:center; line-height:30px; vertical-align:top;'><span style="color: #ff0000; line-height: 30px;"><%=StringUtil.deNull(map.get("f_doc_deadline"))%></td>
				<td width="15%" style='border:1px solid #fff; background:#ffffff;text-align:center; line-height:30px; vertical-align:top;'><span style="color: #ff0000; line-height: 30px;"><%=StringUtil.deNull(map.get("f_doc_deadlines"))%></td>
				<td width="10%" style='border:1px solid #fff; background:#ffffff;text-align:center; line-height:30px; vertical-align:top;'><span style="color: #ff0000; line-height: 30px;"><%=StringUtil.deNull(map.get("f_type_remark"))%></td>
				<td width="10%" style='border:1px solid #fff; background:#ffffff;text-align:center; line-height:30px; vertical-align:top;'><span style="color: #ff0000; line-height: 30px;"><%="1".equals(map.get("f_isagree_destroy"))?"同意销毁":("2".equals(map.get("f_isagree_destroy"))?"不同意销毁":"")%></td>
			</tr>
			<%}} %>
	</table>
	</td></tr>
</table>
</form>
<%-------------- -------------- -------------- --------------%>
<script type="text/javascript">
var LODOP; //声明为全局变量 

function printNote() {	
	//打字份数赋值
	createPrintHtml();	
	LODOP.PREVIEW();
}

function createPrintHtml(){
		jQuery("#dayin_eWebEditor1").html('&nbsp;'+eWebEditor1.getHTML());
	  LODOP=getLodop(document.getElementById('LODOP'),document.getElementById('LODOP_EM'));
      LODOP.PRINT_INIT("打印销毁信息");
      LODOP.SET_PRINT_STYLEA(0,"FontSize",20);
      LODOP.SET_PRINT_STYLEA(0,"Horient",3);
      LODOP.SET_PRINT_STYLEA(0,"Vorient",3);
      addData();
      LODOP.ADD_PRINT_HTM(60,45,"80%","80%",document.getElementById("print_id").innerHTML);
}
function addData(){
	jQuery("#show_OA_FILE_DESTROY__F_LD_IDEAS").html(jQuery("#OA_FILE_DESTROY__F_LD_IDEAS").val());
	jQuery("#show_OA_FILE_DESTROY__F_HQLD_IDEAS").html(jQuery("#OA_FILE_DESTROY__F_HQLD_IDEAS").val());
	jQuery("#show_OA_FILE_DESTROY__F_ORG_NAME").html(jQuery("#OA_FILE_DESTROY__F_ORG_NAME").val());
	jQuery("#show_OA_FILE_DESTROY__F_CHECK_USERNAME").html(jQuery("#OA_FILE_DESTROY__F_CHECK_USERNAME").val());
	jQuery("#show_OA_FILE_DESTROY__F_DESTROY_TITLE").html(jQuery("#OA_FILE_DESTROY__F_DESTROY_TITLE").val());
}

function openPrint(){//开放打印功能
		var printBut = jQuery(['<div style="float:left;padding-right: 5px;padding-left:5px;">',
		                   	'<input class="but_y_01" onclick="printNote()"',
							' id="fawenprint"  type="button" value="打印"></input>',
		                   	'</div>'].join(''));
		jQuery(printBut).insertAfter(jQuery('DIV[name="flowOperationBtn"]').last());//将打印按钮动态绑定到流程页面的返回按钮后面
}
<%if(busi_id.length()==0&&request.getParameter("operType")==null){%>
var afterActionSuccessFn=function(operationType){
	if(getParentWindow('newwindows')){
		if("dotemp"==operationType){
			alert("操作成功");
			getParentWindow('newwindows').userSearch();
			resetSubmit();
			resetOptType("update");
		}else{
			alert("操作成功");
			getParentWindow('newwindows').userSearch();
			removeAlertWindows("newwindows",true);	
		}
	}else{
		if("dotemp"==operationType){
			alert("操作成功");
			resetSubmit();
			resetOptType("update");
		}else{
			alert("操作成功");
		}
	}
};
function returnPage() {
	var okF = function(){
		afterActionSuccessFn();
	}
	var p={
	      	headerText:'提示',
	      	okName:'确认',
	        okFunction:okF,
	        cancelName:'取消'
	    };
	alert('返回该页,未保存的信息将会丢失 '+'<br>'+'确定返回？',p);
}
<%}%>

jQuery(function(){
	initHtmlObj();
});

<%--依据环节id:初始化档案借阅清单--%>
<%if("danganxiaohui_wp1_act1".equals(action_id)){%>
checkDataBeforeRunFlow = function(){
	var flag = true;
	jQuery("#tabs1").tabs('select','tabs-1');//此处跳转至tabs-1进行验证。
	flag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
	
	try{
		if(flag&&!eWebEditor1.getHTML()){
			alert("请输入销毁正文");
			flag = false;
		}
	}catch(e){
		alert("WEB编辑器被禁用，请先配置授权");
		flag = false;
		return flag;
	}
	
	if(flag&&jQuery('#dayTable tr').size()<2){
		alert("请选择待销毁的档案");
		jQuery("#tabs1").tabs('select','tabs-2');
		flag = false;
	}
	if(!flag){
		resetSubmit();
	}
	return flag;
};
<%}%>
</script>
</body>
</oa:init>
</html>