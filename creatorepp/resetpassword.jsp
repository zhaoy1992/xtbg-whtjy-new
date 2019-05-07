<%@ page contentType="text/html; charset=GBK"%>
<%@page import="java.sql.SQLException" %>
<%@page import="java.util.*" %>
<%@page import="com.chinacreator.security.authentication.EncrpyPwd" %>
<%@page import="com.frameworkset.common.poolman.PreparedDBUtil" %>
<%!
	/**
	 * ��ȡƽ̨��Ӧ�������û���������sql���
	 * @param egpDBName ƽ̨����Դ����
	 * @return ����sql����б�
	 */
	public List getUpdateSql(String egpDBName) {
		PreparedDBUtil preDBUtil = new PreparedDBUtil();
		String sql = "select * from tb_application_info order by app_id";
		String app_id = "";
		Collection set = new HashSet();
		List updateSqlList = new ArrayList();
		// ���ȵõ�ƽ̨�û�����sql
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
						// �ֱ��ȡ��Ӧ���û�����sql
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
	 * �ֱ��ȡ��Ӧ���û�����sql
	 * @param app_id Ӧ��ID
	 * @param updateSqlList ����sql�б�
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
		// ����SQL���
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
			// �������ݿ��е�Ӧ�ÿ���������Ϊԭ��������ڣ����α�����Ϣ��
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
			// ��ȡƽ̨��Ӧ�������û���������sql����б�
			List list = getUpdateSql(egpDBName.trim());
			// ִ��sql���
			PreparedDBUtil preDBUtil = new PreparedDBUtil();
			//System.out.println("ƽ̨����Դ����"+ss_EGPDBNAME);
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
		<title>��������</title>
		<script language="javascript" type="text/javascript">
			function sub(){
				if(confirm("ȷ�����������û�������")){
					document.myform.isRes.value="true";
					document.myform.update.disabled="true";
					document.myform.submit();
				}
			}
			if("true"=="<%=isRes%>"){
				if("true"=="<%=mess%>"){
					alert("�ɹ����������û����룡");
				}else{
					alert("���������û��������");
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
						<FONT size="2">��������</FONT>
					</LEGEND>
					<br />
					<%=ssss %>
					<br />
					<FONT size="3" color="red">
						ע����ȷ�����ݿ�������Ϊ����,���ú�ƽ̨�����Ӧ��������<br/>
							�û������뽫�������ļ��������õļ��ܷ�ʽ���м��� !</FONT>
					<br /><br />
					ƽ̨����Դ���ƣ�<input type="text" name="egpDBName" value="bspf">
					<br />
				</fieldset>

				<table width="85%" border="0" align="center" cellpadding="0"
					cellspacing="0" class="table">
					<tr class="tr">
						<td class="td">
							<div align="center">
								<br />
								<input name="update" type="button" onclick="sub();"	class="input" value="��������">
								<input name="isRes" value="false" type="hidden"> 
							</div>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
