<%-- 
描述：档案程序界面基本信息
作者：肖杰
版本：1.0
日期：2013-07-10
 --%>
<%@page import="com.frameworkset.common.poolman.DBUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.OrgCache"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileProgramPageServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.file.service.FileProgramPageServiceIfc"%>
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
	UserCacheBean usercachebean= UserCache.getUserCacheBean(curUserId);
	String subid = request.getParameter("subid");
	String path = request.getContextPath();//服务器根路径
	String f_program_id = request.getParameter("f_program_id");
	String f_program_page="";
	String f_file_list="";
	String f_file_detail="";
	String f_files_list="";
	String f_files_detail="";
	String f_order="";
	String f_remark="";
	Map<String, String> viewMap = new HashMap<String, String>();
	FileProgramPageServiceIfc fileProgramPageServiceIfc = new FileProgramPageServiceImpl();
	if(!StringUtil.isBlank(f_program_id)){
		viewMap=fileProgramPageServiceIfc.getFileProgramPageBean(f_program_id);
		f_program_page = StringUtil.deNull(viewMap.get("f_program_page"));
		f_file_list = StringUtil.deNull(viewMap.get("f_file_list"));
		f_file_detail = StringUtil.deNull(viewMap.get("f_file_detail"));
		f_files_list = StringUtil.deNull(viewMap.get("f_files_list"));
		f_files_detail = StringUtil.deNull(viewMap.get("f_files_detail"));
		f_order = StringUtil.deNull(viewMap.get("f_order"));
		f_remark = StringUtil.deNull(viewMap.get("f_remark"));
	}
	

	
%>
<title>档案程序界面基本信息</title>
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

/*
函数:  addFileProgram
说明:  添加
参数:   无
返回值: 无
*/
var addFileProgram = function() {
	if(!jQuery('#form1').validationEngine('validate')){
		return;
	}
		
	jQuery("#action").val("addFileProgram");
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
	alert('确定添加吗？',p);

}
/*
函数:  updateFileProgram
说明:  修改
参数:   无
返回值: 无
*/
var updateFileProgram = function() {
	if(!jQuery('#form1').validationEngine('validate')){
		return;
	}
	jQuery("#action").val("updateFileProgram");
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
	alert('确定修改吗？',p);

}


/*
函数:  back
说明:  返回列表
参数:   无
返回值: 无
*/
function back(){
			removeWindows(subid,true);
}

</script>

</head>
<body style="overflow-y: hidden;" onload="adaptationWH('_top','vcenter',40)">
<form id="form1" action="fileprogramdo.jsp?subid=<%=subid %>" method="post">
<input type="hidden" name="action" id="action"   />

<!-- 操作-->
<div class="content_02" style="overflow: hidden;" id="_top">
	<div class="content_02_top" style="margin-bottom: 10px;">
		<% if(StringUtil.isBlank(f_program_id)){%>
		<input name="fbbt" id="fbbt" value="添加" onclick="addFileProgram();"  type="button" class="but_y_01" /> 
		<% }else{%>
		<input name="fbbt" id="fbbt" value="修改" onclick="updateFileProgram();"  type="button" class="but_y_01" />
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
						<th class="content_02_box_div_table_th"><font style="COLOR: red">*</font>程序界面名称：</th>
						<td class="content_02_box_div_table_td">
							<input type="hidden" name="f_program_id" id="f_program_id"  value="<%=f_program_id %>" />
							<input  class="validate[required,maxSize[200]] input_188" name="f_program_page" id="f_program_page"  onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" value="<%=f_program_page %>" />
						</td>
						<th class="content_02_box_div_table_th">排序号：</th>
						<td class="content_02_box_div_table_td" width="192px">
							<input  class="validate[custom[number]] input_188" name="f_order" id="f_order" value="<%=f_order %>" />
						</td>
					</tr>
					<tr id="sel">
						<th width="212" valign="top" class="content_02_box_div_table_02_th"><font style="COLOR: red">*</font>文档明细界面：</th>
						<td colspan="3" class="content_02_box_div_table_02_td">
							<select name="f_file_detail"  class="validate[required] select_188_box" id="f_file_detail" style="width: 188px;" onchange="" size="1">
		         		 <%
		                try {
		                    DBUtil dbUtil = new DBUtil();
		                    String sqlCondition = "";
		                    
		                    String hsql = "select dd.dictdata_name,dd.dictdata_value from oa_dict_data dd left join oa_dict_type dt on dd.dict_id=dt.dict_id where dict_code='wdmxjm'";
		                    dbUtil.executeSelect(hsql);
		                    String selected = "";
		                    for (int i = 0; i < dbUtil.size(); i++) {
		                        if (dbUtil.getString(i, "dictdata_value").equals(f_file_detail)){
		                            selected = "selected=\"selected\"";                            
		                    	}
		           		 %>
		            	<option value="<%=dbUtil.getString(i, "dictdata_value")%>" <%=selected%>><%=dbUtil.getString(i, "dictdata_name")%></option>
		         		<%
		                	selected = "";
		                  	}
		               		} catch (Exception e) {
		                   		 e.printStackTrace();
		               		}
		         		   %>
		        		</select>
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th"><font style="COLOR: red">*</font>文档列表界面：</th>
						<td colspan="3" class="content_02_box_div_table_td">
						<select name="f_file_list"  class="validate[required] select_188_box" id="f_file_list" style="width: 188px;" onchange="" size="1">
            				  <%
			                try {
			                    DBUtil dbUtil = new DBUtil();
			                    String sqlCondition = "";
			                    
			                    String hsql = "select dd.dictdata_name,dd.dictdata_value from oa_dict_data dd left join oa_dict_type dt on dd.dict_id=dt.dict_id where dict_code='filePageNo'";
			                    dbUtil.executeSelect(hsql);
			                    String selected ="";
			                    for (int i = 0; i < dbUtil.size(); i++) {
			                        if (dbUtil.getString(i, "dictdata_value").equals(f_file_list)){
			                            selected = "selected=\"selected\"";                            
			                    	}
			           		 %>
			            	<option value="<%=dbUtil.getString(i, "dictdata_value")%>"  <%=selected%>><%=dbUtil.getString(i, "dictdata_name")%></option>
			         		<%
			                	selected = "";
			                  	}
			               		} catch (Exception e) {
			                   		 e.printStackTrace();
			               		}
			         		   %>
            			</select></td>
					</tr>
					<tr id="sel">
						<th width="212" valign="top" class="content_02_box_div_table_02_th"><font style="COLOR: red">*</font>案卷明细界面：</th>
						<td colspan="3" class="content_02_box_div_table_02_td">
						<select name="f_files_detail"  class="validate[required] select_188_box" id="f_files_detail" style="width: 188px;" onchange="" size="1">
            			<%
			                try {
			                    DBUtil dbUtil = new DBUtil();
			                    String sqlCondition = "";
			                    
			                    String hsql = "select dd.dictdata_name,dd.dictdata_value from oa_dict_data dd left join oa_dict_type dt on dd.dict_id=dt.dict_id where dict_code='datjjm'";
			                    dbUtil.executeSelect(hsql);
			                    String selected ="";
			                    for (int i = 0; i < dbUtil.size(); i++) {
			                        if (dbUtil.getString(i, "dictdata_value").equals(f_files_detail)){
			                            selected = "selected=\"selected\"";                            
			                    	}
			           		 %>
			            	<option value="<%=dbUtil.getString(i, "dictdata_value")%>"  <%=selected%>><%=dbUtil.getString(i, "dictdata_name")%></option>
			         		<%
			                	selected = "";
			                  	}
			               		} catch (Exception e) {
			                   		 e.printStackTrace();
			               		}
			         		   %>
            			</select></td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th">案卷列表界面：</th>
						<td colspan="3" class="content_02_box_div_table_td">
						<select name="f_files_list"  class="validate[required] select_188_box" id="f_files_list" style="width: 188px;" onchange="" size="1">
            				  <%
			                try {
			                    DBUtil dbUtil = new DBUtil();
			                    String sqlCondition = "";
			                    
			                    String hsql = "select dd.dictdata_name,dd.dictdata_value from oa_dict_data dd left join oa_dict_type dt on dd.dict_id=dt.dict_id where dict_code='dacxjm'";
			                    dbUtil.executeSelect(hsql);
			                    String selected = "";
			                    for (int i = 0; i < dbUtil.size(); i++) {
			                        if (dbUtil.getString(i, "dictdata_value").equals(f_files_list)){
			                            selected = "selected=\"selected\"";                            
			                    	}
			           		 %>
			            	<option value="<%=dbUtil.getString(i, "dictdata_value")%>" <%=selected%>><%=dbUtil.getString(i, "dictdata_name")%></option>
			         		<%
			                	selected = "";
			                  	}
			               		} catch (Exception e) {
			                   		 e.printStackTrace();
			               		}
			         		   %>
            			</select></td>
					</tr>
					<tr id="sel">
						<th width="212" valign="top" class="content_02_box_div_table_02_th">备注：</th>
						<td colspan="3" class="content_02_box_div_table_02_td">
						<textarea class="validate[maxSize[1000]] textarea_575" style="width:99%" name="f_remark" id="f_remark" value="" ><%=f_remark %></textarea>
							
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