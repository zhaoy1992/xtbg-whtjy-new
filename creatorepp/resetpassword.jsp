<%@ page contentType="text/html; charset=GBK"%>
<%@page import="java.sql.SQLException" %>
<%@page import="java.util.*" %>
<%@page import="com.chinacreator.security.authentication.EncrpyPwd" %>
<%@page import="com.frameworkset.common.poolman.PreparedDBUtil" %>
<%!
	/**
	 * 获取平台及应用所有用户密码重置sql语句
	 * @param egpDBName 平台数据源名称
	 * @return 重置sql语句列表
	 */
	public List getUpdateSql(String egpDBName) {
		PreparedDBUtil preDBUtil = new PreparedDBUtil();
		String sql = "select * from tb_application_info order by app_id";
		String app_id = "";
		Collection set = new HashSet();
		List updateSqlList = new ArrayList();
		// 首先得到平台用户更新sql
		getUpdateSql("", egpDBName, updateSqlList);
		try {
			preDBUtil.preparedSelect(egpDBName, sql);
			preDBUtil.executePrepared();
			if (null != preDBUtil) {
				for (int i = 0; i < preDBUtil.size(); i++) {
					app_id = preDBUtil.getString(i, "app_id");
					if (null != app_id && !app_id.trim().equals("")
							&& !app_id.trim().equalsIgnoreCase("module")
							&& set.add(app_id)) {
						// 分别获取各应用用户更新sql
						getUpdateSql("", egpDBName, updateSqlList);
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return updateSqlList;
	}
	/**
	 * 分别获取各应用用户更新sql
	 * @param app_id 应用ID
	 * @param updateSqlList 存入sql列表
	 */
	private void getUpdateSql(String app_id, String egpDBName,
			List updateSqlList) {
		if (null == app_id || app_id.trim().equals("")
				|| app_id.trim().equalsIgnoreCase("module")) {
			app_id = "";
		} else {
			app_id += ".";
		}
		PreparedDBUtil preDBUtil = new PreparedDBUtil();
		// 创建SQL语句
		String sql = "select user_id,user_password from " + app_id
				+ "td_sm_user";
		String userid = "";
		String old_password = "";
		String new_password = "";
		try {
			preDBUtil.preparedSelect(egpDBName, sql);
			preDBUtil.executePrepared();
			if (null != preDBUtil) {
				for (int i = 0; i < preDBUtil.size(); i++) {
					userid = preDBUtil.getString(i, "user_id");
					old_password = preDBUtil.getString(i, "user_password");
					new_password = EncrpyPwd.encodePassword(old_password);
					updateSqlList.add("update " + app_id
							+ "td_sm_user set user_password='" + new_password
							+ "' where user_id='" + userid+"'");
				}
			}
		} catch (SQLException e) {
			// 由于数据库中的应用可能由于人为原因而不存在，屏蔽报错信息。
			// e.printStackTrace();
		}
	}
%>
<%
	String isRes = request.getParameter("isRes");
	String mess = "false";
	if("true".equals(isRes)){
		String egpDBName = request.getParameter("egpDBName");
		if(null!=egpDBName&&!egpDBName.trim().equals("")){
			// 获取平台及应用所有用户密码重置sql语句列表
			List list = getUpdateSql(egpDBName.trim());
			// 执行sql语句
			PreparedDBUtil preDBUtil = new PreparedDBUtil();
			//System.out.println("平台数据源名称"+ss_EGPDBNAME);
			String sql = "";
			for (int i = 0; i < list.size(); i++) {
				sql = (String) list.get(i);
				try {
					//System.out.println(sql);
					preDBUtil.preparedSelect(egpDBName, sql);
					preDBUtil.executePrepared();
					mess = "true";
				} catch (SQLException e) {
					e.printStackTrace();
					mess = "false";
				}
			}
		}
	}
%>
<%
String ssss=EncrpyPwd.encodePassword("123456");
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/purviewmanager/css/windows.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/purviewmanager/css/treeview.css">
		<title>重置密码</title>
		<script language="javascript" type="text/javascript">
			function sub(){
				if(confirm("确认重置所有用户密码吗？")){
					document.myform.isRes.value="true";
					document.myform.update.disabled="true";
					document.myform.submit();
				}
			}
			if("true"=="<%=isRes%>"){
				if("true"=="<%=mess%>"){
					alert("成功重置所有用户密码！");
				}else{
					alert("重置所有用户密码错误！");
				}
			}
		</script>

	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body
		class="contentbodymargin" onload="" scroll="no">
		<div id="contentborder" align="center">
			<form method="post" name="myform" action="resetpassword.jsp">

				<br />
				<br />
				<fieldset style="width: 90%;">
					<LEGEND align=center>
						<FONT size="2">重置密码</FONT>
					</LEGEND>
					<br />
					<%=ssss %>
					<br />
					<FONT size="3" color="red">
						注：请确认数据库中密码为明文,重置后平台及相关应用下所有<br/>
							用户的密码将按配置文件中所配置的加密方式进行加密 !</FONT>
					<br /><br />
					平台数据源名称：<input type="text" name="egpDBName" value="bspf">
					<br />
				</fieldset>

				<table width="85%" border="0" align="center" cellpadding="0"
					cellspacing="0" class="table">
					<tr class="tr">
						<td class="td">
							<div align="center">
								<br />
								<input name="update" type="button" onclick="sub();"	class="input" value="重置密码">
								<input name="isRes" value="false" type="hidden"> 
							</div>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
