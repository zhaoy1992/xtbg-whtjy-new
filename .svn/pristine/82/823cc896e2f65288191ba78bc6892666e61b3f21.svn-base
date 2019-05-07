<%--
描述：档案管理-公文待归档-非tif格式文件转tif文件后，合并tif文件，并上传
作者：邹拓
版本：1.0
日期：2013-7-16
UTF-8
参数列表
f_devolve_id:档案分类id
actionName:insert OR update OR query
--%>
<%@page import="com.chinacreator.xtbg.core.common.util.DataControlUtil"%>
<%@page import="com.chinacreator.eform.util.Escape"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.file.service.FileFilesDevolveService"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileFilesDevolveServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="com.chinacreator.xtbg.core.file.util.FileConstant"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileFilesServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.file.service.FileFilesService"%>
<%@page import="com.chinacreator.xtbg.core.file.entity.FileFilesDevolveBean"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	String windowId = "updateFileFilesDevolveBean";
	if (request.getParameter("windowId") != null) {
		windowId = request.getParameter("windowId");
	}
	String busi_id = request.getParameter("busi_id");
	String attachId = request.getParameter("attachId");
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
	<!-- 引入jGrid -->
	<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"  charset="utf-8" type="text/javascript"></script>
	<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"  charset="utf-8" type="text/javascript"></script>
	
	<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
	
	<link rel='stylesheet' href='../../resources/plug/fancyupload/fancyupload.css' type='text/css' />
	<script type='text/javascript' src='../../resources/plug/fancyupload/mootools-1.2.5-core-jm.js'></script>
	<script type='text/javascript' src='../../resources/plug/fancyupload/source/Fx.ProgressBar.js'></script>
	<script type='text/javascript' src='../../resources/plug/fancyupload/source/Swiff.Uploader.js'></script>
	<script type='text/javascript' src='../../resources/plug/fancyupload/source/FancyUpload3.Attach.js'></script>
	<script type='text/javascript' src='../../resources/plug/fancyupload/myfancyupload.js'></script>
	<script src="../resources/js/UUID.js" type="text/javascript"></script>
	<script type="text/javascript">
	
	TIFUtil = {
			WshShell:new ActiveXObject("WScript.Shell"),
			fileA:'',
			centerLogFlag:':CENTER',
			writeLog:function(mess){
				if(mess==this.centerLogFlag){
					jQuery("#showLogControl").val("");
				}else{
					var oldLog = jQuery("#showLogControl").val();
					var newLog = oldLog + "\r\n" + mess;
					jQuery("#showLogControl").val(newLog);
				}
			},
			changeTIFForZip:function(obj){
				var fileName = obj.value;
				var fileBean = this.getFileBean(fileName);
		    	if(fileBean){
		    		var newFileName = this.ZipConV(fileBean);
		    		if(newFileName){
		    			TIFUtil.uploadTIFFile(newFileName,fileBean);
		    		}else{
		    			this.writeLog("操作结束");
		    		}
		    	}
			},
			ZipConV:function(fileBean){
				try{
					var newFileName = fileBean["path"]+new UUID().toString()+".zip";
					TIFUtil.fileA = newFileName;
					TIFUtil.fileB = fileBean["fullName"];
				  	var s=ConVToTif.ZipConV(
				  			fileBean["fullName"],
				  			newFileName,2);
				  	if(s=='1'){
				  		this.writeLog(fileBean["fileFirstName"]+'.'+fileBean["extendName"]+"转换成功");
				  		return newFileName;
				  	}else{
				  		this.writeLog(fileBean["fileFirstName"]+'.'+fileBean["extendName"]+"转换失败");
				  		return null;
				  	}
				}catch(e){
					this.writeLog(fileBean["fileFirstName"]+'.'+fileBean["extendName"]+"转换异常");
					return null;
				}
			},
			uploadTIFFile:function(newFileName,fileBean){
				var fso = new ActiveXObject("Scripting.FileSystemObject"); 
				fso.CopyFile(newFileName,fileBean["fullName"]);
				this.writeLog(newFileName+"改名字为 "+fileBean["fullName"]);
			    setTimeout("jQuery('#uploadForm').attr('target','filedocdetaildoJSPhiddenFrame');jQuery('#uploadForm').submit();TIFUtil.writeLog('正在上传');",2000);
				
			},
			getFileBean:function(name){
				var fileBean = null;
				if(name.Path){
					name = name.Path;
				}
				var loc = name.lastIndexOf('\\');
				var locA = name.lastIndexOf('.');
				if(loc>0&&locA>loc){
					fileBean = {
						fullName:name,
						path:name.substring(0,loc+1),
						fileFirstName:name.substring(loc+1,locA),
						extendName:name.substring(locA+1,name.length)
					};
				}
				return fileBean;
			},
			test:function(){
				var a = ConVToTif.ZipConV(
			  			"c:\\gongwen.zip",
			  			"C:\\FileConvertA\\gongwen.zip",2);
				alert(a);
			}
	};
	
	var afterSubmitFn = function(a){
		if(a==1){
			TIFUtil.writeLog('正在刷新父页面的附件列表');	
			getParentWindow('<%=windowId%>').fetchAttach();
		}else{
			TIFUtil.writeLog('操作失败');
		}
		var fso = new ActiveXObject("Scripting.FileSystemObject"); 
		if(fso.FileExists(TIFUtil.fileA)){
           try{      
                fso.DeleteFile(TIFUtil.fileA);
                TIFUtil.writeLog('删除临时文件:'+TIFUtil.fileA);
           }catch(e){
           }
		}
		if(fso.FileExists(TIFUtil.fileB)){      
           try{      
                fso.DeleteFile(TIFUtil.fileB);
                TIFUtil.writeLog('删除临时文件:'+TIFUtil.fileB);
           }catch(e){
           }
		}
		setTimeout("TIFUtil.writeLog('该窗口将自动关闭');",2000);
		setTimeout("removeAlertWindows('<%=windowId%>',true);",3000);
	}
	</script>
</head>
<body style="overflow-x: auto;overflow-y: auto;margin-top:-4px;">
	<iframe id="filedocdetaildoJSPhiddenFrame"
		name="filedocdetaildoJSPhiddenFrame" width=0 height=0></iframe>
	<form
		action="<%=path%>/servlet/pubFileUpload?buessid=<%=attachId%>&_Custom_Upload=com.chinacreator.xtbg.core.file.action.CustomUploadFromFile|upload"
		id='uploadForm' method="post" enctype="multipart/form-data"><input
		type="file" name="zipFile" id='zipFile' size="80"
		onchange="TIFUtil.changeTIFForZip(this)" /></form>
	<br/>
	<textarea id='showLogControl' readonly="readonly"
		style="font-size: 11px;" rows="10" cols="80"
		onpropertychange="javascript: jQuery(this).scrollTop(this.scrollHeight);">
	</textarea>
	
	<OBJECT CLASSID="CLSID:59F92B43-B250-4D00-B310-7B22D7F139B4" height=0
		width=0 id="ConVToTif"> <span style="color: red;">COM组件加载失败</span>
	</OBJECT>
</body>
</html>