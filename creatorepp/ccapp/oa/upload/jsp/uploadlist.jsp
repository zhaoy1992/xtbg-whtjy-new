<%@page import="java.io.File"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.UUID"%>
<%@page import="java.util.Date"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.upload.util.UploadConstants"%>
<%@page contentType="text/html; charset=utf-8"%>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
String userId= accesscontroler.getUserID();

String attach_id = request.getParameter("attach_id");
if (StringUtil.nullOrBlank(attach_id)){
	attach_id = UUID.randomUUID().toString();
}
String isEdit=request.getParameter("isEdit");
String departid = request.getParameter("departid");
String serverName = (String) request.getServerName();//localhost
String serverPort = String.valueOf(request.getServerPort());//8080
String contextPath = (String) request.getContextPath();//oa-core
String rootPath = request.getSession().getServletContext().getRealPath("");
rootPath = rootPath.replace("\\", "/");//-----根目录磁盘路径
String tableName = request.getParameter("tableName");//模块表名
String oType = StringUtil.deNull(request.getParameter("oType")); //操作 权限   ,0只能下载
tableName="OA_FILEUPLOAD_PAPER";

 //attach_id="0b5b655a-9abd-4ef2-92ca-3f72666517fa"; 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>文件上传</title>
<style>
#input-file { 
	position: relative; /* 保证子元素的定位 */ 
	width: 120px; 
	height: 30px; 
	background: #eee; 
	border: 1px solid #ccc; 
	text-align: center; 
	cursor: pointer; 
	} 
#text-file { 
	display: inline-block; 
	margin-top: 5px; 
	color: #666; 
	font-family: "黑体"; 
	font-size: 14px; 
	cursor:pointer;
} 
#fa { 
	display: block; 
	position: absolute; 
	top: 0; 
	left: 0; 
	width: 120px; /* 宽高和外围元素保持一致 */ 
	height: 30px; 
	opacity: 0; 
	-moz-opacity: 0; /* 兼容老式浏览器 */ 
	filter: alpha(opacity=0); /* 兼容IE */ 
	cursor:pointer;
} 

/*  cursor:pointer; position:absolute; right:0px;filter:progid:DXImageTransform.Microsoft.Alpha(opacity=0);opacity:0;*/
</style>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" ></script>

<script src="../../resources/plug/jquery_dialog/jquery_dialog.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<!-- 引入其它  上传文件必要的-->
<script type="text/javascript" src="../../resources/util/public.js" ></script>
<script type="text/javascript" src="../../resources/plug/iWebFile2005/iWebFile2005.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/iWebFile2005/fileupload.js"   charset="utf-8"></script>
<script type="text/javascript">
var isEdit = '<%=isEdit%>';
jQuery(function() {
	if (isEdit=="yes"){//一般在表单修改时，才有加载也有的附件列表
		//异步加载表单已有的附件
		callajaxUploadFile();
	}
});
//异步加载表单已有的附件
function callajaxUploadFile(){
	//调用js中的方法
	ajaxUploadFiles('<%=tableName%>','<%=attach_id%>','<%=oType%>','_filebut');
}
//表单查看(有删除权限)
function openupload4Editcandel(){
	var windowId = 'openupload4EditWindow';
	var url = '?isEdit=yes&windowId='+windowId+'&tableName=<%=tableName%>&attach_id=<%=attach_id%>&oType=1';
    openAlertWindows(windowId, getCurrentFilePath()+'uploadlist.jsp'+url, '查看附件' ,1020,530,'10%','10%');
}
//表单查看
function openupload4Edit(){
	var windowId = 'openupload4EditWindow';
	var url = '?isEdit=yes&windowId='+windowId+'&tableName=<%=tableName%>&attach_id=<%=attach_id%>&oType=0';
    openAlertWindows(windowId, getCurrentFilePath()+'uploadlist.jsp'+url, '查看附件' ,1020,530,'10%','10%');
}
//上传按钮的显示
function dispup1(){
	jQuery("#up1").show();
}
//上传按钮的隐藏
function hideup1(){
	jQuery("#up1").hide();
}

</script>
</head>
<body>
	<table border="0" cellspacing="0" cellpadding="0" height="100">
		<tr>
			<th width="200"  > 文件上传：</th>
			<td width="500"  ></td>
		</tr>
		<tr>
			<th>已上传附件</th>
			<td>
				<div id="input-file"> 
					<span id="text-file">点击上传</span> 
					<input id="fa" type="file" onchange="UpLoadFile('<%=tableName %>',getFullPath(fa),'<%=rootPath%>','<%=attach_id%>','1','_filebut')"/> 
				</div> 
			</td>
		</tr>
		<tr>
			<th>已上传附件</th>
			<td>
				<ul id="_fileshowul"></ul>
			</td>
		</tr>
		<tr>
			<th>在grid列表中查看附件</th>
			<td>
				<input class="but_y_03"  type="button" id="_filebut" value="查看1" onclick="openuploadlist(getCurrentFilePath(),'<%=tableName%>','<%=attach_id%>','1')"/>
				<input class="but_y_03"  type="button" id="_filebut2" value="查看2" onclick="openuploadlist(getCurrentFilePath(),'<%=tableName%>','<%=attach_id%>','0')"/>
			</td>
		</tr>
		<tr>
			<th>上传生成将要保存的id</th>
			<td><font color=green><%=attach_id %></font>
			</td>
		</tr>
		<tr>
			<th>在表单中查看</th>
			<td>
			<button onclick="openupload4Editcandel()">表单查看(有删除权限)</button>
			<button onclick="openupload4Edit()">表单查看</button>
			</td>
		</tr>
		<tr>
			<th>处理上传按钮 </th>
			<td>
				<button onclick="dispup1()">显示【上传文档】</button>
				<button onclick="hideup1()">隐藏【上传文档】</button>
				<input class="but_y_03"  type="button" id="clean" value="清理附件" onclick="cleanfile()"/>
			</td>
		</tr>
	</table>
</body>

</html>