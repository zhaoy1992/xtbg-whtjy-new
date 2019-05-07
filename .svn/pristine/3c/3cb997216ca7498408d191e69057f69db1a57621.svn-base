<%@page import="org.apache.velocity.runtime.directive.Foreach"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.epp.datasourcemanage.DatasourceManage"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
	String path = request.getContextPath();
	String isEdit=StringUtil.deNull(request.getParameter("isEdit"));
	String ids=StringUtil.deNull(request.getParameter("ids"));
	boolean b=false;
	DatasourceManage dsm=new DatasourceManage();
	List<String> dblist=new ArrayList<String>();
	if(!StringUtil.isBlank(ids)){
		String id[]=ids.split(",");
		for(int i=0;i<id.length;i++){
			dblist.add(id[i]);
		}
	}
	if("del".equals(isEdit)){
		b=dsm.clearDatasource(dblist);
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
	<script type="text/javascript">
		var mes = "";
		var bool = true;
		var action = "<%=isEdit%>";
		if(<%=b%>){
			alert('数据源删除成功！');
			window.parent.location.reload();
		}else{
			alert('数据源删除失败！');
		}
		</script>
</head>
<body>

</body>
</html>