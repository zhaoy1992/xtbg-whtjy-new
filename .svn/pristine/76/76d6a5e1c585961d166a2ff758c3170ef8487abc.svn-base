<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.core.businessclassmanager.service.impl.FormClassServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.businessclassmanager.service.FormClassService"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%
AccessControl control = AccessControl.getInstance();
control.checkAccess(request, response);
String path=control.getContextPath();
String app_id = control.getCurrentSystemID();
FormClassService service = new FormClassServiceImpl();
List<Map<String,String>> list = service.getEformClassList(app_id,"0");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head> 
    <title></title>
    <!-- 引入jQuery -->
	<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript">jQuery.noConflict();</script>
    <!-- 引入其它 -->
	<script type="text/javascript" src="../../resources/util/public.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
    <script language="JavaScript">		
	function createFormClass()
	{
		openAlertWindows('add','<%=path%>/ccapp/oa/businessclassmanager/jsp/addformclass.jsp?subid=add&ec_id=0','新增',800,300,'5%','5%');
	}
	
	</script> 
  </head>
  <body>
  <div id="vcenter" style="float:left;width:100%;overflow:hidden;margin-top: -10px">
  <form name="ApplyForm" action="" method="post">		
  	<div class="content_02_box" >
	 <div class="content_02_box_title_bg"><span>业务类别操作</span></div>
	</div>
	<div class="content_02_box" >
  		<table width="100%" border="0" cellpadding="0" cellspacing="1"
					class="content_02_box_div_table">
      		<tr>
      		    <td height='30' class="content_02_box_div_table_td" style="float: none;text-align: center;"  align="center">
				    <b>业务类别信息</b>
				</td>
			</tr>
			<%if(list!=null && list.size()>0){ %>
			<tr>				 
				<td height='30' class="content_02_box_div_table_td" style="float: none;text-align: center;" align="center">
					请选择左边的业务类别查看详细信息			
				</td>
			</tr>
			<%}else{ %>
			<tr>				 
				<td height='30' class="content_02_box_div_table_td" style="float: none;text-align: center;"  align=center>
					当前还没有建立类别			
				</td>
			</tr>
			<%} %>
			<%if (control.checkPermission(AccessControl.BIZ_TYPE_RESOURCE,
								AccessControl.NEW_BIZTYPE_GLOBAL_PERMISSION,
								AccessControl.BIZ_TYPE_RESOURCE)) { %>
      		<tr height="30">
				<td align='right' class="content_02_box_div_table_td">
					<input name="xinzeng" type="button" class="but_y_03" value="新增一级类别" onClick="createFormClass()" style="float: right;" />															
				</td>
			</tr>
			<%} %>
   	 	</table>
 
  </div>
  </form>
  </div>
  </body>
</html>
