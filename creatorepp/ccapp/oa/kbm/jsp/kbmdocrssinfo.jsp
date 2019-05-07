<%-- 
描述：知识库文档订阅信息界面
作者：肖杰
版本：1.0
日期：2013-08-13
 --%>
<%@page import="com.chinacreator.xtbg.core.kbm.service.impl.KbmDocRssServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.kbm.service.KbmDocRssService"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DataControlUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<head>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String curUserId =  accesscontroler.getUserID();
	String curUserName =  accesscontroler.getUserName();
	UserCacheBean usercachebean=UserCache.getUserCacheBean(curUserId);
	String subid = request.getParameter("subid");
	String path = request.getContextPath();//服务器根路径
	String k_rss_id=StringUtil.deNull(request.getParameter("k_rss_id"));
	String k_rss_user=curUserId;
	String k_rss_user_name=curUserName;
	String k_type_id="";
	String k_type_name="";
	String k_key="";
	String k_create_time= StringUtil.convertTimeToString(new Timestamp(System.currentTimeMillis()), "");
	Map<String, String> viewMap = new HashMap<String, String>();
	KbmDocRssService servive=new KbmDocRssServiceImpl();
	if(!StringUtil.isBlank(k_rss_id)){
		viewMap=servive.getKbmDocRssBean(k_rss_id);
		k_rss_user = StringUtil.deNull(viewMap.get("k_rss_user"));
		k_rss_user_name = StringUtil.deNull(viewMap.get("k_rss_user_name"));
		k_type_id = StringUtil.deNull(viewMap.get("k_type_id"));
		k_type_name = StringUtil.deNull(viewMap.get("k_type_name"));
		k_key = StringUtil.deNull(viewMap.get("k_key"));
		k_create_time = StringUtil.deNull(viewMap.get("k_create_time"));
	}
%>
<title>知识库文档订阅信息界面</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入formvValidatetion -->
<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" ></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>

<script type="text/javascript">

var path = '<%=path %>';

var subid = '<%=subid %>';

/*
函数:  add
说明:  添加
参数:   无
返回值: 无
*/
var add = function() {
	if(!jQuery('#form1').validationEngine('validate')){
		return;
	}
		
	jQuery("#action").val("add");
	var okF = function(){
		document.all.form1.target = "hiddenFrame";
		jQuery("#form1").submit();
	}
	 var p={
		headerText:'提示',
		okName:'确认',
	    okFunction:okF,
	    cancelName:'取消'
	};
	alert('确定添加吗？',p);

}
/*
函数:  update
说明:  修改
参数:   无
返回值: 无
*/
var update = function() {
	if(!jQuery('#form1').validationEngine('validate')){
		return;
	}
	jQuery("#action").val("update");
	var okF = function(){
		document.all.form1.target = "hiddenFrame";
		jQuery("#form1").submit();
	}
	 var p={
		headerText:'提示',
		okName:'确认',
	    okFunction:okF,
	    cancelName:'取消'
	};
	alert('确定修改吗？',p);

}


/*
函数:  back
说明:  返回列表
参数:   无
返回值: 无
*/
function back(type){
	if("1"==type){
		var p={
				headerText:'提示',
				okName:'确认',
		        okFunction:function(){
		        	removeWindows('<%=subid%>',true);
		        },
		        cancelName:'取消'
			};
		alert("返回后，数据将不会保存，确定返回？",p);
	}else{
		removeWindows('<%=subid%>',true);
	}
}
var chooseFileType = function (typestr){
	var s = new jQuery.z_tree();
	s.treeID = 'mianType';
	s.treetypestr = typestr;
	s.isShowSeacher = true;
	s.treeName = "选择分类";
	s.headerName = "选择分类";
	s.type = "KBM_TYPE";
	s.isType = "person";
	s.selectedIds = jQuery("#k_type_id").val(),
	s.f_org_id = "<%=usercachebean.getUnit_id()%>";//所属单位id 全局的js变量 引用时注意
	s.returnFunction = function(userObj, nodes){<%--function OK 294 returnFunction(userObj, nodes)--%>
	    try{
	    	if(!IsSpace(userObj)){
	    		jQuery("#k_type_id").val(userObj.id);
	    		jQuery("#k_type_name").val(userObj.name);
	    	}else{
	    		jQuery("#k_type_id").val("");
	    		jQuery("#k_type_name").val("");
	    	}
	    }catch(e){
	    }
	}
	s.init();
}
</script>

</head>
<body style="overflow-y: hidden;" onload="adaptationWH('_top','vcenter',40)">
<form id="form1" action="kbmdocrssdo.jsp?subid=addorupdate" method="post">
<input type="hidden" name="action" id="action"   />
<input type="hidden" name="k_create_time" id="k_create_time"  value="<%=k_create_time %>" />
<input type="hidden" name="k_rss_user" id="k_rss_user"  value="<%=k_rss_user %>" />
<input type="hidden" name="k_rss_user_name" id="k_rss_user_name"  value="<%=k_rss_user_name %>" />
<input type="hidden" name="k_rss_id" id="k_rss_id"  value="<%=k_rss_id %>" />


<!-- 操作-->
<div class="content_02" style="overflow: hidden;" id="_top">
	<div class="content_02_top" style="margin-bottom: 10px;">
		<% if(StringUtil.isBlank(k_rss_id)){%>
		<input name="fbbt" id="fbbt" value="保存" onclick="add();"  type="button" class="but_y_01" /> 
		<% }else{%>
		<input name="fbbt" id="fbbt" value="保存" onclick="update();"  type="button" class="but_y_01" />
		<% }%>
		<input name="" value="返回" onclick="back('1')" type="button" class="but_y_01" />
	</div>
</div>
<!-- 操作-->

<!-- 表格-->
<div id="vcenter" style="float: left; width: 100%; overflow: scroll" scrolling="yes">
	<div style="float: left; width: 775px;">
	
		<div class="content_02_box">
			<div class="content_02_box_title_bg"><span>基本信息</span></div>
			<div class="content_02_box_div">
				<table border="0" cellspacing="0" cellpadding="0"
					class="content_02_box_div_table">
					<tr>
						<th class="content_02_box_div_table_th"><font style="COLOR: red">*</font>订阅的分类：</th>
						<td colspan="3" class="content_02_box_div_table_td">
							<input type="hidden" name="k_type_id" id="k_type_id" value="<%=k_type_id %>"/>
							<textarea class="validate[required,maxSize[200]] textarea_575" style="width:99%" name="k_type_name" id="k_type_name" readonly="readonly" onclick='chooseFileType("checkbox")' ><%=k_type_name %></textarea>
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th">订阅的关键字：</br>(<font style="COLOR: red">关键字请用,隔开</font>)</th>
						<td colspan="3" class="content_02_box_div_table_td">
							<textarea class="validate[maxSize[400]] textarea_575" style="width:99%" name="k_key" id="k_key"  ><%=k_key %></textarea>
						</td>
					</tr>
					<tr id="sel">
						<th class="content_02_box_div_table_th">订阅时间：</th>
						<td colspan="3" class="content_02_box_div_table_td" width="192px">
							<input disabled="disabled"  class=" input_188" name="k_create_time" id="k_create_time" value="<%=k_create_time %>" />
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>

</form>

<iframe name="hiddenFrame" width="0" height="0"></iframe>

</body>
</html>