<%-- 
描述：文号维护基本信息
作者：肖杰
版本：1.0
日期：2013-10-18
 --%>
<%@page import="com.chinacreator.xtbg.core.common.util.DataControlUtil"%>
<%@page import="com.chinacreator.xtbg.core.purviewmanager.service.impl.OrgManagerServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.purviewmanager.service.OrgManagerServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.purviewmanager.entity.Organization"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DbManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.chinacreator.xtbg.core.archive.dao.impl.WordArchiveDaoImpl"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.impl.WordArchiveServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.WordArchiveService"%>
<%@page import="com.chinacreator.xtbg.core.archive.dao.WordArchiveDao"%>
<%@page import="com.chinacreator.xtbg.core.wordnumdef.service.impl.WordNumDefServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.wordnumdef.service.WordNumDefService"%>
<%@page import="com.chinacreator.xtbg.core.dict.service.impl.DictServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.dict.service.DictServiceIfc"%>
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
	String path = request.getContextPath();//服务器根路径
	//特检院OA start 2014-06-06 修改字号中文乱码的问题
	String number_type=DataControlUtil.pageUnEscape((StringUtil.deNull(request.getParameter("number_type"))));
	//特检院OA end 2014-06-06 修改字号中文乱码的问题
	String number_year=StringUtil.deNull(request.getParameter("number_year"));
	String number_order="";
	
	WordNumDefService service=new WordNumDefServiceImpl();
	Map<String,String> numbean=new HashMap<String,String> ();
	WordArchiveService arservice=new WordArchiveServiceImpl();
	//Connection conn=
	if(!StringUtil.isBlank(number_type) && !StringUtil.isBlank(number_year)){
		numbean= service.getWordNumBean(number_type,number_year);
		String number_code=arservice.getMaxArchiveNumber(numbean.get("number_type"),numbean.get("number_year"),"");
		numbean.put("number_code",number_code);
		
		//根据单位ids得到相应单位名称
		String ids=StringUtil.deNull(numbean.get("number_org_id"));
		String orgname="";
		if(!StringUtil.isBlank(ids)){
			String orgids[]=ids.split(",");
			OrgManagerServiceIfc orgservice=new OrgManagerServiceImpl();
			for(int i=0;i<orgids.length;i++){
				Organization orgObject = orgservice.getOrganization(orgids[i]);
				if(orgObject!=null){
					orgname+=orgObject.getOrg_name()+",";	
				}
			}
			if(!StringUtil.isBlank(orgname)){
				orgname=orgname.substring(0,orgname.length()-1);
			}
		}
		numbean.put("number_org_name",orgname);
	}else{
		//得到最大排序号
		number_year=DateUtil.getCurrentYear();
		String sql="select number_order from oa_word_number_def where number_year='"+number_year+"' order by number_order desc";
		number_order=DaoUtil.sqlToField(sql);
		if(StringUtil.isBlank(number_order)){
			number_order="1";
		}else{
			number_order=(Integer.parseInt(number_order)+1)+"";
		}
		numbean.put("number_order",number_order);
		numbean.put("number_code","1");
	}
	String nowyear=(StringUtil.parseInt(DateUtil.getCurrentYear())+1)+"";
%>
<title>文号维护基本信息</title>
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
<script src="../../resources/plug/My97DatePicker/WdatePicker.js"
	type="text/javascript"></script>

<script type="text/javascript">

var path = '<%=path %>';

jQuery(function() {
	if( "<%=number_type%>"==""){
		jQuery("#add").attr("disabled","disabled");
		jQuery("#delete").attr("disabled","disabled");
	}
	jQuery("#number_year").val("<%=number_year%>");
});
/*
函数:  addwordnum
说明:  新增字号
参数:   无
返回值: 无
*/
var addwordnum = function() {
	treereload();
	rightreload();

}
/*
函数:  treereload
说明:  刷新树
参数:   无
返回值: 无
*/
var treereload = function() {
	var urltree="wordnumtree.jsp";
	parent.getleft(urltree);

}
/*
函数:  rightreload
说明:  刷新右边
参数:   无
返回值: 无
*/
var rightreload = function() {
	var url="wordnuminfo.jsp";
	parent.getTempValue(url);

}
/*
函数:  addorupdate
说明:  保存or修改
参数:   无
返回值: 无
*/
var addorupdate = function() {
	if(!jQuery('#form1').validationEngine('validate')){
		return;
	}
	var url="wordnumdefdo.jsp?oldyear=<%=number_year%>";
	jQuery("#form1").attr("action",url);
	jQuery("#action").val("addorupdatewordnum");
	document.all.form1.target = "hiddenFrame";
	jQuery("#form1").submit();
}

/*
函数: deletewordnum
说明:  删除
参数:   无
返回值: 无
*/
var deletewordnum = function() {
	jQuery("#number_type").val("<%=number_type%>");
	jQuery("#number_year").val("<%=number_year%>");
	var url="wordnumdefdo.jsp";
	var okF = function(){
		jQuery("#form1").attr("action",url);
		jQuery("#action").val("deletewordnum");
		document.all.form1.target = "hiddenFrame";
		jQuery("#form1").submit();
	}
	 var p={
		headerText:'提示',
		okName:'确认',
	    okFunction:okF,
	    cancelName:'取消'
	};
	alert('确定删除吗？',p);
}

function onchangeyear(){
	jQuery("#number_code").val("1");
	jQuery("#number_order").val("1");
}
var chooseOrg = function (){
	var s = new jQuery.z_tree();
	  s.treeID='mian';
	  s.treetypestr='checkbox';
	  s.isShowSeacher=true;
	  s.treeName="选取部门";
	  s.isType='dept';
	  s.headerName="选取部门";
	  s.item_id = 'org_id';
	  s.selectedIds=jQuery('#number_org_id').val();
	  s.type='ADEPT';
	  s.returnFunction=function(orgObj){
		  if(!IsSpace(orgObj)){
			  jQuery('#number_org_id').val(orgObj.id);
			  jQuery('#number_org_name').val(orgObj.name);
			  jQuery('#number_org_name').attr("title",orgObj.name);
			 }
		 }
	  s.init();
}

</script>

</head>
<body style="overflow-y: hidden;" onload="adaptationWH('_top','vcenter',40)">
<form id="form1" action="" method="post">
<input type="hidden" name="oldtype" id="oldtype" value="<%=number_type%>"  />
<input type="hidden" name="action" id="action"   />



<!-- 操作-->
<div class="content_02" style="overflow: hidden;" id="_top">
	<div class="content_02_top" style="margin-bottom: 10px;">
		<input name="fbbt" id="add" value="新增字号" onclick="addwordnum();"  type="button" class="but_y_01" /> 
		<input name="fbbt" id="fbbt" value="保存" onclick="addorupdate();"  type="button" class="but_y_01" />
		<input name="" id="delete" value="删除" onclick="deletewordnum()" type="button" class="but_y_01" />
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
						<th class="content_02_box_div_table_th"><font style="COLOR: red">*</font>字号类型：</th>
						<td class="content_02_box_div_table_td">
							<input  class="validate[required,maxSize[100]] input_188" name="number_type" id="number_type" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" value="<%=number_type %>" />
						</td>
						<th class="content_02_box_div_table_th"><font style="COLOR: red">*</font>当前编号：</th>
						<td class="content_02_box_div_table_td" width="192px">
							<input  class="validate[required,maxSize[100]] input_188" name=number_code id="number_code" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" value="<%=StringUtil.deNull(numbean.get("number_code"))  %>" />
						</td>
					</tr>
					<tr id="sel">
						<th class="content_02_box_div_table_th">年度：</th>
						<td class="content_02_box_div_table_td">
							<input type="hidden" id="nowyear" name="nowyear" value="<%=nowyear %>"/>
							<input id="number_year" name="number_year" class="date_120" onchange="onchangeyear()" onclick="WdatePicker({maxDate:'#F{$dp.$D(\'nowyear\')}',dateFmt:'yyyy'})" style="width: 125px" />
						</td>
						<th class="content_02_box_div_table_th">当前序号：</th>
						<td class="content_02_box_div_table_td" width="192px">
							<input  class="validate[custom[number]] input_188" name="number_order" id="number_order" value="<%=StringUtil.deNull( numbean.get("number_order"))%>" />
						</td>
					</tr>
					<tr>
						<th width="212" valign="top" class="content_02_box_div_table_02_th">所属部门：</th>
						<td colspan="3" class="content_02_box_div_table_02_td">
							<input style="width: 94.5%" title="<%=StringUtil.deNull(numbean.get("number_org_name"))%>" class="input_188" name="number_org_name" id="number_org_name" value="<%=StringUtil.deNull(numbean.get("number_org_name"))%>" onclick="chooseOrg()"/>
							<input type="hidden"  class="input_188" name="number_org_id" id="number_org_id" value="<%=StringUtil.deNull(numbean.get("number_org_id"))%>" />
							<input name="k_type_name_button" id="k_type_name_button" type="button" class="but_x" style="height: 26px;" onclick="chooseOrg()" /> 
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