<%@ page contentType="text/html; charset=gb2312"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page import="com.chinacreator.cms.votemanager.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.chinacreator.eg.util.*"%>
<html>
<%
	String module_name = request.getParameter("module_name");
	VoteManagerImpl vote = new VoteManagerImpl();
	String qusetionids = "";
	int flag = 0;
%>
<head>
<title>���ϲ���ͳ�ƴ�ӡ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="<%=request.getContextPath() %>/cms/inc/css/cms.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="<%=request.getContextPath() %>/sysmanager/scripts/selectTime.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/cms/public/datetime/calender.js" language="javascript"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/cms/public/datetime/calender_date.js" language="javascript"></script>
<script language="javascript"> 
		
	function doPrint()
	{
		window.print();
	}
</script>		
</head>
<body>
<table width="100%" height="20" border="0" cellpadding="0" cellspacing="0">
 
  <tr ><td colspan="2" height="2"></td></tr>
  <TR>
  <TD colspan="2">
  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="Datalisttable">
			<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
			<tr><td colspan="100">���ϲ���ͳ�ƴ�ӡ</td></tr>
			<tr><td colspan="100">[<a style="cursor:hand" onclick="javascript:doPrint()">�� ӡ</a>] ��<a style="cursor:hand" onclick="window.close();">�� ��</a>��</td></tr>
			<%String sql = "select a.*,b.user_name,d.name as chname,d.CHANNEL_ID,e.DISPOSEDEP from td_cms_vote_title a,td_sm_user b,TD_CMS_CHANNEL_VOTE c,TD_CMS_CHANNEL d ,td_comm_email_disposedep e "+
					" where a.founder_id=b.user_id and a.id=c.VOTE_TITLE_ID(+) and c.CHANNEL_ID=d.CHANNEL_ID(+) and e.id=a.DEPART_ID  and  a.SITEID=1 and c.channel_id=319 order by istop desc,ctime desc ";%>
				<pg:pager  scope="request" dbname="bspf" statement="<%=sql%>" isList="true">
				<pg:notify>
						<tr  class="labeltable_middle_tr_01">
							<td colspan=6 align='center' height="18px">
								��ʱû��ͳ����Ϣ
							</td>
						</tr>
				  </pg:notify>
				<!--list��ǩѭ�����ÿ����¼-->
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
							voteTotal = question.getVotecount();//С������Ʊ��
							if(question.getStyle()!=2)
							{%>
								<td class="cms_report_tr" nowrap><%=question.getTitle()%></td>
								<%
								 List items = new ArrayList(); 
		     					 items = question.getItems();
		     					 for (int i = 0; i < items.size(); i++) {
	     					 	 	int iVoteCount = ((Item) items.get(i)).getCount();//ѡ��Ʊ��
	     					 		%>
	     					 		<td nowrap><%=((Item) items.get(i)).getOptions()%></td>
	     					 		<td  nowrap style="color:red"><%=((Item) items.get(i)).getCount()%>Ʊ</td>
	     					 		<%
	     					 	}
							}
						}%>
					</tr>
				</pg:list>
					<input id="queryString" name="queryString" value="<pg:querystring/>" type="hidden">
				</pg:pager>
	    </table>
  </TD>
  </TR>
 </table>
</body>
</html>
 