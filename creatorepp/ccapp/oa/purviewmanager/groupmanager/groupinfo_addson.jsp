<%
/*
 * <p>Title: 增加子用户组</p>
 * <p>Description: 增加子用户组</p>
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
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.GroupManager"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Group"%>

<%

	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkManagerAccess(request,response);
		
	String groupId = (String) request.getParameter("groupId");
	String subid=request.getParameter("subid");
	GroupManager groupManager=SecurityDatabase.getGroupManager();
	Group group=groupManager.getGroupByID(groupId);
	String groupName=group.getGroupName();
	if(groupId == null)
	{
		groupId = "";
	}
	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>【<%=groupName%>】用户组新增子组</title>
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
		<script language="javascript">	 		    
        var subid= '<%=subid%>'
		  //保存用户组
		  function saveGroup() 
		  {
			  if(!jQuery('#form1').validationEngine('validate')){
					return;
				}
					
				jQuery("#action").val("addson");
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
		  
		  function back()
		  {
			  closeAlertWindows(subid,true,false);
		  }
		</script>
	</head>
	<body style="overflow-y: hidden;" onload="adaptationWH('_top','vcenter',40)">
<form id="form1" action="submitgroup.jsp?son=1&flag=1&subid=<%=subid %>" method="post">
<input type="hidden" name="action" id="action"   />
<input type="hidden" name="parent_id" value="<%=groupId%>" />


<!-- 操作-->
<div class="content_02" style="overflow: hidden;" id="_top">
	<div class="content_02_top" style="margin-bottom: 10px;">
		<input name="fbbt" id="fbbt" value="保存" onclick="saveGroup();"  type="button" class="but_y_01" /> 
		<input name="" value="返回" onclick="back()" type="button" class="but_y_01" />
	</div>
</div>
<!-- 表格-->
<div id="vcenter" style="float: left; width: 100%; overflow: scroll" scrolling="yes">
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
							<input  class="validate[required,maxSize[100]] input_188" name="group_name" id="group_name"  value="" />
						</td>
					</tr>
					<tr>
						<th width="212" valign="top" class="content_02_box_div_table_02_th"><font style="COLOR: red">*</font>用户组描述</th>
						<td colspan="3" class="content_02_box_div_table_02_td">
						<textarea class="validate[required,maxSize[100]] textarea_575" style="width:99%" name="group_desc" id="group_desc"  ></textarea>
							
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