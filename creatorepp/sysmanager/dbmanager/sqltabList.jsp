
<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>


<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.sql.ResultSetMetaData" %>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>

<html>
	<head>
		<title>��������</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/tab.winclassic.css">
		<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>


 <%

 	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
 	
 	

 	String dsource = request.getParameter("dsource2");
 	String sql = request.getParameter("sqlContent");
 	

 	
 	if(null == dsource || null == sql 
 					|| "".equals(sql)  || "".equals(dsource) || 
 					"".equals(dsource.trim()) || "".equals(sql.trim()))
 	{
 					
 		out.print("��ѯ��������,�����Ƿ�ѡ������Դ���Ƿ�������SQL���!!!");
 		return ;
 	}
 	
 	//ȥ��sql�ո�
 	sql = sql.trim();
 	
	out.print(sql);
		
	boolean flag = false;	

	String errorMessage ="";
	
	//��ȡ����
	List columnList = null ;
	
	try
	{
		//ִ��sql���
		DBUtil db = new DBUtil();
		db.execute(dsource,sql);
		ResultSetMetaData resultMeta = db.getMeta();
		
		if(resultMeta != null) 
		{
	        columnList = new ArrayList();
			int size =resultMeta.getColumnCount();
			for(int i=1; i<=size; i++)
			{
				String columnName = resultMeta.getColumnName(i);
				columnList.add(columnName);
			}
		}
		flag = true;
	} catch(Exception e)
	{
		flag = false;
		errorMessage = e.getMessage();
		e.printStackTrace();
		
	}
	
	
	//����ÿҳ��ʾ�ļ�¼��:Ĭ����10
	
	String str_pageSize = request.getParameter("pageSize2");
	
	int pageSize = 10;
	
	if(str_pageSize != null && !"".equals(str_pageSize))
	{
		try
		{
			pageSize = Integer.parseInt(str_pageSize);
		}catch(NullPointerException e)
		{
			pageSize = 10;
		}
	}

  %>
  
  	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin">
  		
  		<%
  		if(flag && columnList != null)
  		{
  		%>
  			<pg:pager statement="<%=sql %>" dbname="<%=dsource %>" isList="false" maxPageItems="<%=pageSize%>">
  				<pg:param name="sqlContent" value="<%=sql %>"/>
  				<pg:param name="dsource2" value="<%=dsource %>"/>
  				<pg:param name="pageSize2"/>
  				
  				<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
  					<tr class="labeltable_middle_td">
  					<%
  						for(int i=0; i<columnList.size(); i++)
  						{
  					%>	
  							<td height="20" size="3" class="headercolor"><%=(String)columnList.get(i) %></td>
  					<%
  						}
  					 %>	
  		 			<tr>
  		 			<pg:notify>
						<tr><td colspan="<%=columnList.size()+1%>"><font color='red'>û�м�¼</font></td></tr>
					</pg:notify>
					
					<pg:list>
					<tr onMouseOver="this.className='mouseover'" onMouseOut="this.className= 'mouseout'">
					  	<%
					  		for(int j=0; j<columnList.size(); j++)
					  		{
						%>
						<td>
							<pg:cell colName="<%=(String)columnList.get(j) %>"/>
						</td>
						<%
					  		}
					  	 %>
					</tr>
			   		</pg:list>
			   		<tr>
						<td colspan="<%=columnList.size()+1%>" height='20' size="3"  class="tablecells">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							
							��<pg:rowcount/>����¼ <pg:index/>&nbsp;&nbsp;
							</form>
						</td>
					</tr>
				</table>
			</pg:pager>	
  		<%
  			}
  			else if(flag && columnList == null)
  			{
  				out.print("<br/><br/>SQLִ�гɹ�!!!");
  			}
  			else
  			{
  				out.print("<br/><br/>����SQL����Ƿ�������,����ʧ��---> " + errorMessage);
  			}
  		 %>
	</body>
</html>