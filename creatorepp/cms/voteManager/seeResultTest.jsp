<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>

<%@ page import="java.util.*"%>
<%@ page import="org.jfree.chart.*" %>
<%@ page import="org.jfree.chart.plot.*" %>
<%@ page import="org.jfree.chart.servlet.ServletUtilities" %>
<%@ page import="org.jfree.chart.entity.StandardEntityCollection" %>
<%@ page import="org.jfree.chart.renderer.category.BarRenderer3D" %>
<%@ page import="org.jfree.data.category.DefaultCategoryDataset" %>
<%@ page import="org.jfree.data.general.DefaultPieDataset" %>
<%@ page import="org.jfree.chart.renderer.category.BarRenderer3D" %>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%@ page import="com.frameworkset.common.poolman.PreparedDBUtil"%>
<%@ page import="com.chinacreator.cms.votemanager.*"%>
<%@ page import="java.math.*"%>
<%!
  /*ȡ��ͶƱѡ����ɫ*/
  private String getColor(int i){    //����i��ʾ�ڼ�����ɫ
    String[] Color = {
      "#ff0000",  //��ɫ
      "#00ff00",  //��ɫ
      "#ff0ff0", //õ��� 
      "#ffff00",  //��ɫ
      "#ff00ff",  //�ۺ�
      "#00ffff",  //��ɫ
      "#f0f0f0",  //�Ұ�
      "#0f0f0f",  //�ֺ�
      "#ff0ff0",  //õ���
      "#0ff0ff",  //����
      "#666666",  //�Һ�
      "#999999",  //��ɫ
      "#FEFFF0",  //��ɫ
    };

    if (i<0)
      return Color[1];

    String mod1 = Integer.toString(i);
    String mod2 = Integer.toString(11);
    BigInteger big1 = new BigInteger(mod1);
    BigInteger big2 = new BigInteger(mod2);

    i = Integer.parseInt(big1.mod(big2).toString());
    return Color[i];
  }
  
%>
<html>
	<head>
		<title>�鿴ͶƱ��Ϣ</title>
		<meta http-equiv="Content-Type" content="text/html;charset=gb2312">
		<link href="../inc/css/cms.css" rel="stylesheet" type="text/css"/>
<script>

function returnListVote(){
  if( window.opener && window.opener.refreshSelf ){
        window.opener.refreshSelf();
        window.opener.focus();
  }
  window.close();
}
</script>
	</head>
	
	<table bgcolor="#336699" border="0" cellPadding="0" cellSpacing="0" width="100%">
			<tbody>
				<tr>
					<td>
						<br>
					</td>
				</tr>
				<tr>


					<td class="c2" color="#000000"></td>
					<td align="right" class="c1" width="50%" color="#000000">
						<font color="#FFFFFF">��<a href="javascript:window.returnListVote();"><font color="#FFFFFF"> �رմ���</font></a><font color="#FFFFFF">��</font></font>
					</td>
				</tr>
			</tbody>
		</table>
		<table border="1"width="100%" bordercolor="#F0F1EF" cellSpacing="0" >
	
			<%
			String[][]sessionArray = (String[][])session.getAttribute("sessionArray");
			VoteManagerImpl vote = new VoteManagerImpl();
			String qusetionids =request.getParameter("questionid");
			String title_id= request.getParameter("titleid");
			if (qusetionids==null || "".equals(qusetionids)){
				qusetionids = vote.getQuestionIDsBy(title_id);
			}
			//System.out.println(qusetionids);
			String[] qusetionid = qusetionids.split(",");
			int voteTotal = 0;
			int index = 0;
			//System.out.print(qusetionid.length);
			for (int j = 0; j < qusetionid.length; j++) {
				int id = Integer.parseInt(qusetionid[j]);
				
				Question question = vote.getQuestionBy(id);
				
				if (question==null)
					continue;
					
				index++;
				
				//voteTotal = question.getVotecount();//С������Ʊ��
       if(question.getStyle()!=2)
       {
				%>

			<tr class="cms_data_tr">
				<td class=c1 color=#000000 align="left" valign="top" colspan="2">
					<STRONG>��Ŀ��<%=index%>
					.
					<%=question.getTitle()%>��</STRONG>
				</td>
			</tr>

       <tr>
	  <td style="padding:0px">
		 <table >
		<% List items = new ArrayList(); 
	     items = question.getItems();
        
	    for (int i = 0; i < items.size(); i++) {
		int iVoteCount = ((Item) items.get(i)).getCount();//ѡ��Ʊ��

					%>
                        <tr>
			               <td class=c1 style="FONT-FAMILY: MS Sans Serif; FONT-WEIGHT: bold; top:0 width=31 color=#000000">
								<table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#000000" bgcolor="<%=getColor(j)%>" height="12" width="12">
									<tr>
										<td>
											<!--ѡ����ʾɫ��-->
										</td>
									</tr>
								</table>
							</td>
							<td width=190>
								<%=((Item) items.get(i)).getOptions()%> 
								
							</td>
							<td  >
								<div align="left"><%=((Item) items.get(i)).getCount()%>
								Ʊ </div>
								
							</td>
						</tr>
						<%}%>
          </table>
        </td>
		<%
			    List items1 = new ArrayList(); 
				items1=question.getItems();
			    String[] area= new String[items1.size()];
				
				DefaultPieDataset dataset=new DefaultPieDataset();
				//System.out.println(items.size());
				for (int k =0; k <items1.size(); k++) {
				
				//System.out.println(((Item) items1.get(k)).getOptions());
				
				area[k]=((Item)items1.get(k)).getOptions();
				int dq=((Item) items1.get(k)).getCount();
				dataset.setValue(area[k],dq);
				}
								
	     JFreeChart chart=ChartFactory.createPieChart("����ͼ",dataset,true,true,true);
        chart.setTitle("ͶƱͳ��ͼ");//����ͼƬ����
        ChartRenderingInfo info=new ChartRenderingInfo(new StandardEntityCollection());
        String filename=ServletUtilities.saveChartAsJPEG(chart,300,200,info,session);
        //��������ͼƬ������ͼƬ�Ĵ�С��������300������200
        //out.println(filename);
        session.setAttribute("file_name1",filename);
        String URL= request.getContextPath() + "/servlet/DisplayChart?filename=" + filename; 
        session.setAttribute("file_url1",URL);

		%>
		<td class=c1  bgcolor=#E2F5FE valign=top align="center" rowspan="1" > 
					<div align=center>
						<table border="1" cellpadding="0" cellspacing="0" bordercolor="#E2F5FE">
							<tr>
								<td>
									<CENTER>
										<img src="<%=session.getAttribute("file_url1")%>" width=300 height=185 border=0 usemap="#<%=session.getAttribute("file_name1") %>">
									</CENTER>
								</td>

							</tr>s
						</table>
					</div>
				</td>
			</tr>
			<%
			
			}
			else
			{
			%>
			<tr class="cms_data_tr">
				<td class=c1 color=#000000 align="left" valign="top" colspan="2">
					<STRONG>��Ŀ��<%=index%>
					.
					<%=question.getTitle()%>��</STRONG>
				</td>
				
			</tr>
		<% List answers = new ArrayList(); 
	     answers = question.getAnswers();
        if(title_id!=null)
        {
          for (int t = 0; t < answers.size(); t++) {
	      %>
	      <tr class="cms_data_tr">
				<td class=c1 color=#000000 align="left" valign="top" colspan="2">
				<%=((Answer)answers.get(t)).getWhoIp()%>��<%=((Answer)answers.get(t)).getAnswer()%> 
				</td>
			</tr>
	   <% }
        }
         else{
	      for (int t = 0; t < answers.size(); t++) {
	      if(((Answer)answers.get(t)).getState()==1)
	      {
	      %>
	        <tr class="cms_data_tr">
				<td class=c1 color=#000000 align="left" valign="top" colspan="2">
				<%=((Answer)answers.get(t)).getWhoIp()%>��<%=((Answer)answers.get(t)).getAnswer()%> 
				</td>
			</tr>
	    <%}
	     }
	    }
	    %>
		<%	
			}
			}
		%>
			
		</table>

		
</html>


