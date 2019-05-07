<%-- 
描述：送后续环节
作者：shuqi.liu
版本：1.0
日期：2013-10-08
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.subsystemmanage.dao.impl.GwcsOrgConfigDaoImpl"%>
<%@page import="com.chinacreator.xtbg.core.archive.entity.ArchiveDispatchBean"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.WordArchiveService"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.impl.WordArchiveServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.archive.entity.OaWordNumberBean"%>
<%@page import="com.chinacreator.xtbg.core.archive.gwcs.bean.GwConstant"%>
<%@page import="com.chinacreator.xtbg.core.archive.gwcs.bean.GwConstant"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.OASystemCache" %>
<%@page import="java.io.File"%>
<%@ page import="java.net.URLDecoder"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<html>
<head>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	String user_id = accesscontroler.getUserID();
    UserCacheBean userBean = UserCache.getUserCacheBean(user_id);//获得缓存的机构信息
	String unit_id = userBean.getUnit_id();
	
    String n_attach_id = StringUtil.deNull(request.getParameter("n_attach_id"));
	String ins_id = request.getParameter("ins_id");
	String busi_id = request.getParameter("busi_id");
	String title = request.getParameter("title");
	if(!StringUtil.isBlank(title)){
		title = URLDecoder.decode(title,"UTF-8");
		title.trim();
	}
	String mRecordID =   StringUtil.deNull(request.getParameter("mRecordID"));
	WordArchiveService service = new WordArchiveServiceImpl();
	OaWordNumberBean oaWordNumberBean = service.getNumber(busi_id);
	String archive_code = "";
	String sender = "";
	
	if(oaWordNumberBean!=null){
		archive_code = oaWordNumberBean.getNumber_title();
		sender = oaWordNumberBean.getArchive_user();
	}
	
	String operType = "111";
	String optButName = "请选择文件";
	GwConstant gwConstant = new GwConstant();//公文传输常量
    String filePath = gwConstant.tmp_zip_attch_path+File.separator+ins_id+File.separator+"text"+mRecordID+".doc";
    String gwcsjspaddress = OASystemCache.getContextProperty("gwcsjspaddress");
    String tmp_zip_attch_path = OASystemCache.getContextProperty("tmp_zip_attch_path");
    
    String sql="select org_addr,org_name,org_id  from oa_gwcs_org ";
    String projectTypeHtml = DictDropDownList.buildSelect4Expand(sql,"org_name", "","",true,"","width:150px;","");
    
    ArchiveDispatchBean bean=new ArchiveDispatchBean();
    if(!StringUtil.isBlank(ins_id)){
    	bean=service.getArchiveDispatchbean(ins_id);
    	
    	String sendname="";
    	String remark1=bean.getRemark1();
    	if(!StringUtil.isBlank(remark1)){
	    	String []addr=remark1.split("#");
	    	for(int i=0;i<addr.length;i++){
	    		sendname +=addr[i].split(",")[1]+",";
	    	}
	    	if(!StringUtil.isBlank(sendname)){
	    		bean.setSend_org_name(sendname);
	    	}
    	}
    }
    
    String orgid=accesscontroler.getChargeOrgId();
    String orgname=accesscontroler.getChargeOrgName();
    GwcsOrgConfigDaoImpl impl=new GwcsOrgConfigDaoImpl();
    Map<String,String> orgmap= impl.findSubSystemOrgMappingInfoByOAid(orgid);
    String org_code=orgmap.get("gwcs_orgaddr");
    String org_name=orgmap.get("gwcs_orgname");
    
  //通过数据字典生成下拉框
	//1.文种
	String wzsql="select d.dictdata_name,d.dictdata_name from oa_dict_type t,oa_dict_data d where t.dict_id=d.dict_id  and t.dict_code='gwysxx'"
		 +"and d.dictdata_parent_id= (select dictdata_id from oa_dict_data where dictdata_value='wz') order by dictdata_order";
	
	String wzselect=DictDropDownList.buildSelect(wzsql,"dispatch_type","","",false,"");
	//2.紧急程度
	String jjcdsql="select d.dictdata_name,d.dictdata_name from oa_dict_type t,oa_dict_data d where t.dict_id=d.dict_id  and t.dict_code='gwysxx'"
		 +"and d.dictdata_parent_id= (select dictdata_id from oa_dict_data where dictdata_value='jjcd') order by dictdata_order";
	
	String jjcdselect=DictDropDownList.buildSelect(jjcdsql,"urgency_grade","","",false,"");
	//3.保密期限
	String bmqxsql="select d.dictdata_name,d.dictdata_name from oa_dict_type t,oa_dict_data d where t.dict_id=d.dict_id  and t.dict_code='gwysxx'"
		 +"and d.dictdata_parent_id= (select dictdata_id from oa_dict_data where dictdata_value='bmqx') order by dictdata_order";
	
	String bmqxselect=DictDropDownList.buildSelect(bmqxsql,"effect_date","","",false,"");
	//4.公文密级
	String gwmjsql="select d.dictdata_name,d.dictdata_name from oa_dict_type t,oa_dict_data d where t.dict_id=d.dict_id  and t.dict_code='gwysxx'"
		 +"and d.dictdata_parent_id= (select dictdata_id from oa_dict_data where dictdata_value='gwmj') order by dictdata_order";
	
	String gwmjselect=DictDropDownList.buildSelect(gwmjsql,"secrecy_grade","","",false,"");
	
	//发文单位,如果机构ID配置了该单位
	String fwdwsql="select id, config_name from oa_gwcs_org_config where instr(org_id,'"+unit_id+"') > 0";
	
	String fwdwselect=DictDropDownList.buildSelect(fwdwsql,"send_org_config","","fwdwChange();",false,"");
	
	String sendarchivetype = OASystemCache.getContextProperty("sendarchivetype");
%>
<title>送后续环节</title>
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
	<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
<!-- 引入上传控件 -->
<script type="text/javascript" src="../../resources/plug/fancyupload/mootools-1.2.5-core-jm.js"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/Fx.ProgressBar.js"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/Swiff.Uploader.js"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/FancyUpload3.Attach.js"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/myfancyupload.js"></script>
<script type="text/javascript" src="sendarchive.js"></script>
<script type="text/javascript">

jQuery(function() {
	MyFancyupload.createUpload('_fileshow', '#_filebut', '<%=path %>', '<%=path %>'+'/servlet/pubFileUpload?buessid=<%=n_attach_id %>',true,'<%=n_attach_id %>','','','<%=operType%>');
	jQuery("#title").focus();
	jQuery("#org").hide();
	jQuery("#orgmsg").hide();
	isCode();
});

//关闭
function isCode(){
	var archive_no=jQuery("#archive_no").val();
	if(IsSpace(archive_no)){
		alert("该公文还没编号，可能会无法正常分发！");
	}
}
//关闭
function closew(){
	getParentWindow("windowIds").closeAlertWindow();
	removeAlertWindows('windowIds',true);
}

function openAddress(){
	var is_split = jQuery("#dispatch_type").val();	//是否是指标文拆分文种
	var send_org_name=jQuery("#send_org_name").val();
	
	var send_org_config = jQuery("#send_org_config").val();	//获取发文单位配置信息
	var ins_id = "<%=ins_id%>";
	var _title = "公文传输地址本";
	if(is_split == "指标文"){
		is_split = 1;
		_title = "公文传输地址本 （标红的单位已与指标文关联！）";
	} else {
		is_split = 0;
	}
	openAlertWindows('gwcsAddress','<%=path%>/ccapp/oa/archive/wordarchive/gwcsaddress.jsp?subid=gwcsAddress&send_org_name='+send_org_name+'&is_split='+is_split+'&ins_id='+ins_id+'&send_org_config='+send_org_config,_title,900,600,'15%','20%');
}
function get_parentAddress_list(){
	return jQuery("#parentAddress_list").html();
}
function set_parentAddress_list(value,gwcs_address,gwcs_org_name){
	jQuery("#parentAddress_list").html("");
	jQuery("#parentAddress_list").html(value);
	jQuery("#send_org_name").val(gwcs_org_name).attr("title",gwcs_org_name);
	jQuery("#gwcs_address").val(gwcs_address);
}
function onarchive(aa){
	if(aa.value=='1'){
		jQuery("#org").show();
		jQuery("#orgmsg").show();
		jQuery("#union_archive").val("1");
	}else if(aa.value=='0'){
		jQuery("#org").hide();
		jQuery("#orgmsg").hide();
		jQuery("#union_archive").val("0");
	}
}
function openAddress11(){
	var is_split = jQuery("#dispatch_type").val();	//是否是指标文拆分文种
	var ins_id = "<%=ins_id%>";
	var _title = "公文传输地址本";
	if(is_split == "指标文"){
		is_split = 1;
		_title = "公文传输地址本 （标红的单位已与指标文关联！）";
	} else {
		is_split = 0;
	}
	openAlertWindows('gwcsAddress','<%=path%>/ccapp/oa/archive/wordarchive/gwcsaddress11.jsp?subid=gwcsAddress&is_split='+is_split+"&ins_id="+ins_id,_title,900,600,'15%','20%');
}
function addorg(){
	var org_name="";
	var org_code="";
	if(jQuery("#org_name").val()==''){
		alert("请先选一个单位");
		return;
	}else{
		org_name=jQuery("#org_name option[selected='selected']").attr("title");
		org_code=jQuery("#org_name option[selected='selected']").attr("value");
	}
	//var option="<option value="+org_code+" title="+org_name+">"+org_name+" </option>";
	var flag=0;

	jQuery("#orglist option").each(function(){
		if(this.value==org_code){
			alert("单位已经存在，请换一个单位！");
			flag=1;
		}
		
	});
	if(flag==0){
		jQuery("<option value="+org_code+" title="+org_name+">"+org_name+" </option>").appendTo("#orglist");//添加下拉框的option
	}

	//jQuery("#orglist").add
	
}
function delorg(){
	if('<%=org_code%>'==jQuery("#orglist option[selected='selected']").val()){
		alert("分发的本单位不可以删除！");
	}else{
		jQuery("#orglist option[selected='selected']").remove();
	}
}

function changeval(){
	if(jQuery("#is_sned_attach").attr("checked")=="checked"){
		jQuery("#is_sned_attach").val("1");
	}else{
		jQuery("#is_sned_attach").val("0");
	}
}

//发文单位change
function fwdwChange(){
	var curr_send_org_config = jQuery("#curr_send_org_config").val();
	var send_org_config = jQuery("#send_org_config").val();
	var send_org_name = jQuery("#send_org_name").val();
	//分发单位不为空才判断
	if(!IsSpace(send_org_name)){
		var okF = function() {
			 //重置分发单位，原配置
			 jQuery("#send_org_name").val("");
			 jQuery("#send_org_addr").val("");
			 jQuery("#send_org_id").val("");
			 jQuery("#parentAddress_list").html("");
			 jQuery("#gwcs_address").val("");
			 jQuery("#curr_send_org_config").val(send_org_config);
		}
		var cancelF = function(){
			//还原
			jQuery("#send_org_config").val(curr_send_org_config);
		}
		
		var p={
				headerText:'提示',
				okName:'确定',
		        okFunction:okF,
		        cancelName:'取消',
		        cancelFunction:cancelF
		};
		alert("重新选择发文单位会重置已经选择的分发单位，是否继续？",p);
	}
}

jQuery(function() {
	jQuery("#urgency_grade").val("<%=StringUtil.deNull(bean.getUrgency_grade())%>");
	jQuery("#dispatch_type").val("<%=StringUtil.deNull(bean.getDispatch_type())%>");
	jQuery("#effect_date").val("<%=StringUtil.deNull(bean.getEffect_date())%>");
	jQuery("#secrecy_grade").val("<%=StringUtil.deNull(bean.getSecrecy_grade())%>");
	jQuery("#send_org_config").val("<%=StringUtil.deNull(bean.getSend_org_config())%>");
	jQuery("#curr_send_org_config").val("<%=StringUtil.deNull(bean.getSend_org_config())%>");
	
	if("<%=StringUtil.deNull(bean.getIs_sned_attach())%>"=="1"){
		jQuery("#is_sned_attach").attr("checked","checked");
	}else if("<%=StringUtil.deNull(bean.getIs_sned_attach())%>"=="0"){
		jQuery("#is_sned_attach").removeAttr("checked");
	}
	var archive='<%=StringUtil.deNull(bean.getUnion_archive())%>';
	if(archive!=''){
		jQuery("#union_archive").val(archive);
	}
	if("1"==archive){
		jQuery("input[name='union_archive1'][value="+archive+"]").attr("checked",true);
		jQuery("#org").show();
		jQuery("#orgmsg").show();
	}
	var addr='<%=StringUtil.deNull(bean.getUnion_archive_addr())%>';
	if(""!=addr){
		addr.split("#").each(function(i,val){
			if(i!=""){
				var org_code=i.split(",")[0];
				var org_name=i.split(",")[1]
				jQuery("<option value="+org_code+" title="+org_name+">"+org_name+" </option>").appendTo("#orglist");
			}
		});
	}
	
	if('<%=org_code%>'!='' && jQuery("#orglist option").length==0){
		jQuery("<option value='<%=org_code%>' title='<%=org_name%>'><%=org_name%></option>").appendTo("#orglist");//添加下拉框的option
	} 
	
});
</script>

</head>
<body >
<%if("fzff".equals(sendarchivetype)){ %>
	<button id="button1" class="but_y_01" onclick="sendArchiveFZ()">方正分发</button>
<%}else if("wzff".equals(sendarchivetype)){ %>
	<button id="button1" class="but_y_01" onclick="sendArchive()">无章分发</button>
<%}else{ %>
	<button id="button1" class="but_y_01" onclick="agentSendArchive()">分发</button> 
<%}%>
<button id="button2" class="but_y_01" onclick="closew()">关闭</button>
<form id="form1" name="form1" action="" method="post">
<!-- 发文单位配置，用来控制地址薄是否重置 -->
<input type="hidden" name="curr_send_org_config" id="curr_send_org_config" value="" />
<div id="vcenter" style="float: left; width: 100%;"  >
	<div style="float: left; width: 775px;">
		<div class="content_02_box">
			<div class="content_02_box_div">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					id="content_02_box_div_table_02">
					<tr>
						<th class="content_02_box_div_table_th"><span style="color:red">*</span>公文标题：</th>
			            <td class="content_02_box_div_table_td" colspan="3">
						<input class="validate[required] input_160" style="width:99%" id="title" name="title" value="<%=title %>"   />
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th">主题词：</th>
			            <td class="content_02_box_div_table_td" >
						<input class="input_160"  style="width:190px;" id="caption" name="caption" value="<%=StringUtil.deNull(bean.getCaption())%>"   />
						</td>
						<th class="content_02_box_div_table_th"><span style="color:red">*</span>紧急程度：</th>
			            <td class="content_02_box_div_table_td" >
			            <%=jjcdselect %>
						<!-- <select name="urgency_grade" id="urgency_grade"  class="validate[required] cms_select" style="width:180px;"  >
				       		<option value="一般">一般</option>
				            <option value="紧急">紧急</option>
				            <option value="无">无</option>
				            
				        </select> -->
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th"><span style="color:red">*</span>发文号：</th>
			            <td class="content_02_box_div_table_td" >
						<input class="validate[required] input_160"  style="width:190px;" id="archive_no" name="archive_no" value="<%=archive_code %>"   />
						</td>
						<th class="content_02_box_div_table_th">文种：</th>
			            <td class="content_02_box_div_table_td" >
			            <%=wzselect %>
						<!-- <select name="dispatch_type" id="dispatch_type"  class="validate[required] cms_select" style="width:180px;" >
				       		<option value="函">函</option>
				       		<option value="通知">通知</option>
				       		<option value="请示">请示</option>
				       		<option value="指标文">指标文</option>
				       		<option value="无">无</option>
				        </select> -->
						</td>
					</tr>
					<tr id="xzsp_workflowControl_selectUser">
						<th class="content_02_box_div_table_th">关键字：</th>
			            <td class="content_02_box_div_table_td" >
						<input class="input_160"  style="width:190px;" id="key_word" name="key_word" value="<%=StringUtil.deNull(bean.getKey_word()) %>"   />
						</td>
						<th class="content_02_box_div_table_th">保密期限：</th>
			            <td class="content_02_box_div_table_td" >
			            <%=bmqxselect %>
						<!-- <select name="effect_date" id="effect_date"  class="validate[required] cms_select" style="width:180px;" >
				       		<option value="短期">短期</option>
				            <option value="长期">长期</option>
				            <option value="永久">永久</option>
				        </select> -->
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th">签发人：</th>
			            <td class="content_02_box_div_table_td" >
						<input class="input_160"  style="width:190px;" id="sender" name="sender" value="<%= sender %>"   />
						</td>
						<th class="content_02_box_div_table_th"><span style="color:red">*</span>公文密级：</th>
			            <td class="content_02_box_div_table_td" >
			            <%=gwmjselect %>
						<!-- <select name="secrecy_grade" id="secrecy_grade"  class="validate[required] cms_select" style="width:180px;" >
				       		<option value="无">无</option>
				            <option value="机密">机密</option>
				        </select> -->
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th"><span style="color:red">*</span>发文单位：</th>
			            <td class="content_02_box_div_table_td" >
			         	 <%=fwdwselect %> 
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th"><span style="color:red">*</span>分发单位：</th>	
			            <td class="content_02_box_div_table_td" colspan="3">
						<input class="validate[required] input_160"  style="width:99%;" id="send_org_name" name="send_org_name" value="<%=StringUtil.deNull(bean.getSend_org_name()) %>" onclick="openAddress()" />
						<input type="hidden" id="send_org_id" name="send_org_id" value="<%=StringUtil.deNull(bean.getSend_org_id()) %>"   />
						<input type="hidden" id="send_org_addr" name="send_org_addr" value="<%=StringUtil.deNull(bean.getSend_org_addr()) %>"   />
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th">正文附件是否分发：</th>
				        <td  class="content_02_box_div_table_td" style="text-align: left;">
				                <input type="checkbox" id="is_sned_attach" name="is_sned_attach" value="1" onclick="changeval()" checked="checked" />
				        </td>
						<th class="content_02_box_div_table_th"><span style="color:red">*</span>成文日期：</th>
			            <td class="content_02_box_div_table_td" >
						<input class="validate[required] date_120 Wdate" style="width: 180px; height: 24px;" type="text" id="create_date" name="create_date" value="<%=DateUtil.getCurrentDate()%>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
						</td>
			        </tr>
			        <!--<tr>
						<th class="content_02_box_div_table_th">是否发送短信：</th>
			            <td  class="content_02_box_div_table_td" style="text-align: left;">
			                <input type="checkbox" id="isdxtx" name="isdxtx" value="1"  />
			            </td>
					</tr>-->
					<tr>
						<th  class="content_02_box_div_table_02_th">短信内容配置：</th>
			            <td colSpan="7" class="content_02_box_div_table_td">
			                <textarea class="textarea_575" id="msg_txt" name="msg_txt" style="width:99%;height: 40px; margin:2px 0 2px; "><%=StringUtil.deNull(bean.getMsg_txt()) %></textarea> 
			            </td>
					</tr>
					<tr>
						<th  class="content_02_box_div_table_02_th">联合发文：</th>
			            <td colSpan="7" class="content_02_box_div_table_td">
			             <input type="radio" name="union_archive1" id="union_archive1" value="1"  onclick="onarchive(this)" />是
		   				 <input type="radio" name="union_archive1" id="union_archive1" value="0"  onclick="onarchive(this)" checked="checked"/>否
		   				 <input type="hidden" name="union_archive" id="union_archive" value="0"  onclick="onarchive(this)" />
			            </td>
					</tr>
					<tr id="org" style="height: 100px">
						<th  class="content_02_box_div_table_02_th">联合发文单位：</th>
						<td  class="content_02_box_div_table_td">
						<%=projectTypeHtml %>
						<input type="button" value="添加单位"  class="but_y_01"  onclick="addorg()">
						</td>
						<th  class="content_02_box_div_table_02_th">联合发文盖章单位：<br/>顺序从上到下</th>
						<td  class="content_02_box_div_table_td">
						<select multiple="multiple" style="height:80px;width:180px;" id="orglist"></select>
						<input type="button" value="删除单位"  class="but_y_01"  onclick="delorg()">
						</td>
						</tr>
					<tr id="orgmsg">
						<th  class="content_02_box_div_table_02_th">联合发文短信内容：</th>
			            <td colSpan="7" class="content_02_box_div_table_td">
			                <textarea class="textarea_575" id="lh_msg_txt" name="lh_msg_txt" style="width:99%;height: 40px; margin:2px 0 2px; "><%=StringUtil.deNull(bean.getUnion_archive_msg()) %></textarea> 
			            </td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th">附件：</th>
			            <td class="content_02_box_div_table_td" style="text-align:left;">
							<a href="#" id="_filebut" style="padding-left: 10px"><%=optButName %></a>			            
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th">附件列表：</th>
						<td  class="content_02_box_div_table_td" style="text-align:left;" colspan="3">
						<ul style="padding-left: 10px;height: 20px" id="_fileshow"></ul>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>
<input id="gwcs_address" name="gwcs_address" type="hidden" value="<%=StringUtil.deNull(bean.getRemark1()) %>">
<input id="ins_id" name="ins_id" value="<%=ins_id%>" type="hidden">
<input id="busi_id" name="busi_id" value="<%=busi_id%>" type="hidden">
<input id="mRecordID" name="mRecordID" value="<%=mRecordID%>" type="hidden">
<input id="n_attach_id" name="n_attach_id" value="<%=n_attach_id%>" type="hidden">
<input id="gwcsjspaddress" name="gwcsjspaddress" value="<%=gwcsjspaddress%>" type="hidden">
<input id="tmp_zip_attch_path" name="tmp_zip_attch_path" value="<%=tmp_zip_attch_path%>" type="hidden">

</form>
<div id="parentAddress_list" style="display: none;"></div>
</body>
</html>