<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.businessclassmanager.service.impl.FormClassServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.businessclassmanager.service.FormClassService"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	String path=control.getContextPath();
	String ec_id = StringUtil.deNull(request.getParameter("ec_id"));
	
	FormClassService formClassManager = new FormClassServiceImpl();
	Map<String,String> formClass = new HashMap<String,String>();
	if(!StringUtil.isBlank(ec_id)){
   		formClass = formClassManager.getFormClassByClassId(ec_id);
	}
	String ec_upName ="";
	if(!"0".equals(formClass.get("ec_upid"))){
		ec_upName = formClassManager.getFormClassByClassId(formClass.get("ec_upid")).get("ec_name");
	}else{
	    ec_upName = "业务类别";
	}
%>
<html>
	<head>
		<title>属性容器</title>
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
		openAlertWindows('add','<%=path%>/ccapp/oa/businessclassmanager/jsp/addformclass.jsp?action=add&subid=add&ec_id=<%=formClass.get("ec_id")%>','新增',800,300,'5%','5%');
	}
	
	function editFormClass(){	
		openAlertWindows('edit','<%=path%>/ccapp/oa/businessclassmanager/jsp/addformclass.jsp?action=edit&subid=edit&ec_id=<%=formClass.get("ec_id")%>','修改',800,300,'5%','5%');
	}
	
	function deleteFormClass()
	{
		var url="delformclass.jsp";
		var okF = function(){
			jQuery("#form1").attr("action",url);
			jQuery("#action").val("delformclass");
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
</script>
	</head>
	<body class="contentbodymargin" scroll="no">
	  <div id="vcenter" style="float:left;width:100%;overflow:hidden;margin-top: -10px">
	<div class="content_02_box" >
	 <div class="content_02_box_title_bg"><span>业务类别操作</span></div>
	</div>
	<div class="content_02_box" >
  		<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="content_02_box_div_table">
      		<tr>
      		    <td  colspan="2" class="content_02_box_div_table_td" style="float: none;text-align: center;"  align="center">
				<div class="content_02_box_title_bg" style="float: none;text-align: center;"><span style="float: none;text-align: center;">业务类别信息</span></div>
				</td>
			</tr>
				<tr >
							<th class="content_02_box_div_table_th" style="float: none;text-align: right;">
								类别ID
							</th>
							<td class="content_02_box_div_table_td">
							<%=formClass.get("ec_id")%>
							</td>
						</tr>
						<tr>
							<th  class="content_02_box_div_table_th" >
								类别名称
							</th>
							<td class="content_02_box_div_table_td" align=center>
							    <%=formClass.get("ec_name")%>
							</td>
						</tr>
						<tr>
							<th  class="content_02_box_div_table_th" >
								父类别名称
							</th>
							<td class="content_02_box_div_table_td" >
							    <%=ec_upName%>
							</td>
						</tr>
						<tr>
							<th  class="content_02_box_div_table_th" s>
								类别说明
							</th>
							<td  class="content_02_box_div_table_td">
								<%=formClass.get("remark")%>
							</td>
						</tr>
						<tr>
							<th height='30' class="content_02_box_div_table_th" >
								排序编号
							</th>
							<td class="content_02_box_div_table_td" >
							    <%=formClass.get("ec_sn")%>
							</td>
						</tr>
			
      		<tr height="30">
				<td align='right' colspan="2" class="content_02_box_div_table_td">
								<input name="submit" type="button" class="but_y_01" value="删除" onClick="deleteFormClass()" style="float: right;" />
								<%if (control.checkPermission(AccessControl.BIZ_TYPE_RESOURCE,
								AccessControl.UPDATE_BIZTYPE_GLOBAL_PERMISSION,
								AccessControl.BIZ_TYPE_RESOURCE)) { %>
								<input name="xiugai" type="button" class="but_y_01" value="修改" onClick="editFormClass()" style="float: right;" />
								<%} %>
					<%if (control.checkPermission(AccessControl.BIZ_TYPE_RESOURCE,
								AccessControl.NEW_BIZTYPE_GLOBAL_PERMISSION,
								AccessControl.BIZ_TYPE_RESOURCE)) { %>
								<input name="xinzeng" type="button" class="but_y_03" value="新增子类别" onClick="createFormClass()" style="float: right;" />
								<%} %>
																						
				</td>
			</tr>
   	 	</table>
 
  </div>
  <form name="form1" id="form1" action="" method="post">
	<input type="hidden" name="ec_id" id="ec_id" value="<%=formClass.get("ec_id")%>"  />
	<input type="hidden" name="action" id="action" value=""  />
	</form>
	<iframe name="hiddenFrame" width="0" height="0"></iframe>
</div>
	</body>
</html>