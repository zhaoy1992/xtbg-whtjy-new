<%-- 
描述：督查事项查询左边条件
作者：肖杰
版本：1.0
日期：2013-11-06
--%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.core.inspect.service.impl.InspectManageServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.inspect.service.InspectManageService"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	String rightIframename = StringUtil.deNull(request.getParameter("rightIframename"));
	String type=request.getParameter("type");
	//当前用户ID
	String userId = accesscontroler.getUserID();
	//服务接口
    InspectManageService service = new InspectManageServiceImpl();    
    //查询所有分类信息
    List<Map<String,String>> typeList = service.queryAllType();
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>督查事项查询左边条件</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery_zTree-->
<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.exedit-3.0.js"></script>

<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<!-- 引入其它 -->
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
	jQuery("#send_time0").attr("checked",true);
	jQuery("#inspect_type0").attr("checked",true);
	jQuery("#inspect_state0").attr("checked",true);
	toparam("","")
});

function toparam(id,name){
	if(id!="" || name!=""){
		jQuery("#"+name).val(jQuery("#"+id).val());
	}
	var send_time=jQuery("#send_time").val();
	var inspect_type=jQuery("#inspect_type").val();
	var inspect_state=jQuery("#inspect_state").val();
	
	var url="inspectlisttabs.jsp?send_time="+send_time+"&inspect_type="+inspect_type+"&inspect_state="+inspect_state;
	parent.setRightIframeSrc(url);
}
</script>
</head>
<body class="tree_bg_eaeaea">
<input type="hidden" value="0" id="send_time" name="send_time" />
<input type="hidden" value="0" id="inspect_type" name="inspect_type" />
<input type="hidden" value="0" id="inspect_state" name="inspect_state" />
<div style="width: 200px" class="content_02_box_title_bg"><span style="width: 180px">交办时间</span></div>
	<div class="">
	<table id="queryTable" width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
        <tr>
        	<td style="width: 30px;">
        		&nbsp;&nbsp;<input type="radio" value="0" id="send_time0" name="send_time" onclick="toparam(id,name)" />全部
        	</td>
        	<td style="width: 30px">
        		<input type="radio" value="1" id="send_time1" name="send_time" onclick="toparam(id,name)"/>一天以内
        	</td>
        </tr>
        <tr>
        	<td style="width: 30px">
        		&nbsp;&nbsp;<input type="radio" value="2" id="send_time2" name="send_time" onclick="toparam(id,name)"/>一周以内
        	</td>
        	<td style="width: 30px">
        		<input type="radio" value="3" id="send_time3" name="send_time" onclick="toparam(id,name)"/>一月以内
        	</td>
        </tr>
    </table>
 </div>
 
 <div style="width: 200px;margin-top: 10px" class="content_02_box_title_bg"><span style="width: 180px">任务类型</span></div>
 <div class="">
	<table id="queryTable" width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
		<tr>
        	<td style="width: 30px;">
        		&nbsp;&nbsp;<input type="radio" value="0" id="inspect_type0" name="inspect_type" onclick="toparam(id,name)"/>全部
        	</td>
        </tr>
	 	<%
	 		int i=1;
            for(Map<String,String> typemap : typeList){
         %>
         <tr>
        	<td style="width: 30px">
        		&nbsp;&nbsp;<input type="radio" value="<%=typemap.get("type_id") %>" id="inspect_type<%=i %>" name="inspect_type" onclick="toparam(id,name)"/><%=typemap.get("type_name") %>
        	</td>
        </tr>
           
        <%i++; }%>
    </table>
 </div>
 
 <div style="width: 200px;margin-top: 10px;" class="content_02_box_title_bg"><span style="width: 180px">任务状态</span></div>
	<div class="">
	<table id="queryTable" width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
        <tr>
        	<td style="width: 30px;">
        		&nbsp;&nbsp;<input type="radio" value="0" id="inspect_state0" name="inspect_state" onclick="toparam(id,name)"/>全部
        	</td>
        	<td style="width: 30px">
        		<input type="radio" value="1" id="inspect_state1" name="inspect_state" onclick="toparam(id,name)"/>办理中
        	</td>
        </tr>
        <tr>
        	<td style="width: 30px">
        		&nbsp;&nbsp;<input type="radio" value="2" id="inspect_state2" name="inspect_state" onclick="toparam(id,name)"/>已完成
        	</td>
        	<td style="width: 30px">
        		<input type="radio" value="3" id="inspect_state3" name="inspect_state" onclick="toparam(id,name)"/>未完成
        	</td>
        </tr>
    </table>
 </div>
</body>
</html>