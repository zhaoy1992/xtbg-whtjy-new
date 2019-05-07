<%--
描述：个人资料基本信息
作者：邱炼
版本：1.0
日期：2013-08-14
--%>
<%@page import="com.chinacreator.xtbg.core.common.util.DbManager"%>
<%@page import="com.chinacreator.xtbg.core.upload.util.UploadConstants"%>
<%@page import="com.chinacreator.xtbg.core.persondata.service.impl.PsdataTypeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.persondata.service.PsdataTypeService"%>
<%@page import="com.chinacreator.xtbg.core.persondata.service.PsdataBaseService"%>
<%@page import="com.chinacreator.xtbg.core.persondata.service.impl.PsdataBaseServiceImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	
	Map<String,String> bean = new HashMap<String,String>();
	
	String actionName = request.getParameter("actionName");
	String actionNameStr = "";
	String document_recordid ="";
	//当前类别ID
	String user_id = accesscontroler.getUserID();
	String p_type_id = request.getParameter("p_type_id");
	//资料ID
	String p_data_id = request.getParameter("p_data_id");
	//附件ID
    String p_attach_id = "";
	
	UserCacheBean userBean= UserCache.getUserCacheBean(accesscontroler.getUserID());
	if(userBean==null){
		userBean = new UserCacheBean();
	}
	//单位ID
	String p_unit = userBean.getUnit_id();
	
	//个人资料基本信息
	PsdataBaseService service=new PsdataBaseServiceImpl();
	//资料类型
	PsdataTypeService serviceType = new PsdataTypeServiceImpl();
	if("insert".equals(actionName)){
		//文档id
		 //document_recordid = StringUtil.getUUID();
		//modifu by shuqi.liu 采用seq的形势获取ID，适配表分区
    	DbManager dbManager = DbManager.getInstance();
    	document_recordid = dbManager.getSequence(null, "SEQ_OA_DOCUMENT_FILE");
		bean.put("p_docment_id",document_recordid);
		//单位信息
		bean.put("p_unit_d",userBean.getUnit_id());
		bean.put("p_unit_name",userBean.getUnit_name());
		//用户信息
		bean.put("p_creater_userid",accesscontroler.getUserID());
		bean.put("p_creater_username",accesscontroler.getUserName());
		//部门
		bean.put("p_creater_orgid",accesscontroler.getChargeOrgId());
		bean.put("p_creater_orgname",accesscontroler.getChargeOrgName());
		//登记日期
		bean.put("p_creater_time",DateUtil.getCurrentDateTime());
		//文件形成日期
		bean.put("p_file_time",DateUtil.getCurrentDate());
		//分类信息
		Map<String,String> typeBean = null;
		//当前类别ID没有选择的时候
		if(StringUtil.nullOrBlank(p_type_id)){
			typeBean = serviceType.findTypeTopInfo(user_id);
		} else{
			typeBean = serviceType.getPsdataTypeBean(p_type_id);
		}
		//所属分类ID
		bean.put("p_type_id",typeBean.get("p_type_id"));
		//所属分类名称
		bean.put("p_type_name", typeBean.get("p_type_name"));
		
	} else {
		
		bean = service.getPsdataBaseBean(p_data_id);
		//ID
		bean.put("p_data_id",bean.get("p_data_id"));
		//标题
		bean.put("p_data_title",bean.get("p_data_title"));
		//编号
		bean.put("p_data_code",bean.get("p_data_code"));
		//文件形成日期
		bean.put("p_file_time",bean.get("p_file_time"));
		//登记日期
		bean.put("p_creater_time",bean.get("p_creater_time"));
		//所属分类ID
		bean.put("p_type_id",bean.get("p_type_id"));
		//文档id
		 document_recordid =bean.get("p_docment_id") ;
		Map<String,String> typeBean = serviceType.getPsdataTypeBean(bean.get("p_type_id"));
		//所属分类名称
		bean.put("p_type_name", typeBean.get("p_type_name"));
		//附件ID
		p_attach_id = bean.get("p_attach_id");
	}
	//界面名称
	if("update".equals(actionName)||"insert".equals(actionName)){
		actionNameStr = "个人资料管理明细界面";
	}else if("query".equals(actionName)){
		actionNameStr = "个人资料管理明细界面";
	}
	
	 if(StringUtil.isBlank(p_attach_id)){
			p_attach_id=StringUtil.getUUID();
		}
	    
		//附件 上传 
		String departid = request.getParameter("departid");

		String serverName = (String) request.getServerName();
		String serverPort = String.valueOf(request.getServerPort());
		String contextPath = (String) request.getContextPath();

		String rootPath = request.getSession().getServletContext()
				.getRealPath("");
		rootPath = rootPath.replace("\\", "/");
		String tableName = "OA_FILEUPLOAD_KBM";
		String oType="1";
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
	<title></title>
	<!-- 引入jQuery -->
	<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript">jQuery.noConflict();</script>
	<!-- 引入jQuery UI -->
	<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
	<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
	<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
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
	<!-- 引入上传控件 -->
	<script type="text/javascript" src="../../resources/plug/iWebFile2005/iWebFile2005.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/iWebFile2005/fileupload.js"   charset="utf-8"></script>
	<!-- 引入jGrid -->
	<link rel="stylesheet" type="text/css" media="screen" href="../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
	<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"  charset="utf-8" type="text/javascript"></script>
	<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"  charset="utf-8" type="text/javascript"></script>
	<script type="text/javascript" src="../../resources/util/jsonutil.js" ></script>
	<!-- 引入资料个人js -->
	<script type="text/javascript" src="../resources/js/psdata.js" ></script>
	
	<script type="text/javascript">
	//路径
	var path = "<%=path%>";
	//当前用户ID
	var user_id ="<%=user_id%>";
	//单位ID
	var p_unit="<%=p_unit%>";
	var oType="<%=oType%>";
	var  document_recordid ="<%=document_recordid%>";
	//附件
	var p_attach_id="<%=p_attach_id%>";
	jQuery(function() {
		//异步加载表单已有的附件
		ajaxUploadFiles('<%=tableName%>','<%=p_attach_id%>','<%=oType%>','_filebut');
		//1）选择分类 绑事件
	    jQuery("#p_type_name_button").click(function(){
	       chooseFileType("p_type_id","p_type_name","","radio",true);
	    });
		
	  /*   //可操作权限
	   var  attachFlag =true;
	   isFileEnble(p_attach_id,attachFlag); */
	});
	function callajaxUploadFile(){
		ajaxUploadFiles('<%=tableName%>','<%=p_attach_id%>','<%=oType%>','_filebut');
	}
	jQuery(document).ready(function() {
		jQuery("#iframe_iwebOffice").attr("src","<%=path%>/ccapp/oa/resources/plug/iWebOffice2009/iweboffice2009.jsp?RecordID="+document_recordid+"&EditType=1,1&ShowType=1");
	});

	/**
	 *第一个附件的名称复制到标题 
	 *@djsn : 附件ID
	 *@filetype : 附件类型
	 *filename:文件名称
	 */
	copeFileNoName = function(djsn,filetype,filename){
		 //标题
		var p_data_title = jQuery("#p_data_title").val();
		if(IsSpace(p_data_title)){
			 p_data_title = filename.substring(0,filename.indexOf(filetype));
			 jQuery("#p_data_title").val(p_data_title)
		 }
	};
	
	/**
	 *附件是否可以编辑
	 *@p_attach_id :附件id
	 *@attachFlag : 是否可以操作的参数  true(可操作)  false（不可操作）
	 */
	/* function isFileEnble(k_attach_id,attachFlag){
		if(attachFlag){ 
	    	MyFancyupload.createUpload('_fileshow', '_filebut', path, path+'/servlet/pubFileUpload?buessid='+p_attach_id, attachFlag, p_attach_id,'',copeFileNoName,'101');
		}else{
			MyFancyupload.createUpload('_fileshow', '_filebut', path, path+'/servlet/pubFileUpload?buessid='+p_attach_id, attachFlag, p_attach_id,'',copeFileNoName,'001');
		}
	    if(!attachFlag){
	        //设置上传按钮大小，间接实现隐藏
	       jQuery("#_filebut").width(1).height(1);
	    } 
	} */
	/*
	函数：saveWORD
	描述：保存WORD文件
	
	var saveWORD = function(document_recordid){
		debugger;
		 iWebOffice = document.getElementsByName("WebOffice")[0];
		iWebOffice.RecordID = document_recordid;
		iWebOffice.WebSave(true);
	}
	*/
	//界面按钮事件
	updateFn = function(flag,inputObj){
				try{
					inputObj.disabled=true;
					if(flag==='save'){
						var isFlag = jQuery('#formTable').validationEngine('validate'); //是否全部验证通过
						iframe_iwebOffice.saveModify();
						if (isFlag){
							jQuery("#hidden_action").val("addPsdataBaseInfo");
							jQuery("#onlyFrom").submit();
						}
					}else if(flag==='back'){
						var p={
							headerText:'提示',
							okName:'确认',
					        okFunction:function(){
					        	removeWindows('psdatabaseinfo',true);
					        },
					        cancelName:'取消'
						};
						alert("返回后，数据将不会保存，确定返回？",p);
					}
					inputObj.disabled=false;
				}catch(e){alert(e.description);inputObj.disabled=false;}
			};
			
			<%--提交后回调--%>
			afterSubmitFn=function(result){
				try{
					if(result.indexOf("delete")!=-1){
						alert(result.split(",")[1]);
						searchData();
					}else{
						debugger;
						if(result.split(",").length>1){
								result = result.split(",");
								alert(result[0]);
								window.parent.location.href="<%=path%>/ccapp/oa/persondata/jsp/psdatabasemain.jsp?p_type_id=<%=p_type_id%>";
						} else {
							alert(result);
							window.parent.location.href="<%=path%>/ccapp/oa/persondata/jsp/psdatabasemain.jsp?p_type_id=<%=p_type_id%>";
						}
						
					}
				}catch(e){alert(e.description);}
			};
	</script>
</head>
<body style="overflow-x: auto;" onload="adaptationWH('_top','tabs1',0);">
<div id='tabs1' style="width:100%">
<%--button list--%>
<div class="content_02_top" style="margin-bottom:10px;width:99%" id="divA">
		<input type="button" class="but_y_01" value="保存" onclick="updateFn('save',this);" id="btn_insert"/>
		<input type="button" class="but_y_01" value="返回" onclick="updateFn('back',this);" id="btn_update"/>
</div>
<%--button list--%>

<form id="onlyFrom" name="onlyFrom" method="post" action="psdatabaseinfodo.jsp" target="filetypeinfodoJSPhiddenFrame">
<input type='hidden' name='action' id="hidden_action"/>
<input value="<%=StringUtil.deNull(bean.get("p_data_id"))%>" type='hidden' name='p_data_id' id="p_data_id"/>
<input value="<%=StringUtil.deNull(bean.get("p_unit_d"))%>" type='hidden' name='p_unit_d' id="p_unit_d"/>
<input value="<%=StringUtil.deNull(bean.get("p_unit_name"))%>" type='hidden' name='p_unit_name' id="p_unit_name"/>
<input value="<%=StringUtil.deNull(bean.get("p_creater_userid"))%>" type='hidden' name='p_creater_userid' id="p_creater_userid"/>
<input value="<%=StringUtil.deNull(bean.get("p_creater_username"))%>" type='hidden' name='p_creater_username' id="p_creater_username"/>
<input value="<%=StringUtil.deNull(bean.get("p_creater_orgid"))%>" type='hidden' name='p_creater_orgid' id="p_creater_orgid"/>
<input value="<%=StringUtil.deNull(bean.get("p_creater_orgname"))%>" type='hidden' name='p_creater_orgname' id="p_creater_orgname"/>
<input value="<%=StringUtil.deNull(bean.get("p_docment_id"))%>" type='hidden' name='p_docment_id' id="p_docment_id"/>
<input value="<%=p_attach_id%>" type='hidden' name='p_attach_id' id="p_attach_id"/>

<table>
	<tr>
		<td width="98%" align="left" valign="top">
			<div id="vcenter" style="float:left;width:100%; overflow:hidden">
				<div class="content_02_box" >
					<div class="content_02_box_title_bg"><span>基本信息</span></div>
					<div class="content_02_box_div">
						<table id='formTable' border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table">
							<tr>
								<th class="content_02_box_div_table_th" style="width: 150px;"><span style="color: red;">*</span>标题：</th>
								<td  class="content_02_box_div_table_td" style="width: 220px;" colspan="3">
									<input value="<%=StringUtil.deNull(bean.get("p_data_title"))%>" type="text" name="p_data_title"  id="p_data_title" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" class="validate[required,maxSize[100]] input_title_text"/>
								</td>
							</tr>
							<tr>
								<th class="content_02_box_div_table_th" style="width: 150px;"><span style="color: red;">*</span>所属分类：</th>
								<td class="content_02_box_div_table_td" style="width:210px;">
									<input value="<%=StringUtil.deNull(bean.get("p_type_name"))%>" name="p_type_name" id="p_type_name" type="text" readonly="readonly" class="validate[required,maxSize[100]] input_160" style="width: 180px; height: 24px;" />
									<input name="p_type_name_button" id="p_type_name_button"  type="button" class="but_x" style="height: 26px;" /> 
									<input value="<%=StringUtil.deNull(bean.get("p_type_id"))%>" name="p_type_id"id="p_type_id" type="hidden" />
								</td>
								<th class="content_02_box_div_table_th" style="width: 150px;">编号：</th>
								<td  class="content_02_box_div_table_td" style="width: 220px;" colspan="2">
									<input value="<%=StringUtil.deNull(bean.get("p_data_code"))%>" type="text" name="p_data_code" id="p_data_code" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" class="validate[maxSize[20]] input_title_text"/>
								</td>
								
							</tr>
							<tr>
								<th class="content_02_box_div_table_th" style="width: 150px;">文件形成日期：</th>
								<td class="content_02_box_div_table_td">
									<input class="date_120 Wdate" type="text" id="p_file_time" name="p_file_time" value="<%=StringUtil.deNull(bean.get("p_file_time"))%>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
								</td>
								<th class="content_02_box_div_table_th" style="width: 150px;">登记日期：</th>
								<td class="content_02_box_div_table_td">
									<input class="input_title_text" type="text" id="p_creater_time" name="p_creater_time" value="<%=StringUtil.deNull(bean.get("p_creater_time"))%>"  />
								</td>
							</tr>
							<tr>
								<th class="content_02_box_div_table_th">文件上传：</th>
								<td class="content_02_box_div_table_td" colspan=3 id="fujian">
									<input id="d_data_attach" type="hidden" value="<%=p_attach_id %>">
									<input id="fa" type=file value="" style="width: 60%" class=inputcss> 
									<a class="LinkButton" onClick="UpLoadFile('<%=tableName %>',getFullPath(fa),'<%=rootPath%>','<%=p_attach_id%>','','_filebut')">[上传文档]</a>
								</td>
							</tr>
							<tr>
								<th class="content_02_box_div_table_th" valign="top">查看附件：</th>
								<td class="content_02_box_div_table_td" colspan=3>
									<input class="but_y_03"  type="button" id="_filebut" value="查看附件" onclick="openuploadlist('<%=path+UploadConstants.WEBPATH %>','<%=tableName%>','<%=p_attach_id %>',oType)"/>
								</td>
							</tr>
							<tr>
								<th class="content_02_box_div_table_th" style="width: 150px;">备注：</th>
								<td class="content_02_box_div_table_td" colspan="3">
									<textarea style="height: 80px; overflow: auto;" class="validate[maxSize[500]] input_title_text" name="p_remark" id="p_remark"><%=StringUtil.deNull(bean.get("p_remark"))%></textarea>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</td>
	</tr>
</table>
 <div class="content_02_box">
	 <div class="content_02_box_title_bg"><span>正文</span>
	 <span>&nbsp;&nbsp;</span>
	 </div>
	 <div class="content_02_box_div">
	   <table  border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table">
         <tr>
			<td>
<!-- 			<input type="hidden" name="doc_content" id="doc_content" value=""/>  -->
			<iframe id="iframe_iwebOffice" frameborder="0" scrolling="no" width="100%" height="600"></iframe>
			
			</td>
			</tr>

	</table></div></div>
</form>
<iframe name="filetypeinfodoJSPhiddenFrame" width=0 height=0></iframe>
</div>
<script>
if(jQuery("#vcenter").width()>jQuery("body").width()){<%--1024*?分辨率下,拉长divA宽度--%>
	jQuery("#divA").width(jQuery("#vcenter").width()+10);
}else{<%--1440*?分辨率下,缩短divA宽度,防止横向滚动条出现--%>
	jQuery("#divA").width(jQuery("body").width()-19);
}
</script>
</body>
<script type="text/javascript" >
jQuery(function(){
	jQuery("#formTable").validationEngine();
});
</script>
</html>
