<%-- 
描述：系统参数设置基本信息
作者：肖杰
版本：1.0
日期：2013-07-15
 --%>
<%@page import="com.chinacreator.xtbg.core.sysparam.service.impl.SysParamServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.sysparam.service.SysParamServiceIfc"%>
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
	Object treeNode = StringUtil.deNull(request.getParameter("treeNode"));
	String dictdata_id = StringUtil.deNull(request.getParameter("orgid"));
	String p_id=StringUtil.deNull(request.getParameter("p_id"));
	String p_type="";
	String p_code="";
	String p_name="";
	String p_content="";
	String p_valid="";
	String p_isupdate="";
	String p_remark="";
	String p_creator_time= StringUtil.convertTimeToString(new Timestamp(System.currentTimeMillis()), "");
	Map<String, String> viewMap = new HashMap<String, String>();
	SysParamServiceIfc SysParamServiceIfc=new SysParamServiceImpl();
	if(!StringUtil.isBlank(p_id)){
		viewMap=SysParamServiceIfc.getSysParamBean(p_id);
		p_type = StringUtil.deNull(viewMap.get("p_type"));
		p_code = StringUtil.deNull(viewMap.get("p_code"));
		p_name = StringUtil.deNull(viewMap.get("p_name"));
		p_content = StringUtil.deNull(viewMap.get("p_content"));
		p_valid = StringUtil.deNull(viewMap.get("p_valid"));
		p_isupdate = StringUtil.deNull(viewMap.get("p_isupdate"));
		p_remark = StringUtil.deNull(viewMap.get("p_remark"));
		p_creator_time = StringUtil.deNull(viewMap.get("p_creator_time"));
		dictdata_id = StringUtil.deNull(viewMap.get("dictdata_id"));
	}
%>
<title>系统参数设置基本信息</title>
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
jQuery(function() {
	
	if('<%=p_id %>' != '') {
		jQuery("#p_valid").val("<%=p_valid %>");
		jQuery("#p_isupdate").val("<%=p_isupdate %>");
	}

	
	
});
/*
函数:  addSysParam
说明:  添加
参数:   无
返回值: 无
*/
var addSysParam = function() {
	if(!jQuery('#form1').validationEngine('validate')){
		return;
	}
		
	jQuery("#action").val("addSysParam");
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
	alert('确定保存吗？',p);

}
/*
函数:  updateSysParam
说明:  修改
参数:   无
返回值: 无
*/
var updateSysParam = function() {
	if(!jQuery('#form1').validationEngine('validate')){
		return;
	}
	jQuery("#action").val("updateSysParam");
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
	alert('确定保存吗？',p);

}


/*
函数:  back
说明:  返回列表
参数:   无
返回值: 无
*/
function back(){
		var okF = function(){
			if("updatesysparam1"==subid){
				window.location.href="../../sysparam/jsp/sysparamlist.jsp?orgid=<%=dictdata_id%>";
			}else{
			removeWindows(subid,true);
			}
		}
		 var p={
				headerText:'提示',
				okName:'确认',
		        okFunction:okF,
		        cancelName:'取消'};
		 alert('返回该页,未保存的信息将会丢失 '+'<br>'+'确定返回？',p);
}

</script>

</head>
<body style="overflow-y: hidden;" onload="adaptationWH('_top','vcenter',40)">
<form id="form1" action="sysparamdo.jsp?subid=<%=subid %>>" method="post">
<input type="hidden" name="action" id="action"   />
<input type="hidden" name="dictdata_id" id="dictdata_id"  value="<%=dictdata_id %>" />
<input type="hidden" name="p_creator_time" id="p_creator_time"  value="<%=p_creator_time %>" />


<!-- 操作-->
<div class="content_02" style="overflow: hidden;" id="_top">
	<div class="content_02_top" style="margin-bottom: 10px;">
		<% if(StringUtil.isBlank(p_id)){%>
		<input name="fbbt" id="fbbt" value="保存" onclick="addSysParam();"  type="button" class="but_y_01" /> 
		<% }else{%>
		<input name="fbbt" id="fbbt" value="保存" onclick="updateSysParam();"  type="button" class="but_y_01" />
		<% }%>
		<input name="" value="返回" onclick="back()" type="button" class="but_y_01" />
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
						<th class="content_02_box_div_table_th">参数名称：</th>
						<td class="content_02_box_div_table_td">
							<input type="hidden" name="p_id" id="p_id"  value="<%=p_id %>" />
							<input  class="validate[maxSize[100]] input_188" name="p_name" id="p_name" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" value="<%=p_name %>" />
						</td>
						<th class="content_02_box_div_table_th"><font style="COLOR: red">*</font>参数类型：</th>
						<td class="content_02_box_div_table_td" width="192px">
							<input  class="validate[maxSize[50]] input_188" name="p_type" id="p_type" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" value="<%=p_type %>" />
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th"><font style="COLOR: red">*</font>参数编号：</th>
						<td class="content_02_box_div_table_td">
							<input  class="validate[required,maxSize[100]] input_188" name="p_code" id="p_code" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" value="<%=p_code %>" />
						</td>
						<th class="content_02_box_div_table_th">创建时间：</th>
						<td class="content_02_box_div_table_td" width="192px">
							<input disabled="disabled"  class="validate[required] input_188" name="p_creator_time" id="p_creator_time" value="<%=p_creator_time %>" />
						</td>
					</tr>
					<tr id="sel">
						<th class="content_02_box_div_table_th">是否有效：</th>
						<td class="content_02_box_div_table_td">
							<select id="p_valid" name="p_valid" class="select_100_box" style="width: 125px" >
								<option value="1">是</option>
								<option value="0">否</option>
							</select>
						</td>
						<th class="content_02_box_div_table_th">是否可修改：</th>
						<td class="content_02_box_div_table_td" width="192px">
							<select id="p_isupdate" name="p_isupdate" class="select_100_box" style="width: 125px">
								<option value="1">是</option>
								<option value="0">否</option>
							</select>
						</td>
					</tr>
					<tr>
						<th width="212" valign="top" class="content_02_box_div_table_02_th"><font style="COLOR: red">*</font>参数内容：</th>
						<td class="content_02_box_div_table_td" colspan="3">
						<textarea oncontextmenu="toSetTemplatePara(this);return false;"
								onmousedown=lockPosition(this)
								onkeydown=lockPosition(this)
								onkeyup=lockPosition(this)
								onfocus=lockPosition(this)
								name="p_content" id="p_content" style="height: 80px; overflow: auto;" class="validate[required,maxSize[500]] input_title_text"><%=p_content%></textarea>
						
						<script>
						//模板参数设置
						function toSetTemplatePara(obj){
						    var url = "<%=path%>/ccapp/oa/sysparam/jsp/sysparamvalueselect.jsp?p_code=<%=p_code%>&random=" + (new Date()).getTime();
						    openAlertWindows('windowId',url,'请选择参数值',600,400,'20%','20%')
						}
						<%--回调--%>
						function toGetTemplatePara(rtn){
						    var objVal = jQuery("#p_content").val();
						    var pre = objVal.substr(0, startPos);
						    var post = objVal.substr(endPos);
						    if(!IsSpace(rtn)){
						    	if(IsSpace(objVal)){
							        rtn = "【" + rtn + "】"; 
						    	}else{
						    		rtn = "_【" + rtn + "】"; 
						    	}
						       jQuery("#p_content").val(pre + rtn + post);
						    }
						}
						var startPos = 0;
						var endPos = 0;
						function lockPosition(obj){
						    if(typeof(obj.selectionStart) == "number"){
						        startPos = obj.selectionStart;
						        endPos = obj.selectionEnd;
						    }else if(document.selection){ //IE6
						        //两个range，一个是已经选择的text(range)，一个是整个textarea(range_all)
						        //range_all.compareEndPoints()比较两个端点，如果range_all比range更往左(further to the left)         
						        //返回小于0的值，则range_all往右移一点，直到两个range的start相同。
						        //calculate selection start point by moving beginning of range_all to beginning of range
						        var range = document.selection.createRange();
						        if(range.parentElement().id == obj.id){
						            var range_all = document.body.createTextRange();
						            range_all.moveToElementText(obj);
						            for (startPos = 0; range_all.compareEndPoints("StartToStart", range) < 0; startPos++){
						                range_all.moveStart('character', 1);
						            }
						            for (var i = 0; i <= startPos; i ++){
						                if (obj.value.charAt(i) == '\n'){
						                    startPos++;
						                }
						            }
						            var range_all = document.body.createTextRange();
						            range_all.moveToElementText(obj);
						            for (endPos = 0; range_all.compareEndPoints('StartToEnd', range) < 0; endPos++){
						                range_all.moveStart('character', 1);
						            }
						            for (var i = 0; i <= endPos; i ++){
						                if (obj.value.charAt(i) == '\n'){
						                    endPos++;
						                }
						            }
						        }
						    }
						}
						</script>
					</td>
					</tr>
					<tr>
						<th width="212" valign="top" class="content_02_box_div_table_02_th">参数描述：</th>
						<td colspan="3" class="content_02_box_div_table_02_td">
						<textarea class="validate[maxSize[500]] textarea_575" style="width:99%" name="p_remark" id="p_remark"  ><%=p_remark %></textarea>
							
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class="content_02_box">
			<div class="content_02_box_title_bg"><span>参数值设置</span></div>
			<div>
				<iframe id="ifdirectory" scrolling="no" width="100%" height="680" frameborder="0"></iframe>
				<script>
					var srcc = "sysparamvaluelist.jsp?p_code="+_pub.lang.zwzm('<%=p_code%>');
					jQuery("#ifdirectory").attr("src",srcc);
				</script>
			</div>
		</div>
	
	</div>
</div>

</form>

<iframe name="hiddenFrame" width="0" height="0"></iframe>

</body>
</html>