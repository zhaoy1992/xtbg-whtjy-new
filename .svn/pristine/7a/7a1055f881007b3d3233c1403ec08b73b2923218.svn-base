<%@page import="com.chinacreator.business.common.tools.CacheCommonManageProxy"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	String action_form = request.getParameter("action_form");
	String ins_id= request.getParameter("ins_id");
	String busi_id = request.getParameter("busi_id");
	String list_type = request.getParameter("list_type");
	String operType = request.getParameter("operType");
	String act_name = request.getParameter("act_name");
	String reissue = request.getParameter("reissue");
	String path = request.getContextPath();
	String fromPage = "tabs-3";
	//状态标志位，3为由管理处统计进入,2为窗口人员请假统计进入
	String qingjiaStatus = request.getParameter("qingjiaStatus");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript"
	src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-remote.1.1.js"></script>
<script type="text/javascript" src="../../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<title>Insert title here</title>
</head>
<script type="text/javascript">
var list_type ='<%=list_type%>';
var fromPage = '<%=fromPage%>';
var qingjiaStatus = '<%=qingjiaStatus%>';
function backto(){
	//alert('关闭该页,未保存的信息将会丢失 '+'<br>'+'确定关闭？',p);
	
	//var okF = function(){
			if(list_type =="situation"){
				window.location.href="situationFind.jsp";
			}else if(list_type == "sub_main_updatedocumentfile"){
				window.location.href="../../../yimingju/documentfile/jsp/doc_fileview.jsp";
			}else if(list_type == "sub_main_circularize"){
				window.location.href="../../../huaihua/circularize/circularizelist.jsp";
			}else if(list_type == "tianshanglailist"){
				window.location.href="../../../suxian/sxsfw/jsp/sendDocumentworklist.jsp";
			}else if(list_type == "getfile"){
				window.location.href="mainwork.jsp?index=5";
			}else if(list_type == "getfileReceive"){
				window.location.href="../../../suxian/sxsfw/jsp/receiveWorklist.jsp";
			}else if(list_type == "Archived"){
				window.location.href="../../../suxian/sxsfw/jsp/sendArchivedList.jsp";
			}else if(list_type =="elect"){
				removeWindows("main_todowork1");
			}else if(list_type =="gongwen"){
				window.location.href="mainwork.jsp?index=3";
			}
			else{
				window.location.href="../../../chenzhou/leaveManage/jsp/leaveMain.jsp?pagefrom=" + fromPage;
			}
		if(qingjiaStatus == "2"){
			
			window.location.href="../../../chenzhou/leaveManage/jsp/showCKRYList.jsp";
		}
		
		if(qingjiaStatus == "3"){
			window.location.href="../../../chenzhou/leaveManage/jsp/showGLCList.jsp";
		
		}
}

</script>
<body>
<div style="height: 100%;overflow-x: hidden;">
<div style="height: 5%">
		<div class="content_02_top" style="margin-bottom: 5px;" id="top">
			<input name="" value="返回" type="button" class="but_y_01" id="back"
				onclick="backto(); " />
			<%if(CacheCommonManageProxy.getBooleanSystemParam("fileview_printView")){//打印功能%>
				<input name="" value="打印" type="button" class="but_y_01" id="print" onclick="subFrame.prn1_preview(); " />
			<%} %>
		</div>
		<div style="height: 500px">
		<IFRAME style="WIDTH: 100%;height: 800px;" id="subFrame" name="subFrame" src="<%=path + action_form%>?ins_id=<%=ins_id%>&busi_id=<%=busi_id%>&list_type=<%=list_type %>&operType=<%=operType %>&act_name=<%=act_name %>&reissue=<%=reissue %>" frameborder="0" scrolling="no"></IFRAME>
		</div>
	</div>
	</div>
</body>
</html>