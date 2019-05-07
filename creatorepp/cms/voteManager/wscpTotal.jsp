<%@ page contentType="text/html; charset=gb2312"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page import="com.chinacreator.cms.votemanager.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
	String module_name = request.getParameter("module_name");
	VoteManagerImpl vote = new VoteManagerImpl();
	String qusetionids = "";
	int flag = 0;
%>
<head>
<title><%=module_name%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="<%=request.getContextPath() %>/cms/inc/css/cms.css" rel="stylesheet" type="text/css">
<link href="css/main.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="<%=request.getContextPath() %>/sysmanager/scripts/selectTime.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/cms/public/datetime/calender.js" language="javascript"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/cms/public/datetime/calender_date.js" language="javascript"></script>
<script language="javascript"> 
		function test()
		{
		  if(form1.all.starttime.value != "" && form1.all.endtime.value != "" && form1.all.starttime.value > form1.all.endtime.value){
				alert("结束时间必须大于起始时间");
				return false;
		  }
		  document.form1.method="post";
		  document.form1.target="_self";
		  document.form1.action="lb_total.jsp";
		  document.form1.submit();
		}	
		function clearform()
		{
			document.all("info_type").value = "";
			document.all("starttime").value = "";
			document.all("endtime").value = "";
		}
		function print_lb()
		{
			window.open("print.jsp","_blank");
		}	
</script>		
</head>

<body scroll="auto">
<table width="100%" border="0" cellpadding="0" cellspacing="0"> 
  <tr>
    
    <td  >
	<table width="98%" height="100%" border="0" cellpadding="0" align="center" cellspacing="0">
		<tr>
			<td>
				<table width="100%" border="0" class="table01">
					<tr>
						<td width="1%" align="left">&nbsp;</td>
    					<td width="89%" align="left">当前位置:网上测评 &gt;&gt; 统计管理</td>
						<td width="10% align="right">
						<INPUT name="print" type="button" class="button2" value=" 打 印 " onClick="print_lb();"></td>
				  </tr>
				</table>
			</td>
		</tr>
				
	  
	  <TR>
	  <TD>
		  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0"  class="Atable">
		  <%String sql = "select a.*,b.user_name,d.name as chname,d.CHANNEL_ID,e.DISPOSEDEP from td_cms_vote_title a,td_sm_user b,TD_CMS_CHANNEL_VOTE c,TD_CMS_CHANNEL d ,td_comm_email_disposedep e "+
					" where a.founder_id=b.user_id and a.id=c.VOTE_TITLE_ID(+) and c.CHANNEL_ID=d.CHANNEL_ID(+) and e.id=a.DEPART_ID  and  a.SITEID=1 and c.channel_id=319 order by istop desc,ctime desc ";%>
				<pg:pager maxPageItems="15" scope="request" dbname="bspf" statement="<%=sql%>" isList="false">
				<pg:notify>
						<tr  class="labeltable_middle_tr_01">
							<td colspan=6 align='center' height="18px">
								暂时没有统计信息
							</td>
						</tr>
				  </pg:notify>
				<!--list标签循环输出每条记录-->
				<pg:list>
					<tr>
						<td nowrap><pg:cell colName="DISPOSEDEP"/></td>
						<%
						qusetionids = vote.getQuestionIDsBy(dataSet.getString("id"));
						String[] qusetionid = qusetionids.split(",");
						int index = 0;
						int voteTotal = 0;
						for (int j = 0; j < qusetionid.length; j++) {
							int id = Integer.parseInt(qusetionid[j]);
					
							Question question = vote.getQuestionBy(id);
							if (question==null)
								continue;
							index++;
							voteTotal = question.getVotecount();//小主题总票数
							if(question.getStyle()!=2)
							{%>
								<td class="cms_report_tr" nowrap><%=question.getTitle()%></td>
								<%
								 List items = new ArrayList(); 
		     					 items = question.getItems();
		     					 for (int i = 0; i < items.size(); i++) {
	     					 	 	int iVoteCount = ((Item) items.get(i)).getCount();//选项票数
	     					 		%>
	     					 		<td nowrap><%=((Item) items.get(i)).getOptions()%></td>
	     					 		<td  nowrap style="color:red"><%=((Item) items.get(i)).getCount()%>票</td>
	     					 		<%
	     					 	}
							}
						}%>
					</tr>
				</pg:list>
					<tr><td colspan=6 align="right" class="c2">
							共
							<pg:rowcount />
							条记录
							<pg:index />
						</td></tr>
					<input id="queryString" name="queryString" value="<pg:querystring/>" type="hidden">
				</pg:pager>
	    </table>
  </TD>
  </TR>
</table>
</body>
</html>
 