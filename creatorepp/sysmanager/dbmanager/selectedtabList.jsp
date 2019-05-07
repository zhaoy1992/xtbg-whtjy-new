
<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="java.util.*"%>
<%@ page import="com.frameworkset.common.poolman.sql.PrimaryKeyMetaData"%>
<%@ page import="com.frameworkset.common.poolman.sql.TableMetaData"%>
<%@ page import="com.frameworkset.common.poolman.sql.ColumnMetaData"%>
<%@ page import="com.frameworkset.common.poolman.util.SQLUtil"%>
<%@ page import="java.sql.ResultSetMetaData" %>
<%@ page import="com.frameworkset.common.tag.pager.tags.PagerDataSet" %>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%@ page import="com.chinacreator.security.AccessControl"%>

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
<%! 

	//��ȡ���º�ɾ������
	public String getCondition(String db,String tablename,PagerDataSet dataSet)
	{
		String cond = "";
		if(db != null && tablename != null && !db.equals("") && !tablename.equals(""))
		{
			Set set  =DBUtil.getPrimaryKeyMetaDatas(db,tablename);
			Iterator iterator = set.iterator();
			
			while(iterator.hasNext())
			{
				PrimaryKeyMetaData keyMetaData = (PrimaryKeyMetaData) iterator.next();
				String columnName = keyMetaData.getColumnName();
				String value = dataSet.getString(columnName);
				if(cond.equals(""))
				{
					cond += columnName + "= '" + value + "'";
				}
				else 
				{
					cond += " , " + columnName +" = '" + value + "'";
				}
			}
		}
		return cond.trim();
	}
 %>

 <%

 	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
 	
 	String str_numCount = request.getParameter("numCount");
 	String dsource = request.getParameter("dsource");
 	String tablename = request.getParameter("table_name");
 	 		 	
 	int numCount = 0;
 	
 	String sql = request.getParameter("sql"); 	
 	
 	if(sql == null || sql.equals(null) || sql.equals(""))
 	{
 		String condition = "";
 		if(dsource != null && tablename != null && !"".equals(dsource) && !"".equals(tablename))
 		{
	 		if(str_numCount != null && !"".equals(str_numCount))
	 		{
	 			numCount = Integer.parseInt(str_numCount);
	 			
	 			for(int i=1; i<=numCount ; i++)
	 			{
	 				String fieldNameAndType = request.getParameter("advancedField" + i);
	 				if(fieldNameAndType != null && !fieldNameAndType.equals(""))
	 				{
	 					int location = fieldNameAndType.indexOf("|");
		 				String fieldName = fieldNameAndType.substring(0,location);
		 				String fieldType = fieldNameAndType.substring(location+1); 
		 				
		 				String logical = request.getParameter("logical" +i);	 				
		 				logical = logical ==null ? "" : logical;
	
		 				//������������
		 				if(fieldType.equals("DATE"))
		 				{
		 					String startDate = request.getParameter("startDate"+i);
		 					String endDate = request.getParameter("endDate" + i);
		 					
		 					if(startDate != null && !startDate.equals(""))
		 					{
		 						
		 						condition += logical + " " + fieldName + ">=to_date('" + startDate +" 00:00:00','yyyy-mm-dd hh24:mi:ss') ";
		 						if(endDate != null && !endDate.equals(""))
		 						{
		 							condition += "and " + fieldName + "<=to_date('" + endDate +" 23:59:59','yyyy-mm-dd hh24:mi:ss') ";
		 						}	 				
		 					}
		 				}
		 				else
		 				{
		 					String value = request.getParameter("advancedvalue" + i);
							if(value !=null && !value.equals(""))
							{
								condition += logical + " " + fieldName + " like '%" + value + "%' ";
							}
		 				}	
	 				}
	 			}
	 		}
	 		
	 		if(!condition.equals("")) 
	 		{
	 			condition = condition.trim();
	 			if(condition.startsWith("and"))
	 			{
	 				condition = condition.substring(4);
	 			}
	 			else if(condition.startsWith("or"))
	 			{
	 				condition = condition.substring(3);
	 			}
	 			sql = "select * from " + tablename + " where " + condition;
	 		}
	 		else
	 		{
	 			sql = "select * from " + tablename;
	 		}
 		}
 	}
 	
 	out.print(sql);
 	
 	boolean flag  = false;
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
		e.printStackTrace();
		
	}
	
	
	//����ÿҳ��ʾ�ļ�¼��:Ĭ����10
	String str_pageSize = request.getParameter("pageSize");
	int pageSize = 10;
	if(str_pageSize != null && !"".equals(str_pageSize))
	{
		try
		{
			pageSize = Integer.parseInt(str_pageSize);
		}catch(NumberFormatException e)
		{
			pageSize = 10;
		}
	}
	
 %>
 <script type="text/javascript">
  	function selectAll()
  	{
  		var delall = document.getElementById("all");
  		var del = document.getElementsByName("checkObject");	
  		
  		if(delall.checked ==true)
  		{
  			for(var i=0; i<del.length; i++)
  			{
  				del[i].checked = true;
  			}
  		}else 
  		{
  			for(var i=0; i<del.length; i++)
  			{
  				del[i].checked = false;
  			}
  		}
  	}
  	
  	function checkDelAll()
  	{
  		var del = document.getElementsByName("checkObject");
  		var delall = document.getElementById("all");

  		var size = 0;
  		for(var i=0; i<del.length; i++)
  		{
  			if(del[i].checked == true)
  			{
  				size ++ ;
  			}
  		}
  		if(size == 0)
  		{
  			alert('����ѡ��һ��!!!!');
  			return ;
  		}
  		else if(size == 1)
  		{
  			for(var i=0; i<del.length; i++)
  			{
  				if(del[i].value =='')
  				{
  					alert('����䲻��ɾ��(��������Ϣ)!!!');
  					del[i].checked = false;
  					return;
  				}
  			}
  		}
  		 		
  		var dsource = form1.dsource.value;
  		var tablename = form1.tablename.value;
  		
  		if(dsource == "" || tablename =="")
  		{
  			alert("ȱ�ٲ���,����ɾ���ñ��������Ϣ!!!");
  			return ;
  		}
  		
  		if(confirm('��ȷ��Ҫɾ����ѡ������?(ɾ����Ͳ��ָܻ�!)'))
  		{	
  			document.form1.action = "delRecord.jsp";
  			document.form1.target = "_del";
  			var popupWin = window.open('delRecord.jsp','_del','scrollbars=no,width=300,height=200');    
  			document.form1.submit();
  			
  			document.location.href="selectedtabList.jsp?dsource=<%=dsource%>&table_name=<%=tablename%>&pageSize=<%=pageSize%>";
  		}
  		else 
  		{
  			for(var i=0; i<del.length; i++)
  			{
  				del[i].checked = false;
  			}
  			delall.checked = false;
  			return;
  		}
  	}
  	
  	function checkUpd()
  	{
  		var selectAll = document.getElementById("all");
  		var updateObjects = document.getElementsByName("checkObject");
  		var size = 0;
  		for(var i=0; i<updateObjects.length; i++)
  		{
  			if(updateObjects[i].checked == true)
  			{
  				size ++;
  			}
  		}
  		
  		if(size == 0)
  		{
  			alert('����ѡ���������޸�!!!');
  			return ;
  		} 
  		else if(size > 1)
  		{
  			alert('ÿ��ֻ���޸�һ����¼!!!');
  			if(selectAll.checked == true)
  			{
  				selectAll.checked = false;
  			}
  			for(var i=0; i<updateObjects.length;i++)
  			{
  				updateObjects[i].checked = false;
  			}
  			return ;
  		}
  		else if(size == 1)
  		{
  			for(var i=0; i<updateObjects.length; i++)
  			{
  				if(updateObjects[i].value =='')
  				{
  					alert('����䲻���޸�(��������Ϣ)!!!');
  					updateObjects[i].checked = false;
  					return;
  				}
  			}
  		}
  		
  		
  		
  		if(confirm('��ȷ��Ҫ�޸���ѡ������?(�޸ĺ�Ͳ��ָܻ�!)'))
  		{
  			form1.action = "displayRecord.jsp";
  			form1.submit();
  		}else
  		{
  			for(var i=0; i<updateObjects.length; i++)
  			{
  				updateObjects[i].checked = false;
  			}
  			
  			return;
  		}
  	}  	
  </script>
 <%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin">
  		<form action="" method="post" name="form1">
	  		<span>
	  			<input type="button" class="input" style="width:100" name="add" value="ɾ����ѡ" onclick="checkDelAll()"/>&nbsp;&nbsp;
	  			<input type="button" class="input" name="update" style="width:100" value="�޸�" onclick="checkUpd()"/>
	  			<input type="hidden" name="sql" value="<%=sql %>"/>
	  			
	  			
	  			<!-- ɾ���͸�����Ҫ�Ĳ��� -->
	  			<input type="hidden" name="dsource" value="<%=dsource %>"/>
	  			<input type="hidden" name="tablename" value="<%=tablename %>"/>
	  			<input type="hidden" name="pageSize" value="<%=pageSize%>"/>
	  			
	  			<!-- ���ڷ�ҳ�Ĳ��� -->
	  			<input type="hidden" name="table_name" value="<%=tablename %>"/>
	  			
	  		</span>	
	  		
			<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
		<%
			if(flag)
			{
		 %>
			    <pg:pager statement="<%=sql%>" 
	    		  dbname="<%=dsource %>" isList="false" maxPageItems="<%=pageSize %>" >
	    		  <pg:param name="sql"/>
	    		  <pg:param name="pageSize"/>
	    		  <pg:param name="table_name" value="<%=tablename %>"/>
	    		  <pg:param name="dsource" value="<%=dsource %>"/>
	    		  
	    		  
	    		  
	    		  
				<tr class="labeltable_middle_td">
					<td height="20" size="3" class="headercolor">
						<input type="checkbox" size="3" name="all" id="all" onclick="selectAll()"/>
					</td>
					<%
  						for(int i=0; i<columnList.size(); i++)
  						{
  					%>	
  							<td height="20" size="3" class="headercolor"><%=(String)columnList.get(i) %></td>
  					<%
  						}
  					 %>	
				</tr>
				
				<pg:notify>
				<tr><td colspan="<%=columnList.size()+1%>"><font color='red'>û�м�¼</font></td></tr>
				</pg:notify>
				<pg:list>
					<tr onMouseOver="this.className='mouseover'" onMouseOut="this.className= 'mouseout'">
						<td height='20' size="3" align="center" class="tablecells">
							<input type="checkbox" size="3" name="checkObject" value="<%=getCondition(dsource,tablename,dataSet) %>"/>
						</td>
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
						��<pg:rowcount/>����¼ <pg:index/>
					</td>
				</tr>
				</pg:pager>
			<% }%>
			</table>
		</form>
	</body>
</html>