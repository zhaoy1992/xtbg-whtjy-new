<%--
describe:消息盒子主界面
author:dailianchun
date: 2013-9-11
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String userId = accesscontroler.getUserID();
//父窗口id
String windowId = StringUtil.deNull(request.getParameter("windowId"));
//档案id
String id = StringUtil.deNull(request.getParameter("id"));
String f_type_id = StringUtil.deNull(request.getParameter("f_type_id"));
String f_type_name = StringUtil.deNull(request.getParameter("f_type_name"));
String f_typeno = StringUtil.deNull(request.getParameter("f_typeno"));
String f_files_state = StringUtil.deNull(request.getParameter("f_files_state"));//案卷状态(0：待归档    1、已归档（正常状态）   8、已移交（移交到档案局）   9. 已销毁)
String busiTypeCode =StringUtil.deNull(request.getParameter("busiTypeCode"));//业务名


String action= StringUtil.nullOrBlank(id)?"add":"update";
String busi_id = StringUtil.nullOrBlank(id)?StringUtil.getUUID():id;//传入业务id，则取传入的id，没有传入则新建id
//服务对象
FileFilesService service = new FileFilesServiceImpl();  
Map<String,String> programMap = service.queryProgramByTypeId(f_type_id);
String detailPage = "";//添加档案的明细界面
if(null != programMap && programMap.size()>0){
	detailPage = StringUtil.deNull(programMap.get("f_files_detail"));//获得添加档案的明细界面
}

//判断用户是否档案管理员
boolean isFileManager = KbmUtil.isRolesUser(userId,"单位档案管理员");
%>    

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="com.chinacreator.xtbg.core.file.service.FileFilesService"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileFilesServiceImpl"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.kbm.util.KbmUtil"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript"
    src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入jQuery UI -->
<script
    src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"
    type="text/javascript"></script>

<!-- 引入jGrid -->
<link rel="stylesheet" type="text/css" media="screen"
    href="../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
<script
    src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"
    type="text/javascript"></script>
<script
    src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"
    type="text/javascript"></script>

<!-- 引入其它 -->
<script type="text/javascript"
    src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"
    charset="utf-8"></script>
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript"
    src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<!-- 日期控件 -->
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 公共部分引用结束 -->       
<script type="text/javascript" charset="utf-8">  
	$(function() {		
	    $("#tabs").tabs({
	    	border:true,  
	        select : function(event, ui) { 
	       
	            if("垃圾箱" == jQuery(ui.tab).text()){
		            //如果页面未加载，则加载页面
                   if(!jQuery("#frame2").attr("src")){
                      jQuery("#frame2").attr("src","");
                   }
	            }                
	        }
	    });	 	       	    
	    jQuery("#_top_tabs").show();
	    jQuery("#frame1").attr("src","messagelist.jsp");
	    adaptationWH('','frame1',20);
	    adaptationWH('','frame2',1); 
        
	});



</script>
<title></title>
</head>
<body >
   <div class="content_02" style="overflow: hidden;" id="_top">
       <table style="WIDTH: 100%;">
        <tr>
            <td>
                <div>
                    <div id="tabs">
                        <div id="_top_tabs" style="display:none;">
                            <ul>
                                <li id="tabTitle1_div"><a id="tabTitle1" href="#tabs-1">消息列表</a></li>
                                <li id="tabTitle2_div"><a id="tabTitle2" href="#tabs-2">垃圾箱</a></li>
                            </ul>
                            <div id="tabs-1">
						         <iframe src="" 
						                 id="frame1" frameborder="0" width="100%"></iframe>
						    </div>
						    <div id="tabs-2">
						           <iframe src="" id="frame2" frameborder="0"
						                                width="100%"></iframe>
						    </div>
						   
                        </div>                       
                    </div>
                </div>
            </td>
        </tr>
    </table>
    </div>
    
    
    </body>
</html>