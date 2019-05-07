<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ page import="com.chinacreator.epp.datasourcemanage.DatasourceManage"%>
<%@page import="com.chinacreator.epp.datasourcemanage.Poolman"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String isEdit = request.getParameter("isEdit") != null ? request
			.getParameter("isEdit") : "false";
	String dbname = request.getParameter("Dbname") != null ? request
			.getParameter("Dbname") : "";
	String loadmetadata = request.getParameter("Loadmetadata") != null ? request
			.getParameter("Loadmetadata")
			: "";
	String jndiName = request.getParameter("JndiName") != null ? request
			.getParameter("JndiName")
			: "";
	String driver = request.getParameter("Driver") != null ? request
			.getParameter("Driver") : "";
	String url = request.getParameter("Url") != null ? request
			.getParameter("Url") : "";
	String username = request.getParameter("Username") != null ? request
			.getParameter("Username")
			: "";
	String password = request.getParameter("Password") != null ? request
			.getParameter("Password")
			: "";
	String txIsolationLevel = request.getParameter("TxIsolationLevel") != null ? request
			.getParameter("TxIsolationLevel")
			: "";
	String nativeResults = request.getParameter("NativeResults") != null ? request
			.getParameter("NativeResults")
			: "";
	String poolPreparedStatements = request
			.getParameter("PoolPreparedStatements") != null ? request
			.getParameter("PoolPreparedStatements") : "";
	String initialConnections = request
			.getParameter("InitialConnections") != null ? request
			.getParameter("InitialConnections") : "";
	String minimumSize = request.getParameter("MinimumSize") != null ? request
			.getParameter("MinimumSize")
			: "";
	String maximumSize = request.getParameter("MaximumSize") != null ? request
			.getParameter("MaximumSize")
			: "";
	String maximumSoft = request.getParameter("MaximumSoft") != null ? request
			.getParameter("MaximumSoft")
			: "";
	String maxWait = request.getParameter("MaxWait") != null ? request
			.getParameter("MaxWait") : "";
	String removeAbandoned = request.getParameter("RemoveAbandoned") != null ? request
			.getParameter("RemoveAbandoned")
			: "";
	String userTimeout = request.getParameter("UserTimeout") != null ? request
			.getParameter("UserTimeout")
			: "";
	String connectionTimeout = request
			.getParameter("ConnectionTimeout") != null ? request
			.getParameter("ConnectionTimeout") : "";
	String shrinkBy = request.getParameter("ShrinkBy") != null ? request
			.getParameter("ShrinkBy")
			: "";
	String keygenerate = request.getParameter("Keygenerate") != null ? request
			.getParameter("Keygenerate")
			: "";
	String interceptor = request.getParameter("Interceptor");
	
	String strDatabaseType = request.getParameter("databaseType");
	if((strDatabaseType == null) || (strDatabaseType.length() <= 0)) strDatabaseType = "oracle";
	//modify by wen.zhu 多数据源数据库支持
	//String strSqlTransition = request.getParameter("sqlTransition");
	//if((strSqlTransition == null) || (strSqlTransition.length() <= 0)) strSqlTransition = "false";
	String Interceptor	= request.getParameter("Interceptor");
	
	Poolman poolman = new Poolman();
	poolman.setDbname(dbname);
	poolman.setLoadmetadata(loadmetadata);
	poolman.setJndiName(jndiName);
	poolman.setDriver(driver);
	poolman.setUrl(url);
	poolman.setDatabasetype(strDatabaseType);
	//modify by wen.zhu 20100802
	//poolman.setIssqltransition(strSqlTransition);
	poolman.setInterceptor(Interceptor);
	poolman.setUsername(username);
	poolman.setPassword(password);
	poolman.setTxIsolationLevel(txIsolationLevel);
	poolman.setNativeResults(nativeResults);
	poolman.setPoolPreparedStatements(poolPreparedStatements);
	poolman.setInitialConnections(initialConnections);
	poolman.setMinimumSize(minimumSize);
	poolman.setMaximumSize(maximumSize);
	poolman.setMaximumSoft(maximumSoft);
	poolman.setMaxWait(maxWait);
	poolman.setRemoveAbandoned(removeAbandoned);
	poolman.setUserTimeout(userTimeout);
	poolman.setConnectionTimeout(connectionTimeout);
	poolman.setShrinkBy(shrinkBy);
	poolman.setKeygenerate(keygenerate);
	
	DatasourceManage dm = new DatasourceManage();
	boolean b = false;
	if (isEdit.equals("add")) {
		b = dm.addDatasource(poolman);
	} else if (isEdit.equals("modify")) {
		b = dm.setDatasource(poolman);
	} else if (isEdit.equals("test")) {
		b = dm.testConnection(poolman);
	}

	if (b) {
		out.print("<script type=\"text/javascript\">");
		if (isEdit.equals("add")) {
			out.print("alert('新增数据源成功!');");
			out.print("window.top.returnValue='true';");
			out.print("window.top.close();");
		} else if (isEdit.equals("modify")) {
			out.print("alert('修改数据源成功!请手动重启服务器以使该数据源生效！');");
			out.print("window.top.returnValue='true';");
			out.print("window.top.close();");
		} else if (isEdit.equals("test")) {
			out.print("alert('数据源连接成功！');");
			out.print("window.parent.returnDB();");
		} else {
			out.print("alert('数据源操作失败！');");
			out.print("window.parent.returnDB();");
		}		
		out.print("</script>");
	} else {
		out.print("<script type=\"text/javascript\">");
		if (isEdit.equals("add")) {
			out.print("alert('新增数据源失败!');");
		} else if (isEdit.equals("modify")) {
			out.print("alert('修改数据源失败!');");
		} else if (isEdit.equals("test")) {
			out.print("alert('数据源连接失败！');");
		} else {
			out.print("alert('数据源操作失败！');");
		}
		out.print("window.parent.returnDB();");
		out.print("</script>");
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>datasourceInfo_do</title>
		<script type="text/javascript"></script>
	</head>

	<body>
		This is my JSP page.
		<br>
	</body>
</html>
