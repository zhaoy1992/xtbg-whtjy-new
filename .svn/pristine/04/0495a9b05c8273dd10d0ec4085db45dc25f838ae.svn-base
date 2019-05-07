<%-- 
描述：查询来文
作者：肖杰
版本：1.0
日期：2013-12-13
 --%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.core.archive.gwcs.services.impl.ReceiveGwServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.archive.gwcs.services.ReceiveGwService"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html; charset=utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.OASystemCache" %>
<%@page import="java.io.File"%>

<%
	String windowsId = request.getParameter("windowsId");
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	StringBuffer sql = new StringBuffer();
	sql.append("select org_name");
	sql.append("  from td_sm_organization");
	sql.append(" where parent_id = '0'");
	sql.append("   and org_id in");
	sql.append("       (select org_id");
	sql.append("          from td_sm_organization");
	sql.append("         start with org_id = '"+accesscontroler.getChargeOrgId()+"'");
	sql.append("        connect by prior parent_id = org_id)");
	String org_name = DaoUtil.sqlToField(sql.toString());
	boolean canEdit = true;
	Map<String,String> bean = new HashMap<String,String>();
	String gwreceive_id=StringUtil.deNull(request.getParameter("gwreceive_id"));
	if(gwreceive_id.length()>0){
		ReceiveGwService service=new ReceiveGwServiceImpl();
		bean=service.findReceiveGw(gwreceive_id);
		String attach_id=service.findAttachid(bean.get("attach_id"),bean.get("file_name"));
		org_name = bean.get("recv_org_name");
	}else{
		String attach_id=bean.get("attach_id");
		bean.put("attach_id",StringUtil.getUUID());
		bean.put("insert_by_self","1");
	}
	if("1".equals(bean.get("is_accept"))||!"1".equals(bean.get("insert_by_self"))){
		canEdit = false;
	}
	
	//通过数据字典生成下拉框
	//1.文种
	String wzsql="select d.dictdata_name,d.dictdata_name from oa_dict_type t,oa_dict_data d where t.dict_id=d.dict_id  and t.dict_code='gwysxx'"
		 +"and d.dictdata_parent_id= (select dictdata_id from oa_dict_data where dictdata_value='wz') order by dictdata_order";
	
	String wzselect=DictDropDownList.buildSelect(wzsql,"dispatch_type","","",true,"");
	//2.紧急程度
	String jjcdsql="select d.dictdata_name,d.dictdata_name from oa_dict_type t,oa_dict_data d where t.dict_id=d.dict_id  and t.dict_code='gwysxx'"
		 +"and d.dictdata_parent_id= (select dictdata_id from oa_dict_data where dictdata_value='jjcd') order by dictdata_order";
	
	String jjcdselect=DictDropDownList.buildSelect(jjcdsql,"urgency_grade","","",true,"");
	//3.保密期限
	String bmqxsql="select d.dictdata_name,d.dictdata_name from oa_dict_type t,oa_dict_data d where t.dict_id=d.dict_id  and t.dict_code='gwysxx'"
		 +"and d.dictdata_parent_id= (select dictdata_id from oa_dict_data where dictdata_value='bmqx') order by dictdata_order";
	
	String bmqxselect=DictDropDownList.buildSelect(bmqxsql,"effect_date","","",true,"");
	//4.公文密级
	String gwmjsql="select d.dictdata_name,d.dictdata_name from oa_dict_type t,oa_dict_data d where t.dict_id=d.dict_id  and t.dict_code='gwysxx'"
		 +"and d.dictdata_parent_id= (select dictdata_id from oa_dict_data where dictdata_value='gwmj') order by dictdata_order";
	
	String gwmjselect=DictDropDownList.buildSelect(gwmjsql,"secrecy_grade","","",true,"");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title></title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 引入上传控件 -->
<script type="text/javascript" src="../../resources/plug/fancyupload/mootools-1.2.5-core-jm.js"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/Fx.ProgressBar.js"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/Swiff.Uploader.js"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/FancyUpload3.Attach.js"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/myfancyupload.js"></script>
<script type="text/javascript" src="../wordarchive/sendarchive.js"></script>

<link rel="stylesheet" href="../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
jQuery(function() {
	initPage();
});
//关闭
function closew(){
	removeAlertWindows('<%=windowsId%>',true);
}
function save(){
	if(jQuery("#_fileshow li").size()<1){
		alert('请上传文件');
		return false;
	}
	var isFlag = jQuery('#onlyFrom').validationEngine('validate'); //是否全部验证通过
	if (isFlag){
		jQuery("#hidden_action").val("addGwreceiveBean");
		jQuery("#onlyFrom").attr("target","gwreceiveinfodoJSPhiddenFrame");
		jQuery("#onlyFrom").submit();
	}
}

afterSubmitFn=function(result){
	try{
		alert(result);
		getParentWindow("<%=windowsId%>").userSearch();
		removeAlertWindows('<%=windowsId%>',true);
	}catch(e){alert(e.description);}
}
function initPage(){
	jQuery("#title").focus();
	jQuery("#urgency_grade").val("<%=StringUtil.deNull(bean.get("urgency_grade"))%>");
	jQuery("#dispatch_type").val("<%=StringUtil.deNull(bean.get("dispatch_type"))%>");
	jQuery("#effect_date").val("<%=StringUtil.deNull(bean.get("effect_date"))%>");
	jQuery("#secrecy_grade").val("<%=StringUtil.deNull(bean.get("secrecy_grade"))%>");
	
	<%if(!canEdit){%>
		jQuery("input[type=text]").prop("readonly",true);
		jQuery("#fjTr").hide();
		jQuery(".swiff-uploader-box").hide();
		jQuery("#button1").hide();
		jQuery("INPUT[name='issign']").attr("disabled","disabled");
		jQuery("SELECT").attr("disabled","disabled");
		
		MyFancyupload.createUpload('_fileshow',
				'#_filebut',
				'<%=path %>',
				'<%=path %>/servlet/pubFileUpload?buessid=<%=bean.get("attach_id") %>',
				true,
				'<%=bean.get("attach_id") %>','','',
				'011');
		//隐藏上传按钮 
		jQuery(".swiff-uploader-box").hide();
	<%}else{%>
		MyFancyupload.createUpload('_fileshow',
			'#_filebut',
			'<%=path %>',
			'<%=path %>/servlet/pubFileUpload?buessid=<%=bean.get("attach_id")%>',
			true,
			'<%=bean.get("attach_id") %>','',
			function(){
				autoTitle("#file_name",jQuery("#_fileshow li:last")[0].innerText);
			},
			'111');
	
	jQuery("#onlyFrom").validationEngine();
	
	jQuery("#symbol").click(function(){
		WdatePicker({dateFmt:'yyyy'});
	});
	jQuery("#create_date").click(function(){
		WdatePicker({dateFmt:'yyyy-MM-dd'});
	});
	jQuery("#send_date").click(function(){
		WdatePicker({dateFmt:'yyyy-MM-dd'});
	});
	<%}%>
}

outSideSelectedIdsZHLB = '';
selectZHLB = function(){
	var s = new jQuery.z_tree();
	s.type = "inqueryTreeDictDataByDictType";
	s.dictCode = "wenjianzihao";
	s.treeID = "TreeDictDataByDictType";
	s.treetypestr = 'radio';
	s.isShowSeacher = true;
	s.treeName = "字号类别";
	s.headerName = s.treeName;
	s.selectedIds = outSideSelectedIdsZHLB,
	s.isType = 'dept',
	s.returnFunction = function(fuyun,nodes) {
		showVal = '';
		if(nodes&&nodes.length==1){
			jQuery('#prefix').val(nodes[0].name);
			outSideSelectedIdsZHLB = nodes[0].org_id;
		}else{
			jQuery('#prefix').val("");
			outSideSelectedIdsZHLB = '';
		}
	}
	s.init();
};

function autoTitle(tmp_titleDom,tmp_fileName){
	try {
		var indexofpoint = tmp_fileName.indexOf(" ");
		if( indexofpoint != -1){
			var fileName = tmp_fileName.substring(0,indexofpoint);
			if(jQuery(tmp_titleDom).val()!=""){
				jQuery(tmp_titleDom).val(jQuery(tmp_titleDom).val()+","+fileName);
			}else{
				jQuery(tmp_titleDom).val(jQuery(tmp_titleDom).val()+fileName);
			}
		} else {
			jQuery(tmp_titleDom).val(jQuery(tmp_titleDom).val()+","+tmp_fileName);
		}
	} catch(error){
		jQuery(tmp_titleDom).val("");
	}
}
</script>

</head>
<body >
<iframe id="gwreceiveinfodoJSPhiddenFrame" name="gwreceiveinfodoJSPhiddenFrame" width=0 height=0></iframe>
<div style="width:900px;float:left;">
	<div class="content_02_top">
		<button id="button1" style='margin-top: 7px;margin-left: 5px;' class="but_y_01" onclick="save()">保存</button>
		<button id="button2" style='margin-top: 7px;margin-left: 5px;' class="but_y_01" onclick="closew()">关闭</button>
		<button id="button3" style='margin-top: 7px;margin-left: 5px;' disabled="disabled" class="but_y_06">扫二维码</button>
	</div>

<form id="onlyFrom" name="onlyFrom" method="post"
	action="gwreceiveinfodo.jsp">
	<input type='hidden' name='action' id="hidden_action"/>
	<input type='hidden' name='insert_by_self' id="insert_by_self" value="<%=StringUtil.deNull(bean.get("insert_by_self"))%>"/>
	<input type='hidden' name='gwreceive_id' id="gwreceive_id" value="<%=StringUtil.deNull(bean.get("gwreceive_id"))%>"/>
	<input type='hidden' name='recv_org_addr' id="recv_org_addr" value="<%=StringUtil.nullOrBlank(bean.get("recv_org_addr"))?"00000000000000000000":(bean.get("recv_org_addr"))%>"/>
	<input type='hidden' name='recv_org_name' id="recv_org_name" value='<%=StringUtil.nullOrBlank(bean.get("recv_org_name"))?"湖南省财政厅":(bean.get("recv_org_name"))%>'/>
	<input type='hidden' name='send_org_addr' id="send_org_addr" value="<%=StringUtil.nullOrBlank(bean.get("send_org_addr"))?"00000000000000000000":(bean.get("send_org_addr"))%>"/>
	<input type='hidden' name='attach_id' id="attach_id" value="<%=bean.get("attach_id")%>"/>
	<input type='hidden' name='is_accept' id="is_accept" value="<%=0%>"/>
<div id="vcenter" style="float:left;width:100%; overflow:hidden;">
	<div style="float: left; width: 775px;">
		<div class="content_02_box">
			<div class="content_02_box_div">
<table width="100%" border="0" cellspacing="0" cellpadding="0" id="content_02_box_div_table_02">
	<tr>
		<th class="content_02_box_div_table_th"><span style="color: red">*</span>公文标题：</th>
		<td class="content_02_box_div_table_td" colspan="3">
		<input
			type="text" class="validate[required,maxSize[50]] input_160" style="width: 99%"
			id="title" name="title"
			value="<%=StringUtil.deNull(bean.get("title")) %>" />
			</td>
	</tr>
	<tr>
		<th class="content_02_box_div_table_th">主题词：</th>
		<td class="content_02_box_div_table_td"><input type="text"
			class="validate[maxSize[50]] input_160" style="width: 190px;"
			id="caption" name="caption"
			value="<%=StringUtil.deNull(bean.get("caption"))%>" /></td>
		<th class="content_02_box_div_table_th">关键字：</th>
		<td class="content_02_box_div_table_td"><input type="text"
			class="validate[maxSize[50]] input_160" style="width: 190px;"
			id="keyword" name="keyword"
			value="<%=StringUtil.deNull(bean.get("keyword")) %>" /></td>
	</tr>
	<tr>
		<th class="content_02_box_div_table_th"><span style="color: red">*</span>来文单位：</th>
		<td class="content_02_box_div_table_td"><input
			type="text" class="validate[required,maxSize[20]] input_160" style="width: 99%;"
			id="send_org_name" name="send_org_name"
			value="<%=StringUtil.deNull(bean.get("send_org_name")) %>" /></td>
		<th class="content_02_box_div_table_th"><span style="color: red">*</span>来文日期：</th>
		<td class="content_02_box_div_table_td"><input type="text"
			class="validate[required] date_120 Wdate"
			style="width: 180px; height: 24px;" type="text" id="send_date"
			name="send_date"
			value="<%=StringUtil.deNull(bean.get("send_date"))%>" /></td>
	</tr>
	<tr>
		<th class="content_02_box_div_table_th"><span style="color: red">*</span>公文文号：</th>
		<td class="content_02_box_div_table_td"><input type='text'
			name='prefix' id='prefix' style='width: 35px'
			class='validate[required,maxSize[20]] input_160'
			value='<%=StringUtil.deNull(bean.get("prefix"))%>' /> <input
			type="button" class="but_x" onclick="selectZHLB();"
			style="float: left" />
		<input type='text' name='symbol' id='symbol'
			style='width: 66px; display: block; height: 24px' readonly='readonly'
			class='validate[required,maxSize[4],custom[onlyNumberSp]] date_120'
			value='<%=StringUtil.deNull(bean.get("symbol")).replaceAll("\\〔","").replaceAll("\\〕","")%>' />
		<input type='text' name='serial_number'
			id='serial_number' style='width: 40px; display: block;'
			class='validate[required,maxSize[20],custom[onlyNumberSp]] input_160'
			value='<%=StringUtil.deNull(bean.get("serial_number")).replaceAll("号","")%>' />&nbsp;号</td>
		<th class="content_02_box_div_table_th">文种：</th>
		<td class="content_02_box_div_table_td">
			<%=wzselect %>
			<!-- <select name="dispatch_type" id="dispatch_type"  class="cms_select" 
style="width:180px;" >
				<option value="">---请选择---</option>
	       		<option value="函">函</option>
	       		<option value="通知">通知</option>
	       		<option value="请示">请示</option>
	       		<option value="指标文">指标文</option>
	       		<option value="无">无</option>
	        </select> -->
	    </td>
	</tr>
	<tr>
		<th class="content_02_box_div_table_th">紧急程度：</th>
		<td class="content_02_box_div_table_td">
			<%=jjcdselect %>
			<!-- <select name="urgency_grade" id="urgency_grade"  class="cms_select"  style="width:180px;"  >
	       		<option value="">---请选择---</option>
	       		<option value="一般">一般</option>
	            <option value="紧急">紧急</option>
	            <option value="无">无</option>
	        </select> -->
	    </td>
		<th class="content_02_box_div_table_th">保密期限：</th>
		<td class="content_02_box_div_table_td">
			<%=bmqxselect %>
			<!-- <select name="effect_date" id="effect_date"  class="cms_select" style="width:180px;" >
	       		<option value="">---请选择---</option>
	       		<option value="短期">短期</option>
	            <option value="长期">长期</option>
	            <option value="永久">永久</option>
	        </select> -->
	    </td>
	</tr>
	<tr>
		<th class="content_02_box_div_table_th">签发人：</th>
		<td class="content_02_box_div_table_td"><input type="text"
			class="validate[maxSize[25]] input_160" style="width: 190px;"
			id="sender" name="sender"
			value="<%=StringUtil.deNull(bean.get("sender")) %>" /></td>
		<th class="content_02_box_div_table_th">公文密级：</th>
		<td class="content_02_box_div_table_td">
			<%=gwmjselect %>
		  <!--   <select  name="secrecy_grade" id="secrecy_grade"  class="cms_select"  style="width:180px;" >
	       		<option value="">---请选择---</option>
	       		<option value="无">无</option>
	            <option value="机密">机密</option>
	        </select> -->
	</tr>
	<tr>
		<th class="content_02_box_div_table_th"><span style="color: red">*</span>来文文件名称：</th>
		<td class="content_02_box_div_table_td" colspan="3"><input type="text"
			class="validate[required,maxSize[50]] input_160" type="text" id="file_name" style="width: 99%"
			name="file_name"
			value="<%=StringUtil.deNull(bean.get("file_name"))%>" /></td>
	</tr>
	<tr>
		<th class="content_02_box_div_table_th">收文处理单位：</th>
		<td class="content_02_box_div_table_td" colspan="3"><input
			type="text" class="input_160" style="width: 99%;" readOnly='readOnly'
			id="org_name" name="org_name" value="<%=org_name%>" /></td>
	</tr>
	<tr>
		<th class="content_02_box_div_table_th">成文日期：</th>
		<td class="content_02_box_div_table_td"><input type="text"
			class="date_120 Wdate"
			style="width: 180px; height: 24px;" type="text" id="create_date"
			name="create_date"
			value="<%=StringUtil.deNull(bean.get("create_date"))%>" /></td>
		<th class="content_02_box_div_table_th">是否加盖电子印章：</th>
		<td class="content_02_box_div_table_td">
			<input type='radio'
				   name = 'issign'
			       value ='true'
			       <%=StringUtil.deNull(bean.get("issign")).equals("false")?"":"checked=\"checked\""%>
			/>&nbsp;是
			&nbsp;<input type='radio'
				   name = 'issign'
			       value ='false'
			       <%=StringUtil.deNull(bean.get("issign")).equals("false")?"checked=\"checked\"":""%>
			/>&nbsp;否
		</td>
	</tr>
	
	
	<tr>
		<th class="content_02_box_div_table_th">发布层次：</th>
		<td class="content_02_box_div_table_td"><input type="text"
			class="validate[maxSize[20]] input_160"
			style="width: 99%;" type="text" id="sendscope"
			name="sendscope"
			value="<%=StringUtil.deNull(bean.get("sendscope"))%>" /></td>
		<th class="content_02_box_div_table_th">发文操作的用户名称：</th>
		<td class="content_02_box_div_table_td"><input type="text"
			class="validate[maxSize[20]] input_160" type="text" id="sendusername" style="width: 99%;"
			name="sendusername"
			value="<%=StringUtil.deNull(bean.get("sendusername"))%>" /></td>
	</tr>
	
	<tr>
		<th class="content_02_box_div_table_th" style="width: 150px;">
			<span style="color: red">*</span>附件：<br/>
		</th>
		<td class="content_02_box_div_table_td" colspan="3">
			<span style='padding-left:5px;' id='fjTr'>
			<a href="javascript:void(0);" id="_filebut" >请选择文件</a>
			</span>
			<div>
			<ul id="_fileshow" style="float:left;overflow-y: auto;overflow-x:hidden;margin:1px ;padding-left:10px;background:white;border:0px;background:white;border:0;">
			</ul></div>
		</td>
	</tr>
	
</table>
</div>
</div>
</div>
</div>
</form>
</div>
</body>
</html>