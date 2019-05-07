<%@page contentType="text/html;charset=GBK"%>
<%@page import="java.util.*" %>
<%@page import="com.chinacreator.epp.reportmanage.service.ReportManage" %>
<%@page import="com.chinacreator.epp.reportmanage.vo.*" %>
<%@page import="com.chinacreator.epp.reportmanage.factory.ReportBeanFactory"%>

<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>

<%
	String repId = request.getParameter("repId");
	ReportManage rm = ReportBeanFactory.getReportManager();
	List<Tb_report> list = rm.queryVersionsByReport(repId); 
%>

<html>
	<head>
		<title>查看历史报表</title>

		<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
		<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
		<META HTTP-EQUIV="Expires" CONTENT="0">


		<link rel="stylesheet" type="text/css" href="../css/windows.css">
	   <link rel="stylesheet" type="text/css" href="../css/contentpage.css">
	  <link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
	  <link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
	  <link rel="stylesheet" type="text/css" href="../sysmanager/css/contentpage.css">
	  <link rel="stylesheet" type="text/css" href="../sysmanager/css/tab.winclassic.css">

		<script type="text/javascript">
				function openXpdl(ec_id,mgrName)
				{
					var tmp = escape(mgrName);
					//var retx=window.showModalDialog("xpdl_open.jsp?ec_id="+ec_id+"&op=modify&mgrName="+tmp);
					//if(retx) window.location.reload();
					//window.location.href="xpdl_open.jsp?ec_id="+ec_id+"&op=modify&mgrName="+tmp;
					window.showModalDialog("xpdl_open.jsp?ec_id="+ec_id+"&op=modify&mgrName="+tmp);
				}
		</script>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body>
		<script type="text/javascript">
			//alert("<%=list.size()%>");
		</script>

		<table width="100%" border="0" cellpadding="0" cellspacing="1"
					class="thin">

					<tr class="labeltable_middle_td">
							<!--设置分页表头-->
							<td class="headercolor" width="6%">
								<!-- P align="left">
									<INPUT type="checkbox" name="checkBoxAll"
										onclick="checkAll('checkBoxAll','checkBoxOne')">
								</P-->
							</td>
							<td height='20' class="headercolor">
								版本号
							</td>
							<td height='20' class="headercolor">
								报表名称
							</td>
							<td height='20' class="headercolor">
								创建时间
							</td>
							<td height='20' class="headercolor">
								修改
							<input class="text" type="hidden" name="selectId"/>
							<input name="delSingle" type="hidden" validator="string"
									maxlength="100" value="false"/>
							</td>
						</tr>
						<!-- 循环体 -->
						<%
							if(list.size()>0){
							Iterator<Tb_report> it = list.iterator();
							while(it.hasNext()){
								Tb_report rep = (Tb_report)it.next();
						%>
						<tr class="labeltable_middle_tr_01"
								onMouseOver="this.className='mousestyle1'"
								onMouseOut="this.className= 'mousestyle2'"
								>
								<td class="tablecells" nowrap="true">
									<!--P align="left">
										<INPUT type="checkbox" name="checkBoxOne"
											onclick="checkOne('checkBoxAll','checkBoxOne')"
											value=''>
									</P-->
								</td>
								<td height='20' align="left" class="tablecells" onclick="">
									<%=rep.getRep_ver() %>
								</td>
								<td height='20' align="left" class="tablecells" onclick="">
									<%=rep.getRep_name()%>
								</td>
								<td height='20' align="left" class="tablecells">
									<%=rep.getCreattime().toLocaleString() %>
								</td>

								<td height='20' align="left" class="tablecells">
									<input type="button" value="修改" onclick="openXpdl('')"/>
								</td>
						</tr>
						<%}} %>

		</table>
	</body>
</html>