<%--
　　描述：档案管理--文件管理--照片文件(照片组)
　　作者：黄海
　　版本：1.0
　　日期：2013-7-22
　　参数:
    busi_id:照片文件ID(照片组)
    F_TYPE_ID:文件分类ID
	isgd:归档
	isview：查看页面
--%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.fancyuoload.service.impl.FiletransferServiceImpl"%>
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
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	String getCurrentDate = DateUtil.getCurrentDate();//"yyyy-MM-dd"
	String getCurrentDateTime = DateUtil.getCurrentDateTime();//"yyyy-MM-dd HH:mm:ss"
	String windowId = StringUtil.deNull(request
			.getParameter("windowId"));
	String busi_id  = StringUtil.deNull(request.getParameter("busi_id"));
	    if(busi_id.length()>0){
	    	model = FileDocBean.MODEL_B;
	    }
	String F_USER_ID = accesscontroler.getUserID();
	UserCacheBean usercachebean = UserCache.getUserCacheBean(F_USER_ID);
	if (usercachebean == null) {
		usercachebean = new UserCacheBean();
	}
	String F_UNIT_ID = usercachebean.getUnit_id();
	String F_UNIT_NAME = usercachebean.getUnit_name();
	String F_ORG_ID = usercachebean.getOrg_id();
	String F_ORG_NAME = usercachebean.getOrg_name();

	String F_USER_NAME = accesscontroler.getUserName();
	String F_CREATOR_TIME = DateUtil.getCurrentDateTime();
	String F_TYPE_ID = StringUtil.deNull(request
			.getParameter("F_TYPE_ID"));
	String F_TYPE_NAME = StringUtil.deNull(request
			.getParameter("F_TYPE_NAME"));
	F_TYPE_NAME = DataControlUtil.replaceStr(F_TYPE_NAME);
	F_TYPE_NAME = Escape.unescape(F_TYPE_NAME);
	String isgd = StringUtil.deNull(request.getParameter("isgd"));
	String f_files_id = StringUtil.deNull(request
			.getParameter("f_files_id"));

	String f_doc_year = DateUtil.getCurrentYear();
	String f_doc_deadline = StringUtil.deNull(request
			.getParameter("f_doc_deadline"));//保管期限

	String SEPARATOR = Constant.SEPARATOR;//分隔字符

	String mypath = request.getServletPath();
	mypath = mypath.substring(0, mypath.lastIndexOf("/") + 1);
	mypath = request.getContextPath() + mypath;

	//WJZH初始化
    String wjzhTime = DateUtil.getCurrentYear();
    if(wjzhTime==null){
    	wjzhTime = "2014";
    }
    String defaultWZJH = "["+wjzhTime+"] 号";

	//服务对象
	FileFilesService service = new FileFilesServiceImpl();
	FileFilesBean bean = new FileFilesBean(); //文档对象
	if (!StringUtil.nullOrBlank(f_files_id)) {
		bean = service.queryToFileFilesBean(f_files_id);
		//处理时间
		String closeTime = bean.getF_file_time().toString();
		if (!StringUtil.nullOrBlank(closeTime)) {
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
	if (StringUtil.nullOrBlank(busi_id)) {
		isInsert = true;
	}
	//查询入口参数:isview
	boolean isview = false;//true?查询:编辑
	boolean canRead = false;//true?查询时可读:查询时不可读
	boolean canDownload = false;//true?查询时可下载:查询时不可下载
	String isviewStr = StringUtil
			.deNull(request.getParameter("isview"));
	if (isviewStr != null && isviewStr.length() > 0) {
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
	boolean fromPageIsAJ = false;//进入的入口是否是案卷
	if (!StringUtil.nullOrBlank(isgd)) {
		fromPageIsAJ = true;
	}
	String upload_To_SeverPath = new String(FiletransferServiceImpl.upload_To_SeverPath);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>档案管理--文件管理--照片</title>
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
		}
	}
}

%>
<script type="text/javascript" src="<%=mypath%>../resources/js/filedoclist.js"></script>
<script>
var SEPARATOR = "<%=SEPARATOR%>";
var tableName = "OA_FILE_DOC"+SEPARATOR+"";
var isgd="<%=isgd%>";
var upload_To_SeverPath ="<%=upload_To_SeverPath.replaceAll("\\\\","/")%>";
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
	if(!jQuery("#OA_FILE_DOC__F_DOC_NUM").attr("disabled")){
		jQuery("#OA_FILE_DOC__F_DOC_NUM").focus();
	}
	 //初始化归档状态
    if(initFileState){
    	initFileState();
    }
    //获得文件内容模板数据
    initFileMB();
    initData();
    if(typeof(initTable)=='function'){
    	initTable();	
    }
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

<%if(fromPageIsAJ){
	%>
	initFileState = function(){
		jQuery("#OA_FILE_DOC__F_DOC_STATE OPTION[value!='2']").remove();
	};
	<%
}else{
	if(isInsert){//来自案卷管理外的新增
	%>
	initFileState = function(){
		jQuery("#OA_FILE_DOC__F_DOC_STATE OPTION[value!='0'][value!='1']").remove();
	};
	<%
	}else{//来自案卷管理外的修改
	%>
	initFileState = function(){
	};
	<%
	}
}%>
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

/**
 * 打印照片
 */
function print(){
	//ajax方式提交数据
    jQuery.ajax({
        type: "post",
        url: '<%=mypath%>filetypeinfodo.jsp?action=exportPic', 
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data : {
        	"action":"exportPic",
        	"id":jQuery("#busi_id").val()
        },
        dataType: "json",
        success: function(data){
            if(data&&data.length){
            	printDetailBackPhoto(data);
            }else{
                alert("找不到可打印照片！");
            }
        }, 
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert("出现异常，请稍后再试！");
        }
     });
}
/* 打印图片详细信息回调函数 */
 function printDetailBackPhoto(data){
	debugger;
     var htmlArray = new Array();
     htmlArray.push('<div id="printPic" style="width:660px;float:left;font-size:12px;">');
     htmlArray.push("<div style='width:100%;height:20px;float:left;margin-bottom:20px;");
     htmlArray.push("border-bottom:1px solid #000;text-align:right;'>第1页</div>");
     var i = 1;
	for(var j=0;j<data.length;j++){
		//id不为空
         htmlArray.push(getHTMLFromPhoto(data[j]));    
         if(i%3 == 0 && i!=(data.length)){
        	 htmlArray.push("<div style='width:100%;height:20px;float:left;");
             htmlArray.push("border-bottom:1px solid #000;text-align:right;'>&nbsp;</div>");         
             
             htmlArray.push("<div style='float:left;height:72px;width:100%;'></div>");

             
             htmlArray.push("<div style='width:100%;height:20px;float:left;margin-bottom:20px;");
             htmlArray.push("border-bottom:1px solid #000;text-align:right;'>第"+(i/3+1)+"页</div>"); 

         }

         
         i++; 
	}
     htmlArray.push('</div>');
     jQuery("#testDiv1").html(htmlArray.join(" "));
      /*判断浏览器的类型并决定采用哪个对象实例，并检测控件是否安装、是否最新版本、并引导安装或升级。  */
      var LODOP=getLodop(document.getElementById('LODOP'),document.getElementById('LODOP_EM'));      
      createPrintHtml(LODOP,htmlArray.join(" "));        
      LODOP.PREVIEW();
 };
var ischecked = false;
function getIMGFromPhoto(data){
	debugger;
	if(typeof(htmlshowTIFhelp)=='undefined'){
		var fileurl = data.fileurl.trim();
		if(fileurl&&fileurl.length>4){
			djsnId = fileurl.substring(0,fileurl.length-4);
			fileNameStr = data.f_title;
			srcUrl = "<%=path%>/servlet/pubFileDownload?djsn="+djsnId+"&openType=download&_Custom_Download=pageReadTif&fileName="+fileNameStr;
			var html = [
				  '<img src="'+srcUrl+'"  title="'+srcUrl+'"' ,
				  'style="margin-bottom:0px;float:left;" border="0" height="300" width="460" />'];
			return html.join(" ");
		}else{
			var html = [
				  '<img title="找不到图片路径" style="margin-bottom:0px;float:left;" border="0" height="300" width="460" />'];
			return html.join(" ");
		}
	}else{
		if(!ischecked){
			htmlshowTIFhelp.checkTIF("checkTIFmessDiv");
			ischecked = true;
		}
		if(htmlshowTIFhelp.unNeedCJ){
			var html = [
				  '<img src="<%=path%>'+upload_To_SeverPath+data.fileurl+'"',
				  'style="margin-bottom:0px;float:left;" border="0" height="300" width="460" />'];
				return html.join(" ");
		}else{
			if(htmlshowTIFhelp.hasCJ){
				srcUrl = "<%=path%>"+upload_To_SeverPath+data.fileurl;
				var sqls=new Array;
				sqls.push("<OBJECT WIDTH='460px;' HEIGHT='300px;' CLASSID='CLSID:106E49CF-797A-11D2-81A2-00E02C015623'>");
				sqls.push(" <embed src='"+srcUrl+"' type='application/x-alternatiff'>");
				sqls.push(" <param name='src' value='"+srcUrl+"'>");
				sqls.push(" <param name='negative' value='no'>");
				sqls.push("</OBJECT>");
				return sqls.join(" ");
			}else{
				srcUrl = "<%=path%>"+upload_To_SeverPath+data.fileurl;
				var sqls=new Array;
				sqls.push("<OBJECT WIDTH='460px;' HEIGHT='300px;' CLASSID='CLSID:106E49CF-797A-11D2-81A2-00E02C015623'>");
				sqls.push(" <embed src='"+srcUrl+"' type='application/x-alternatiff'>");
				sqls.push(" <param name='src' value='"+srcUrl+"'>");
				sqls.push(" <param name='negative' value='no'>");
				sqls.push("</OBJECT>");
				alert(sqls.join(" "));
				return sqls.join(" ");
			}
		}
	}
}
 function getHTMLFromPhoto(data){
	  var html = [
	   '<table border="0" cellpadding="0" cellspacing="0" width="660px;" style="margin-bottom:20px;">',
	   '<tr>',
	   '<td style="width:480px;height:300px;padding:0px;" valign="bottom">',
	   getIMGFromPhoto(data),
	   '</td>',
	   '<td style="width:150px;padding:0px;" align="left" valign="bottom">',
	        '<table border="0"cellpadding="0" cellspacing="1" width="100%" style="font-size:12px;display:inline;background: #000;margin:0px;">',
	         '<tr style="background: #FFF;">',
	           '<td align="center" style="width:50px;">',
	           ' 题名',
	           '</td>',
	           '<td align="center" style="width:100px;height: 40px;">',
	              '<div style="vertical-align:middle;height:40px;width:90px;word-wrap:break-wrod;',
	                'word-break:break-all;overflow: hidden;float: left;display: inline;',
	                'line-height:20px;margin-left:5px;">'+data.f_title,
	              '</div>',
	           '</td>',
	         '</tr>',      
	         '<tr style="background: #FFF;">',
	           '<td align="center" >',
	           '照片号',
	           '</td>',
	           '<td align="center" >'+data.f_no,
	           '</td>',
	         '</tr>',	         
	         '<tr style="background: #FFF;">',
	           '<td align="center" >',
	           ' 参见号',
	           '</td>',
	           '<td align="center" >'+data.f_cj_no+'&nbsp;',
	           '</td>',
	         '</tr>',
	          '<tr style="background: #FFF;">',
	           '<td align="center" >',
	           '时间',
	           '</td>',
	           '<td align="center" >'+data.f_file_formtime+"&nbsp;",
	           '</td>',
	         '</tr>',	         
	         '<tr style="background: #FFF;">',
	           '<td align="center" >',
	           '摄影者',
	           '</td>',
	           '<td align="center" >'+data.f_shooting_user+"&nbsp;",
	           '</td>',
	         '</tr>',	         
	         '<tr style="background: #FFF;">',
	           '<td align="center" >',
	           ' 文字<br/>说明',
	           '</td>',
	           '<td style="height:140px;width:100px;">',
	           '<div style="height:140px;width:90px;word-wrap:break-wrod;',
	                'word-break:break-all;overflow: hidden;float: left;display: inline;',
	                'line-height:20px;margin-left:5px;">',
	                data.f_doc_content_pic,
	              '</div>',
	           '</td>',
	         '</tr>',
	      '</table>',
	   '</td>',
	   '</tr>',
	   '</table>'
	 ]
	 return html.join(" ");
 }
/**
 * 打印照片说明
 */
function printDetail(){
	//ajax方式提交数据
    jQuery.ajax({
        type: "post",
        url: '<%=mypath%>filetypeinfodo.jsp?action=exportPicDetail', 
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data : {
        	"action":"exportPicDetail",
        	"type":"1",//1:照片文件(照片组),2照片信息
        	"id":jQuery("#busi_id").val()
        },
        dataType: "json",
        success: function(data){
            if(data&&data.length){
            	printDetailBack(data);
            }else{
                alert("找不到可打印的照片说明！");
            }
        }, 
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert("出现异常，请稍后再试！");
        }
     });
}
/**
 * 打印照片组说明
 */
function printDetailZPZ(){
	//ajax方式提交数据
    jQuery.ajax({
        type: "post",
        url: '<%=mypath%>filetypeinfodo.jsp?action=exportPicFile',
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data : {
        	"action":"exportPicFile",
        	"id":jQuery("#busi_id").val()
        },
        dataType: "json",
        success: function(data){
            if(data&&data.length){
            	printDetailBackZPZ(data);
            }else{
                alert("找不到可打印的照片组说明！");
            }
        }, 
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert("出现异常，请稍后再试！");
        }
     });
}
<%--照片组--%>
function getHTMLForZPZ(data){
		if(data.f_doc_content&&data.f_doc_content.length>150){
			data.f_doc_content = data.f_doc_content.substring(0,150)+'...';
		}
	  var html = [
	   '<table border="0" cellpadding="0" cellspacing="0" width="660px;" style="margin-bottom:20px;">',
		'		<tr>',
		'		<td style="width:480px;height:300px;padding:0px;" valign="bottom">',
		'		<table border="0"cellpadding="0" cellspacing="1" width="100%" style="text-align: center;font-size:16px;display:inline;background: #000;margin:0px;">',
		'			<tr style="background: #FFF;height: 30px;">',
		'				<td colspan="5" style="text-align: center">',
		'					照片档案说明',
		'				</td>',
		'			</tr>',
		'			<tr style="background: #FFF;height: 30px;">',
		'				<td style="width:20%">类别</td>',
		'				<td style="width:20%">案卷号</td>',
		'				<td style="width:20%">照片号</td>',
		'				<td style="width:20%">张数</td>',
		'				<td style="width:20%">规格</td>',
		'			</tr>',
		'			<tr style="background: #FFF;height: 30px;">',
		'				<td>'+data.f_type_name+'</td>',
		'				<td>'+data.f_filesno+'</td>',
		'				<td>'+data.f_info_num+'</td>',
		'				<td>'+data.f_file_quantity+'</td>',
		'				<td>'+data.f_specification+'</td>',
		'			</tr>',
		'			<tr style="background: #FFF;height: 30px;">',
		'				<td>拍摄时间</td>',
		'				<td colspan="2">'+data.f_file_formtime+'</td>',
		'				<td>摄影者</td>',
		'				<td>'+data.f_shooting_user+'</td>',
		'			</tr>',
		'			<tr style="background: #FFF;height: 30px;">',
		'				<td>地点</td>',
		'				<td colspan="4">'+data.f_add+'</td>',
		'			</tr>',
		'			<tr style="background: #FFF;height: 100px;">',
		'				<td>内容</td>',
		'				<td colspan="4">'+data.f_doc_content+'</td>',
		'			</tr>',
		'		</table>',
		'		</td>',
		'		</tr>',
		'	</table>'
	 ]
	 return html.join(" ");
 }
/**
  *生成html
  */
 function getHTML(data){
 	if(data.f_title&&data.f_title.length>12){
 		data.f_title=data.f_title.substring(0,12)+"...";
 	}
 	if(data.f_doc_content_pic&&data.f_doc_content_pic.length>20){
 		data.f_doc_content_pic=data.f_doc_content_pic.substring(0,20)+"...";
 	}
	  var html = [
	        '<table border="0"cellpadding="0" cellspacing="1" width="150px;" style="font-size:12px;display:inline;background: #000;margin:0px;">',
	         '<tr style="background: #FFF;">',
	           '<td align="center" style="width:50px;">',
	           ' 题名',
	           '</td>',
	           '<td align="center" style="width:100px;height: 40px;">',
	              '<div style="vertical-align:middle;height:40px;width:90px;word-wrap:break-wrod;',
	                'word-break:break-all;overflow: hidden;float: left;display: inline;',
	                'line-height:20px;margin-left:5px;">'+data.f_title,
	              '</div>',
	           '</td>',
	         '</tr>',      
	         '<tr style="background: #FFF;">',
	           '<td align="center" >',
	           '照片号',
	           '</td>',
	           '<td align="center" >'+data.f_no,
	           '</td>',
	         '</tr>',	         
	         '<tr style="background: #FFF;">',
	           '<td align="center" >',
	           ' 参见号',
	           '</td>',
	           '<td align="center" >'+data.f_cj_no+'&nbsp;',
	           '</td>',
	         '</tr>',
	          '<tr style="background: #FFF;">',
	           '<td align="center" >',
	           '时间',
	           '</td>',
	           '<td align="center" >'+data.f_file_formtime+"&nbsp;",
	           '</td>',
	         '</tr>',	         
	         '<tr style="background: #FFF;">',
	           '<td align="center" >',
	           '摄影者',
	           '</td>',
	           '<td align="center" >'+data.f_shooting_user+"&nbsp;",
	           '</td>',
	         '</tr>',	         
	         '<tr style="background: #FFF;">',
	           '<td align="center" >',
	           ' 文字<br/>说明',
	           '</td>',
	           '<td style="height:65px;width:100px;">',
	           '<div style="height:65px;width:90px;word-wrap:break-wrod;',
	                'word-break:break-all;overflow: hidden;float: left;display: inline;',
	                'line-height:20px;margin-left:5px;">',
	                data.f_doc_content_pic,
	              '</div>',
	           '</td>',
	         '</tr>',
	      '</table>'
	 ]
	 return html.join(" ");
 }

//照片说明
 function printDetailBack(data){
     var htmlArray = new Array();
     htmlArray.push('<div id="printPic" style="width:660px;float:left;font-size:12px;">');
     htmlArray.push("<div style='width:100%;height:20px;float:left;margin-bottom:20px;");
     htmlArray.push("border-bottom:1px solid #000;text-align:right;'>第1页</div>");         
     
    var j = 0;
   	for(var i = 0;i<data.length;i++){
   		j++;
   		htmlArray.push(getHTML(data[i]));
   		if(j%16==0){
   			htmlArray.push("<div style='width:100%;height:20px;float:left;");
            htmlArray.push("border-bottom:1px solid #000;text-align:right;'>&nbsp;</div>");         
             
            htmlArray.push("<div style='float:left;height:72px;width:100%;'></div>");
            htmlArray.push("<div style='width:100%;height:20px;float:left;margin-bottom:20px;");
            htmlArray.push("border-bottom:1px solid #000;text-align:right;'>第"+(j/16+1)+"页</div>");
   		}else if (j%4==0){
   			htmlArray.push("<br/>");
   		}else{
   			htmlArray.push("&nbsp;");
   		}
   	}
    htmlArray.push('</div>');
      /*判断浏览器的类型并决定采用哪个对象实例，并检测控件是否安装、是否最新版本、并引导安装或升级。  */
      var LODOP=getLodop(document.getElementById('LODOP'),document.getElementById('LODOP_EM'));      
      createPrintHtml(LODOP,htmlArray.join(" "));        
      LODOP.PREVIEW();
 };
 //照片组说明
 function printDetailBackZPZ(data){
     var htmlArray = new Array();
     htmlArray.push('<div id="printPic" style="width:660px;float:left;font-size:12px;">');
     htmlArray.push("<div style='width:100%;height:20px;float:left;margin-bottom:20px;");
     htmlArray.push("border-bottom:1px solid #000;text-align:right;'>第1页</div>");         
     htmlArray.push(getHTMLForZPZ(data[0]));
     	htmlArray.push('</div>');
      /*判断浏览器的类型并决定采用哪个对象实例，并检测控件是否安装、是否最新版本、并引导安装或升级。  */
      var LODOP=getLodop(document.getElementById('LODOP'),document.getElementById('LODOP_EM'));      
      createPrintHtml(LODOP,htmlArray.join(" "));        
      LODOP.PREVIEW();
 };
 /*创建部分打印内容  */
 function createPrintHtml(LODOP,phtml){
    /*初始化运行环境，清理异常打印遗留的系统资源，设定打印任务名。  */
     LODOP.PRINT_INIT("打印");
     LODOP.SET_PRINT_PAGESIZE(1, 0, 0, "A4") ;
     LODOP.SET_PRINT_STYLE("FontSize", 20);
     LODOP.SET_PRINT_STYLEA(0,"Horient",3);
     LODOP.SET_PRINT_STYLEA(0,"Vorient",3);  
     LODOP.ADD_PRINT_HTM('0%','1.5CM','100%','100%',phtml); 
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
    
    jQuery("#zhaopianList1").hide();
    jQuery("#zhaopianList2").hide();
    
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
			<%if(busi_id==null||busi_id.length()==0){%>
				busi_idObj = document.getElementById("busi_id");
				if(busi_idObj&&busi_idObj.value){
					getParentWindow('<%=windowId%>').search();
					getParentWindow('<%=windowId%>').updateFileDocDetailAfterCloseWin(busi_idObj.value,'<%=windowId%>');
				}
			<%}%>
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
var xinzeng = function(){
	savedThis("xinzeng");
};
</script>
<!-- 引入jGrid -->
<script src="<%=mypath%>../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"  charset="utf-8" type="text/javascript"></script>
<script src="<%=mypath%>../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"  charset="utf-8" type="text/javascript"></script>

<script type="text/javascript" src="<%=mypath%>../resources/js/filedoc.js"></script>
<script src="<%=mypath%>../resources/js/UUID.js" type="text/javascript"></script>

<!-- 打印需要导入的内容、方法 -->
<script language="javascript" src="<%=mypath%>../../resources/plug/Lodop/LodopFuncs.js"></script> 
<object  id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>  
<!-- 是专为 FireFox 浏览器设计的代码  -->
<embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0 pluginspage="<%=path%>/resources/plug/Lodop/Lodopinstall_lodop.exe"></embed>
</object>
</head>
<body>
<iframe id="filedocdetaildoJSPhiddenFrame" name="filedocdetaildoJSPhiddenFrame" width=0 height=0></iframe>

<div style="width:1020px;float:left;">
<div class="content_02_top" > 
	<input value="保存" onclick="savedThis()"  type="button" class="but_y_01" id="savedButton"/>
	<input value="打印照片" onclick="print()"  type="button" class="but_y_03" style="width:105px;"/>
	<input value="打印照片说明" onclick="printDetail()"  type="button" class="but_y_03" style="width:105px;"/>
	<input value="打印照片组说明" onclick="printDetailZPZ()"  type="button" class="but_y_03"  style="width:105px;"/>
	<input value="关闭" onclick="closed()" type="button" class="but_y_01"/>
	<input value="连续新增" onclick="xinzeng()" type="button" class="but_y_01" id="xinzeng"/>
	<script>
	afterSubmitFn=function(type){
		if(type=="deleteFilephotoinfo"){
			searchData();
			return;
		}
		<%if(busi_id!=null&&busi_id.length()>0){%>
			getParentWindow('updateFileDocDetailWindow').search();
			removeAlertWindowByWindowID('updateFileDocDetailWindow');
		<%}else{%>
			busi_idObj = document.getElementById("busi_id");
			alert(busi_idObj.value);
			if(busi_idObj&&busi_idObj.value){
				getParentWindow('<%=windowId%>').search();
				getParentWindow('<%=windowId%>').updateFileDocDetail(busi_idObj.value);
				removeAlertWindowByWindowID('<%=windowId%>');
			}else{
				getParentWindow('<%=windowId%>').search();
				removeAlertWindowByWindowID('<%=windowId%>');
			}
		<%}%>
	};
	</script>
</div>
<div class="vcenter" style="height:460px;width:100%;overflow-y:auto;">
	<form id="form1" name="form1" action="" method="post" target="filedocdetail4photoJSPhiddenFrame">
		<input type="hidden" id="busi_id"      name="busi_id"  value="<%=busi_id%>" />
		<input type="hidden" id="opt_type"     name="opt_type" /> 
		<input type="hidden" id="busiTypeCode" name="busiTypeCode" />
		<input type="hidden" id="windowId" name="windowId" value="<%=windowId%>" />
		<oa:input type="hidden" column="F_FLOW_STATE" table="OA_FILE_DOC"   value="3" />
		<oa:input type="hidden" column="F_DESTROY_STATE" table="OA_FILE_DOC"   value="<%=FileDocBean.F_DESTROY_STATE_ONE%>" />
		<div style="float: left; width: 990px;">
			<div class="content_02_box" style="width: 990px;">
				<%--照片组信息 begin--%>
				<div class="content_02_box_title_bg" style="width: 98%;">
					<span>照片组信息</span>
				</div>
				<div class="content_02_box_div" style="width: 98%;">
					<table border="0" cellspacing="0" cellpadding="0"
						class="content_02_box_div_table" style="width: 100%;">
						<tr><%--row1--%>
							<th class="content_02_box_div_table_th">
								<span class="color_red">*</span>所属分类：
							</th>
							<td class="content_02_box_div_table_td">
								<oa:input
									type="text" column="F_TYPE_NAME" table="OA_FILE_DOC"
									value="<%=F_TYPE_NAME%>"
									other="readonly='readonly' class='input_cx_title_240'" />
								<oa:input
									type="hidden" column="F_TYPE_ID" table="OA_FILE_DOC"
									value="<%=F_TYPE_ID%>" />
							</td>
							<th class="content_02_box_div_table_th">
								<span class="color_red">*</span>档案年份：
							</th>
							<td class="content_02_box_div_table_td">
								<oa:input
                                        type="text" column="F_DOC_YEAR" table="OA_FILE_DOC" 
                                        value="<%=f_doc_year%>"
                                        other="style='width:246px;background:url(/xtbg/ccapp/oa/resources/style/blue/images/date_img_year.jpg) right 1px no-repeat;' readonly='readonly' class='date_120'" />
                                     <script>
                                     jQuery("#OA_FILE_DOC__F_DOC_YEAR").attr("onclick","WdatePicker({dateFmt:'yyyy',maxDate:'<%=wjzhTime%>-01-01'})");
                                     </script>
							</td>
						</tr>
						<tr><%--row2--%>
							<th class="content_02_box_div_table_th">
								<span class="color_red">*</span>组号：<%--照片文件.组号==文书文件.件号--%>
							</th>
							<td class="content_02_box_div_table_td">
								<oa:input
                                       type="text" column="F_DOC_NUM" table="OA_FILE_DOC"
                                       other="class='validate[required,custom[onlyNumberSp],maxSize[8]] input_cx_title_240'" />
							</td>
							<th class="content_02_box_div_table_th">
								<span class="color_red">*</span>题名：
							</th>
							<td class="content_02_box_div_table_td">
								<oa:input
                                       type="text" column="F_DOC_NAME" table="OA_FILE_DOC"
                                       other="class='validate[required,maxSize[60]] input_cx_title_240'" />
							</td>
                           </tr>
                           <tr><%--row3--%>
							<th class="content_02_box_div_table_th">
								<span class="color_red">*</span>所属部门：
							</th><%--所属单位+所属部门--%>
							<td class="content_02_box_div_table_td">
								<oa:input type="text" column="F_DEPT_NAME" table="OA_FILE_DOC"
                                		value="<%=F_ORG_NAME%>" 
                                		other='readonly="readonly"  style = "width:218px;" class="validate[required,maxSize[50]] input_160"' /> 
                            		<oa:input type="hidden" column="F_DEPT_ID" table="OA_FILE_DOC"
                                				value="<%=F_ORG_ID%>" other='' />
                            		<input name="f_dept_name_button" id="f_dept_name_button" type="button"  class="but_x"
                            			onclick='chooseOrg("OA_FILE_DOC__F_DEPT_ID","OA_FILE_DOC__F_DEPT_NAME","radio");'
                            		/>
								<oa:input type="hidden" column="F_ORG_ID" table="OA_FILE_DOC" value="<%=F_UNIT_ID%>"/>
								<oa:input type="hidden" column="F_ORG_NAME" table="OA_FILE_DOC" value="<%=F_UNIT_NAME%>"/>
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
							<th class="content_02_box_div_table_th">规格：</th>
							<td class="content_02_box_div_table_td">
								<oa:input
									type="text" column="F_SPECIFICATION" table="OA_FILE_PAN_EXT"
									other="class='validate[maxSize[100]] input_cx_title_240'" />
							</td>
						</tr>
						<tr><%--row4--%>
							<th class="content_02_box_div_table_th">
								<span class="color_red">*</span>拍摄时间：
							</th>
							<td class="content_02_box_div_table_td">
								<oa:date
									dateFmt="yyyy-MM-dd" column="F_FILE_FORMTIME"
									table="OA_FILE_DOC"
									other="class='validate[required] date_120 Wdate' style='width:245px'" />
							</td>
							<th class="content_02_box_div_table_th">摄影者：</th>
							<td class="content_02_box_div_table_td">
								<oa:input type="text" column="F_SHOOTING_USER" table="OA_FILE_PAN_EXT"
									other="validate[required,maxSize[100]] class='input_cx_title_240'" />
							</td>
						</tr>
						<tr><%--row5--%>
							<th class="content_02_box_div_table_th"><span
								class="color_red">*</span>归档状态：</th>
							<td class="content_02_box_div_table_td"><oa:select
									column="F_DOC_STATE" table="OA_FILE_DOC" dictType="gdzt" hiddenName="F_DOC_STATE_NAME"
									defautValue="F_DOC_STATE" other="style='width:246px'"></oa:select>
							</td>
							<th class="content_02_box_div_table_th">照片号：</th><%--照片文件.照片号==文书文件.参见号--%>
							<td class="content_02_box_div_table_td"><oa:input
									type="text" column="F_INFO_NUM" table="OA_FILE_DOC"
									other="class='validate[maxSize[40]] input_cx_title_240'" />
							</td>
						</tr>
						<tr><%--row6--%>
							<th class="content_02_box_div_table_th">
								<span class="color_red">*</span>照片张数：
							</th>
							<td class="content_02_box_div_table_td" title='系统自动检查照片张数'>
								<oa:input
									type="text" column="F_FILE_QUANTITY" table="OA_FILE_DOC" value='0'
									other="readOnly='readOnly' class='validate[required,custom[onlyNumberSp],maxSize[8]] input_cx_title_240' style='width:246px;'" />
								<oa:input type="hidden" column="F_FILE_NUM" table="OA_FILE_DOC" value="1"/>
							</td>
							<th class="content_02_box_div_table_th">
								<span class="color_red">*</span>密级：
							</th>
							<td class="content_02_box_div_table_td">
								<oa:select
									column="F_SECRECY_ID" table="OA_FILE_DOC" dictType="damj" hiddenName="F_SECRECY_NAME"
									defautValue="F_SECRECY_ID" other="style='width:246px'"></oa:select>
							</td>
						</tr>
						<tr><%--row7--%>
							<th class="content_02_box_div_table_th">
								<span class="color_red">*</span>保管期限：
							</th>
							<td class="content_02_box_div_table_td">
								<oa:select
									column="F_DOC_DEADLINE" table="OA_FILE_DOC" dictType="bgqx"  hiddenName="F_DOC_DEADLINE_NAME"
									defautValue="<%=f_doc_deadline%>" other="style='width:246px'"></oa:select>
							</td>
							<th class="content_02_box_div_table_th">
								<span class="color_red">*</span>信息类型：<%--*文件.信息类型==原*文件.实物类型--%>
							</th>
							<td class="content_02_box_div_table_td">
								<oa:select
									column="F_ENTITY_TYPE" table="OA_FILE_DOC" dictType="swlx"  hiddenName="F_ENTITY_TYPE_NAME"
									defautValue="F_ENTITY_TYPE" other="style='width:246px'"></oa:select>
								<script>
								jQuery("#OA_FILE_DOC__F_ENTITY_TYPE").find("OPTION[value!='2']").remove();<%--照片文件.信息类型==照片--%>
								</script>
							</td>
						</tr>
						<tr><%--row8--%>
							<th class="content_02_box_div_table_th"><span
								class="color_red">*</span>文件登记人：</th>
							<td class="content_02_box_div_table_td"><oa:input
									type="text" column="F_USER_NAME" table="OA_FILE_DOC"
									value="<%=F_USER_NAME%>"
									other="class='input_cx_title_240' readonly='readonly'" /> <oa:input
									type="hidden" column="F_USER_ID" table="OA_FILE_DOC"
									value="<%=F_USER_ID%>"
									other="class='input_cx_title_240' readonly='readonly'" />
							</td>
							<th class="content_02_box_div_table_th"><span
								class="color_red">*</span>文件登记日期：</th>
							<td class="content_02_box_div_table_td"><oa:date
									dateFmt="yyyy-MM-dd" column="F_CREATOR_TIME"
									table="OA_FILE_DOC" defaultValue="sysDate"
										other="class='validate[required] input_cx_title_240' style='width:245px' readonly='readonly'" />
									<script>
                                    	jQuery("#dis_OA_FILE_DOC__F_CREATOR_TIME").removeAttr("onclick");
                                    </script>
							</td>
						</tr>
						<tr><%--row9--%>
							<th class="content_02_box_div_table_th"><span
								class="color_red">*</span>地点：</th>
							<td class="content_02_box_div_table_td" colspan=3><oa:input
									type="text" column="F_ADD" table="OA_FILE_PAN_EXT"
									other="class='validate[required,maxSize[50]] input_cx_title_240' style='width:733px;'" />
							</td>
						</tr>
						<tr><%--row10--%>
							<th class="content_02_box_div_table_th" style="height: 70px">内容：</th>
							<td class="content_02_box_div_table_td" colspan=3>
								<oa:textarea
									column="F_DOC_CONTENT" table="OA_FILE_DOC"
									other="style='width:733px;'" />
								<div id="defaultFileMB" style="display: none"><%=defaultFileMB%></div>
							</td>
						</tr>
					</table>
					<%--OA_FILE_DOC要求不为空,而照片文件不存在,--%>
					<oa:input type="hidden" column="F_DOC_MEDIA" table="OA_FILE_DOC" value="1"/><%--照片文件页面无介质类型:填写1:电子--%>
					<oa:input type="hidden" column="F_DOC_MEDIA_NAME" table="OA_FILE_DOC" value="1"/>
					<oa:input type="hidden" column="F_FILE_NUM_UNIT" table="OA_FILE_DOC" value="1"/>
					<oa:input type="hidden" column="F_FILE_NUM_UNIT_NAME" table="OA_FILE_DOC" value="1"/>
					<oa:input type="hidden" column="F_PERSON" table="OA_FILE_PAN_EXT" value="1"/>
					<oa:input type="hidden" column="F_BACKGROUND" table="OA_FILE_PAN_EXT" value="1"/>
				</div>
				<%--照片组信息 end--%>
				<br/>
				<%
					if (busi_id != null && busi_id.length() > 0) {
				%>
				<%--照片信息 begin--%>
				<div class="content_02_box_title_bg" style="width: 98%;" id="zhaopianList1">
					<span>照片信息</span>
				</div>
				<div class="content_02_box_div" style="width:100%;" id="zhaopianList2">
				<div style="float:left;width:100%;margin-left: -10px;" class="cGridArea">
					<table id="gridTable" width="100%"></table>
					<div id="gridPager"></div>
				</div>
				<script>
				copyData = {};
				clickAElement = function(aObj){
					aName = aObj.name;
					if("insert"==aName){
						var url = "<%=path%>/ccapp/oa/file/jsp/filephotoinfo.jsp?f_file_id=<%=busi_id%>&actionName=insert&windowId=filephotoinfoJSP&busi_id=&busiTypeCode=wj-002";
							openAlertWindows('filephotoinfoJSP',url,'增加照片信息',1020,530,'10%','10%');
					}else if("delete"==aName){
						var selectedIds = jQuery("#gridTable").jqGrid("getGridParam", "selarrrow");
						if(selectedIds.length>0){
							deleteList = '';
							for ( var i = 0; i < selectedIds.length; i++){
								model = jQuery("#gridTable").jqGrid('getRowData',
										selectedIds[i]);
								deleteList+=model.f_id+",";
							}
							jQuery("#hidden_delete").val(deleteList);
							jQuery("#secordFrom").submit();
						}else{
							alert("请选择数据");
						}
					}else if("copy"==aName){
						var selectedIds = jQuery("#gridTable").jqGrid("getGridParam", "selarrrow");
						if(selectedIds.length==1){
							var model = jQuery("#gridTable").jqGrid('getRowData',selectedIds[0]);
							copyData  = model;
							var url = "<%=path%>/ccapp/oa/file/jsp/filephotoinfo.jsp?f_file_id=<%=busi_id%>&actionName=insert&windowId=filephotoinfoJSP&busi_id=&busiTypeCode=wj-002&copy=true";
							openAlertWindows('filephotoinfoJSP',url,'增加照片信息',1020,530,'10%','10%');
						}else{
							alert("请选择数据");
						}
					}
				};
				function toParamJosn(){
					var str = "{'f_file_id':'<%=busi_id%>'}";	
					return escape(str);
				}
				searchData = function(){
					data = {paramJson: toParamJosn()};
					postData = jQuery("#gridTable").jqGrid("getGridParam", "postData");
					jQuery.extend(postData, data);
					jQuery("#gridTable").jqGrid("setGridParam", {
						search : true
					}).trigger("reloadGrid", [{
						page : 1
					}]);
				};
				initTable=function(){
				jQuery("#gridTable").jqGrid({
					gridComplete: function(){
			    		var num = jQuery("#gridTable")[0].p.records;
			    		var jianhao = jQuery("#OA_FILE_DOC__F_FILE_QUANTITY");
			    		jianhao.attr("readOnly","readOnly");
			    		jianhao.val(num);
			    	},
					url: '<%=path%>/pubListServlet?classNameId=com.chinacreator.xtbg.core.file.list.FilePhotoList',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
					//jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
					datatype: "json",
					//这个参数用于设定将要得到的数据类型。我最常用的是“json”，其余的类型还包括：xml、xmlstring、local、javascript、function
					mtype: "POST",
					//定义使用哪种方法发起请求，GET或者POST
					height: "100%",//270
					//Grid的高度，可以接受数字、%值、auto，默认值为150
					//width ：'800', //Grid的宽度，如果未设置，则宽度应为所有列宽的之和；如果设置了宽度，则每列的宽度将会根据shrinkToFit选项的设置，进行设置。
					//shrinkToFit ：true 此选项用于根据width计算每列宽度的算法。默认值为true。如果shrinkToFit为true且设置了width值，则每列宽度会根据width成比例缩放；如果shrinkToFit为false且设置了width值，则每列的宽度不会成比例缩放，而是保持原有设置，而Grid将会有水平滚动条
					autowidth: true,
					//默认值为false。如果设为true，则Grid的宽度会根据父容器的宽度自动重算。重算仅发生在Grid初始化的阶段；如果当父容器尺寸变化了，同时也需要变化Grid的尺寸的话，则需要在自己的代码中调用setGridWidth方法来完成。
					colNames: ['照片号','题名','文字说明','参见号','f_id','f_dang_no'],
					//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
					colModel: [ //最重要的数组之一，用于设定各列的参数
				        {
				        	name: 'f_no',index: 'f_no',width:'200'
						},
						{
							name: 'f_title',index: 'f_title',width:'300'
						},
						{
							name: 'f_explain',index: 'f_explain',width:'300'
						},
						{
							name: 'f_cj_no',index: 'f_cj_no'
						},
						{
							name: 'f_id',index: 'f_id',hidden:true
						},
						{
							name: 'f_dang_no',index: 'f_dang_no',hidden:true
						}
					],
					sortname : 'f_no',
			        //指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
			        sortorder : 'asc',
					viewrecords: true,
					
					//设置是否在Pager Bar显示所有记录的总数。
					rowNum: 10,
					//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
					rowList: [10, 20, 30],
					//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
					jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
						repeatitems: false
					},
					//pager: "#gridPager",
					pagerintoolbar:true,//上面的分页条
					pagerinBottombar:true,//下面的分页条
					//定义页码控制条Page Bar
					//caption: "草稿箱",
					//设置Grid表格的标题，如果未设置，则标题区域不显示。
					search : toParamJosn(),
					prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
						rows: "rows",
						//表示请求行数的参数名称  
						sort: "sidx",
						//表示用于排序的列名的参数名称  
						order: "sord",
						//表示采用的排序方式的参数名称 
						search : "search"
					},
					multiselect: <%=!isview%>,
					
					toolbar: [true,"top"
					<%if(!isview){%>
					,"<input name='insert' type='button' onclick='clickAElement(this);' value='新增' class='but_y_01' onMouseOver=\"javascript:jQuery(this).attr('class','but_y_02');\" onMouseOut=\"javascript:jQuery(this).attr('class','but_y_01');\"/>"
					+"<input name='delete' type='button' onclick='clickAElement(this);' value='删除' class='but_y_01' onMouseOver=\"javascript:jQuery(this).attr('class','but_y_02');\" onMouseOut=\"javascript:jQuery(this).attr('class','but_y_01');\"/>"
					+"<input name='copy' type='button' onclick='filedoclist.copyDocPhotoMess()' value='复制' class='but_y_01' onMouseOver=\"javascript:jQuery(this).attr('class','but_y_02');\" onMouseOut=\"javascript:jQuery(this).attr('class','but_y_01');\"/>"
					<%}%>
					],
					onCellSelect:function(rowid,iCol){
						model = jQuery("#gridTable").jqGrid('getRowData',rowid);
						if(iCol>0){
							updateDocPhotoMess(model.f_id);
						}
					}
				}).navGrid('#gridPager', {
					edit: false,
					add: false,
					del: false,
					search:false,
					refresh:false
				});
				};
				
				updateDocPhotoMess = function (f_id){
					var url = "<%=path%>/ccapp/oa/file/jsp/filephotoinfo.jsp?busi_id="+f_id+"&f_file_id=<%=busi_id%>&actionName=insert&windowId=windowId&busi_id=&busiTypeCode=wj-002";
					<%if(isview){%>
						url = url+"&isview=<%=isview%>";
					<%}%>
					openAlertWindows('windowId',url,'修改照片信息',1020,530,'10%','10%');
				};
				</script>
				</div>
				<%--照片信息 end--%>
				<%
					}
				%>
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
                                           value="<%=StringUtil.deNull(bean.getF_files_no())%>" other='style = "width:90%;" class="validate[required,maxSize[200]] input_160" ' /> 
                                       <input type="hidden" id="f_files_id" name="f_files_id" 
                                       value="<%=StringUtil.deNull(f_files_id)%>"/>
                                </td>
                            </tr>
                            <!-- 由档案管理传值 begin --------------------------------------------------------------------->
                            <tr>
                                <th class="content_02_box_div_table_th"><span
                                    class="color_red">*</span>存放位置：</th>
                                <td class="content_02_box_div_table_td" colspan=3>
                                     <%=StringUtil.deNull(bean.getF_storage_fullname())%>
                                </td>
                            </tr>
                            <tr>
                                <th class="content_02_box_div_table_th"><span
                                    class="color_red">*</span>案卷号：</th>
                                <td class="content_02_box_div_table_td">
                                     <%=StringUtil.deNull(bean.getF_filesno())%>
                                </td>
                                <th class="content_02_box_div_table_th"><span
                                    class="color_red">*</span>归档人：</th>
                                <td class="content_02_box_div_table_td">
                                <%=StringUtil.deNull(bean.getF_file_username())%>
                                </td>
                            </tr>
                            <!-- 由档案管理传值 end------------------------------------------------------------------------ -->
                            <tr>
                                <th width="20%" class="content_02_box_div_table_th">
                                                                                                   档案分类号：</th>
                                <td width="30%" class="content_02_box_div_table_td">
                                <%=StringUtil.deNull(bean.getF_typeno())%>
                                </td>
                                <th width="20%" class="content_02_box_div_table_th">
                                                                                                    归档日期：</th>
                                <td width="30%" class="content_02_box_div_table_td">
                                <%=StringUtil.deNull(bean.getF_file_time())%>
                                </td>
                                
                            </tr>
                            <tr>
                                <th class="content_02_box_div_table_th"><span
                                    class="color_red">*</span>全宗号：</th>
                                <td class="content_02_box_div_table_td">
                                <%=StringUtil.deNull(bean.getF_fondsno())%>
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

<form id="secordFrom" name="secordFrom" method="post" action="<%=path%>/ccapp/oa/file/jsp/filedocdetaildo.jsp" target="filedocdetail4photoJSPhiddenFrame">
<input type='hidden' name='opt_type' id="hidden_otp_type" value="deleteFilephotoinfo"/>
<input type='hidden' name='delete' id="hidden_delete"/>
<input type='hidden' name='businessType' id="hidden_businessType" value="wj-002"/>

</form>

<iframe id="filedocdetail4photoJSPhiddenFrame" name="filedocdetail4photoJSPhiddenFrame" width=0 height=0></iframe>

</div>


</body>
</oa:filedocinit>
</html>
<script>
jQuery(function(){
	<%--为了支持附件标签,不能顶部--%>
	controlReadOnly();
});
</script>
<%--f_type_id获取不到 照片可以在线看 不需要hasRole checktype=2--%>
<jsp:include page="filecheckquerycount.jsp">
	<jsp:param name="checktype" value="2"/>
	<jsp:param name="f_doc_id" value="<%=busi_id%>"/>
	<jsp:param name="f_type_id" value="<%=F_TYPE_ID%>"/>
	<jsp:param name="isview" value="<%=isviewStr%>"/>
</jsp:include>