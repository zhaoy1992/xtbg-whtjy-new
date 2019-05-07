<%--
描述：电子考勤 打卡详情界面
作者：邱炼
版本：1.0
日期：2014-08-07
--%>
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.entity.ElectInfoBean"%>
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.dao.ElectInfoDao"%>
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.dao.imploracle.ElectInfoDaoImpl"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String actionName = request.getParameter("actionName");
	String elect_id = request.getParameter("elect_id");//主键ID
	ElectInfoDao electinfodao = new ElectInfoDaoImpl();
	ElectInfoBean electinfobean = electinfodao.findElectInfoBeanById(elect_id);
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>电子考勤查看详情</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 引入jQuery_dialog -->
<script src="../../../resources/plug/jquery_dialog/jquery_dialog.js"></script>
<!-- 引入公共JS -->
<!-- 引入formvValidatetion -->
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="UTF-8"></script>
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="UTF-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript">
jQuery(document).ready(function() {
	jQuery("#form1").validationEngine();
});

function closed(){
	removeWindows('',true);
}
	
</script>
<body style="overflow-y:hidden;">
	<form id="form1"  method="post"  >
		<div id="users-contain">
			<table  width="100%" border="0" cellspacing="0" cellpadding="0" >
					<tr>
						<th class="content_02_box_div_table_th" width="25%">姓名：</th>
						<td class="content_02_box_div_table_td" width="25%">
							<%=electinfobean.getUsername() %>
						</td>
						<td  class="content_02_box_div_table_th" width="25%">日期：</td>
						<td class="content_02_box_div_table_td" width="25%">
							<%=electinfobean.getDatetime() %>
						</td>
						
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th">上班的时间：</td>
						<td class="content_02_box_div_table_td">
							<%=electinfobean.getStart_time() %>
						</td>
								<td  class="content_02_box_div_table_th">上班打卡IP：</td>
						<td class="content_02_box_div_table_td">
							<%=electinfobean.getStart_ip() %>
						</td>
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th">下班的时间：</td>
						<td class="content_02_box_div_table_td">
							<%=electinfobean.getEnd_time() %>
						</td>
						<td  class="content_02_box_div_table_th">下班打卡IP：</td>
						<td class="content_02_box_div_table_td">
							<%=electinfobean.getEnd_ip() %>
						</td>
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th">考勤状态：</td>
						<td class="content_02_box_div_table_td" colspan="3">
							<%=electinfobean.getState() %>
						</td>
					</tr>
					<tr height="60px;">
						<td  class="content_02_box_div_table_th">出勤详细信息：</td>
						<td class="content_02_box_div_table_td" colspan="3">
							<%=electinfobean.getDetails() %>
						</td>
					</tr>
					
			</table>
		</div>
		
		<div class="cue_box_foot">
			<input class="but_y_01" type="button" value="返回" onclick="removeAlertWindows('',true)" />
		</div>
		
	</form>
	
	<iframe name="filetypeinfodoJSPhiddenFrame" width=0 height=0></iframe>
</body>
</html>