<%--
描述：档案管理-档案借阅申请流程表单页面
作者：邹拓
版本：1.0
日期：2013-7-31
UTF-8
参数列表
busiTypeCode
addList 借阅文档集合
dagly_id 被借阅文档管理员ID
busi_id
--%>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
<%@page import="com.chinacreator.xtbg.core.archive.dao.FlowBusiDataSaveDao"%>
<%@page import="com.chinacreator.xtbg.core.file.entity.FilelendingBean"%>
<%@taglib uri="/WEB-INF/archive-taglib.tld" prefix="oa"%>
<%
String path = request.getContextPath();
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
String busi_id  = StringUtil.deNull(request.getParameter("busi_id"));
String windowsId = request.getParameter("windowsId");
//获取借阅人基本信息
String F_USER_ID = accesscontroler.getUserID();
String F_USER_NAME = accesscontroler.getUserName();
UserCacheBean usercachebean=UserCache.getUserCacheBean(F_USER_ID);

String F_UNIT_ID=usercachebean.getUnit_id();
String F_UNIT_NAME=usercachebean.getUnit_name();
String F_ORG_ID = usercachebean.getOrg_id();
String F_ORG_NAME = usercachebean.getOrg_name();
//获得借阅文档集合
String addList = request.getParameter("addList");
List<Map<String,String>> list = new ArrayList<Map<String,String>>();
FileLendingServiceIfc service = new FileLendingServiceImpl();
if(addList!=null){
	String[] addListArr = addList.split(",");
	//环节1新建 可能出现
	list = service.getFileLendingDetailForJYSQ(addListArr);
}else{
	list = service.getFileLendingDetailByKey(busi_id);
}
String dagly_id = StringUtil.deNull(request.getParameter("dagly_id"));
//介质类型下拉框
String sql = "select d.dictdata_value, d.dictdata_name from OA_DICT_DATA d, OA_DICT_TYPE t where t.dict_code = 'jzlx' and d.dict_id = t.dict_id and t.dict_is_valid = 1 and d.dictdata_is_valid = 1";
String selectData = DictDropDownList.buildSelect(sql.toString(),"jzlx-jzlx","","",true,"","");
//阅读权限下拉框
String sql1 = "select odd.dictdata_value, odd.dictdata_name from OA_DICT_DATA odd where odd.dict_id='12' order by odd.dictdata_order";
String selectData1 = DictDropDownList.buildSelect(sql1.toString(),"ydqx-ydqx","","",true,"","");

//流程环节控制
boolean canEdit=false;
boolean canEditJIEYUE=false;//能否编辑"是否可借阅"

String actId = request.getParameter("action_defid");
if(StringUtil.nullOrBlank(actId)){
	actId = FilelendingBean.ACT_JY_SQ;
}
String operType = request.getParameter("operType");
if(operType==null){
	if(FilelendingBean.ACT_JY_SQ.equals(actId)){
		canEdit=true;
	}
}else{
	if(operType.equals("null")
			||operType.equals("nosend")
			||operType.equals("daiban")){
		if(FilelendingBean.ACT_DAGLY_SH.equals(actId)||FilelendingBean.ACT_BM_SH.equals(actId)){
			canEditJIEYUE=true;
		}
		if(FilelendingBean.ACT_JY_SQ.equals(actId)){
			canEdit=true;
		}
	}
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title></title>
	<oa:init>
	<link rel="stylesheet" href="ccapp/oa/archive/css.css" type="text/css" />
	
<script type="text/javascript">
	<%--弹出选择窗口--%>
	function openAddPage(){
		var detailId = "";
		jQuery("#gridTable input[name=detailId]").each(function(i,e){
			detailId=detailId+ jQuery(e).val() +",";
		});
		detailId = detailId.substr(0,detailId.length-1);
		var dagly_id = jQuery("#dagly_id").val();
		var flag = openAlertWindows('windowId','<%=path%>/ccapp/oa/file/jsp/filelendingadd.jsp?windowsId=windowId&detailIds='+detailId+'&dagly_id='+dagly_id,'借阅篮',850,470,'25%','25%');
	}
	<%--增加列表中一行--%>
	function addOneRow(model){
		var num = getNextRowId();
		var htmlStr = jQuery("#didiaoTable").html();
		htmlStr=htmlStr.replace("(datarowTR)","datarowTR-"+num);
		htmlStr=htmlStr.replace("(datarow_id)","datarow-"+num);
		htmlStr=htmlStr.replace("(datarow_value)",""+num);
		htmlStr=htmlStr.replace("(datarownum_id)","datarownum-"+num);
		htmlStr=htmlStr.replace("(f_lending_type_id)","f_lending_type-"+num);
		htmlStr=htmlStr.replace("(f_read_purview_id)","f_read_purview-"+num);
		htmlStr=htmlStr.replace("(datarownum_value)",""+num);
		htmlStr=htmlStr.replace("(detailId_value)",model.f_detail_id);
		htmlStr=htmlStr.replace("(detailId_id)","detailId-"+num);
		htmlStr=htmlStr.replace("(f_doc_num_value)",model.f_doc_num);
		htmlStr=htmlStr.replace("(f_file_no_value)",model.f_file_no);
		htmlStr=htmlStr.replace("(f_doc_name_value)",model.f_doc_name);
		htmlStr=htmlStr.replace("(f_file_formtime_value)",model.f_creator_time_str);
		htmlStr=htmlStr.replace("jzlx-jzlx","jzlx-"+num);
		htmlStr=htmlStr.replace("ydqx-ydqx","ydqx-"+num);
		jQuery(htmlStr).appendTo(jQuery("#gridTable"));
		jQuery("#jzlx-"+num).val(model.f_doc_media);
		jQuery("#f_lending_type-"+num).val(model.f_doc_media);
		jQuery("#jzlx-"+num).attr("disabled","disabled");
		jQuery("#jzlx-"+num).change(function(){
			bObjId = "ydqx-"+this.id.substring(5);
			dObjId = "f_lending_type-"+this.id.substring(5);
			alert(this.value);
			jQuery("#"+bObjId).val(this.value);
			if(this.value=='0'||this.value=='1'){
				jQuery("#"+bObjId).removeAttr("disabled");
			}else{
				jQuery("#"+bObjId).attr("disabled","disabled");
				jQuery("#"+bObjId).val("");
			}
		});
		
		jQuery("#ydqx-"+num).change(function(){
			cObjId = "f_read_purview-"+this.id.substring(5);
			jQuery("#"+cObjId).val(this.value);
		});
		changeYDQX(jQuery("#jzlx-"+num)[0]);
		
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
	<%--获取下一个行号,支持addOneRow--%>
	del = function(){
		jQuery("#gridTable INPUT[name='datarow']").each(function(){
			if(this.checked){
				trId = "datarowTR-"+this.id.substring(8);
				jQuery("#"+trId).remove();
			}
			
			jQuery("#selectAllInput").removeAttr("checked");
		});
	};
	
	<%--全选按钮--%>
	selectAll = function(obj){
		flag = obj.checked;
		jQuery("#gridTable INPUT[name='datarow']").each(function(){
			this.checked = flag;
		});
	};
	changeSFKJY = function(flag){
		jQuery("#gridTable INPUT[name='datarow']").each(function(){
			if(this.checked){
				trId = "sfkjy-"+this.id.substring(8);
				var val = flag?"1":"0";
				jQuery("#"+trId).val(val);
			}
		});
	};
	<%--初始化档案借阅清单--%>
	<%if(canEdit){%>
		initgridTable = function(){
			//隐藏按钮
			jQuery("#btyBtnSpan").hide();
			jQuery("#tyBtnSpan").hide();
			//让是否可借阅只读
			jQuery("#gridTable SELECT[name^='sfkjy']").attr("disabled","disabled");
		}
	<%}else if(canEditJIEYUE){%>
		initgridTable = function(){
			//隐藏按钮
			jQuery("#delBtnSpan").hide();
			jQuery("#addBtnSpan").hide();
			//让借阅天数只读
			jQuery("#gridTable INPUT[name='f_lending_day']").attr("readOnly","readOnly");
			//让阅读权限只读
			jQuery("#gridTable SELECT[name^='ydqx']").attr("disabled","disabled");
		}
	<%}else{%>
		initgridTable = function(){
			//隐藏按钮
			jQuery("#btyBtnSpan").hide();
			jQuery("#tyBtnSpan").hide();
			jQuery("#delBtnSpan").hide();
			jQuery("#addBtnSpan").hide();
			//让借阅天数只读
			jQuery("#gridTable INPUT[name='f_lending_day']").attr("readOnly","readOnly");
			//让阅读权限只读
			jQuery("#gridTable SELECT[name^='ydqx']").attr("disabled","disabled");
			//让是否可借阅只读
			jQuery("#gridTable SELECT[name^='sfkjy']").attr("disabled","disabled");
		}
	<%}%>
	changeYDQX = function(obj){
		bObjId = "ydqx-"+obj.id.substring(5);
		cObjId = "f_read_purview-"+obj.id.substring(5);
		if(obj.value=='0'||obj.value=='1'){
			jQuery("#"+bObjId).removeAttr("disabled");
		}else{
			jQuery("#"+bObjId).attr("disabled","disabled");
			jQuery("#"+bObjId).val("");
		}
	};
	function resetSubmit(){
		jQuery("#form1").resetSubmit(false);
	}
	jQuery(function(){
		<%--初始化档案借阅清单--%>
		initgridTable();
		
	});




</script>

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

<form id="form1" name="form1" action="" method="post">
<input type="hidden" id="busi_id"      name="busi_id"  value="<%=busi_id %>" /> <%--基本--%>
<input type="hidden" id="opt_type"     name="opt_type" />  <%--基本--%>
<input type="hidden" id="busiTypeCode" name="busiTypeCode" /><%--基本--%>
<input value="<%=dagly_id%>" id="dagly_id" name="dagly_id" type="hidden"/><%--业务--%>
<input value="<%=actId%>" id="action_defid" name="action_defid" type="hidden"/><%--业务--%>
<input id="windowsId" name="windowsId" type="hidden" value="<%=windowsId%>"/>
<input value="com.chinacreator.xtbg.core.file.dao.imploracle.FileLendingDetailDaoImpl" id="<%=FlowBusiDataSaveDao.CUSTOM_CRUD_CLASSNAME_FLAG%>" name="<%=FlowBusiDataSaveDao.CUSTOM_CRUD_CLASSNAME_FLAG%>" type="hidden"/><%--业务--%>
<div id="tabs1" style="width:99%">
	<div id="tabs-1">
		<table width="95%" border="0" cellspacing="1" cellpadding="0"
			style="margin-left: 15px; margin-right: 15px; display: inline;">
			<tr>
				<td><oa:flowcommonstart flowType="1" />
				</td>
			</tr>
			<tr>
				<td style="padding-bottom: 10px;">
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
						<tr><%--row1--%>
							<th class="content_02_box_div_table_th">借阅人：</th>
							<td class="content_02_box_div_table_td">
								<oa:input
										type="text" column="F_LENDING_USERNAME" table="OA_FILE_LENDING"
										value="<%=F_USER_NAME%>"
										other="class='input_cx_title_240' readonly='readonly'" />
								<oa:input
										type="hidden" column="F_LENDING_USERID" table="OA_FILE_LENDING"
										value="<%=F_USER_ID%>"
										other="class='input_cx_title_240' readonly='readonly'" />
							</td>
							<th class="content_02_box_div_table_th">所属部门：</th>
							<td class="content_02_box_div_table_td">
								<oa:input
										type="text" column="F_DEPT_NAME" table="OA_FILE_LENDING"
										value="<%=F_ORG_NAME%>"
										other="class='input_cx_title_240' readonly='readonly'" />
								<oa:input
										type="hidden" column="F_DEPT_ID" table="OA_FILE_LENDING"
										value="<%=F_ORG_ID%>"
										other="class='input_cx_title_240' readonly='readonly'" />
										
								<oa:input
										type="hidden" column="F_ORG_ID" table="OA_FILE_LENDING"
										value="<%=F_UNIT_ID%>"
										other="class='input_cx_title_240' readonly='readonly'" />
								<oa:input
										type="hidden" column="F_ORG_NAME" table="OA_FILE_LENDING"
										value="<%=F_UNIT_NAME%>"
										other="class='input_cx_title_240' readonly='readonly'" />
							</td>
						</tr>
						<tr><%--row2--%>
							<th class="content_02_box_div_table_th">联系电话：</th>
							<td class="content_02_box_div_table_td">
								<oa:input type="text"
										column="F_TEL"
										 table="OA_FILE_LENDING" value="<%=StringUtil.deNull(usercachebean.getUser_mobiletel1())%>"
									     other="class='input_cx_title_240'"/>
							</td>
							<th class="content_02_box_div_table_th"><span
                                    class="color_red">*</span>申请日期：</th>
							<td class="content_02_box_div_table_td">
								<oa:date
									dateFmt="yyyy-MM-dd" column="F_CREATOR_TIME"
									table="OA_FILE_LENDING" defaultValue="sysDate"
									other="class='date_120 Wdate' style='width:245px'" />
							</td>
						</tr>
						<tr><%--row3--%>
							<th class="content_02_box_div_table_th" style="height: 70px"><span
                                    class="color_red">*</span>借阅理由：</th>
							<td class="content_02_box_div_table_td" colspan=4><oa:textarea
									column="F_LENDING_REASON" table="OA_FILE_LENDING"
									style="border: 1;width:99%;overflow: auto;"
									other="class='validate[maxSize[250]] textarea_556'" />
							</td>
						</tr>
						<tr><%--row4--%>
							<th class="content_02_box_div_table_th" style="height: 70px">审批意见：</th>
							<td class="content_02_box_div_table_td" colspan=4>
								<oa:view column="F_CHECKMSG" table="OA_FILE_LENDING" 
								style="border: 1;width:99%;overflow: auto;" other="class='validate[maxSize[1000]] textarea_556'" />
							</td>
						</tr>
					</table>
				</div>
			</div>
			
			<%--xia--%>
			<div class="content_02_box" style="width: 900px;">
				<div class="content_02_box_title_bg" style="width: 900px;">
					<span>借阅的档案清单</span>
					<span id='delBtnSpan' style="display: block;float: right;"><a href="javascript:void(0);" onclick="del();">
						<img src="ccapp/oa/file/image/buttom_del-02.gif"/>&nbsp;删除&nbsp;</a></span>
					<span id='addBtnSpan' style="display: block;float: right;"><a href="javascript:void(0);" onclick="openAddPage();">
						<img src="ccapp/oa/file/image/add.gif"/>&nbsp;增加&nbsp;</a></span>
					
					<span id='btyBtnSpan' style="display: block;float: right;"><a href="javascript:void(0);" onclick="changeSFKJY(false);">
						<img src="ccapp/oa/file/image/add.gif"/>不同意&nbsp;</a></span>
					<span id='tyBtnSpan' style="display: block;float: right;"><a href="javascript:void(0);" onclick="changeSFKJY(true);">
						<img src="ccapp/oa/file/image/add.gif"/>同意&nbsp;</a></span>
				</div>
				<div class="content_02_box_div" style="width: 900px;">
					<div style="float:left;width:100%;margin-left: -10px" class="cGridArea">
					<table id="gridTable">
					<tr class="content_02_box_div_table user_data_table" width="100%" border="0" cellspacing="0" cellpadding="0" datatype="1" id="user_data_1">
						<td class="content_02_box_div_table_th" style="width:5%; text-align: center;font-weight: bold;">
							<input type='checkbox' onclick="selectAll(this)" id="selectAllInput"/>
						</td>
						<td class="content_02_box_div_table_th" style="width:80px; text-align: center;font-weight: bold;">件号</td>
						<td class="content_02_box_div_table_th" style="width:100px; text-align: center;font-weight: bold;">档号</td>
						<td class="content_02_box_div_table_th" style="width:150px; text-align: center;font-weight: bold;">文件标题</td>
						<td class="content_02_box_div_table_th" style="width:100px; text-align: center;font-weight: bold;">文件形成日期</td>
						<td class="content_02_box_div_table_th" style="width:100px; text-align: center;font-weight: bold;"><span class="color_red">*</span>借阅天数</td>
						<td class="content_02_box_div_table_th" style="width:100px; text-align: center;font-weight: bold;">介质类型</td>
						<td class="content_02_box_div_table_th" style="width:100px; text-align: center;font-weight: bold;">阅读权限</td>
						<td class="content_02_box_div_table_th" style="width:100px; text-align: center;font-weight: bold;">是否可借阅</td>
					</tr>
					<%int i = 0;%>
					<%for(Map<String,String> map : list){%>
						<%i++;%>
					<tr class="content_02_box_div_table user_data_table" width="100%" border="0" cellspacing="0" cellpadding="0" datatype="1" id="<%="datarowTR-"+i%>">
						<td class="content_02_box_div_table_td" style="width:5%; text-align: center;font-weight: bold;">
							<input type='checkbox' name="datarow" id="<%="datarow-"+i%>" value="<%=i%>"/>
							<input type='hidden' value="<%=i%>" name="datarownum" id="<%="datarownum-"+i%>"/>
							<input type='hidden' value="<%=StringUtil.deNull(map.get("f_detail_id"))%>" name="<%="detailId"%>" id="<%="detailId-"+i%>"/>
						</td>
						<td class="content_02_box_div_table_td" style="width:80px; text-align: center;"><%=StringUtil.deNull(map.get("f_doc_num"))%></td>
						<td class="content_02_box_div_table_td" style="width:100px; text-align: center;"><%=StringUtil.deNull(map.get("f_file_no"))%></td>
						<td class="content_02_box_div_table_td" style="width:150px; text-align: center;"><%=StringUtil.deNull(map.get("f_doc_name"))%></td>
						<td class="content_02_box_div_table_td" style="width:100px; text-align: center;"><%=StringUtil.deNull(map.get("f_file_formtime"))%></td>
						<td class="content_02_box_div_table_td" style="width:100px; text-align: center;"><input name="f_lending_day" value="<%=StringUtil.deNull(map.get("f_lending_day"))%>" class="input_title_text_noborder input_text_center_wc arg1" type="text" /></td>
						<td class="content_02_box_div_table_td" style="width:100px; text-align: center;">
							<%=selectData.replaceAll("jzlx-jzlx","jzlx-"+i)%>
							<input name="<%="f_lending_type"%>" id="<%="f_lending_type-"+i%>"  type='hidden'/>
							<script type="text/javascript">
								jQuery("#<%="jzlx-"+i%>").val("<%=StringUtil.deNull(map.get("f_doc_media"))%>");
								jQuery("#<%="f_lending_type-"+i%>").val("<%=StringUtil.deNull(map.get("f_doc_media"))%>");
								jQuery("#<%="jzlx-"+i%>").attr("disabled","disabled");
								jQuery("#<%="jzlx-"+i%>").change(function(){
									bObjId = "ydqx-"+this.id.substring(5);
									cObjId = "f_read_purview-"+this.id.substring(5);
									dObjId = "f_lending_type-"+this.id.substring(5);
									jQuery("#"+dObjId).val(this.value);
									if(this.value=='0'||this.value=='1'){
										jQuery("#"+bObjId).removeAttr("disabled");
									}else{
										jQuery("#"+bObjId).attr("disabled","disabled");
										jQuery("#"+bObjId).val("");
										jQuery("#"+cObjId).val("");
									}
								});
							</script>
						</td>
						<td class="content_02_box_div_table_td" style="width:100px; text-align: center;">
							<%=selectData1.replaceAll("ydqx-ydqx","ydqx-"+i)%>
							<input name="<%="f_read_purview"%>" id="<%="f_read_purview-"+i%>"  type='hidden'/>
							<script type="text/javascript">
								jQuery("#<%="ydqx-"+i%>").val("<%=StringUtil.deNull(map.get("f_read_purview"))%>");
								jQuery("#<%="f_read_purview-"+i%>").val("<%=StringUtil.deNull(map.get("f_read_purview"))%>");
								jQuery("#<%="ydqx-"+i%>").change(function(){
									cObjId = "f_read_purview-"+this.id.substring(5);
									jQuery("#"+cObjId).val(this.value);
								});
								changeYDQX(jQuery("#<%="jzlx-"+i%>")[0]);
							</script>
						</td>
						<td class="content_02_box_div_table_td" style="width:100px; text-align: center;">
							<select id='sfkjy-<%=i%>' name='sfkjy' onchange='' style=''>
								<option value='' selected>---请选择---</option>
								<option value='1'>同意</option>
								<option value='0'>不同意</option>
							</select>
							<script type="text/javascript">
								jQuery("#sfkjy-<%=i%>").val("<%=StringUtil.deNull(map.get("f_isagree"))%>");
							</script>
						</td>
					</tr>
					<%}%>
					</table>
					<input type='hidden' value="<%=i%>" name="count" id="count"/>
				</div>
			</div>
		</div>
		<%--xia end--%>
	</div>
</div>
<%-- 主表单 end---%>
				</td>
			</tr>
		</table>
	</div>
</div>
</form>

<IFRAME name=frame1 width=100% height=0> </IFRAME> 
<%--低调table,作为增加行提供模板--%>
<table id='didiaoTable' style="display: none">
	<tr class="content_02_box_div_table user_data_table" width="100%" border="0" cellspacing="0" cellpadding="0" datatype="1" id="(datarowTR)">
		<td class="content_02_box_div_table_td" style="width:5%; text-align: center;font-weight: bold;">
			<input type='checkbox' name="datarow" id="(datarow_id)" value="(datarow_value)"/>
			<input type='hidden' value="(datarownum_value)" name="datarownum" id="(datarownum_id)"/>
			<input type='hidden' value="(detailId_value)" name="detailId" id="(detailId_id)"/>
		</td>
		<td class="content_02_box_div_table_td" style="width:80px; text-align: center;">(f_doc_num_value)</td>
		<td class="content_02_box_div_table_td" style="width:100px; text-align: center;">(f_file_no_value)</td>
		<td class="content_02_box_div_table_td" style="width:150px; text-align: center;">(f_doc_name_value)</td>
		<td class="content_02_box_div_table_td" style="width:100px; text-align: center;">(f_file_formtime_value)</td>
		<td class="content_02_box_div_table_td" style="width:100px; text-align: center;">
			<input name="f_lending_day" value="3" class="input_title_text_noborder input_text_center_wc arg1" type="text"/>
		</td>
		<td class="content_02_box_div_table_td" style="width:100px; text-align: center;">
			<%=selectData%>
			<input name="f_lending_type" id="(f_lending_type_id)"  type='hidden'/>
		</td>
		<td class="content_02_box_div_table_td" style="width:100px; text-align: center;">
			<%=selectData1%>
			<input name="f_read_purview" id="(f_read_purview_id)"  type='hidden'/>
		</td>
		<td class="content_02_box_div_table_td" style="width:100px; text-align: center;">
			<select disabled="disabled">
				<option value='' selected>---请选择---</option>
			</select>
		</td>
	</tr>
</table>
</body>
</oa:init>
<script type="text/javascript">
<%if(FilelendingBean.ACT_JY_SQ.equals(actId)){%>
checkDataBeforeRunFlow = function(){
	var flag = true;
	jQuery("#tabs1").tabs('select','tabs-1');//此处跳转至tabs-1进行验证。
	flag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
	if(flag&&jQuery('#gridTable tr').size()<2){
		alert("请选择借阅档案");
		flag = false;
	}
	
	if(flag){
		jQuery("#gridTable INPUT[name='f_lending_day']").each(function(){
			if(!this.value||isNaN(this.value)){
				flag = false;
				return;
			}
		});
		if(!flag){
			alert("请填写借阅天数(限数字)");
		}
	}
	
	
	if(flag){
		jQuery("#gridTable SELECT[name^='ydqx']").each(function(){
			if(!this.disabled&&!this.value){
				flag = false;
				return;
			}
		});
		if(!flag){
			alert("请填写阅读权限");
		}
	}
	if(!flag){
		resetSubmit();
	}
	return flag;
};





<%--重写跳转方法--%>
function doReturnOK(indexReturn) {
	window.location.href = "<%=path%>/ccapp/oa/file/jsp/filelendingflowtabs.jsp";
}
<%}%>
<%if("filelendingflowdolist".equals(request.getParameter("fromPage"))||"filelendingflowdonelist".equals(request.getParameter("fromPage"))){%>
jQuery("#btnreturn").hide();
<%}%>
<%if(operType==null&&(busi_id==null||busi_id.length()==0)){%>
var afterActionSuccessFn=function(){
	if(typeof(getParentWindow('<%=windowsId%>').userSearch)=="function"){
		getParentWindow('<%=windowsId%>').userSearch();
	}
	removeAlertWindows("<%=windowsId%>",true);
};
<%--第一个环节,如果入口是新增公文不重写,如果入口不是新增公文重写returnPage--%>
if(typeof(getParentWindow('<%=windowsId%>').userSearch)!='undefined'){
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
}
<%}%>
</script>
</html>