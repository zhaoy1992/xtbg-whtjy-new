<%--
	描述：业务类型分类
	作者：shuqi.liu
	版本：1.0
	日期：2013-7-23
--%>
<%@page import="com.chinacreator.xtbg.core.common.cache.OASystemCache"%>
<%@page import="com.chinacreator.xtbg.core.archive.entity.OfficialDocumentRegisterHandleBean"%>
<%@page import="com.chinacreator.xtbg.core.archive.entity.FlowMoveBean"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String thisWindowId = StringUtil.deNull(request.getParameter("windowsId"));
	String busitype_type_code=StringUtil.deNull(request.getParameter("busitype_type_code"));
	StringBuffer urlTmp = new StringBuffer();
	//判断是"一般发起新流程"还是"流程进行时中发起新流程"
	FlowMoveBean fmb= new FlowMoveBean(request);
	urlTmp.append(fmb.getURLString());
	//处理收文登记的对象
	OfficialDocumentRegisterHandleBean odr = new OfficialDocumentRegisterHandleBean(request,true);
	urlTmp.append(odr.getURLString());
	System.out.println(urlTmp);
	
	StringBuffer typeurl=new StringBuffer();
	if(!StringUtil.isBlank(busitype_type_code)){
		typeurl.append("?busitype_type_code="+busitype_type_code);
	}
	String type =OASystemCache.getContextProperty("createWorkListType");
	String document_recordid = StringUtil.deNull(request.getParameter("document_recordid"));
%>
<title>业务类型分类</title>
<style type="text/css">
HTML{overflow: hidden;}
</style>
<!-- 引入jQuery -->
<script type="text/javascript" src="../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript">
//加载右窗口
function getTempValue(url){
	$("#dict").attr("src",url);
}

//如果是发起新流程页面，获取收文登记。那么做下面操作。
<%if(!StringUtil.isBlank(urlTmp.toString())){%>
function afterActionSuccessFn(){
	getParentWindow('newwindows').removeAlertWindows("newwindows",true);
	getParentWindow('<%=thisWindowId%>').wordiwebofficeJS.doFlowInFlow.newFlowWindowClose();
	getParentWindow('<%=thisWindowId%>').removeAlertWindows("<%=thisWindowId%>",true);//移除本窗口
};
<%}%>

//打开页面
function openForms(url, flowname){
	//var height = window.screen.availHeight;
	//var width = window.screen.availWidth;
	var width = jQuery(window.top).width();//界面宽度
	var height = jQuery(window.top).height();//界面高度
	
	url= url+"&height="+height;
	url= url+"&width="+width;
	url= url+"&windowsId=newwindows&document_recordid=<%=document_recordid%>"
	url = url +"<%=urlTmp.toString()%>";
	//弹出款TOP下移，空出标签页及以上位置，165为TOP图片高度，暂时写死，应该是根据TOP的页面高度去动态获取
	openAlertWindows('newwindows',url,flowname,width,height-86,86,'0%','','',true);
}
jQuery(function(){ //DOM Ready
	var type="<%=type%>";
	if("image"==type){
		var url="newflowlist.jsp<%=typeurl%>";
	}else{
		var url="newflowlist1.jsp<%=typeurl%>";
	}
	getTempValue(url);
});
</script>
</head>
<body style="overflow-y: hidden;">
	<table width="100%">
		<tr>
			<td width="200px">
				<iframe id="dicttypetree" name="dicttypetree" src="newflowtree.jsp<%=typeurl%>" scrolling="no" width="220px" height="680" style="padding:0px;margin-top: 20px;" frameborder="0"></iframe>
			</td>
			<td>
				<iframe id="dict" src="" scrolling="no" width="100%" height="680" frameborder="0"></iframe>
			</td>
		</tr>
	</table>
</body>
</html>