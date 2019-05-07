<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.sql.*"%>

<html>
<head>
	<title>用户信息</title>
		<link rel="stylesheet" type="text/css" href="../../../css/windows.css">
	<link rel="stylesheet" type="text/css" href="../../../css/treeview.css">
	<script defer>
	 function window.onload() {
 	setPrintBase('页眉','页脚');
 	}
		function window.onload()
		{
			 // -- advanced features
			 factory.printing.SetMarginMeasure(2); // measure margins in inches
			 //factory.printing.printer = "HP DeskJet 870C";
			 factory.printing.paperSize = "A4";
			 factory.printing.paperSource = "Manual feed";
			 factory.printing.collate = true;
			 factory.printing.copies = 1;
			 factory.printing.SetPageRange(false, 1, 1); // need pages from 1 to 3

			 // -- basic features
			 factory.printing.header = "This is MeadCo";
			 factory.printing.font = "宋体";
			 factory.printing.footer = "Advanced Printing by ScriptX";
			 factory.printing.portrait = false;
			 factory.printing.leftMargin = 1.0;
			 factory.printing.topMargin = 1.0;
			 factory.printing.rightMargin = 1.0;
			 factory.printing.bottomMargin = 1.0;
		}
	</script>

	<script language="javascript">
		function printTure() //打印函数
		{
			 document.all("dayinDiv").style.display="none";//隐藏按钮
			 factory.printing.Print(true); //调用控件打印
			 document.all("dayinDiv").style.display="";//显示
		}

		function printTurePre() //打印预览
		{
			 document.all("dayinDiv").style.display="none";//隐藏按钮
			 factory.printing.Preview(); //调用控件预览
			 document.all("dayinDiv").style.display="";//显示
		}

		function printTureSet() //设置函数
		{
			 document.all("dayinDiv").style.display="none";//隐藏按钮
			 factory.printing.PageSetup(); //调用控件设置
			 document.all("dayinDiv").style.display="";//显示
		}

		function killErrors()
		{
		    return true;
		}

		window.onerror = killErrors;
	</script>

<style type="text/css" media="screen">
<!-- /* PR-CSS */
table {
border-collapse:collapse; /* 关键属性：合并表格内外边框(其实表格边框有2px，外面1px，里面还有1px哦) */
border:solid #999; /* 设置边框属性；样式(solid=实线)、颜色(#999=灰) */
border-width:1px 0 0 1px; /* 设置边框状粗细：上 右 下 左 = 对应：1px 0 0 1px */
}
table caption {font-size:14px;font-weight:bolder;}
table th,table td {border:solid #999;border-width:0 1px 1px 0;padding:2px;}
tfoot td {text-align:center;}
-->
</style>
<script type="text/javascript">
window.
</script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%>
<body>
	<div  id="dayinDiv" style="display:block" name="dayinDiv" align="center">
		<input type=button value="打印本页"  class="input" onclick="printTure()">
		<input type=button value="页面设置"  class="input" onclick="printTureSet()">
		<input type=button value="打印预览"  class="input" onclick="printTurePre()">
		<input type=button value="关闭"  class="input" onclick="window.close();">
	</div>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String curUserId = accesscontroler.getUserID();
	String userName = request.getParameter("userName");
	String userRealname = request.getParameter("userRealname");
	String userOrgType = request.getParameter("userOrgType");

	StringBuffer sb_user = new StringBuffer();//条件查询
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
			{//过滤用户查询。根据用户可管理的机构条件过滤
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
		//没有主机构
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
					//过滤用户查询。根据用户可管理的机构条件过滤
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
		//离散用户查询
		sql = new StringBuffer()
		.append("select t.*,'离散用户' as org_job,'0' as SAME_JOB_USER_SN,'0' as ORG_ID,'0' as ORG_SN from td_sm_user  t where 1=1 ")
		.append(sb_user.toString())
		.append(" and t.user_id in (select user1_.USER_ID from td_sm_user user1_ minus select userjoborg1_.user_id from td_sm_userjoborg userjoborg1_)");
	}
	java.sql.Connection con = null;
	System.out.println(sql.toString());
	%>
	<br>
	<br>
	<table align="center" width="80%">
	<tr>
	<th>用户登录名</th><th>用户实名</th><th>所在机构</th><th>联系方式</th>
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
	<object id="factory" viewastext  style="display:none"   WIDTH=0 HEIGHT=0
	  classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814"
	  codebase="smsx.cab#Version=6,5,439,12">
	</object>


</body>
</html>