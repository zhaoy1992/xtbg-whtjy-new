<%--
描述：展示回复意见Ceb信息
作者：邱炼
版本：1.0
日期：2014-05-01
--%>
<%@page import="com.chinacreator.xtbg.core.process.flowprocessing.dao.impl.FlowInstanceDataSaveDaoImpl"%>
<%@page import="com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowInstanceDataSaveDao"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.fancyuoload.entity.FileInfoBean"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.core.common.util.FileUtil"%>
<%@page import="com.chinacreator.xtbg.core.upload.util.UploadConstants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.OASystemCache" %>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	Map<String,String> bean = new HashMap<String,String>();
	
	String user_id = accesscontroler.getUserID();
	//业务ID
	String busi_id = request.getParameter("busi_id");
	//业务类型code 
	String busitype_code = request.getParameter("busiTypeCode");
	//传阅性ID
	String circularize_id = request.getParameter("circularize_id");
	
	//修改传阅 的查看状态
	FlowInstanceDataSaveDao flowinstancedatasavedao = new FlowInstanceDataSaveDaoImpl();
	flowinstancedatasavedao.updateFlowActInsState(circularize_id,user_id,"1");
	//System.out.println("==============="+busitype_code);
	String sql = "select substr(t.insname_rule,2,INSTR(t.insname_rule,'__',1,1)-2) as tablesName from oa_flow_baseinfo t where t.busitype_code='"+busitype_code+"'";
	String tablesNames = DaoUtil.SqlToField(sql);
	//System.out.println("==============="+tablesNames);
	String sql2 = "select t_zw_id from "+tablesNames+" where t_id ='"+busi_id+"'";
	//正文ID
	String zw_id = DaoUtil.SqlToField(sql2);
	//System.out.println(zw_id);
	
	//附件ID
	String sql3 ="select t_fj_id from "+tablesNames+" where t_id ='"+busi_id+"'";
	String t_fj_id = DaoUtil.SqlToField(sql3);
	//System.out.println(t_fj_id);
	
	String basePath = request.getScheme() + "://" + request.getServerName()+ ":" + request.getServerPort() + request.getContextPath();
	
	String serverName = (String) request.getServerName();
	String serverPort = String.valueOf(request.getServerPort());
	String contextPath = (String) request.getContextPath();
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
	<title></title>
	<script type="text/javascript" src="../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript">jQuery.noConflict();</script>
	<!-- 引入jQuery UI -->
	<script src="../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
	<!-- 引入其它 -->
	<script src="../resources/util/public.js" type="text/javascript"></script>
	<!-- 引入提示 -->
	<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
	<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
	<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
	
	<script type="text/javascript" src="../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
	<script type="text/javascript" src="../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
	
	<script src="../resources/plug/jquery-media/jquery.media.js" type="text/javascript" charset="utf-8"></script>
	
	<link rel="stylesheet" href="../resources/plug/fancyupload/fancyupload.css" type="text/css" />
	<script type="text/javascript" src="../resources/plug/fancyupload/mootools-1.2.5-core-jm.js" charset="utf-8"></script>
	<script type="text/javascript" src="../resources/plug/fancyupload/source/Fx.ProgressBar.js" charset="utf-8"></script>
	<script type="text/javascript" src="../resources/plug/fancyupload/source/Swiff.Uploader.js" charset="utf-8"></script>
	<script type="text/javascript" src="../resources/plug/fancyupload/source/FancyUpload3.Attach.js" charset="utf-8"></script>
	<script type="text/javascript" src="../resources/plug/fancyupload/myfancyupload.js" charset="utf-8"></script> 
	
	<script type="text/javascript">
	
	//路径
	var path = "<%=path%>";
	
	jQuery(function(){
		//初始化插件 
    	new controlWordOrPdf({
    	 	 //展示插件的节点
    	     dom : "#showIframe",
    	     //鼠标滚动的相对对象，默认为window,如果是相对于整个document滚动的，可以不传 
    	     scrollDom : "#vcenter",  
    	     //鼠标滚动到的高度
    	     scrollHeight : 252,
    	     //滚动缓冲的高度
    	     bufferHeight : 20,
    	     //插件节点的高度
    	     height : jQuery(window).height(),
    	     initButtonSelf:initButton,
    	     //插件节点的宽度
    	     width : "100%",        
    	     //word是否可编辑
    	     editAble : false,
    	     //展示的文件类型
    	     type : "word",
    	     //展示的文件，word为文件id，pdf为文件名
    	     file : '<%=zw_id%>' 
    	});
    	
		
	});
	
	//初始化iwebOffice2009
	function initButton(weboffice){
		weboffice.VisibleTools("保存文件",false);
		weboffice.VisibleTools("新建文件",false);
		weboffice.VisibleTools("打开文件",false);
	}
	
	 jQuery(function(){
		MyFancyupload.createUpload('_fileshow', '#_filebut', '<%=path%>', '<%=path%>/servlet/FileUpload?buessid=<%=t_fj_id%>', false, "<%=t_fj_id%>",'','','011');
		
	});
	
	//关闭刷新父页面
	function closeReload(){
		removeWindows(menuId, false, "",false, false, false);
	}
	
	</script>
	
<style>
</style>
</head>
<body style="overflow: scroll;">
<form id="onlyFrom" name="onlyFrom" method="post" action="" target="filedocReportSigninfoodoJSPhiddenFrame">
<input type='hidden' name='action' id="hidden_action"/>
<div class="content_02_box" style="width: 85%; text-align: center;" >
			<div class="content_02_box_title_bg"  style="width:99%"><span>附件</span></div>
			<div class="content_02_box_div"  style="width:99%">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" id="content_02_box_div_table_02"  style="width:100%">
				<tr id="fj" style="display: none;">
					<th class="content_02_box_div_table_th" style="padding-top:10px">附件：</th>
                     <td class="content_02_box_div_table_td" ><a href="#" id="_filebut">请选择</a>
								</td>
				</tr>
				<tr>
                        <th class="content_02_box_div_table_th" >附件列表：</th>
                        <td class="content_02_box_div_table_td" ><ul id="_fileshow"></ul>
							&nbsp;</td>
               </tr>
			</table> 
			</div>
			</br>
			<div class="content_02_box_div"  style="width:100%">
					<iframe id="showIframe" style='width: 100%;' src=''></iframe> 
			</div>
</div>
</form>
<iframe name="filedocReportSigninfoodoJSPhiddenFrame" width=0 height=0></iframe>
</body>
</html>
