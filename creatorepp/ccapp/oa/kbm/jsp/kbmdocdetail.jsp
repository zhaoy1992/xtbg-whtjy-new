<%--
　　描述：知识库管理文档明细界面（分审核和上传管理 两个入口。注意区分控制）
　　作者：黄海
　　版本：1.0
　　日期：2013-8-6
--%>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.xtbg.core.common.commonlist.Constant"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="com.chinacreator.xtbg.core.kbm.dao.*"%>
<%@page import="com.chinacreator.xtbg.core.kbm.entity.*"%>
<%@page import="com.chinacreator.xtbg.core.kbm.service.*"%>
<%@page import="com.chinacreator.xtbg.core.kbm.service.impl.*"%>
<%@page import="com.chinacreator.xtbg.core.kbm.util.KbmConstants"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.sysparam.util.*"%>
<%@page import="com.chinacreator.xtbg.core.kbm.util.KbmUtil"%>
<%@page import="com.chinacreator.xtbg.core.upload.util.UploadConstants"%>
<%
	String windowId = StringUtil.deNull(request.getParameter("windowId"));
	String opentype = StringUtil.deNull(request.getParameter("opentype"));

    AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
    String path = request.getContextPath();
    
    String k_doc_id = StringUtil.deNull(request.getParameter("k_doc_id"));
    String k_title = "";
    String k_code = "";
    String k_type_id  = StringUtil.deNull(request.getParameter("k_type_id"));
    String k_type_name  = StringUtil.deNull(request.getParameter("k_type_name"));
    
    String k_key = "";
    String k_secrecy_id = "";//select的name就id选定时确定
    String k_first_time = "";
    String k_create_user = accesscontroler.getUserID();
    String k_create_user_name = accesscontroler.getUserName();
    UserCacheBean usercachebean=UserCache.getUserCacheBean(k_create_user);
    String k_unit=usercachebean.getUnit_id();//单位
    String k_unit_name=usercachebean.getUnit_name();
    String k_dept = usercachebean.getOrg_id();//部门
    String k_dept_name = usercachebean.getOrg_name();
    
    String k_contents = "";
    String k_attach_id = "";
    String k_flag = "";
    String k_flag_name = "";
    String k_remark = "";
    
    String k_check_user = accesscontroler.getUserID();
    String k_check_user_name = accesscontroler.getUserName();
    String k_check_time = DateUtil.getCurrentDate();
    String k_check_info = "";
    
     //特检院OA 追加 批准人 批准意见字段   2014-03-27 start
	 String k_approval_time = DateUtil.getCurrentDate();//批准时间
	 String k_approval_user = accesscontroler.getUserID();      //批准人
	 String k_approval_user_name = accesscontroler.getUserName(); //批准人name
	 String k_approval_info = "";      //批准意见
	 //特检院OA 追加 批准人 批准意见 字段  2014-03-27 end
 	//特检院OA 追加适用部门ID 适用部门名称 start
	String k_receive_deptid = "";
	String k_receive_deptname = "";
	//特检院OA 追加适用部门ID 适用部门名称 end 
	
	//特检院OA 追加 上传类型 字段   2014-04-03 start
    String k_upload_type ="新增";	
   	//特检院OA 追加 上传类型 字段   2014-04-03 end
    
    String m_msg_contents = "";//短信模板
    
    String k_users = "";
    
    if(StringUtil.nullOrBlank(k_doc_id)){//为空，新增时
    	k_first_time=DateUtil.getCurrentDate();
    }else{
    	KbmDocService service = new KbmDocServiceImpl();
    	KbmDocBean model = new KbmDocBean();
    	model = service.getKbmDocBeanById(k_doc_id);
    	Map<String, String> kbmDocMap = RequestBeanUtils.transBean2Map(model);
        k_title = StringUtil.encoding4jQuery(model.getK_title());
        k_code = StringUtil.encoding4jQuery(model.getK_code());
        k_type_id  = model.getK_type_id();
        k_type_name  = model.getK_type_name();
        k_key = StringUtil.encoding4jQuery(model.getK_key());
        k_secrecy_id = model.getK_secrecy_id();
        k_first_time = model.getK_first_time().toString().substring(0,10);   
        k_unit=model.getK_unit();//单位   更新时单位还是新增时的单位不变
   	    k_unit_name=model.getK_unit_name();
   	    k_dept = model.getK_dept();//部门
   	    k_dept_name = model.getK_dept_name();
        k_contents = StringUtil.encoding4jQuery(model.getK_contents());
        if(!StringUtil.nullOrBlank(model.getK_attach_id())) k_attach_id = model.getK_attach_id();
        k_flag = model.getK_flag();
        k_remark = StringUtil.encoding4jQuery(model.getK_remark());
        k_flag_name = model.getK_flag_name();
        //if(!StringUtil.nullOrBlank(model.getK_check_time())){
        //	k_check_time = model.getK_check_time().toString().substring(0,10);
        //}
    	//特检院OA 追加 上传类型 字段   2014-04-03 start
    	k_upload_type = model.getK_upload_type();
     	//特检院OA 追加 上传类型 字段   2014-04-03 end
        k_check_info = model.getK_check_info();
        //特检院OA 追加 批准人 批准意见字段   2014-03-27 start
        //待审核
        if(!k_flag.equals(KbmConstants.FLAG_PENDING)){
        	k_check_user = model.getK_check_user();
        	k_check_user_name = model.getK_check_user_name();
       	    if(!StringUtil.nullOrBlank(model.getK_check_time())){
             	k_check_time = model.getK_check_time().toString().substring(0,10);
            }
        }
        //待批准
        if(!k_flag.equals(KbmConstants.FLAG_PASS)){
	        if(!StringUtil.nullOrBlank(model.getK_approval_time())){
	        	k_approval_time = model.getK_approval_time().toString().substring(0,10);
	        }
		   	k_approval_user = model.getK_approval_user();      //批准人
		   	k_approval_user_name = model.getK_approval_user_name(); //批准人name
		   	k_approval_info = model.getK_approval_info();      //批准意见
        }
   		//特检院OA 追加 批准人 批准意见 字段  2014-03-27 end
   		//特检院OA 追加适用部门ID 适用部门名称 start
		k_receive_deptid = model.getK_receive_deptid();
		k_receive_deptname = model.getK_receive_deptname();
		//特检院OA 追加适用部门ID 适用部门名称 end 
        if("checked".equalsIgnoreCase(opentype) || "uncheck".equalsIgnoreCase(opentype)){//来自审核功能时
        	String checkpass = SysParamUitl.getSysParamValueIsVALID(KbmConstants.KBM_NOTE_CHECKPASS);
        	if(!StringUtil.nullOrBlank(checkpass)){
        		m_msg_contents = SysParamUitl.getSysParamValue(checkpass);
            	List<Map<String, String>> listmap = SysParamUitl.getSysParamValueDetail(checkpass);
            	if(!StringUtil.nullOrBlank(m_msg_contents) && listmap!=null && listmap.size()>0){
            		for (Map<String, String> map : listmap){
            			//System.out.println("map.get(\"p_value_name\")=="+map.get("p_value_name")+",map.get(\"p_value_code\")==="+map.get("p_value_code")+",kbmDocMap.get(map.get(\"p_value_code\"))=="+kbmDocMap.get(map.get("p_value_code")));
            			if(kbmDocMap!=null && kbmDocMap.size()>0 && !StringUtil.nullOrBlank(kbmDocMap.get(map.get("p_value_code")))){
            				if("文档审核结果".equals(map.get("p_value_name"))){}else{
            				m_msg_contents = m_msg_contents.replaceAll(map.get("p_value_name"),kbmDocMap.get(map.get("p_value_code")));
            				}
            			}
            		}
            	}	
        	}
        	
        }
        
        //得到所以推荐人员，id用逗号隔开
        k_users = StringUtil.deNull(KbmUtil.getSuggestUserByDocId(k_doc_id));
    }
    
    //下拉框  选中的id由bean存的值确定
    String k_secrecy_id_dictType = "damj";//密级
    String k_secrecy_id_selectHtml = DictDropDownList.buildSelect4DictType(k_secrecy_id_dictType,"k_secrecy_id" ,  StringUtil.deNull(k_secrecy_id), "" , false, "" ,"" ,"class='validate[required] select_240' style='width: 282px;height:24px;'","" );
    
	if(StringUtil.isBlank(k_attach_id)){
		k_attach_id=StringUtil.getUUID();
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

	//已有编制的末级分类
	String  type_id = DaoUtil.sqlToField("select wm_concat(t.k_type_id) from oa_kbm_doc_type t where t.k_type_level = '3' and t.k_type_id in (select a.k_type_id from OA_KBM_DOC a)");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>知识库管理文档明细界面</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<!-- 引入提示 -->
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<!-- 引入上传控件 -->
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/fancyupload/mootools-1.2.5-core-jm.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/fancyupload/source/Fx.ProgressBar.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/fancyupload/source/Swiff.Uploader.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/fancyupload/source/FancyUpload3.Attach.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/fancyupload/myfancyupload.js" charset="utf-8"></script>
<!-- 引入formvValidatetion -->
<script type="text/javascript" src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/formvalidation/jquery.validationEngine.js" charset="utf-8"></script>
<script type="text/javascript" src="../resources/js/kbmdoc.js" ></script>
<script>

var k_users = "<%=k_users%>";
var path = "<%=path%>";
var windowId = "<%=windowId%>";
var opentype = "<%=opentype%>";

var k_title="<%=k_title%>";
var k_doc_id="<%=k_doc_id%>";
var k_code="<%=k_code%>";
var k_type_id="<%=k_type_id%>";
var k_type_name="<%=k_type_name%>";
var k_key="<%=k_key%>";
var k_secrecy_id="<%=k_secrecy_id%>";
var k_unit="<%=k_unit%>";
var k_unit_name="<%=k_unit_name%>";
var k_dept="<%=k_dept%>";
var k_dept_name="<%=k_dept_name%>";
var k_first_time="<%=k_first_time%>";
var k_create_user="<%=k_create_user%>";
var k_create_user_name="<%=k_create_user_name%>";
var k_attach_id="<%=k_attach_id%>";
var k_flag="<%=k_flag%>";
var k_flag_name="<%=k_flag_name%>";
var k_check_user="<%=k_check_user%>";
var k_check_user_name="<%=k_check_user_name%>";
var k_check_time="<%=k_check_time%>";
var oType="<%=oType%>";
var type_id = "<%=type_id%>";
var ids = new Array();
ids = type_id.split(",");

//特检院OA 追加 批准人 批准意见字段   2014-03-27 start
var	k_approval_time = "<%=k_approval_time%>";
var	k_approval_user = "<%=k_approval_user%>";      //批准人
var	k_approval_user_name = "<%=k_approval_user_name%>"; //批准人name
var	k_approval_info = "<%=k_approval_info%>";      //批准意见
//特检院OA 追加 批准人 批准意见 字段  2014-03-27 end
var k_receive_deptid = "<%=k_receive_deptid%>";//适用部门ID
var k_receive_deptname = "<%=k_receive_deptname%>";//适用部门名称
var m_msg_contents="<%=m_msg_contents%>";
//特检院OA 追加 上传类型 字段   2014-04-03 start
var k_upload_type="<%=k_upload_type%>";
//特检院OA 追加 上传类型字段   2014-04-03 end

jQuery(function() {
	MyFancyupload.createUpload('file_list', '#file_attach', '<%=path%>', '<%=path%>/servlet/pubFileUpload?buessid=<%=k_attach_id%>', false, "<%=k_attach_id%>",'',callback,'011');
	jQuery("#k_title").focus();
	//1）按钮流程权限隐藏与显示
	displayButton();
	//2）绑定控件值
	initFormValues();
	//3）选择分类 绑事件
    jQuery("#k_type_name_button").click(function(){
       chooseFileType("k_type_id","k_type_name",ids,"radio",true);
    });
	//4）审核时把控件置为不可用
	if(opentype=="uncheck" || opentype=="checked"){
		//jQuery("#eWebEditor1").attr("src",jQuery("#eWebEditor1").attr("src")+"&readonly=1");
		disabledForm();
		//特检院OA【发布】环节的执行人可修改【所属分类】、【编号】字段  2014-03-28 start 
		//待发布
		if (k_flag == "<%=KbmConstants.FLAG_APPROVAL_PASS%>") {
			jQuery("#k_code").prop("disabled", false);
			jQuery("#k_type_name").prop("disabled", false);
			jQuery("#k_type_name_button").show();
			jQuery("#k_check_info").prop("disabled", true);
			jQuery("#k_check_time").prop("disabled", true);
			jQuery("#k_approval_info").prop("disabled", true);
			jQuery("#k_approval_time").prop("disabled", true);
			
			jQuery("#k_receive_deptb_button").show();
		}
		//特检院OA 【发布】环节的执行人可修改【所属分类】、【编号】字段  2014-03-28 end 
		displayForm4CheckInfo();
		//特检院OA 追加 待审核 已发布 意见信息控制   信息 start
		if (k_flag != "<%=KbmConstants.FLAG_PENDING%>") {
			displayForm4ApprovalInfo();
		}
		//待批准
		if (k_flag == "<%=KbmConstants.FLAG_PASS%>") {
			jQuery("#k_check_info").prop("disabled", true);
			jQuery("#k_check_time").prop("disabled", true);
			//已处理列表
			if(opentype=="checked"){
				jQuery("#k_approval_info").prop("disabled", true);
				jQuery("#k_approval_time").prop("disabled", true);
			}
		}
		//已发布
		if (k_flag == "<%=KbmConstants.FLAG_PUBLISH_PASS%>") {
			jQuery("#k_check_info").prop("disabled", true);
			jQuery("#k_check_time").prop("disabled", true);
			jQuery("#k_approval_info").prop("disabled", true);
			jQuery("#k_approval_time").prop("disabled", true);
		}
		//特检院OA 追加 批准 信息 end
	}
	
	
	jQuery("#form1 INPUT[type='text']").height("24px");
	
	var _documentBodyHeight = window.top.findPageCacheName("_documentBodyHeight");
	jQuery("#treediv").height(_documentBodyHeight-(_documentBodyHeight-520+100));
	
});


/**
 * 函数:  displayForm4CheckInfo
 * 说明:  审核时显示文档表单中的审核信息
 */
function displayForm4CheckInfo(){
	jQuery("tr[id='more']").each(function(i, obj) {
		jQuery(this).show();
	});
	jQuery("div[id='more']").each(function(i, obj) {
		jQuery(this).show();
	});
}

/**
 * 函数:  displayForm4ApprovalInfo
 * 说明:  待批准时显示文档表单中的批准信息
 */
function displayForm4ApprovalInfo(){
	jQuery("tr[id='approval']").each(function(i, obj) {
		jQuery(this).show();
	});
	jQuery("div[id='approval']").each(function(i, obj) {
		jQuery(this).show();
	});
}



/**
 * 函数:  disabledForm
 * 说明:  审核时隐藏文档表单的基本信息控件
 */
function disabledForm(){
	jQuery("#k_title").prop("disabled", true);
	jQuery("#k_code").prop("disabled", true);
	jQuery("#k_type_name").prop("disabled", true);
	jQuery("#k_type_name_button").hide();
	jQuery("#k_key").prop("disabled", true);
	jQuery("#k_secrecy_id").prop("disabled", true);
	jQuery("#k_unit_name").prop("disabled", true);
	jQuery("#k_dept_name").prop("disabled", true);
	jQuery("#k_first_time").prop("disabled", true);
	//jQuery("#k_contents").prop("disabled", true);
	jQuery("#k_remark").prop("disabled", true);
	//适用部门选择按钮
	jQuery("#k_receive_deptb_button").hide();
}

/**
 * 函数:  displayButton
 * 说明:  按钮流程权限隐藏与显示
 */
function displayButton(){
	 
	//特检院OA 追加 批准和发布环节  2014-03-27 start 
	<%-- if (k_doc_id == "") { //新增时，审核功能按钮和推荐按钮隐藏
	    jQuery("#suggest").hide();//保存后才显示推荐
	    jQuery("#pass").hide();
	    jQuery("#unpass").hide();
	} else if (opentype == "unpublish" || opentype == "published") { //未发布
	    if (k_flag == "<%=KbmConstants.FLAG_PENDING%>") {
	        jQuery("#callback").show(); //“待审” 才显示“追回”
	        jQuery("#pending").hide(); //“待审” 隐藏   “送审”
	    }
	    if (k_flag == "<%=KbmConstants.FLAG_PASS%>") {
	        jQuery("#pending").hide(); //“审核通过时” 隐藏   “送审”
	    }
	} else if (opentype == "uncheck" || opentype == "checked") {//审核入口
		if (k_flag == "<%=KbmConstants.FLAG_PASS%>") {
			jQuery("#pass").hide();
		    jQuery("#unpass").show();
		}else if(k_flag == "<%=KbmConstants.FLAG_UNPASS%>"){
		 	jQuery("#unpass").hide();
		    jQuery("#pass").show();
	 	}else{
		    jQuery("#pass").show();
		    jQuery("#unpass").show();
	 	}
	    jQuery("#delete1").show();
	    jQuery("#saved").hide();
		jQuery("#pending").hide();
		jQuery("#callback").hide();
	} --%>
	if (k_doc_id == "") { //新增时，审核功能按钮和推荐按钮隐藏
	    jQuery("#suggest").hide();//保存后才显示推荐
	    jQuery("#pass").hide();
	    jQuery("#unpass").hide();
	} else if (opentype == "unpublish" || opentype == "published") { //未发布
	    if (k_flag == "<%=KbmConstants.FLAG_PENDING%>") {
	        jQuery("#callback").show(); //“待审核” 才显示“追回”
	        jQuery("#pending").hide(); //“待审核” 隐藏   “送审”
	        //jQuery("#saved").hide(); //“待审核” 隐藏 “保存”
	    }
	    if (k_flag == "<%=KbmConstants.FLAG_PASS%>") {
	        jQuery("#pending").hide(); //“审核通过时” 隐藏   “送审”
	        //jQuery("#saved").hide(); //“审核通过时” 隐藏 “保存”
	    }
	 	if (k_flag == "<%=KbmConstants.FLAG_APPROVAL_PASS%>") {
	        jQuery("#pending").hide(); //“审核通过时” 隐藏   “送审”
	        //jQuery("#saved").hide(); //“待发布” 隐藏 “保存”
	    }
	 	if (k_flag == "<%=KbmConstants.FLAG_PUBLISH_PASS%>") {
		        jQuery("#pending").hide(); //“审核通过时” 隐藏   “送审”
		       // jQuery("#saved").hide(); //“已发布” 隐藏 “保存”
	    }
	} else if (opentype == "uncheck" || opentype == "checked") {//审核入口
		//待批准
		if (k_flag == "<%=KbmConstants.FLAG_PASS%>") { 
			jQuery("#pass").hide(); //呈批按钮隐藏
			jQuery("#approval_pass").show(); //通过按钮显示
		    jQuery("#unpass").show();
			//已处理列表
			if(opentype == "checked"){
				  jQuery("#unpass").hide();
				  jQuery("#approval_pass").hide();
			}
		//待发布
		} else if(k_flag == "<%=KbmConstants.FLAG_APPROVAL_PASS%>"){
			jQuery("#pass").hide(); //呈批按钮隐藏
			jQuery("#publish_pass").show(); //发布按钮显示
			//已处理列表
			if(opentype == "checked"){
				  jQuery("#publish_pass").hide();
			}
		//不通过
		} else if(k_flag == "<%=KbmConstants.FLAG_UNPASS%>"){
		 	jQuery("#unpass").hide();
		 //待审核
	 	} else if(k_flag == "<%=KbmConstants.FLAG_PENDING%>"){
	 		 jQuery("#pass").show();
			 jQuery("#unpass").show();
		//已发布
	 	} else if(k_flag == "<%=KbmConstants.FLAG_PUBLISH_PASS%>"){
	 		
	 	} else {
		    jQuery("#unpass").show();
	 	}
	    jQuery("#delete1").show();
	    //jQuery("#saved").hide();
		jQuery("#pending").hide();
		jQuery("#callback").hide();
	}
	//特检院OA 追加  批准和发布 环节  2014-03-27 end
}
/**
 *附件是否可以编辑
 *@k_attach_id :附件id
 *@attachFlag : 是否可以操作的参数  true(可操作)  false（不可操作）
 */
/* function isFileEnble(k_attach_id,attachFlag){
	if(attachFlag){ 
    	MyFancyupload.createUpload('_fileshow', '_filebut', path, path+'/servlet/pubFileUpload?buessid='+k_attach_id, attachFlag, k_attach_id,'',function(){
			//上传附件回调
			autoTitle("#k_title",jQuery("#_fileshow li:first").contents().first().text());},'100');
	}else{
		MyFancyupload.createUpload('_fileshow', '_filebut', path, path+'/servlet/pubFileUpload?buessid='+k_attach_id, attachFlag, k_attach_id,'','','001');
	}
    if(!attachFlag){
        //设置上传按钮大小，间接实现隐藏
       jQuery("#_filebut").width(1).height(1);
    } 
} */
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
//关闭弹窗
function closed(){
	var p={
			headerText:'提示',
			okName:'确认',
	        okFunction:function(){
	        	removeAlertWindows(windowId,true);
	        },
	        cancelName:'取消'
		};
	alert("关闭后，数据将不会保存，确定关闭？",p);
    
}

/**
    函数:  initFormValues
    说明:  “新增”时或“修改”时初始化相关控件
**/ 
function initFormValues(){
	jQuery("#k_title").val(decoding4jQuery(k_title));
	jQuery("#k_doc_id").val(k_doc_id);
	jQuery("#k_code").val(decoding4jQuery(k_code));
	jQuery("#k_type_id").val(k_type_id);
	jQuery("#k_type_name").val(k_type_name);
	jQuery("#k_key").val(decoding4jQuery(k_key));
	jQuery("#k_secrecy_id").val(k_secrecy_id);
	jQuery("#k_unit").val(k_unit);
	jQuery("#k_unit_name").val(k_unit_name);
	jQuery("#k_dept").val(k_dept);
	jQuery("#k_dept_name").val(k_dept_name);
	jQuery("#k_first_time").val(k_first_time);
	jQuery("#k_attach_id").val(k_attach_id);
	//特检院OA 追加适用部门ID 适用部门名称 start
	jQuery("#k_receive_deptid").val(k_receive_deptid);
	jQuery("#k_receive_deptname").val(k_receive_deptname);
	//特检院OA 追加适用部门ID 适用部门名称 end 
	jQuery("#k_upload_type option[value='"+k_upload_type+"']").attr("selected","selected");
	//k_dcount新增为0,修改暂时不做处理
	//处理附件
	var attachFlag=true;
	if(opentype == "uncheck" || opentype == "checked"){//有不能修改时的条件
		attachFlag = false;
		jQuery("#k_check_user").val(k_check_user);
		jQuery("#k_check_user_name").val(k_check_user_name);
		jQuery("#k_check_time").val(k_check_time);
		
		//特检院OA 追加 批准人 批准意见字段   2014-03-27 start
		jQuery("#k_approval_user").val(k_approval_user);
		jQuery("#k_approval_user_name").val(k_approval_user_name);
		jQuery("#k_approval_time").val(k_approval_time);
		//特检院OA 追加 批准人 批准意见 字段  2014-03-27 end
		jQuery("#fujian").html("");
		oType="0";
	}
	//isFileEnble(k_attach_id,attachFlag);
}
var kbmdocbean={
		"k_doc_id": "",
	    "k_title": "",
	    "k_code": "",
	    "k_type_id": "",
	    "k_type_name": "",
	    "k_key": "",
	    "k_secrecy_id": "",
	    "k_secrecy_name": "",
	    "k_unit": "",
	    "opentype":"",
	    "k_unit_name": "",
	    "k_dept": "",
	    "k_dept_name": "",
	    "k_first_time": "",
	    "k_create_user": "",
	    "k_create_user_name": "",
	   // "k_contents": "",
	    "k_attach_id": "",
	    "k_flag": "",
	    "k_remark":"",
	    "k_flag_name": "",
	    "k_check_user": "",
	    "k_check_user_name": "",
	    "k_check_info":"",
	    "m_msg_type":"",
	    "m_msg_contents":"",
		//特检院OA 追加 批准人 批准意见字段   2014-03-27 start
		"k_approval_time":"",
		"k_approval_user":"",
		"k_approval_user_name":"",
		"k_approval_info":"",
		//特检院OA 追加 批准人 批准意见 字段  2014-03-27 end
		//特检院OA 追加适用部门ID 适用部门名称 start
		"k_receive_deptid":"",
		"k_receive_deptname":"",
		//特检院OA 追加适用部门ID 适用部门名称 end
		"k_upload_type":""
};
/**
 * 保存时拼装json对象供保存用--update
 */
function setValues(f,n){
	kbmdocbean.k_title=jQuery("#k_title").val();
	kbmdocbean.k_doc_id=k_doc_id;
	kbmdocbean.k_code=jQuery("#k_code").val();
	kbmdocbean.k_type_id=jQuery("#k_type_id").val();
	kbmdocbean.k_type_name=jQuery("#k_type_name").val();
	kbmdocbean.k_key=jQuery("#k_key").val();
	kbmdocbean.k_secrecy_id=jQuery("#k_secrecy_id").val();
	kbmdocbean.k_secrecy_name=jQuery("#k_secrecy_id option[value='']~option:selected").text();
	kbmdocbean.k_unit=jQuery("#k_unit").val();
	kbmdocbean.k_unit_name=jQuery("#k_unit_name").val();
	kbmdocbean.k_dept=jQuery("#k_dept").val();
	kbmdocbean.k_dept_name=jQuery("#k_dept_name").val();
	kbmdocbean.k_first_time=jQuery("#k_first_time").val();
	kbmdocbean.k_create_user=k_create_user;
	kbmdocbean.k_create_user_name=k_create_user_name;
	//var str = eWebEditor1.getHTML();
	//jQuery('#k_contents').val(str);
	//kbmdocbean.k_contents=jQuery("#k_contents").val();
	kbmdocbean.k_attach_id=jQuery("#k_attach_id").val();
	kbmdocbean.k_flag=f;
	kbmdocbean.k_flag_name=n;
	kbmdocbean.k_remark=jQuery("#k_remark").val();
	//特检院OA 追加适用部门ID 适用部门名称 start
	kbmdocbean.k_receive_deptid = jQuery("#k_receive_deptid").val();
	kbmdocbean.k_receive_deptname = jQuery("#k_receive_deptname").val();
	//特检院OA 追加适用部门ID 适用部门名称 end 
	
	//特检院OA 追加 上传类型 字段   2014-04-03 start
	kbmdocbean.k_upload_type = jQuery("#k_upload_type").val() ;
	//特检院OA 追加 上传类型字段   2014-04-03 end
	if(opentype == "uncheck" || opentype == "checked"){
		kbmdocbean.k_check_time=jQuery("#k_check_time").val();
		kbmdocbean.k_check_user=k_check_user;
		kbmdocbean.k_check_user_name=k_check_user_name;
		kbmdocbean.k_check_info=jQuery("#k_check_info").val();
		//特检院OA 追加 批准人 批准意见字段   2014-03-27 start
		kbmdocbean.k_approval_time = jQuery("#k_approval_time").val();//批准时间
		kbmdocbean.k_approval_user = jQuery("#k_approval_user").val(); //批准人
		kbmdocbean.k_approval_user_name = jQuery("#k_approval_user_name").val(); //批准人name
		kbmdocbean.k_approval_info = jQuery("#k_approval_info").val(); //批准意见
		//特检院OA 追加 批准人 批准意见 字段  2014-03-27 end
		//短信发送方式
		var m_msg_type = new Array();
		jQuery("input[name='m_msg_type']:checked").each(function(){         
		    m_msg_type.push(jQuery(this).val());
		});
		if(!isSpace(m_msg_type.join(",")) && !isSpace(jQuery("#m_msg_contents").val()) ){
			kbmdocbean.m_msg_type=m_msg_type.join(",");
			kbmdocbean.m_msg_contents=(jQuery("#m_msg_contents").val()).replace("文档审核结果",n);
		}
	}else{
		kbmdocbean.k_check_time="";
		kbmdocbean.k_check_user="";
		kbmdocbean.k_check_user_name="";
		kbmdocbean.k_check_info="";
	}
	//k_dcount新增为0,修改暂时不做处理
}

function saved(f,n,alertTile){
	//自动校验
    var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
	if (!isFlag){
		return isFlag;	
	}
	
	if(("1"==k_flag || "2"==k_flag) && ("unpublish"==opentype || "published"==opentype) && jQuery('#k_remark').val()==""){
		alert("请填写更新备注！");
		return;
	}
	setValues(f,n);//获取表单值并保存至JSON对象
	var data={
		kbmdocbean:kbmdocbean,
		action:"save",
		opentype:opentype
	}
	var okF = function() {
		url = "kbmdocdetaildo.jsp";
		jQuery.ajax({
			url : url,
			type : 'POST',
			dataType : 'json',
			data : data,
			async : true,
			success : function(data) {
				if (data.flag) {
					alert("操作成功！");
					setTimeout(function(){closeform(windowId);},ts);
				} else {
					alert("操作失败！");
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert("error:" + textStatus);
				closeform();
			}
		});
	};
	var p = {
		headerText : '提示',
		okName : '确认',
		okFunction : okF,
		cancelName : '取消'
	};
	var alertInfo= alertTile;
	if (k_flag=="<%=KbmConstants.FLAG_PENDING%>" && n=="暂存" ) {
		alertInfo="追回";
	}
	alert("确定要"+alertInfo+"吗？", p);	
}

function delete1(){
	//自动校验
    var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
	if (!isFlag){
		return isFlag;	
	}
	setValues();//获取表单值并保存至JSON对象
	var data={
		kbmdocbean:kbmdocbean,
		action:"delete"
	};
	var okF = function() {
		url = "kbmdocdetaildo.jsp?ids="+k_doc_id;
		jQuery.ajax({
			url : url,
			type : 'POST',
			dataType : 'json',
			data : data,
			async : true,
			success : function(data) {
				if (data.flag) {
					alert("操作成功！");
					setTimeout(function(){closeform(windowId);},ts);
				} else {
					alert("操作失败！");
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert("error:" + textStatus);
				closeform();
			}
		});
	};
	var p = {
		headerText : '提示',
		okName : '确认',
		okFunction : okF,
		cancelName : '取消'
	};
	alert("确定要删除吗？", p);	
}

/* 
函数:  closeform
说明:  关闭指定窗口，刷新其父页面列表
参数:  windowId 窗口id
*/
function closeform(windowId){
	closeAlertWindows(windowId, false, true);
}
/* 
函数:  setValue4m_msg_contents
说明:  事件响应方法设置短信模板
*/
function setValue4m_msg_contents(id){
	if(isSpace(jQuery("#k_check_info").val())){
		//alert("审核意见不能为空");
		//return;
	}
	//m_msg_contents=m_msg_contents.replace("【审核意见】",jQuery("#k_check_info").val())
	
	if(id=="model_id"){
		jQuery("#m_msg_contents").val(m_msg_contents);
	}else{
		if(jQuery("#m_msg_contents").val()==""){
			jQuery("#m_msg_contents").val(m_msg_contents);//短信模板
		}
	}
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
	  s.selectedIds=jQuery('#k_dept').val();
	  s.type='ADEPT';
	  s.returnFunction=function(orgObj){
		  if(!IsSpace(orgObj)){
			  jQuery('#k_dept').val(orgObj.id);
			  jQuery('#k_dept_name').val(orgObj.name);
			 }
		 }
	  s.init();
}

/*
函数:  chooseReceiveOrg
说明:  选择部门
参数：   org_id    部门ID
	   org_name  部门名称
*/
var chooseReceiveOrg = function (org_id,org_name){
	var s = new jQuery.z_tree();
	  s.treeID='mian';
	  s.treetypestr='checkbox';
	  s.isShowSeacher=true;
	  s.treeName="选取部门";
	  s.isType='dept';
	  s.headerName="选取部门";
	  s.item_id = 'org_id';
	  s.selectedIds=jQuery('#'+org_id).val();
	  s.type='ADEPT';
	  s.returnFunction=function(orgObj){
		  if(!IsSpace(orgObj)){
			  jQuery('#'+org_id).val(orgObj.id);
			  jQuery('#'+org_name).val(orgObj.name);
			 }
		 }
	  s.init();
}

/*
函数:  openSuggest
说明:  选择人员
参数：   userId（回填父页面的控件id）,userName（回填父页面的控件id）,
		orgName(回填父页面的“单位”控件id),treetypestr（单选radio或多选checkbox）
*/
var openSuggest = function (userId,userName,orgName,treetypestr){
	var s = new jQuery.z_tree();
	s.treeID = 'mianUser';
	s.treetypestr = treetypestr;
	s.isShowSeacher = true;
	s.treeName = "选取人员";
	s.headerName = "选取人员";
	s.type = "APERSON";
	s.selectedIds = k_users;
	s.returnFunction = function(userObj,o) {
		if(!isSpace(userObj) && !isSpace(userObj.id)){
			addSuggest(userObj.id,k_doc_id)
		}
	}
	s.init();
}

var callback = function(djsn,filetype,filename){
	MyFancyupload.deletes("<%=k_attach_id%>",djsn);
	jQuery("ul>li").not(":last").remove();
	//location.reload();
	//destroy();
}
</script>
</head>
<body>
	<div class="content_02_top" > 
		<!-- 特检院OA 追加 批准发布 2014-03-28  start-->
		<!-- <input value="保存" onclick="saved('<%=KbmConstants.FLAG_DRAFT %>','草稿')"  type="button" class="but_y_01" id="saved"/>
	    <input value="推荐" onclick="openSuggest()"  type="button" class="but_y_01" id="suggest"/>
	    <input value="送审" onclick="saved('<%=KbmConstants.FLAG_PENDING %>','送审')"  type="button" class="but_y_01" id="pending"/>
	    <input value="追回"   style="display: none" onclick="saved('<%=KbmConstants.FLAG_DRAFT %>','草稿')"  type="button" class="but_y_01" id="callback"/>
	    <input value="通过"   style="display: none" onclick="saved('<%=KbmConstants.FLAG_PASS %>','审核通过')"  type="button" class="but_y_01" id="pass"/>
	    <input value="不通过"  style="display: none" onclick="saved('<%=KbmConstants.FLAG_UNPASS %>','审核不通过')"  type="button" class="but_y_01" id="unpass"/>
	    -->
	    <input value="保存" onclick="saved('<%=KbmConstants.FLAG_PUBLISH_PASS %>','已发布','发布')"  type="button" class="but_y_01" id="saved"/>
<!-- 	    <input value="推荐" onclick="openSuggest()"  type="button" class="but_y_01" id="suggest"/> -->
	    <input value="送审" style="display: none" onclick="saved('<%=KbmConstants.FLAG_PENDING %>','待审核','送审')"  type="button" class="but_y_01" id="pending"/>
	    <input value="追回"   style="display: none" onclick="saved('<%=KbmConstants.FLAG_DRAFT %>','草稿','保存草稿')"  type="button" class="but_y_01" id="callback"/>
	    <input value="呈批"   style="display: none" onclick="saved('<%=KbmConstants.FLAG_PASS %>','待批准','审核通过')"  type="button" class="but_y_01" id="pass"/>
	    <input value="通过"   style="display: none" onclick="saved('<%=KbmConstants.FLAG_APPROVAL_PASS %>','待发布','审核通过')"  type="button" class="but_y_01" id="approval_pass"/>
		<input value="发布"   style="display: none" onclick="saved('<%=KbmConstants.FLAG_PUBLISH_PASS %>','已发布','发布')"  type="button" class="but_y_01" id="publish_pass"/>
		<input value="不通过"  style="display: none" onclick="saved('<%=KbmConstants.FLAG_UNPASS %>','不通过','不通过')"  type="button" class="but_y_01" id="unpass"/>
	    <!-- 特检院OA 追加 批准发布 2014-03-28  start-->
	    <input value="删除"  style="display: none" onclick="delete1()"  type="button" class="but_y_01" id="delete1"/>
	    <input value="关闭" onclick="closed()" type="button" class="but_y_01"/>
	</div>
	<div class="vcenter" style="float: left; width: 100%; height:460px;overflow-y: scroll" scrolling="yes" id="treediv">
		<form id="form1" name="form1" action="" method="post">
			<div style="float: left; width: 990px;">
				<div class="content_02_box" style="width: 990px;">
				<div class="content_02_box_title_bg" style="width: 98%;">
									<span>基本信息</span>
								</div>
					<div class="content_02_box_div" style="width: 98%;">
						<table border="0" cellspacing="0" cellpadding="0"
							class="content_02_box_div_table" style="width: 100%;">
							<tr>
								<th class="content_02_box_div_table_th"><span
									class="color_red">*</span>标题：</th>
								<td class="content_02_box_div_table_td" colspan=3><input
									type="text"
									class="validate[required,maxSize[100]] input_cx_title_240"
									style="width: 99%;" name="k_title" id="k_title" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" />
								</td>
							</tr>
							<tr>
								<th class="content_02_box_div_table_th"><span
									class="color_red">*</span>所属分类：</th>
								<td class="content_02_box_div_table_td" style="width: 290px">
									<input name="k_type_name" id="k_type_name" type="text"readonly="readonly"class="validate[required,maxSize[100]] input_cx_title_240"style="width: 250px;" /> 
									<input name="k_type_name_button" id="k_type_name_button" type="button"class="but_x" style="height: 26px;" /> 
									<input name="k_type_id"id="k_type_id" type="hidden" />
								</td>
								<th class="content_02_box_div_table_th">编号：</th>
								<td class="content_02_box_div_table_td"><input type="text" style="width: 282px"
									class="validate[maxSize[40]] input_cx_title_240" name="k_code"
									id="k_code" onkeyup="checkInsert(this),changeUploadType(this)"   onbeforepaste="checkPaste()" />
								</td>
							</tr>
							<tr>
								<th class="content_02_box_div_table_th"><span
									class="color_red">*</span>文件形成日期：</th>
								<td class="content_02_box_div_table_td" style="width: 290px">
									<input class="validate[required] date_120 Wdate" type="text"
									id="k_first_time" name="k_first_time" 
									onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width: 280px"/>
								</td>
								<th class="content_02_box_div_table_th">上传类型：</th>
								<td class="content_02_box_div_table_td">
									<select style="width: 282px" id="k_upload_type" name="k_upload_type" disabled="disabled">
										<option value="新增">新增</option>
										<option value="更新">更新</option>
									</select>
								</td>
							</tr>
							<tr>
								<th class="content_02_box_div_table_th"><span
									class="color_red">*</span>密级：</th>
								<td class="content_02_box_div_table_td" style="width: 290px">
									<%=k_secrecy_id_selectHtml %>
								</td>
								<th class="content_02_box_div_table_th"><span
									class="color_red">*</span>所属部门：</th>
								<td class="content_02_box_div_table_td"><input type="text"
									readonly="readonly"
									class="validate[required,maxSize[50]] input_cx_title_240"
									name="k_dept_name" id="k_dept_name" style="width: 282px"/><input type="hidden"
									name="k_dept" id="k_dept" />
								</td>
							</tr>
							<!--特检院OA 体系文件追加 试用单位字段 发布时，用来查看用 2014-03-31 start  -->
							<tr>
								<th class="content_02_box_div_table_th"><span
									class="color_red">*</span>发布单位：</th>
								<td class="content_02_box_div_table_td"><input type="text"
									readonly="readonly"
									class="validate[required,maxSize[50]] input_cx_title_240"
									name="k_unit_name" id="k_unit_name" style="width: 282px"/><input type="hidden"
									name="k_unit" id="k_unit" />
								</td>
								<th class="content_02_box_div_table_th">适用部门：</th>
								<td class="content_02_box_div_table_td" >
									<input type="text" readonly="readonly" class="validate[maxSize[2000]] input_cx_title_240" style="width: 250px"
										name="k_receive_deptname" id="k_receive_deptname" />
										<input id="k_receive_deptb_button" name="k_receive_deptb_button" type="button" value="" class="but_x" onclick="chooseReceiveOrg('k_receive_deptid','k_receive_deptname')"/>
										<input type="hidden" name="k_receive_deptid" id="k_receive_deptid" />
								</td>
							</tr>
							<!--特检院OA 体系文件追加 试用单位字段 发布时，用来查看用 2014-03-31 end  -->
							<tr>
								<th class="content_02_box_div_table_th">文件上传：</th>
								<td class="content_02_box_div_table_td" colspan=3 id="fujian">
									<input id="k_attach_id" type="hidden" value="<%=k_attach_id %>">
									<a href="#" id="file_attach">请选择文件</a>
								</td>
							</tr>
							<tr>
								<th class="content_02_box_div_table_th" valign="top">查看文件：</th>
								<td class="content_02_box_div_table_td" colspan=3>
									<ul id="file_list" ></ul>&nbsp;
								</td>
							</tr>
							<!--<tr>
								<th class="content_02_box_div_table_th">内容：</th>
								<td class="content_02_box_div_table_td" colspan=3>
								<textarea style="display: none" id="k_contents" name="k_contents" class="validate[maxSize[500]] textarea_575" style="width: 99%;"><%=k_contents %></textarea>
								<iframe id="eWebEditor1" src="../../resources/plug/eWebEditor_V4.60/ewebeditor.htm?id=k_contents&style=gray" frameborder="0" 
								scrolling="no" width="100%" height="400"></iframe>
								</td>
							</tr>
							<tr>
								<th class="content_02_box_div_table_th">关键字(用<font color=red>半角的“,”</font>分开)：</th>
								<td class="content_02_box_div_table_td" colspan=3><input
									type="text"
									class="validate[maxSize[100]] input_cx_title_240"
									style="width: 99%;" name="k_key" id="k_key" />
								</td>
							</tr> -->
							<tr>
								<%if(("1".equals(k_flag)||"2".equals(k_flag)) && (("unpublish".equals(opentype) || "published".equals(opentype)))){ %>
								<th class="content_02_box_div_table_th"><span class="color_red">*</span>更新备注：</th>
								<td class="content_02_box_div_table_td" colspan=3><textarea
										id="k_remark" name="k_remark" 
										class="validate[maxSize[500]] textarea_575" style="width: 99%;"><%=k_remark %></textarea>
								</td>
								<%}else{ %>
								<th class="content_02_box_div_table_th">更新备注：</th>
								<td class="content_02_box_div_table_td" colspan=3><textarea
										id="k_remark" name="k_remark" 
										class="validate[maxSize[500]] textarea_575" style="width: 99%;"><%=k_remark %></textarea>
								</td>
								<%} %>
							</tr>
							<!-- 审核时显示的信息，默认隐藏 -->
							<tr id="more" style="display: none">
								<th class="content_02_box_div_table_th">审核意见：</th>
								<td class="content_02_box_div_table_td" colspan=3><textarea
										id="k_check_info" name="k_check_info"
										class="validate[maxSize[500]] textarea_575" style="width: 99%;"><%=k_check_info %></textarea>
								</td>
							</tr>
							<tr id="more" style="display: none">
								<th class="content_02_box_div_table_th"><span
									class="color_red">*</span>审核人：</th>
								<td class="content_02_box_div_table_td"><input type="text"
									readonly="readonly"
									class="validate[required,maxSize[50]] input_cx_title_240"
									name="k_check_user_name" id="k_check_user_name" style="width: 282px"/><input type="hidden"
									name="k_check_user" id="k_check_user" />
								</td>
								<th class="content_02_box_div_table_th"><span
									class="color_red">*</span>审核日期：</th>
								<td class="content_02_box_div_table_td" style="width: 290px">
									<input class="validate[required] date_120 Wdate" type="text"
									id="k_check_time" name="k_check_time" 
									onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width: 280px"/>
								</td>
							</tr>
							<!-- 特检院OA 批准时显示的信息，默认隐藏  2014-03-28  start-->
							<tr id="approval" style="display: none">
								<th class="content_02_box_div_table_th">批准意见：</th>
								<td class="content_02_box_div_table_td" colspan=3><textarea
										id="k_approval_info" name="k_approval_info"
										class="validate[maxSize[500]] textarea_575" style="width: 99%;"><%=k_approval_info %></textarea>
								</td>
							</tr>
							<tr id="approval" style="display: none">
								<th class="content_02_box_div_table_th"><span
									class="color_red">*</span>批准人：</th>
								<td class="content_02_box_div_table_td"><input type="text"
									readonly="readonly"
									class="validate[required,maxSize[50]] input_cx_title_240"
									name="k_approval_user_name" id="k_approval_user_name" style="width: 282px"/><input type="hidden"
									name="k_approval_user" id="k_approval_user" />
								</td>
								<th class="content_02_box_div_table_th"><span
									class="color_red">*</span>批准日期：</th>
								<td class="content_02_box_div_table_td" style="width: 290px">
									<input class="validate[required] date_120 Wdate" type="text"
									id="k_approval_time" name="k_approval_time" 
									onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width: 280px"/>
								</td>
							</tr>
							<!-- 特检院OA 批准时显示的信息，默认隐藏  2014-03-28 end-->
						</table>
					</div>
					
					<!-- 消息提醒begin -->
					<div id="more1"  style="display: none">
						<div class="content_02_box_title_bg" style="width: 98%;">
							<span>消息提醒</span>
							<div class="content_02_box_add show_content" style="cursor: hand">
							</div>
						</div>
						<div class="content_02_box_div" style="width: 98%;">
							<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table" style="width: 100%;">
								<tr>
									<th class="content_02_box_div_table_th"  style="width:200px;">提醒方式：</th>
									<td class="content_02_box_div_table_td" colspan="5">
										<div><span style="float:left;display:block;width: 20px">&nbsp;</span>
											<input style="float:left;display:block;margin:7px 2px 0 2px" type="checkbox"  name="m_msg_type" id="m_msg_type" onclick="setValue4m_msg_contents(this.id);" />
											<span style="float:left;display:block;width: 50px">短信</span>
											<input style="float:left;display:block;margin:7px 2px 0 2px" type="checkbox"  name="m_msg_type" id="m_msg_type" onclick="setValue4m_msg_contents(this.id);"  />
											<span style="float:left;display:block;width: 100px">及时信息</span>
											<!-- <input style="float:left;display:block;width: 100px" type="button" class="but_y_05" value="使用默认模版"/> -->
											<span style="float:left;display:block;width: 100px" id="model_id" onclick="setValue4m_msg_contents(this.id);">使用默认模版</span>
										</div>
									</td>
								</tr>
								<tr>
									<th class="content_02_box_div_table_th" >提醒内容：</th>
									<td class="content_02_box_div_table_td" colspan="5">
										<textarea id="m_msg_contents" name="m_msg_contents" class="validate[maxSize[300]] textarea_575" cols="110" rows="2" style="width: 99%;"></textarea>
									</td>
								</tr>
							</table>
						</div>
					</div>
					<!-- 消息提醒end -->
				</div>
			</div>
		</form>
	</div>
</body>
</html>