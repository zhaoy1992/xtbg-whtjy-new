<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.sql.*"%>

<html>
<head>
	<title>�û���Ϣ</title>
		<link rel="stylesheet" type="text/css" href="../../../css/windows.css">
	<link rel="stylesheet" type="text/css" href="../../../css/treeview.css">
<SCRIPT language=javascript>
function printpr() //Ԥ������
{
document.all("qingkongyema").click();//��ӡ֮ǰȥ��ҳü��ҳ��
document.all("dayinDiv").style.display="none"; //��ӡ֮ǰ�����ز����ӡ�����Ԫ�أ����������ء���ӡ���͡���ӡԤ����������ť��
var OLECMDID = 7;
var PROMPT = 1;
var WebBrowser = '<OBJECT ID="WebBrowser1" WIDTH=0 HEIGHT=0 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>';
document.body.insertAdjacentHTML('beforeEnd', WebBrowser);
WebBrowser1.ExecWB(OLECMDID, PROMPT);
WebBrowser1.outerHTML = "";
document.all("dayinDiv").style.display="";//��ӡ֮�󽫸�Ԫ����ʾ��������ʾ������ӡ���͡���ӡԤ����������ť����������´δ�ӡ��
}

function printTure() //��ӡ����
{
 document.all('qingkongyema').click();//ͬ��
 document.all("dayinDiv").style.display="none";//ͬ��
 window.print();
 document.all("dayinDiv").style.display="";
}
function doPage()
{
 layLoading.style.display = "none";//ͬ��
}

</SCRIPT>

<script language="VBScript">
dim hkey_root,hkey_path,hkey_key
hkey_root="HKEY_CURRENT_USER"
hkey_path="\Software\Microsoft\Internet Explorer\PageSetup"
'//������ҳ��ӡ��ҳüҳ��Ϊ��
function pagesetup_null()
on error resume next
Set RegWsh = CreateObject("WScript.Shell")
hkey_key="\header"
RegWsh.RegWrite hkey_root+hkey_path+hkey_key,""
hkey_key="\footer"
RegWsh.RegWrite hkey_root+hkey_path+hkey_key,""
end function
'//������ҳ��ӡ��ҳüҳ��ΪĬ��ֵ
function pagesetup_default()
on error resume next
Set RegWsh = CreateObject("WScript.Shell")
hkey_key="\header"
RegWsh.RegWrite hkey_root+hkey_path+hkey_key,"&w&bҳ�룬&p/&P"
hkey_key="\footer"
RegWsh.RegWrite hkey_root+hkey_path+hkey_key,"&u&b&d"
end function
</script>

<style type="text/css" media="screen">
<!-- /* PR-CSS */
table {
border-collapse:collapse; /* �ؼ����ԣ��ϲ��������߿�(��ʵ���߿���2px������1px�����滹��1pxŶ) */
border:solid #999; /* ���ñ߿����ԣ���ʽ(solid=ʵ��)����ɫ(#999=��) */
border-width:1px 0 0 1px; /* ���ñ߿�״��ϸ���� �� �� �� = ��Ӧ��1px 0 0 1px */
}
table caption {font-size:14px;font-weight:bolder;}
table th,table td {border:solid #999;border-width:0 1px 1px 0;padding:2px;}
tfoot td {text-align:center;}
-->
</style>
</head>
<%@ include file="/epp/css/cssControl.jsp"%>
<body>
<hr>
<DIV align="right" id="dayinDiv" name="dayinDiv">
			<input type="button" class="input" value="��ӡ" onclick="printTure();">
			&nbsp;&nbsp;
			<input type="hidden" class="tab" value="��ӡԤ��" onclick="printpr();">
			<input type="hidden" name="qingkongyema" id="qingkongyema"
				class="tab" value="���ҳ��" onclick="pagesetup_null()">
			&nbsp;&nbsp;
			<input type="hidden" class="tab" value="�ָ�ҳ��"
				onclick="pagesetup_default()">
		</DIV>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String curUserId = accesscontroler.getUserID();
	String userName = request.getParameter("userName");
	String userRealname = request.getParameter("userRealname");
	String userOrgType = request.getParameter("userOrgType");

	StringBuffer sb_user = new StringBuffer();//������ѯ
	StringBuffer sql = null;

	if(userName != null && userName.length()>0)
	{
		sb_user.append(" and t.user_name like '%" + userName.trim()+ "%' ");
	}

	if(userRealname != null && userRealname.length()>0)
	{
		sb_user.append(" and t.user_realname like '%" + userRealname.trim()+ "%'");
	}

	if(userOrgType.equalsIgnoreCase("hasMainOrg"))
	{
		sql = new StringBuffer()
			.append(" select bb.same_job_user_sn,getUserorgjobinfos(t.user_id || '') as org_job,  ")
			.append(" t.*, a.org_id,a.org_sn from  ")
			.append(" (select rownum as num,org_sn, a.org_id  from td_sm_organization a start with a.parent_id= '0'  ")
			.append(" connect by prior a.org_id = a.parent_id order siblings by a.org_sn) a, ")
			.append(" ( select min(tmp.same_job_user_sn) as same_job_user_sn,tmp.org_id,tmp.user_id from (  ")
			.append(" (select  ujo.* from td_sm_userjoborg ujo,TD_SM_ORGUSER ou where ")
			.append(" ou.org_id=ujo.org_id  and ou.user_id=ujo.user_id  ) ")
			.append(" )tmp group by  tmp.user_id ,tmp.org_id   ")
			.append("  ) bb, ")
			.append(" td_sm_user t  ")
			.append(" where a.org_id=bb.org_id ");

			if(!accesscontroler.isAdmin())
			{//�����û���ѯ�������û��ɹ���Ļ�����������
				sql.append(" and a.org_id in(select distinct org.org_id from td_sm_organization org ")
					.append(" start with org.org_id in(select o.org_id from td_sm_organization o, td_sm_orgmanager om ")
					.append(" where o.org_id = om.org_id  and om.user_id = '").append(curUserId).append("') ")
					.append("connect by prior org.org_id = org.parent_id)");
			}
			sql.append(sb_user.toString())
				.append(" and bb.user_id=t.user_id  ")
				.append(" order by a.num,bb.same_job_user_sn,t.user_id ");
	}
	else if(userOrgType.equalsIgnoreCase("noMainOrg"))
	{
		//û��������
			sql = new StringBuffer()
				.append(" select bb.same_job_user_sn,getUserorgjobinfos(t.user_id || '') as org_job,  ")
				.append(" t.*, a.org_id,a.org_sn from  ")
				.append(" (select rownum as num,org_sn, a.org_id  from td_sm_organization a start with a.parent_id= '0'  ")
				.append(" connect by prior a.org_id = a.parent_id order siblings by a.org_sn) a, ")
				.append(" ( select min(tmp.same_job_user_sn) as same_job_user_sn,tmp.org_id,tmp.user_id from (  ")
				.append(" (select ujo.* from td_sm_userjoborg ujo where ujo.user_id not in (select ou.user_id from TD_SM_ORGUSER ou)) ")
				.append(" )tmp group by  tmp.user_id ,tmp.org_id   ")
				.append("  ) bb, ")
				.append(" td_sm_user t  ")
				.append(" where a.org_id=bb.org_id");

				if(!accesscontroler.isAdmin())
				{
					//�����û���ѯ�������û��ɹ���Ļ�����������
					sql.append(" and a.org_id in(select distinct org.org_id from td_sm_organization org ")
						.append(" start with org.org_id in(select o.org_id from td_sm_organization o, td_sm_orgmanager om ")
						.append(" where o.org_id = om.org_id  and om.user_id = '").append(curUserId).append("') ")
						.append("connect by prior org.org_id = org.parent_id)");
				}

				sql.append(" and bb.user_id=t.user_id  ")
					.append(sb_user.toString())
					.append(" order by a.num,bb.same_job_user_sn,t.user_id ");

	}
	else if(userOrgType.equalsIgnoreCase("dis"))
	{
		//��ɢ�û���ѯ
		sql = new StringBuffer()
		.append("select t.*,'��ɢ�û�' as org_job,'0' as SAME_JOB_USER_SN,'0' as ORG_ID,'0' as ORG_SN from td_sm_user  t where 1=1 ")
		.append(sb_user.toString())
		.append(" and t.user_id in (select user1_.USER_ID from td_sm_user user1_ minus select userjoborg1_.user_id from td_sm_userjoborg userjoborg1_)");
	}
	java.sql.Connection con = null;
	System.out.println(sql.toString());
	%>
	<hr>
	<DIV align=center>
	<table align="center" width="80%">
	<tr>
	<th>�û���¼��</th><th>�û�ʵ��</th><th>���ڻ���</th><th>��ϵ��ʽ</th>
	</tr>
	<%
	Connection conn = DBUtil.getConection();
	Statement stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery(sql.toString());

	while(rs.next()){
	String username = rs.getString("USER_NAME");
	username=username==null?"":username;
	String userrealname = rs.getString("USER_REALNAME");
	userrealname=userrealname==null?"":userrealname;
	String job = rs.getString("ORG_JOB");
	job=job==null?"":job;
	String phone = rs.getString("USER_MOBILETEL1");
	phone=phone==null?"":phone;
	%>
	<tr align="center">
	<td ><%=username %></td>
	<td><%=userrealname %></td>
	<td><%=job %></td>
	<td><%=phone %></td>
	</tr>
<%
	}
	if(conn!=null){
		conn.close();
	}
%>

</table>
</DIV>


</body>
</html>