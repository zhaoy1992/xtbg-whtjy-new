<%--
　　描述：档案管理 --文件管理--视频
　　作者：黄海
　　版本：1.0
　　日期：2013-7-22
--%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.commonlist.Constant"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileTypeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileFilesServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.file.service.FileFilesService"%>
<%@page import="com.chinacreator.xtbg.core.file.entity.FileFilesBean"%>
<%@page import="com.chinacreator.eform.util.Escape"%>
<%@page import="com.chinacreator.xtbg.core.file.entity.FileDocBean"%>
<%@ taglib uri="/WEB-INF/archive-taglib.tld" prefix="oa"%>
<%
	String model  = FileDocBean.MODEL_A;
	AccessControl accesscontroler = AccessControl.getInstance();
	String path = request.getContextPath();
	String getCurrentDate = DateUtil.getCurrentDate();//"yyyy-MM-dd"
	String getCurrentDateTime = DateUtil.getCurrentDateTime();//"yyyy-MM-dd HH:mm:ss"
	String mypath = request.getServletPath();
	mypath = mypath.substring(0,mypath.lastIndexOf("/")+1);
	mypath = request.getContextPath()+mypath;
	accesscontroler.checkAccess(request, response);
	String windowId = StringUtil.deNull(request.getParameter("windowId"));
	String busi_id  = StringUtil.deNull(request.getParameter("busi_id"));
    if(busi_id.length()>0){
    	model = FileDocBean.MODEL_B;
    }
	String F_USER_ID = accesscontroler.getUserID();
	String F_USER_NAME = accesscontroler.getUserName();
	String F_CREATOR_TIME = DateUtil.getCurrentDateTime();
	String F_TYPE_ID  = StringUtil.deNull(request.getParameter("F_TYPE_ID"));
	String F_TYPE_NAME  = StringUtil.deNull(request.getParameter("F_TYPE_NAME"));
	F_TYPE_NAME =DataControlUtil.replaceStr(F_TYPE_NAME);
    F_TYPE_NAME = Escape.unescape(F_TYPE_NAME);
	String isgd = StringUtil.deNull(request.getParameter("isgd"));
	
    String f_files_id = StringUtil.deNull(request.getParameter("f_files_id"));    
    String f_doc_year = DateUtil.getCurrentYear();
    String f_doc_deadline = StringUtil.deNull(request.getParameter("f_doc_deadline"));//保管期限
    
	//isgd="yes";
	String SEPARATOR = Constant.SEPARATOR;//分隔字符
	
	UserCacheBean usercachebean=UserCache.getUserCacheBean(F_USER_ID);
	if(usercachebean==null){
    	usercachebean=new UserCacheBean();
    }
	String F_UNIT_ID=usercachebean.getUnit_id();
	String F_UNIT_NAME=usercachebean.getUnit_name();
	String F_ORG_ID = usercachebean.getOrg_id();
	String F_ORG_NAME = usercachebean.getOrg_name();
	
	
	
	//服务对象
	FileFilesService service = new FileFilesServiceImpl();
    FileFilesBean bean = new FileFilesBean() ;    //文档对象
    if(!StringUtil.nullOrBlank(f_files_id)){
        bean = service.queryToFileFilesBean(f_files_id);       
        //处理时间
        String closeTime = bean.getF_file_time().toString();
        if(!StringUtil.nullOrBlank(closeTime)){
            bean.setF_file_time(closeTime.split(" ")[0]);
        }   
    }
    if(!StringUtil.nullOrBlank(f_files_id)){
    	if(StringUtil.nullOrBlank(busi_id)){
        	model = FileDocBean.MODEL_C;
        }else{
        	model = FileDocBean.MODEL_D;
        }
    }
    //判断是新增还是修改
    boolean isInsert = false;
    if(StringUtil.nullOrBlank(busi_id)){
    	isInsert = true;
    }
    
    boolean fromPageIsAJ = false;//进入的入口是否是案卷
    if(!StringUtil.nullOrBlank(isgd)){
    	fromPageIsAJ = true;
    }
  //查询入口参数:isview
	boolean isview = false;//true?查询:编辑
	boolean canRead = false;//true?查询时可读:查询时不可读
	boolean canDownload = false;//true?查询时可下载:查询时不可下载
	String isviewStr = StringUtil.deNull(request.getParameter("isview"));
	if(isviewStr!=null&&isviewStr.length()>0){
		if("isview".equals(isviewStr)){
    		isview = true;
            if(busi_id!=null&&busi_id.length()>0&&F_USER_ID!=null&&F_USER_ID.length()>0){
                Boolean[] roles = new FileTypeServiceImpl().checkFileTypeRoleOfUser(F_USER_ID,busi_id);
                canRead = roles[0];
                canDownload = roles[1];
            }
            model = FileDocBean.MODEL_E;
    	}else if("jieshou".equals(isviewStr)){
    		isview = true;
            if(busi_id!=null&&busi_id.length()>0&&F_USER_ID!=null&&F_USER_ID.length()>0){
                canRead = true;
                canDownload = true;
            }
            model = FileDocBean.MODEL_E;
    	}
	}
	//默认的模板
    String defaultFileMB = "";
    if(model.equals(FileDocBean.MODEL_A)
    		||model.equals(FileDocBean.MODEL_C)){
    	if(F_TYPE_ID.length()>0){
    		//F_TYPE_ID
	    	FileTypeServiceImpl serviceImpl = new FileTypeServiceImpl();
	    	defaultFileMB = serviceImpl.getFileTypeBeanById(F_TYPE_ID).get("f_template_file");
    	}
    }
  //WJZH初始化
    String wjzhTime = DateUtil.getCurrentYear();
    if(wjzhTime==null){
    	wjzhTime = "2013";
    }
    String defaultWZJH = "["+wjzhTime+"] 号";
    
    String openType = "111";
    if(request.getParameter("openType")!=null){
    	openType = request.getParameter("openType");
    }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>档案管理 --文件管理--光盘</title>
<oa:filedocinit>
<%
//封装的数据 没有办法才通过这种方式获取数据
Map<String, List<Map<String, String>>> archivedate = (Map<String, List<Map<String, String>>>)pageContext.getAttribute("archivedata");
if(archivedate!=null){
	List<Map<String, String>> list = archivedate.get("OA_FILE_DOC");
	if(list!=null&&list.size()>0){
		Map<String, String> values = archivedate.get("OA_FILE_DOC").get(0);
		String f_doc_state = values.get("F_DOC_STATE");
		if((!f_doc_state.equals(FileDocBean.STATE_DGD)
				&&!f_doc_state.equals(FileDocBean.STATE_BXGD))
			&&request.getParameter("f_files_id")==null){
			//需求:已归档的文件，在文件管理中打开全部都是只读
			model = FileDocBean.MODEL_E;
			openType = "000";
		}
	}
}

%>
<script>
var SEPARATOR = "<%=SEPARATOR%>";
var tableName = "OA_FILE_DOC"+SEPARATOR+"";
var isgd="<%=isgd%>";
jQuery(function() {
	jQuery("#OA_FILE_DOC__F_DOC_NAME").focus();

	var busi_id = '<%=busi_id%>';
	if ("yes"==isgd){//归档操作时
        //显示归档控件，并设置归档人员和归档日期
        jQuery("div[id^='gdDiv'],tr[id^='gdDiv']").show();
    }else{
        if (isSpace(busi_id)){//为空，新增时  
            initFormValues();
        }else{
            
        }
    }
 	//初始化归档状态
    if(initFileState){
    	initFileState();
    }
   //获得文件内容模板数据
    initFileMB();
   initFJ();
   
   initData();
});

function controlReadOnly(){
	<%if(model.equals(FileDocBean.MODEL_E)){%>
		jQuery("#form1 input[type='text']").attr("readOnly","readOnly").removeAttr("onclick");
		jQuery("#form1 select").attr("disabled","disabled").removeAttr("onclick");
		jQuery("#form1 textarea").attr("readOnly","readOnly").removeAttr("onclick");
		
		jQuery("#savedButton").hide();
		jQuery("#xinzeng").hide();
		jQuery("#fuJianTr").hide();
		jQuery(".swiff-uploader-box").hide();
	<%}else{%>
		jQuery("#OA_FILE_DOC__F_DOC_NAME").focus();
		//当前不是自读模式:<%=model%>
	<%}%>
}

function initFileMB(){
	<%if(isInsert){%>
	jQuery("#OA_FILE_DOC__F_DOC_CONTENT").val(jQuery("#defaultFileMB").html());
	<%}%>
}

function initData(){
<%if(isInsert){%>
    jQuery("#OA_FILE_DOC__F_FILE_NUM").val("1");
  	
    var initDataConfig={
    	actionURL:getContextPath()+'/ccapp/oa/file/jsp/filedoclistdo.jsp',
    	actionData:{
    		action:"aaa",
    		userId:"<%=F_USER_ID%>",
    		fileType:"<%=F_TYPE_ID%>",
    		deptId:"<%=F_ORG_ID%>",
    		f_files_id:"<%=f_files_id%>"
    	},
    	dataTypeList:{
    		"OA_FILE_DOC__F_DOC_NUM":["f_doc_num",function(data){if(!isNaN(data)){return ""+(parseInt(data)+1);}else{return data;}}]
    	},
    	actionCallBack:"now no thing"
    };
    filedocJS.initData(initDataConfig);
    <%}%>
}

function initFileState(){
	<%if(model.equals(FileDocBean.MODEL_A)){%>
	jQuery("#OA_FILE_DOC__F_DOC_STATE OPTION[value!='<%=FileDocBean.STATE_DGD%>'][value!='<%=FileDocBean.STATE_BXGD%>']").remove();
	<%}else if(model.equals(FileDocBean.MODEL_B)){%>
	var state = jQuery("#OA_FILE_DOC__F_DOC_STATE").val();
	if(state=='<%=FileDocBean.STATE_DGD%>'
		||state=='<%=FileDocBean.STATE_BXGD%>'
		||state==''){
		jQuery("#OA_FILE_DOC__F_DOC_STATE OPTION[value!='<%=FileDocBean.STATE_DGD%>'][value!='<%=FileDocBean.STATE_BXGD%>']").remove();
	}else{
		jQuery("#OA_FILE_DOC__F_DOC_STATE").attr("disabled","disabled");
	}
	<%}else if(model.equals(FileDocBean.MODEL_C)){%>
		jQuery("#OA_FILE_DOC__F_DOC_STATE OPTION[value!='<%=FileDocBean.STATE_YGD%>']").remove();
		jQuery("#OA_FILE_DOC__F_DOC_STATE_NAME").val("<%=FileDocBean.STATE_YGD_NM%>");
	<%}else if(model.equals(FileDocBean.MODEL_D)){%>
		var state = jQuery("#OA_FILE_DOC__F_DOC_STATE").val();
		if(state=='<%=FileDocBean.STATE_DGD%>'
			||state=='<%=FileDocBean.STATE_BXGD%>'
			||state==''){
			jQuery("#OA_FILE_DOC__F_DOC_STATE OPTION[value!='<%=FileDocBean.STATE_YGD%>']").remove();
			jQuery("#OA_FILE_DOC__F_DOC_STATE_NAME").val("<%=FileDocBean.STATE_YGD_NM%>");
		}else{
			jQuery("#OA_FILE_DOC__F_DOC_STATE").attr("disabled","disabled");
		}
	<%}%>
}
//关闭弹窗
function closed(){
	removeAlertWindows('<%=windowId%>',true);
}
/**
	函数:  initFormValues
	说明:  新增时初始化相关控件
**/
function initFormValues(){
	jQuery("#"+tableName+"F_CREATOR_TIME").val("<%=F_CREATOR_TIME%>");
}
function initFJ(){
	jQuery("#_fileshow").css("max-height","");
	jQuery("#_fileshow").css("height","");
	jQuery("#_fileshow").parent().css("height","");
}
var xinzeng = function(){
	savedThis("xinzeng");
};

var xinzengBody = function(){
    jQuery("#busi_id").val(new UUID().toString());
    jQuery("#opt_type").val("save");
    //附件重新赋值
    var newFJId = new UUID().toString();
    jQuery("#_fileshow").html("");
    MyFancyupload.createUpload('_fileshow', '#_filebut', '<%=path%>', 
            '<%=path%>/servlet/pubFileUpload?buessid='+newFJId, true, 
            newFJId,'','','111','',false);
    //附件id赋值
    jQuery("input[name='OA_FILE_DOC__F_ATTACH_ID']").val(newFJId);
    
    jQuery("#OA_FILE_DOC__F_USER_NAME").val('<%=F_USER_NAME%>');
    jQuery("#OA_FILE_DOC__F_USER_ID").val('<%=F_USER_ID%>');
    jQuery("#dis_OA_FILE_DOC__F_CREATOR_TIME").val('<%=getCurrentDate%>');
    jQuery("#OA_FILE_DOC__F_CREATOR_TIME").val('<%=getCurrentDateTime%>');
    jQuery("#dis_OA_FILE_DOC__F_FILE_FORMTIME").val('<%=getCurrentDate%>');
    jQuery("#OA_FILE_DOC__F_FILE_FORMTIME").val('<%=getCurrentDateTime%>');
    
    var initDataConfig={
           	actionURL:getContextPath()+'/ccapp/oa/file/jsp/filedoclistdo.jsp',
           	actionData:{
           		action:"aaa",
           		userId:"<%=F_USER_ID%>",
           		fileType:jQuery("#OA_FILE_DOC__F_TYPE_ID").val(),
           		deptId:"<%=F_ORG_ID%>",
           		f_files_id:"<%=f_files_id%>"
           	},
           	dataTypeList:{
           		"OA_FILE_DOC__F_DOC_NUM":["f_doc_num",function(data){if(!isNaN(data)){return ""+(parseInt(data)+1);}else{return data;}}]
           	},
           	actionCallBack:"now no thing"
           };
           filedocJS.initData(initDataConfig);
};

var afterSubmitFnA = function(otp_type,flag){
	jQuery("#form1").resetSubmit(false);
	if(flag=='true'){
		var ok=function(){
			getParentWindow('<%=windowId%>').search();
			jQuery("#opt_type").val("update");
		}
		window.top.alert("操作成功",{headerText:'处理结果',okName:'确认',okFunction:ok});
	}else{
		window.top.alert("操作失败");
		closeAlertWindows('<%=windowId%>', false, true);
	}
};
var afterSubmitFnB = function(otp_type,flag){
	jQuery("#form1").resetSubmit(false);
	if(flag=='true'){
		var ok=function(){
			xinzengBody();
			getParentWindow('<%=windowId%>').search();
		}
		window.top.alert("操作成功,请继续新增",{headerText:'处理结果',okName:'确认',okFunction:ok});
	}else{
		window.top.alert("操作失败");
		closeAlertWindows('<%=windowId%>', false, true);
	}
	
};
var afterSubmitFn=afterSubmitFnA;

function savedThis(type){
	if(type){
		afterSubmitFn=afterSubmitFnB;
	}else{
		afterSubmitFn=afterSubmitFnA;
	}
	//自动校验
	var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
	if (!isFlag){
		return isFlag;	
	}
	
    var okF = function(){
    	var fm = document.getElementById("form1");
    	jQuery('#form1').attr("target","filedocdetaildoJSPhiddenFrame");
        fm.action = getCurrentFilePath()+"filedocdetaildo.jsp";
        jQuery('#form1').submit();
	}
	var p={
		headerText:'提示',
		okName:'确认',
	    okFunction:okF,
	    cancelFunction:function(){
            jQuery("#form1").resetSubmit(false);
        },
	    cancelName:'取消'
	};
	alert('确定保存吗？',p);
}
</script>
<script type="text/javascript" src="<%=mypath %>../resources/js/filedoc.js"></script>
<script src="<%=mypath%>../resources/js/UUID.js" type="text/javascript"></script>
</head>
<body>
<iframe id="filedocdetaildoJSPhiddenFrame" name="filedocdetaildoJSPhiddenFrame" width=0 height=0></iframe>

<div style="width:1020px;float:left;">
<div class="content_02_top" > 
	<input value="保存" onclick="savedThis()"  type="button" class="but_y_01" id="savedButton"/>
	<input value="关闭" onclick="closed()" type="button" class="but_y_01"/>
	<input value="连续新增" onclick="xinzeng()" type="button" class="but_y_01" id="xinzeng"/>
</div>
<iframe name="filedocdetail4photoJSPhiddenFrame" width=0 height=0></iframe>


<div class="vcenter" style="height:460px;width:100%;overflow-y:auto;">
	<form id="form1" name="form1" action="" method="post">
		<input type="hidden" id="busi_id"      name="busi_id"  value="<%=busi_id %>" /> 
		<input type="hidden" id="opt_type"     name="opt_type" /> 
		<input type="hidden" id="busiTypeCode" name="busiTypeCode" />
		<input type="hidden" id="windowId" name="windowId" value="<%=windowId%>" />
		<oa:input type="hidden" column="F_FLOW_STATE" table="OA_FILE_DOC"   value="3" />
		<oa:input type="hidden" column="F_DESTROY_STATE" table="OA_FILE_DOC"   value="<%=FileDocBean.F_DESTROY_STATE_ONE%>" />
		<div style="float: left; width: 990px;">
			<div class="content_02_box" style="width: 990px;">
				<div class="content_02_box_title_bg" style="width: 98%;">
					<span>视频信息</span>
				</div>
				<div class="content_02_box_div" style="width: 98%;">
					<table border="0" cellspacing="0" cellpadding="0"
						class="content_02_box_div_table" style="width: 100%;">
							<tr>
								<th class="content_02_box_div_table_th"><span
									class="color_red">*</span>标题：</th>
								<td class="content_02_box_div_table_td" colspan=3><oa:input
										type="text" column="F_DOC_NAME" table="OA_FILE_DOC"
										other="class='validate[required,maxSize[200]] input_cx_title_240' style='width:733px;'" />
								</td>
							</tr>
							<tr><%--row2--%>
								<th class="content_02_box_div_table_th">地点：</th>
								<td class="content_02_box_div_table_td" colspan=3><oa:input
										type="text" column="F_ADD" table="OA_FILE_PAN_EXT"
										other="class='validate[maxSize[50]] input_cx_title_240' style='width:733px;'" />
								</td>
							</tr>
							<tr><%--row3--%>
								<th class="content_02_box_div_table_th"><span
									class="color_red">*</span>所属分类：</th>
								<td class="content_02_box_div_table_td"><oa:input
										type="text" column="F_TYPE_NAME" table="OA_FILE_DOC"
										value="<%=F_TYPE_NAME %>"
										other="readonly='readonly' class='input_cx_title_240'" /> <oa:input
										type="hidden" column="F_TYPE_ID" table="OA_FILE_DOC"
										value="<%=F_TYPE_ID %>" />
								</td>
								<th class="content_02_box_div_table_th"><span
									class="color_red">*</span>档案年份：</th>
								<td class="content_02_box_div_table_td">
									<oa:input
                                        type="text" column="F_DOC_YEAR" table="OA_FILE_DOC" 
                                        value="<%=f_doc_year %>"
                                        other="style='width:246px;background:url(/xtbg/ccapp/oa/resources/style/blue/images/date_img_year.jpg) right 1px no-repeat;' readonly='readonly' class='date_120'" />
                                     <script>
                                     jQuery("#OA_FILE_DOC__F_DOC_YEAR").attr("onclick","WdatePicker({dateFmt:'yyyy',maxDate:'<%=wjzhTime%>-01-01'})");
                                     </script>
								</td>
							</tr>
							<tr><%--row4--%>
								<th class="content_02_box_div_table_th"><span
									class="color_red">*</span>所属部门：</th>
								<td class="content_02_box_div_table_td">
									<oa:input type="text" column="F_DEPT_NAME" table="OA_FILE_DOC"
                                		value="<%=F_ORG_NAME%>" 
                                		other='readonly="readonly"  style = "width:218px;" class="validate[required,maxSize[50]] input_160"' /> 
                            		<oa:input type="hidden" column="F_DEPT_ID" table="OA_FILE_DOC"
                                				value="<%=F_ORG_ID%>" other='' />
                            		<input name="f_dept_name_button" id="f_dept_name_button" type="button"  class="but_x"
                            			onclick='chooseOrg("OA_FILE_DOC__F_DEPT_ID","OA_FILE_DOC__F_DEPT_NAME","radio");'
                            		/>
									<oa:input
										type="hidden" column="F_ORG_ID" table="OA_FILE_DOC" value="<%=F_UNIT_ID %>" />
									<oa:input
										type="hidden" column="F_ORG_NAME" table="OA_FILE_DOC" value="<%=F_UNIT_NAME %>" />
										<script>
									var chooseOrg = function (id,name,treetypestr){
									    var s = new jQuery.z_tree();
									    s.treeID = 'mainUser';
									    s.treetypestr = treetypestr;
									    s.isShowSeacher = true;
									    s.treeName = "选择部门";
									    s.headerName = "选择部门";
									    s.isType="dept"; //要设置默认选中值，则需要此类型
									    s.type = "ADEPT";
									    s.selectedIds = jQuery("#"+id).val(),   
									    s.returnFunction = function(userObj,o){
									       try{
									        if (!IsSpace(o)) {
									             jQuery('#'+id).val(userObj.id);
									           jQuery('#'+name).val(userObj.name);
									        } else {
									            jQuery('#'+name).val("");
									            jQuery('#'+id).val("");
									        }
									       }catch(e){
									         /**忽略客户端异常信息**/ 
									       }
									    }
									    s.init();
									}
									</script>
								</td>
								
								<th class="content_02_box_div_table_th"><span
									class="color_red">*</span>密级：</th>
								<td class="content_02_box_div_table_td"><oa:select
										column="F_SECRECY_ID" table="OA_FILE_DOC" dictType="damj" hiddenName="F_SECRECY_NAME"
										defautValue="F_SECRECY_ID" other="style='width:246px'"></oa:select>
								</td>
							</tr>
							<tr><%--row5--%>
								
								<th class="content_02_box_div_table_th">摄影者：</th>
								<td class="content_02_box_div_table_td">
									<oa:input type="text" column="F_SHOOTING_USER" table="OA_FILE_PAN_EXT"
										other="validate[required,maxSize[100]] class='input_cx_title_240'" />
								</td>
								<th class="content_02_box_div_table_th">
									<span class="color_red">*</span>拍摄时间：
								</th>
								<td class="content_02_box_div_table_td">
									<oa:date
										dateFmt="yyyy-MM-dd" column="F_FILE_FORMTIME"
										table="OA_FILE_DOC"
										other="class='validate[required] date_120 Wdate' style='width:245px'" />
								</td>
							</tr>
							<tr><%--row6--%>
								<th class="content_02_box_div_table_th">参见号：</th>
								<td class="content_02_box_div_table_td"><oa:input
										type="text" column="F_INFO_NUM" table="OA_FILE_DOC"
										other="class='validate[maxSize[40]] input_cx_title_240'" />
								</td>
								<th class="content_02_box_div_table_th"><span
                                    class="color_red">*</span>时长：</th>
                                <td class="content_02_box_div_table_td">
                                	<oa:input type="hidden" column="F_FILE_NUM" table="OA_FILE_DOC" value="1"/><%--库存:默认=1--%>
                                	<oa:input type="hidden" column="F_FILE_NUM_UNIT" table="OA_FILE_DOC" value="3"/><%--原单位 3:小时--%>
                                	<oa:input type="hidden" column="F_FILE_NUM_UNIT_NAME" table="OA_FILE_DOC" value="小时"/><%--原单位 3:小时--%>
                                	<oa:input
                                        type="text" column="F_FILE_QUANTITY" table="OA_FILE_DOC" value="00:00:00"
                                        other="class='validate[required,maxSize[8]] input_cx_title_240' style='width:245px;'" />
									<script>
									jQuery("#OA_FILE_DOC__F_FILE_QUANTITY").blur(function(){
										var re = new RegExp("[0-9]{2}(:[0-5][0-9]){2}");
										if(!re.test(this.value)){
											this.value="00:00:00";
										}
									});
									
                                	</script>
                                </td>
							</tr>
							<tr><%--row7--%>
								<th class="content_02_box_div_table_th"><span
									class="color_red">*</span>介质类型：</th>
								<td class="content_02_box_div_table_td"><oa:select
										column="F_DOC_MEDIA" table="OA_FILE_DOC" dictType="jzlx"  hiddenName="F_DOC_MEDIA_NAME"
										defautValue="F_DOC_MEDIA" other="style='width:246px'"></oa:select>
								</td>
								
								<th class="content_02_box_div_table_th"><span
									class="color_red">*</span>保管期限：</th>
								<td class="content_02_box_div_table_td"><oa:select
										column="F_DOC_DEADLINE" table="OA_FILE_DOC" dictType="bgqx"  hiddenName="F_DOC_DEADLINE_NAME"
										defautValue="<%=f_doc_deadline %>" other="style='width:246px'"></oa:select>
								</td>
							</tr>
							<tr>
								<th class="content_02_box_div_table_th"><span
									class="color_red">*</span>存储格式：</th>
								<td class="content_02_box_div_table_td">
									<oa:select
										column="F_SAVE_FORMAT" table="OA_FILE_PAN_EXT" dictType="ccgs"  hiddenName="F_SAVE_FORMAT_NAME"
										defautValue="F_SAVE_FORMAT" other="style='width:246px'"></oa:select>
								</td>
								<th class="content_02_box_div_table_th"><span
									class="color_red">*</span>信息类型：</th>
								<td class="content_02_box_div_table_td">
									<oa:select
										column="F_ENTITY_TYPE" table="OA_FILE_DOC" dictType="swlx"  hiddenName="F_ENTITY_TYPE_NAME"
										defautValue="F_ENTITY_TYPE" other="style='width:246px'"></oa:select>
									<script>
									jQuery("#OA_FILE_DOC__F_ENTITY_TYPE").find("OPTION[value!='4']").remove();<%--照片文件.信息类型==照片--%>
									</script>
								</td>
							</tr>
							<th class="content_02_box_div_table_th"><span
                                    class="color_red">*</span>件号：</th>
                                <td class="content_02_box_div_table_td">
                                <oa:input
                                        type="text" column="F_DOC_NUM" table="OA_FILE_DOC"
                                        other="class='validate[custom[onlyNumberSp],maxSize[8]] input_cx_title_240'" />
                                </td>
                               	<th class="content_02_box_div_table_th"><span
									class="color_red">*</span>归档状态：</th>
								<td class="content_02_box_div_table_td"><oa:select
										column="F_DOC_STATE" table="OA_FILE_DOC" dictType="gdzt" hiddenName="F_DOC_STATE_NAME"
										defautValue="F_DOC_STATE" other="style='width:246px'"></oa:select>
								</td>
                            </tr>
							<tr>
								<th class="content_02_box_div_table_th"><span
									class="color_red">*</span>登记人：</th>
								<td class="content_02_box_div_table_td"><oa:input
										type="text" column="F_USER_NAME" table="OA_FILE_DOC"
										value="<%=F_USER_NAME%>"
										other="class='input_cx_title_240' readonly='readonly'" /> <oa:input
										type="hidden" column="F_USER_ID" table="OA_FILE_DOC"
										value="<%=F_USER_ID%>"
										other="class='input_cx_title_240' readonly='readonly'" />
								</td>
								<th class="content_02_box_div_table_th"><span
									class="color_red">*</span>登记日期：</th>
								<td class="content_02_box_div_table_td"><oa:date
										dateFmt="yyyy-MM-dd" column="F_CREATOR_TIME"
										table="OA_FILE_DOC" defaultValue="sysDate" realDateFmt="yyyy-MM-dd HH:mm:ss"
										other="class='validate[required] input_cx_title_240' style='width:245px' readonly='readonly'" />
									<script>
                                    	jQuery("#dis_OA_FILE_DOC__F_CREATOR_TIME").removeAttr("onclick");
                                    </script>
								</td>
							</tr>
							<tr>
								<th class="content_02_box_div_table_th" style="height: 70px">内容：</th>
								<td class="content_02_box_div_table_td" colspan="3">
									<oa:textarea
										column="F_DOC_CONTENT" table="OA_FILE_DOC"
										other="style='width:733px;'" />
									<div id="defaultFileMB" style="display: none"><%=defaultFileMB%></div>
								</td>
							</tr>
							<tr id='fuJianTr'>
                             	<th class="content_02_box_div_table_th" style="vertical-align: top">附件：</th>
								<td class="content_02_box_div_table_td" colspan=3>
									<%if(isview){
										openType = "000";
										if(canDownload&&canRead){
											openType = "011";
										}else if(!canDownload&&canRead){
											openType = "010";
										}else if(canDownload&&!canRead){
											openType = "001";
										}%>
										<oa:affixbut 
										butName='请选择文件' column='F_ATTACH_ID' table='OA_FILE_DOC'
										title='' operType="<%=openType%>"/>
										<%
									}else{%>
									<oa:affixbut
										butName='请选择文件' column='F_ATTACH_ID' table='OA_FILE_DOC'
										title='' operType="<%=openType%>"/>
									<%} %>
								</td>
							</tr>
							<tr>
								<th class="content_02_box_div_table_th" style="vertical-align: top">附件列表：</th>
								<td class="content_02_box_div_table_td" colspan="3"><oa:affixshow
										title='' /></td>
							</tr>
						</table>
					</div>
				<div class="content_02_box_title_bg" style="width: 98%;display: none;" id="gdDiv1" >
                    <span>归档信息</span>
                </div>
                <div class="content_02_box_div"      style="width: 98%;display: none;" id="gdDiv2">
                    <table border="0" cellspacing="0" cellpadding="0"
                        class="content_02_box_div_table" style="width: 100%;">
                            <tr>
                                <th class="content_02_box_div_table_th"><span
                                    class="color_red">*</span>档号：</th>
                                <td class="content_02_box_div_table_td" colspan=3>
                                       <oa:input type="text" column="F_FILE_NO" table="OA_FILE_DOC"
                                           value="<%=StringUtil.deNull(bean.getF_files_no()) %>" other='style = "width:90%;" class="validate[required,maxSize[200]] input_160" ' /> 
                                       <input type="hidden" id="f_files_id" name="f_files_id" 
                                       value="<%=StringUtil.deNull(f_files_id) %>"/>
                                </td>
                            </tr>
                            <!-- 由档案管理传值 begin --------------------------------------------------------------------->
                            <tr>
                                <th class="content_02_box_div_table_th"><span
                                    class="color_red">*</span>存放位置：</th>
                                <td class="content_02_box_div_table_td" colspan=3>
                                     <%=StringUtil.deNull(bean.getF_storage_fullname()) %>
                                </td>
                            </tr>
                            <tr>
                                <th class="content_02_box_div_table_th"><span
                                    class="color_red">*</span>案卷号：</th>
                                <td class="content_02_box_div_table_td">
                                     <%=StringUtil.deNull(bean.getF_filesno()) %>
                                </td>
                                <th class="content_02_box_div_table_th"><span
                                    class="color_red">*</span>归档人：</th>
                                <td class="content_02_box_div_table_td">
                                <%=StringUtil.deNull(bean.getF_file_username()) %>
                                </td>
                            </tr>
                            <!-- 由档案管理传值 end------------------------------------------------------------------------ -->
                            <tr>
                                <th width="20%" class="content_02_box_div_table_th">
                                                                                                   档案分类号：</th>
                                <td width="30%" class="content_02_box_div_table_td">
                                <%=StringUtil.deNull(bean.getF_typeno()) %>
                                </td>
                                <th width="20%" class="content_02_box_div_table_th">
                                                                                                    归档日期：</th>
                                <td width="30%" class="content_02_box_div_table_td">
                                <%=StringUtil.deNull(bean.getF_file_time()) %>
                                </td>
                                
                            </tr>
                            <tr>
                                <th class="content_02_box_div_table_th"><span
                                    class="color_red">*</span>全宗号：</th>
                                <td class="content_02_box_div_table_td">
                                <%=StringUtil.deNull(bean.getF_fondsno()) %>
                                </td>
                                <th class="content_02_box_div_table_th">
                                </th>
                                <td class="content_02_box_div_table_td">
                               
                                </td>
                                
                            </tr>
                        </table>
                </div>

				<div class="content_02_box_title_bg" style="width: 98%;"></div>
			</div>
		</div>
	</form>
</div>
</div>
</body>
</oa:filedocinit>
</html>
<script type="text/javascript">
jQuery(function(){
	<%--为了支持附件标签,不能顶部--%>
	controlReadOnly();
});
</script>
<%--f_type_id获取不到--%>
<jsp:include page="filecheckquerycount.jsp">
	<jsp:param name="checktype" value="1"/>
	<jsp:param name="f_doc_id" value="<%=busi_id%>"/>
	<jsp:param name="f_type_id" value="<%=F_TYPE_ID%>"/>
	<jsp:param name="isview" value="<%=isviewStr%>"/>
	<jsp:param name="hasRole" value="<%=canDownload||canRead%>"/>
</jsp:include>