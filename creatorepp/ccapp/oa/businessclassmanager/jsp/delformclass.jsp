<%@page import="com.chinacreator.xtbg.core.businessclassmanager.service.impl.FormClassServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.businessclassmanager.service.FormClassService"%>
<%@page import="org.apache.velocity.runtime.directive.Foreach"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.epp.datasourcemanage.DatasourceManage"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
	String path = request.getContextPath();
	String action=StringUtil.deNull(request.getParameter("action"));
	String ec_id=StringUtil.deNull(request.getParameter("ec_id"));
	boolean b=false;
	FormClassService service=new FormClassServiceImpl();
	List<String> dblist=new ArrayList<String>();
	boolean flag=service.isExistSonByUpId(ec_id);
	if(!flag){
		if("delformclass".equals(action)){
			b=service.delFormClass(ec_id);
		}
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
		var action = "<%=action%>";
		if(!<%=flag%>){
			if(<%=b%>){
				alert('业务类型删除成功！');
				window.parent.parent.location.reload();
			}else{
				alert('业务类型删除失败！');
			}
		}else{
			alert("业务类别下有子类，请先删除子类！");
		}
		</script>
</head>
<body>

</body>
</html>