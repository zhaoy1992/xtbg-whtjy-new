<%-- 
描述：业务类型top页面
作者：肖杰
版本：1.0
日期：2013-07-30
 --%>
<%@page import="com.chinacreator.xtbg.core.pubconfig.service.impl.FormBusitypeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.pubconfig.service.FormBusitypeServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.pubconfig.dao.FormBusitypeDao"%>
<%@page import="com.chinacreator.xtbg.core.pubconfig.entity.FormBusitypebean"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page
    import="com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.security.AccessControl,com.frameworkset.common.poolman.DBUtil"%>
<%@page import="java.util.*"%>

<html>
<head>
<%
    AccessControl accesscontroler = AccessControl.getAccessControl();
    accesscontroler.checkAccess(request, response);
    String userid = accesscontroler.getUserID();
    String path = request.getContextPath();
    String busitype_code = request.getParameter("busitype_code");
    String type = request.getParameter("type");
    String openwindid = request.getParameter("operwindowid");
    FormBusitypebean fbb = new FormBusitypebean();
	FormBusitypeServiceIfc fbs=new FormBusitypeServiceImpl();
	if(!StringUtil.isBlank(busitype_code)){
		fbb=fbs.findFormBusitypeInfoById(busitype_code);
	}
	
	
        
%>
<!-- 引入jQuery -->
<script type="text/javascript"
    src="../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<script
    src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"
    type="text/javascript"></script>
    
    <script
    src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js"
    type="text/javascript" charset="utf-8"></script>
<script
    src="../../resources/plug/formvalidation/jquery.validationEngine.js"
    type="text/javascript" charset="utf-8">
</script>
<script
    src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"
    type="text/javascript"></script>
<script
    src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"
    type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript"
    src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript"
    src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript"
    src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"
    charset="utf-8"></script>
<script type="text/javascript"
    src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js"
    charset="utf-8"></script>
<script type="text/javascript"
    src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript"
    src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<script type="text/javascript"
    src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"
    charset="utf-8"></script>
   
<script type="text/javascript">
jQuery(document).ready(function() {
	adaptationWH('_top','vcenter',20);
	judgeshowcflow();
	showAndhide();
	
});
var typetemp ='<%=type%>';
var did=null;
var idss=null;

function showcflow(){
    $("#selectButton").css("display","");
    $("#bindButton").css("display","");
}

function judgeshowcflow(){
    var busitype_code='<%=StringUtil.deNull(fbb.getBusitype_code())%>';
    if(busitype_code!=""){
        showcflow();
    }
}


function showAndhide()
{   
    var  typeflag = '<%=type%>';
    if(typeflag == 'flag')
    {
         $('#saveButton').hide();
         $('#bindButton').hide();
         $('#selectButton').hide();
        // $('#restoreButton').hide();
    }
}

function backparent(){
   var url="formbusitypelist.jsp";
   location.href=url;
    
}

function saveFormBusitypeInfo(){
   document.frame1.window.saveFormBusitypeInfo();	
}

function chooseWorkFlow(){
	document.frame1.window.chooseWorkFlow();   	  
}
function saveFlowInfo(){
	document.frame1.window.saveFlowInfo();
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>流程信息配置详细表单</title>
</head>
<body style="overflow-y: hidden;">
<form id="form1" name="form1" method="post" class="formular">
<div class="content_02" style="overflow: hidden;">
<div class="content_02_top" style="margin-bottom: 10px;" id="_top">
	<input id="saveButton" name="saveButton" type="button" class="but_y_01"
	    value="保存" onClick="saveFormBusitypeInfo();" /> 
	 <!-- <input id="selectButton" name="selectButton" class="but_y_01" type="button" value="选择流程"
	    style="display: none" onClick="chooseWorkFlow()" /> 
	<input id="bindButton" name="bindButton" class="but_y_01" type="button"
	    value="绑定" style="display: none" onClick="saveFlowInfo()" />  -->
	<input name="restoreButton" type="button" class="but_y_01" value="返回" onclick="backparent()"/>
</div>
<div id="vcenter" style="float: left; width: 100%; overflow: scroll; overflow-x: hidden;">
    <iframe src="pubinfoconfigdetail4detail.jsp?busitype_code=<%=busitype_code %>&operwindowid=<%=openwindid %>&type=<%=type %>"
     id="frame1" name="frame1" frameborder="0"  height="800" width="98%" scrolling="no"></iframe>  
</div>

</div>
</form>
</body>
</html>