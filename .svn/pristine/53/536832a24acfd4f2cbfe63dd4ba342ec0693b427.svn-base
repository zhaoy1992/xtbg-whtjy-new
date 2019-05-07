<%
/*
 * <p>Title: 用户组信息</p>
 * <p>Description: 查看用户组信息</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-18
 * @author liangbing.tao
 * @version 1.0
 */
%>
<%     
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0); 
%>

<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.GroupManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.User"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Group"%>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%

	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkManagerAccess(request,response);

	String groupId = (String) request.getParameter("groupId");
	String subid=request.getParameter("subid");
	
	String groupName = "";
	String groupDesc = "";
	String userName="";
	String userRealName="";
	if(groupId != null && !groupId.equals(""))
	{
		//依据组ID获取当前所选组的基本信息
		GroupManager groupManager=SecurityDatabase.getGroupManager();
		UserManager userManager=SecurityDatabase.getUserManager();
		Group group=groupManager.getGroupByID(groupId);
		if(group != null)
		{
			groupName=group.getGroupName();
			groupDesc=group.getGroupDesc();	
			String groupOwnerId=String.valueOf(group.getOwner_id());
			User user=userManager.getUserById(groupOwnerId);
			userName=user.getUserName();
			userRealName=user.getUserRealname();
		}
	}
	else
	{
		groupId="";
	}
%>
<html>
	<head>
	<!--引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入formvValidatetion -->
<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" ></script>
<!--引入其他 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
		<script language="JavaScript">
		var subid='<%=subid%>'
		 function back()
		  {
			  closeAlertWindows(subid,true,false);
		  }
		</script>
	</head>
<body style="overflow-y: hidden;" onload="adaptationWH('_top','vcenter',40)">
	<%
		if(groupId.equals(""))
	{
	%>
	 <table>
		 <tr>
	 		<td class="detailtitle">请选择左边的组再进行操作</td>
	 	</tr> 
	 </table>
	<%
	}
	else
	{
	%>
	<form id="form1"  method="post">



<!-- 操作-->
<div class="content_02" style="overflow: hidden;" id="_top">
	<div class="content_02_top" style="margin-bottom: 10px;">
		<input name="" value="返回" onclick="back();" type="button" class="but_y_01" />
	</div>
</div>
<!-- 表格-->
<div id="vcenter" style="float: left; width: 100%; overflow: scroll" scrolling="no">
	<div style="float: left; width: 775px;">
	
		<div class="content_02_box">
			<div class="content_02_box_title_bg"><span>基本信息</span></div>
			<div class="content_02_box_div">
				<table border="0" cellspacing="0" cellpadding="0"
					class="content_02_box_div_table">
					<tr>
						<th class="content_02_box_div_table_th"><font style="COLOR: red">*</font>用户组名称</th>
						<td class="content_02_box_div_table_td">
							<input type="hidden" name="p_id" id="p_id"  value="" />
							<input  class="validate[required,maxSize[100]] input_188" name="group_name" id="group_name"  value="<%=groupName %>"  readonly/>
						</td>
					</tr>
					<tr>
						<th width="212" valign="top" class="content_02_box_div_table_02_th"><font style="COLOR: red">*</font>用户组描述</th>
						<td  class="content_02_box_div_table_02_td">
						<textarea class="validate[required,maxSize[100]] textarea_575" style="width:99%" name="group_desc" id="group_desc" readonly ><%=groupDesc %></textarea>
							
						</td>
					</tr>
					<tr>
					<th class="content_02_box_div_table_th">创建人信息：</th>
					<td class="content_02_box_div_table_td">
						<input name="creatorName" id="creatorName" class=" input_188" value="<%=userName%>【<%=userRealName%>】"  readonly/>
					</td>
				</tr>
				</table>
			</div>
		</div>
	</div>
</div>


</form>
	<%
	}
	%>	
	</body>
</html>