<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.businessclassmanager.service.impl.FormClassServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.businessclassmanager.service.FormClassService"%>
<%@page import="com.chinacreator.xtbg.core.businessclassmanager.entity.FormClass"%>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.util.List"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/tabpane-taglib.tld" prefix="tab"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.RoleTypeManager"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	
	boolean isEdit = false;
	if(request.getParameter("action")!=null&&request.getParameter("action").equals("edit")){
	    isEdit = true;
	}else{
	    isEdit = false;  
	}
	String subid=StringUtil.deNull(request.getParameter("subid"));
	Map<String,String> formClass = new HashMap<String,String>();
	String ec_id=request.getParameter("ec_id");  //编辑时作为当前分类id
	String ec_upid = "";
	int ec_sn = 0;
	FormClassService service = new FormClassServiceImpl();
	if(isEdit){
		formClass = service.getFormClassByClassId(ec_id);
	}else{
		formClass.put("ec_id",ec_id);
		String appId = (String)request.getSession().getAttribute("subsystem_id");
		ec_sn = service.getMaxEc_SnByAppId(appId)+1;
		formClass.put("ec_sn",ec_sn+"");
	}
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title><%if(isEdit){ %>
		              修改业务类别
		       <%}else{%>
		              新增业务类别
		       <%} %>
		</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js" charset="utf-8"></script>

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
		<SCRIPT LANGUAGE="JavaScript"> 			
			function saveFormClass() {
				if(jQuery("#formClassForm").validationEngine("validate")){
					if(validateFormValue()){
						var url="";
						if(<%=isEdit%>){
							url="addformclass_do.jsp?isEdit=true&subid=<%=subid%>";
						}else{
							url="addformclass_do.jsp?subid=<%=subid%>";
						}
						document.all.formClassForm.target = "hiddenFrame";
						jQuery("#formClassForm").attr("action",url);
						jQuery("#formClassForm").submit();
					}
				}
			}
			
			function validateFormValue() {
				if(jQuery("#ec_name").val().search(/[\\\/\|:\*\?<>"']/g)!=-1){
					alert("分类名称不能有\\/|:*?<>\"'!等特殊字符");
					return false;
				}	
				
				return true;
			}
			function back(){
				closeAlertWindows('<%=subid%>',false,true);
			}
			jQuery(function() {
				jQuery("#ec_name").focus();
				
			});
			
</SCRIPT>
	</head>
	<body class="contentbodymargin" onload="" scroll="no">
		<div id="contentborder" align="center">
			<form method="post" name="formClassForm" id="formClassForm" action="addFormClass_do.jsp">
			<input type="hidden" name="ec_id" id="ec_id"  value="<%=StringUtil.deNull(formClass.get("ec_id"))%>"/>
			<input type="hidden" name="ec_upid" id="ec_upid" value="<%=StringUtil.deNull(formClass.get("ec_upid"))%>"/>
			<div class="content_02_box" >
			<div class="content_02_top">								
							<input name="update" type="button" onClick="saveFormClass()" class="but_y_01" value="保存">
							<input name="calc" type="reset" class="but_y_01" value="重置">
							<input name="calc" type="button" class="but_y_01" value="返回" onClick="back()">
					    </div>
         <div class="content_02_box_title_bg"><span>基本信息</span></div>
         <div class="content_02_box_div">
				<table width="100%" height="25" border="0" cellpadding="0" cellspacing="1" class="content_02_box_div_table_02">
					<tr class="tr">
						<td class="content_02_box_div_table_th" >分类名称<font color="red">*</font>：</td>
						<td class="content_02_box_div_table_td">
							<input type=text name="ec_name" id="ec_name" class="validate[required] input_title_text" value="<%=StringUtil.deNull(formClass.get("ec_name"))%>"/>
						</td>
					</tr>
					<tr class="tr">
						<td class="content_02_box_div_table_th">排序编号<font color="red">*</font>：</td>
						<td class="content_02_box_div_table_td">
							<input type=text name="ec_sn" id="ec_sn" class="validate[required,custom[number]] input_title_text" value="<%=StringUtil.deNull(formClass.get("ec_sn"))%>"/>
						</td>
					</tr>						
					<tr class="tr">
						<td class="content_02_box_div_table_th">分类描述<font color="red">*</font>：</td>
						<td class="content_02_box_div_table_td">
							<textarea name="remark"  id="remark" class="validate[required,maxSize[250]] textarea_575"><%=StringUtil.deNull(formClass.get("remark"))%></textarea>
						</td>
					</tr>
			</table>
			  </div>
			  </div>
			</form>
		</div>
	</body>
	<iframe name="hiddenFrame" width="0" height="0"></iframe>
</html>