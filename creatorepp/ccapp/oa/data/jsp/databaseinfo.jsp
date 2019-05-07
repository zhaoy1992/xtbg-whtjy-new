<%--
描述：资料基本信息
作者：肖杰
版本：1.0
日期：2013-08-21
--%>
<%@page import="com.chinacreator.xtbg.core.upload.util.UploadConstants"%>
<%@page import="com.chinacreator.xtbg.core.data.service.impl.DataDataServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.data.service.DataDataService"%>
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
	//当前类别ID
	String user_id = accesscontroler.getUserID();
	String d_type_id = request.getParameter("d_type_id");
	String d_type_name = request.getParameter("d_type_name");
	String type = request.getParameter("type");
	//资料ID
	String d_data_id = StringUtil.deNull(request.getParameter("d_data_id"));
	//附件ID
    String d_data_attach = "";
	
	UserCacheBean userBean= UserCache.getUserCacheBean(accesscontroler.getUserID());
	if(userBean==null){
		userBean = new UserCacheBean();
	}
	//单位ID
	String d_data_unit_id = userBean.getUnit_id();
	
	DataDataService service=new DataDataServiceImpl();
	if("insert".equals(actionName)){
		//单位信息
		bean.put("d_data_unit_id",userBean.getUnit_id());
		bean.put("d_data_unit_name",userBean.getUnit_name());
		//用户信息
		bean.put("d_data_user_id",accesscontroler.getUserID());
		bean.put("d_data_user_name",accesscontroler.getUserName());
		//部门
		bean.put("d_data_dept_id",accesscontroler.getChargeOrgId());
		bean.put("d_data_dept_name",accesscontroler.getChargeOrgName());
		//发布时间
		bean.put("d_data_create_time",DateUtil.getCurrentDateTime());
		bean.put("d_type_id", d_type_id);
		bean.put("d_type_name", d_type_name);
		bean.put("d_data_put_time", DateUtil.getCurrentDate());
		
	} else {
		
		bean = service.getDataBaseBean(d_data_id);
		//ID
		bean.put("d_data_id",bean.get("d_data_id"));
		//标题
		bean.put("d_data_name",bean.get("d_data_name"));
		//编号
		bean.put("d_data_code",bean.get("d_data_code"));
		//文件形成日期
		if(bean.get("d_data_put_time").length()>10){
			bean.put("d_data_put_time",bean.get("d_data_put_time").substring(0, 10));
		}else{
			bean.put("d_data_put_time",bean.get("d_data_put_time"));
		}
		
		//登记日期
		bean.put("d_data_create_time",bean.get("d_data_create_time"));
		//所属分类ID
		bean.put("d_type_id",bean.get("d_type_id"));
		//所属分类名称
		bean.put("d_type_name", bean.get("d_type_name"));
		//附件ID
		d_data_attach = bean.get("d_data_attach");
	}
	
	//界面名称
	if("update".equals(actionName)||"insert".equals(actionName)){
		actionNameStr = "资料管理明细界面";
	}else if("query".equals(actionName)){
		actionNameStr = "基本信息";
	}
	 //下拉框  选中的id由bean存的值确定
    String secrecy_dictType = "damj";//年份
    String d_data_secrecy = DictDropDownList.buildSelect4DictType(secrecy_dictType,"d_data_secrecy_id" , "", "" , false, "" ,"" ,"class='select_100_box_type validate[required]' style='width: 206px; height: 24px;'","" );
	
    if(StringUtil.isBlank(d_data_attach)){
		d_data_attach=StringUtil.getUUID();
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
	<script src="<%=path%>/ccapp/oa/resources/util/htmlutil.js"
    type="text/javascript"></script>
	<script type="text/javascript">
	var d_data_id="<%=d_data_id%>";
	//路径
	var path = "<%=path%>";
	//当前用户ID
	var user_id ="<%=user_id%>";
	//单位ID
	var d_data_unit_id="<%=d_data_unit_id%>";
	//附件
	var d_data_attach="<%=d_data_attach%>";
	var oType="<%=oType%>";
	/* jQuery(function() {
	    //可操作权限
	   var  attachFlag =true;
	   isFileEnble(d_data_attach,attachFlag); 
	}); */
	
	/**
	 *附件是否可以编辑
	 *@d_data_attach :附件id
	 *@attachFlag : 是否可以操作的参数  true(可操作)  false（不可操作）
	 */
	<%-- function isFileEnble(d_data_attach,attachFlag){
		if('find'!='<%=type%>'){ 
	    	MyFancyupload.createUpload('_fileshow', '_filebut', path, path+'/servlet/pubFileUpload?buessid='+d_data_attach, attachFlag, d_data_attach,'',function(){
				//上传附件回调
				autoTitle("#d_data_name",jQuery("#_fileshow li:first").contents().first().text());},
				'100');
		}else{
			MyFancyupload.createUpload('_fileshow', '_filebut', path, path+'/servlet/pubFileUpload?buessid='+d_data_attach, attachFlag, d_data_attach,'','','001');
			jQuery(".swiff-uploader-box").hide();
		}
	    if(!attachFlag){
	        //设置上传按钮大小，间接实现隐藏
	       jQuery("#_filebut").width(1).height(1);
	    } 
	} --%>
	function autoTitle(tmp_titleDom,tmp_fileName){
			try {
				var lastindexofpoint = tmp_fileName.lastIndexOf(".");
				if( lastindexofpoint != -1){
					var fileName = tmp_fileName.substring(0,lastindexofpoint);
					if(jQuery(tmp_titleDom).val()!=""){
						
					}else{
						jQuery(tmp_titleDom).val(jQuery(tmp_titleDom).val()+fileName);
					}
				} else {
					if(jQuery(tmp_titleDom).val()==""){
						jQuery(tmp_titleDom).val(tmp_fileName);
					}
				}
			} catch(error){
				jQuery(tmp_titleDom).val("");
			}
		}
	//界面按钮事件
	updateFn = function(flag,inputObj){
				try{
					inputObj.disabled=true;
					if(flag==='save'){
						var isFlag = jQuery('#formTable').validationEngine('validate');//是否全部验证通过
						if (isFlag){
							jQuery("#hidden_action").val("addDataBaseInfo");
							jQuery("#onlyFrom").submit();
						}
					}else if(flag==='back'){
						if('find'!='<%=type%>'){ 
							var p={
								headerText:'提示',
								okName:'确认',
						        okFunction:function(){
						        	removeWindows('databaseinfo',true);
						        },
						        cancelName:'取消'
							};
							alert("返回后，数据将不会保存，确定返回？",p);
						}else{
							removeWindows('databaseinfo',true);
						}
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
						if(result.split(",").length>1){
								result = result.split(",");
								alert(result[0]);
								window.parent.location.href="<%=path%>/ccapp/oa/data/jsp/databasemain.jsp?d_type_id=<%=d_type_id%>";
						} else {
							alert(result);
							window.parent.location.href="<%=path%>/ccapp/oa/data/jsp/databasemain.jsp?d_type_id=<%=d_type_id%>";
						}
						
					}
				}catch(e){alert(e.description);}
			};
			var chooseDataType = function (){
				var s = new jQuery.z_tree();
				s.treeID = 'mianType';
				s.treetypestr = "radio";
				s.isShowSeacher = true;
				s.treeName = "选择分类";
				s.headerName = "选择分类";
				s.type = "DATA_TYPE";
				s.isType="dept"; //要设置默认选中值，则需要此类型
				s.selectedIds = jQuery("#d_type_id").val(),
				s.f_org_id = '<%=d_data_unit_id%>';//所属单位id 全局的js变量 引用时注意
				s.returnFunction = function(nothing,object){    
				    try{
				    	jQuery("#d_type_id").val(object[0].id);
				    	jQuery("#d_type_name").val(object[0].name);
				    }catch(e){
				    }
				}
				s.init();
			}
			var chooseOrg = function (){
				var s = new jQuery.z_tree();
				  s.treeID='mian';
				  s.treetypestr='radio';
				  s.isShowSeacher=true;
				  s.treeName="选取部门";
				  s.isType='dept';
				  s.headerName="选取部门";
				  s.item_id = 'org_id';
				  s.selectedIds=jQuery('#d_data_dept_id').val();
				  s.type='ADEPT';
				  s.returnFunction=function(orgObj){
					  if(!IsSpace(orgObj)){
						  jQuery('#d_data_dept_id').val(orgObj.id);
						  jQuery('#d_data_dept_name').val(orgObj.name);
						 }
					 }
				  s.init();
			}
			jQuery(function() {
					//异步加载表单已有的附件
					ajaxUploadFiles('<%=tableName%>','<%=d_data_attach%>','<%=oType%>','_filebut');
				
				jQuery("#d_data_secrecy_id").val("<%=bean.get("d_data_secrecy_id") %>");
				if('find'=='<%=type%>'){
					jQuery("#save").hide();
					jQuery("#vcenter input[type=text][id!=task_name]:visible,#vcenter select:visible").unbind().each(function(){
						   HTMLUtil.readOnly(this);
					   });
					jQuery("#d_data_secrecy_id").prop("disabled", true);
					jQuery("#p_org_name_button").remove();
					jQuery("#p_type_name_button").remove();
					jQuery("#back").prop("disabled", false);
					//jQuery("#_filebut").hide();
					jQuery("#eWebEditor1").attr("src",jQuery("#eWebEditor1").attr("src")+"&readonly=1");
					oType="0";
					jQuery("#fujian").html("");
				}
				
			});
			
			function callajaxUploadFile(){
				ajaxUploadFiles('<%=tableName%>','<%=d_data_attach%>','<%=oType%>','_filebut');
			}
	</script>
</head>
<body style="overflow-x: auto;" onload="adaptationWH('','tabs1','30');">
<div id='tabs1' style="width:100%">
<%--button list--%>
<div class="content_02_top" style="margin-bottom:10px;width:99%" id="divA">
		<input id="save" type="button" class="but_y_01" value="保存" onclick="updateFn('save',this);" />
		<input id="back" type="button" class="but_y_01" value="返回" onclick="updateFn('back',this);" />
</div>
<%--button list--%>

<form id="onlyFrom" name="onlyFrom" method="post" action="databaseinfodo.jsp" target="filetypeinfodoJSPhiddenFrame">
<input type='hidden' name='action' id="hidden_action"/>
<input value="<%=StringUtil.deNull(bean.get("d_data_id"))%>" type='hidden' name='d_data_id' id="d_data_id"/>
<input value="<%=StringUtil.deNull(bean.get("d_data_unit_id"))%>" type='hidden' name='d_data_unit_id' id="d_data_unit_id"/>
<input value="<%=StringUtil.deNull(bean.get("d_data_unit_name"))%>" type='hidden' name='d_data_unit_name' id="d_data_unit_name"/>
<input value="<%=StringUtil.deNull(bean.get("d_data_user_id"))%>" type='hidden' name='d_data_user_id' id="d_data_user_id"/>
<input value="<%=StringUtil.deNull(bean.get("d_data_user_name"))%>" type='hidden' name='d_data_user_name' id="d_data_user_name"/>

<input value="<%=d_data_attach%>" type='hidden' name='d_data_attach' id="d_data_attach"/>
<input value="<%=StringUtil.deNull(bean.get("d_data_create_time"))%>" type='hidden' name='d_data_create_time' id="d_data_create_time"/>

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
									<input value="<%=StringUtil.deNull(bean.get("d_data_name"))%>" type="text" name="d_data_name" id="d_data_name" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" class="validate[required,maxSize[100]] input_title_text"/>
								</td>
							</tr>
							<tr>
								<th class="content_02_box_div_table_th" style="width: 150px;"><span style="color: red;">*</span>所属分类：</th>
								<td class="content_02_box_div_table_td" style="width:210px;">
									<input value="<%=StringUtil.deNull(bean.get("d_type_name"))%>" name="d_type_name" id="d_type_name" type="text"  readonly="readonly" class="validate[required,maxSize[100]] input_160" style="width: 180px; height: 24px;" />
									<input name="p_type_name_button" id="p_type_name_button" onclick="chooseDataType();"  type="button" class="but_x" style="height: 26px;" /> 
									<input value="<%=StringUtil.deNull(bean.get("d_type_id"))%>" name="d_type_id"id="d_type_id" type="hidden" />
								</td>
								<th class="content_02_box_div_table_th" style="width: 150px;">编号：</th>
								<td  class="content_02_box_div_table_td" style="width: 220px;" >
									<input value="<%=StringUtil.deNull(bean.get("d_data_code"))%>" type="text" name="d_data_code" id="d_data_code" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" class="validate[maxSize[20]] input_title_text"/>
								</td>
								
							</tr>
							<tr>
								<th class="content_02_box_div_table_th" style="width: 150px;"><span style="color: red;">*</span>文件形成日期：</th>
								<td class="content_02_box_div_table_td">
									<input class="validate[required] date_120 Wdate" style="width: 205px; height: 24px;" type="text" id="d_data_put_time" name="d_data_put_time" value="<%=StringUtil.decoding(bean.get("d_data_put_time"))%>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
								</td>
								<th class="content_02_box_div_table_th" style="width: 150px;">发布单位：</th>
								<td class="content_02_box_div_table_td">
									<input disabled="disabled" class="input_title_text" type="text" id="d_data_unit_name" name="d_data_unit_name" value="<%=StringUtil.deNull(bean.get("d_data_unit_name"))%>"  />
								</td>
							</tr>
							<tr>
								<th class="content_02_box_div_table_th" style="width: 150px;"><span style="color: red;">*</span>密级：</th>
								<td  class="content_02_box_div_table_td" style="width: 220px;">
									<%=d_data_secrecy %>
								</td>
								<th class="content_02_box_div_table_th" style="width: 150px;"><span style="color: red;">*</span>所属部门：</th>
								<td class="content_02_box_div_table_td" style="width:210px;">
									<input value="<%=StringUtil.deNull(bean.get("d_data_dept_name"))%>" name="d_data_dept_name" id="d_data_dept_name" type="text"  readonly="readonly" class="validate[required,maxSize[100]] input_160" style="width: 180px; height: 24px;" />
									<input name="p_org_name_button" id="p_org_name_button"  type="button" onclick="chooseOrg();" class="but_x" style="height: 26px;" /> 
									<input value="<%=StringUtil.deNull(bean.get("d_data_dept_id"))%>" name="d_data_dept_id"id="d_data_dept_id" type="hidden" />
								</td>
							</tr>
							<tr>
								<th class="content_02_box_div_table_th" style="width: 150px;">登记人：</th>
								<td class="content_02_box_div_table_td">
									<input disabled="disabled" class="input_title_text" type="text" id="d_data_user_name" name="d_data_user_name" value="<%=StringUtil.deNull(bean.get("d_data_user_name"))%>"  />
								</td>
								<th class="content_02_box_div_table_th" style="width: 150px;">登记日期：</th>
								<td class="content_02_box_div_table_td">
									<input disabled="disabled" class="input_title_text" type="text" id="d_data_create_time" name="d_data_create_time" value="<%=StringUtil.deNull(bean.get("d_data_create_time"))%>"  />
								</td>
							</tr>
							
							<tr>
								<th class="content_02_box_div_table_th">文件上传：</th>
								<td class="content_02_box_div_table_td" colspan=3 id="fujian">
									<input id="d_data_attach" type="hidden" value="<%=d_data_attach %>">
									<input id="fa" type=file value="" style="width: 60%" class=inputcss> 
									<a class="LinkButton" onClick="UpLoadFile('<%=tableName %>',getFullPath(fa),'<%=rootPath%>','<%=d_data_attach%>','','_filebut')">[上传文档]</a>
								</td>
							</tr>
							<tr>
								<th class="content_02_box_div_table_th" valign="top">查看附件：</th>
								<td class="content_02_box_div_table_td" colspan=3>
									<input class="but_y_03"  type="button" id="_filebut" value="查看附件" onclick="openuploadlist('<%=path+UploadConstants.WEBPATH %>','<%=tableName%>','<%=d_data_attach %>',oType)"/>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<div class="content_02_box" >
			          <div class="content_02_box_title_bg"><span>内容</span></div>
			          <div class="text_show_main_box">
			          <table width="100%" border="0" cellspacing="0" cellpadding="0">  
			              <tr>
			                  <td>
			                      <textarea  style="display:none" id="d_data_content" name="d_data_content" ><%=StringUtil.deNull(bean.get("d_data_content"))%></textarea>
			                      <iframe id="eWebEditor1" src="../../resources/plug/eWebEditor_V4.60/ewebeditor.htm?id=d_data_content&style=gray" frameborder="0" scrolling="no" width="100%" height="260"></iframe> 
			                  </td>
			              </tr>
			          </table>
			          </div>
			    </div>
			</div>
		</td>
	</tr>
</table>
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
