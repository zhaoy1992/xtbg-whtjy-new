<%--
　　描述：数据库表管理页面
　　作者：黄海
　　版本：1.0
　　日期：2013-06-04
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<script type="text/javascript">
/*
	函数:  parent.openDbColumnsList
	说明:  dbtablelist.jsp子页面选中select框对应数据元表名后，联动dbcolumnslist.jsp相应列表查询方法。
	作者：  黄海
	日期：  2013-06-05
*/
function openDbColumnsList(url){
	$("#dbcolumnslist").attr("src",url);
}
/*
	函数:  openAfterTableUpdated
	说明:  调用子页面中的JS方法静态刷新jqGrid
	作者：  黄海
	日期： 2013-06-05
*/
function openAfterTableUpdated(url){
	dbcolumnslist.window.refreshGrid(); 
}
</script>
<meta>
<title>数据元表管理页面</title>
</head>
<body style="overflow-y: hidden;">
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td width="290px">
				<iframe id="dbtablelist"  src="dbtablelist.jsp" scrolling="no"  height="460" frameborder="0"></iframe>
			</td>
			<td  width="800px">
				<iframe id="dbcolumnslist" src="dbcolumnslist.jsp?table_id=&table_code=&flag=init"  width="100%"  height="460" frameborder="0"></iframe>
			</td>
		</tr>
	</table>
</body>
</html>