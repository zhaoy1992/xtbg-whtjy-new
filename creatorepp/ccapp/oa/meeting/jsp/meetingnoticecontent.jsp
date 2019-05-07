<%-- 
描述：会议通知申请 正文 页面
作者：黄海
版本：1.0
日期：2013-06-22
 --%>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page contentType="text/html; charset=utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	//String n_attach_id = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
	//特检院  OA 附件 ID修改
	String n_attach_id = StringUtil.getUUID();
%>
<title>通知公告基本信息页面</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入formvValidatetion -->
<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<!-- 引入上传控件 -->
<script type="text/javascript" src="../../resources/plug/fancyupload/mootools-1.2.5-core-jm.js"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/Fx.ProgressBar.js"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/Swiff.Uploader.js"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/FancyUpload3.Attach.js"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/myfancyupload.js"></script>
<script>
var n_attach_id = '<%=n_attach_id %>';
var path = '<%=path %>';
var cont = decoding4jQuery(window.parent.getContents());//new edit 2013-08-15
if(!isSpace(window.parent.getM_djbh())){
	n_attach_id = window.parent.getM_djbh();
}
jQuery(function() {
	var _documentBodyHeight = window.top.findPageCacheName("_documentBodyHeight");
	jQuery("#maindiv").height(_documentBodyHeight-100);
	jQuery('#n_attach_id').val(n_attach_id);
	if(!isSpace(cont)){
		jQuery('#m_contents').val(cont);
		if(getInternetExplorerVersion()==8 || getInternetExplorerVersion()==7){
			eWebEditor1.setHTML(cont);
		}
	}
	var attachFlag=true;
	if(!window.parent.canOperate()){
		attachFlag = false;
	}
	isFileEnble(n_attach_id,attachFlag);
});
/*
 * 设为可以编辑
 */
function doIsFileEnble(){
	jQuery("#_filebut").show();
	jQuery("#_fileshow").html('');
	isFileEnble(n_attach_id,true);
}
/**
 *附件是否可以编辑
 *@m_attach_id :附件id
 *@attachFlag : 是否可以操作的参数  true(可操作)  false（不可操作）
 */
function isFileEnble(m_attach_id,attachFlag){
	var m_check_flag = window.parent.frame1.window.jQuery("#createuser").val();
	if(attachFlag || (window.parent.$("#issaved").val()!="doquery" & m_check_flag!='4' && m_check_flag!='5' && window.parent.frame1.window.jQuery("#createuser").val()=='<%=accesscontroler.getUserID()%>')){
        //附件
        MyFancyupload.createUpload('_fileshow', '_filebut', path, path+'/servlet/pubFileUpload?buessid='+m_attach_id, attachFlag, m_attach_id,'','','111');
    }else{
        MyFancyupload.createUpload('_fileshow', '_filebut', path, path+'/servlet/pubFileUpload?buessid='+m_attach_id, attachFlag, m_attach_id,'','','001');
    }
    if(!attachFlag){
        //设置上传按钮大小，间接实现隐藏
       jQuery("#_filebut").attr("disabled","disabled").hide().prop("disabled", false);
    }
}

/*
	函数:  getJson
	说明:  得到对应实体类的json格式字符串
*/
function getJson(){
	var str = eWebEditor1.getHTML();
	jQuery('#m_contents').val(str)
	//return "'m_contents':'"+jQuery('#m_contents').val()+"','m_djbh':'"+jQuery('#n_attach_id').val()+"'";
	meetingnoticecontentjson.m_contents=jQuery('#m_contents').val();//new add  2013-08-15
	meetingnoticecontentjson.m_djbh=jQuery('#n_attach_id').val()
	return meetingnoticecontentjson;
}
//new add  2013-08-15
//json 对象定义
var meetingnoticecontentjson={
		"m_contents": "",
		"m_djbh":""
};
/*
 * 得到正文
 */
function getM_contents(){
	var str = eWebEditor1.getHTML();
	jQuery('#m_contents').val(str)
	return jQuery('#m_contents').val();
}
/*
 * 得到浏览器版本
 */
function getInternetExplorerVersion()  
{  
	var rv = -1; 
	if (navigator.appName == 'Microsoft Internet Explorer')  
	{  
		var ua = navigator.userAgent;  
		var re  = new RegExp("MSIE ([0-9]{1,}[/.0-9]{0,})");  
		if (re.exec(ua) != null)  
		rv = parseFloat( RegExp.$1 );  
	}  
	return rv;  
}  

</script>
</head>
<body>
<div id="maindiv" class="vcenter" style="height:500px; overflow:auto;">
	<div style="float: left; width: 775px;">
		<div class="content_02_box">
			<div class="content_02_box_title_bg">
				<span>会议附件</span>
			</div>
			<div class="content_02_box_div">
				<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table">
					<tr>
						<th width="200px" class="content_02_box_div_table_th">
							附件：
						</th>
						<td class="content_02_box_div_table_td" colspan="5">
							<input class="but_y_03"  type="button" id="_filebut" value="请选择文件"/>
						</td>
					</tr>
					<tr>
						<th width="200px" class="content_02_box_div_table_th">
						</th>
						<td class="content_02_box_div_table_td" colspan="5">
						<ul id="_fileshow"></ul>
						&nbsp;
						</td>
						
					</tr>
				</table>
			</div>
			<div class="content_02_box_title_bg"><span>会议正文</span> 
				<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
				<span class="color_red">提示：可以直接粘贴word、excel表格</span>
				<div class="content_02_box_add" id="t2"><span id="selAreaImg" class="tabs_search_text_but"></span></div>
			</div>
		
			<div class="content_02_box_div">
				<table border="0" cellspacing="0" cellpadding="0"
					class="content_02_box_div_table">
					<tr>
						<td colspan="4">
						<textarea style="display: none" name="m_contents" id="m_contents"></textarea> 
						<iframe id="eWebEditor1" src="../../resources/plug/eWebEditor_V4.60/ewebeditor.htm?id=m_contents&style=gray" frameborder="0" scrolling="no" width="100%" height="400"></iframe>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<p>
		&nbsp;
		&nbsp;
		&nbsp;
		&nbsp;
		&nbsp;
		</p>
		<table><tr><td height="50"></td></tr></table>
		<p>
		&nbsp;
		&nbsp;
		&nbsp;
		&nbsp;
		&nbsp;
		</p>
		<input type="hidden" id="n_attach_id" value="" />
	</div>
</div>
</body>
</html>