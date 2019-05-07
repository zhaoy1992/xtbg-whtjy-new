<%--
　　描述：数据元表维护页面
　　作者：黄海
　　版本：1.0
　　日期：2013-06-05
--%>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.core.dssave.entity.MdTableBean"%>
<%@page import="com.chinacreator.xtbg.core.process.dbmanager.service.MdServiceIfc" %>
<%@page import="com.chinacreator.xtbg.core.process.dbmanager.service.impl.MdServiceImpl" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
%>
<meta>
<title>数据表列表</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script src="../../../resources/util/public.js" type="text/javascript"></script>
<script>
/*
	函数:  add
	说明:  弹出新增表界面
	作者：  黄海
	日期： 2013-06-05
*/
function add(){
	var url = getCurrentFilePath()+"createtableform.jsp";
	openAlertWindows('windowId',url,'新增表及字段','810','500','20%');
}
/*
函数:  update
说明:  弹出修改表界面
作者：  肖杰
日期： 2013-11-27
*/
function update(){
	if($("#table_id option:selected").length==1){
		var table_id = "";
		var table_code = "";
		$("#table_id option:selected").each(function() {
			table_id = $(this).val();
			table_code = delTableName($(this).text());
	    });
		var url = getCurrentFilePath()+"updatetableform.jsp?table_id="+table_id;
		openAlertWindows('windowId',url,'修改','810','500','20%');
	}else{
		alert("注意：一次编辑一张表");
		return;
	}
}
	/*
	函数:  copy
	说明:  弹出复制表界面
	作者：  肖杰
	日期： 2013-11-29
	*/
	function copytable(){
		if($("#table_id option:selected").length==1){
			var table_id = "";
			var table_code = "";
			$("#table_id option:selected").each(function() {
				table_id = $(this).val();
				table_code = delTableName($(this).text());
		    });
			var url = getCurrentFilePath()+"createtableform.jsp?table_id="+table_id;
			openAlertWindows('windowId',url,'修改','810','500','20%');
		}else{
			alert("注意：一次编辑一张表");
			return;
		}
	}
/*
	函数:  del
	说明:  执行表的删除操作
	作者：  黄海
	日期： 2013-06-05
*/
function del(){
	if($("#table_id option:selected").length==1){
		var table_id = "";
		var table_code = "";
		$("#table_id option:selected").each(function() {
			table_id = $(this).val();
			table_code = delTableName($(this).text());
	    });
		if(table_id=='5'){
			alert("这种有数据的表不能删！稍后代码会在查询数据库作判断,这里暂时不能删除！");
			return;
		}
		var okF = function(){
			var url = "deletemdtables.jsp";
			$("#md_table_id").val(table_id);
			$("#table_code").val(table_code);
			document.all.form1.action = url;
			document.all.form1.target = "hiddenFrame4table";
			document.all.form1.submit();
		}
		var p={
				headerText:'提示',
				okName:'确认',
		        okFunction:okF,
		        cancelName:'取消'
		};
		alert("将物理删除用户表，确定要删除吗？",p);
	}else{
		alert("注意：一次删除一张表");
		return;
	}
}
/*
	函数:  add
	说明:  弹出设置主键界面
	作者：  黄海
	日期： 2013-06-05
*/
function setpk(){
}
function delTableName(str){
	return str.substring(0,str.indexOf("["));
}
/*
	函数:  openParentFunc
	说明:  onchange事件触发调用父页面opendbcolumnslist方法
	作者：  黄海
	日期： 2013-06-05
*/
function openParentFunc(){
	if($("#table_id option:selected").length==1){
		var table_id = "";
		var table_code = "";
		$("#table_id option:selected").each(function() {
			table_id = $(this).val();
			table_code = delTableName($(this).text());
	    });
		parent.openDbColumnsList("dbcolumnslist.jsp?table_code="+table_code+"&table_id=" + table_id);
	}else{
		alert("注意：一次编辑一张表");
		return;
	}
}
/*
	函数:  openAfterTableUpdated
	说明:  删除表之后调用父页面openAfterTableUpdated方法
	作者：  黄海
	日期： 2013-06-05
*/
function openAfterTableUpdated(){
	parent.openAfterTableUpdated();
}
</script>
</head>
<body>
	<table  style="width:290px;">
	        <tr>
	            <td style="height:30px;width:290px;"  >
	                <div >
	                    <input id="add" class="but_y_01" onclick="add()" value="新建表" type="button"/>
	                    <input id="del" class="but_y_01" onclick="del()" value="删除表" type="button"/>
	                    <input id="update" class="but_y_01" onclick="update()" value="修改表" type="button"/>
	                    <input id="copy11" class="but_y_01" onclick="copytable()" value="复制表" type="button"/>
	                    <!-- <input id="del" class="but_y_01" onclick="openAfterTableUpdated()" value="设置主键"type="button"/> -->
	                </div>
	            </td>
	        </tr>
	</table>
	<table  width="290px">
		<tr>
			<td style="width:290px;" >
				<select multiple="multiple" id="table_id" onchange="openParentFunc()"  style="height:395px;width:290px;font-size: 12pt;letter-spacing: 20">
					<% 
					MdServiceIfc service = new MdServiceImpl();
					MdTableBean mdTableBean = new MdTableBean();
					List<MdTableBean> list = service.findMdTableList(mdTableBean);
					for (MdTableBean model : list) {
					%>
						<option value ="<%=model.getTable_id() %>" title="<%=(model.getTable_code()+"[ "+model.getTable_name()+" ]")%>" style="line-height: 50px"  ><%=(model.getTable_code()+"[ "+model.getTable_name()+" ]")%></option>
					<%
					}
					%>
				</select>
			</td>
		</tr>
	</table>
	<form id="form1" name="form1" method="post" >
		<input id="md_table_id" name="md_table_id" type="hidden"></input>
		<input id="table_code" name="table_code" type="hidden"></input>
	</form>
	<iframe name="hiddenFrame4table" width="0" height="0"></iframe>
</body>
</html>