<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@page import="com.frameworkset.common.poolman.DBUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.*"%>
<%@page import="com.frameworkset.common.poolman.sql.*"%>
<%@page import="com.frameworkset.common.poolman.util.*"%>
<%@taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld"%>
<%@taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>


<%
	AccessControl accesscontroler = AccessControl.getInstance();
	if(!accesscontroler.checkAdminAccess(request, response)){
		return;
	}
	
	String dsource = request.getParameter("dsource");
	String table_name = request.getParameter("table_name") ;
	
	//�������������: ����|����
	List columnNameAndTypeList = new ArrayList();
	
	if(dsource!=null && table_name != null && !"".equals(dsource) && !"".equals(table_name)){
		
		TableMetaData tableMeta  = SQLUtil.getTableMetaData(dsource,table_name);

		Set columnMetaDataSet = tableMeta.getColumns();
		
		Iterator iterator = columnMetaDataSet.iterator();
		
		for(;iterator.hasNext();){
			//�����������ʹ����ArrayList��
			ColumnMetaData columnMetaData = (ColumnMetaData)iterator.next();	
			
			//String columnName = columnMetaData.getColumnName();
			//String columnType = columnMetaData.getTypeName();
			//String columnName_type = 	columnName +"_" + columnType;
			String columnName_type = columnMetaData.getColumnName() + "|" + columnMetaData.getTypeName();
			
			columnNameAndTypeList.add(columnName_type);
		}
	}
	
%>
 
 
<html>
	<head>
		<title>��������</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css"
			href="../css/tab.winclassic.css">
			
			
		<tab:tabConfig/>
		<script language="JavaScript" src="common.js" type="text/javascript"></script>
		<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
		<script language="javascript" src="../scripts/selectTime.js"></script>
		<script language="JavaScript" src="../include/pager.js"
			type="text/javascript"></script>
		<script src="../inc/js/func.js"></script>
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/public/datetime/calender_date.js"></script>
		<script language="JavaScript"
			src="../../sysmanager/scripts/selectTime.js" type="text/javascript"></script>
		<script type="text/javascript" src="../../public/datetime/calender.js"
			language="javascript"></script>
		<script type="text/javascript"
			src="../../public/datetime/calender_date.js" language="javascript"></script>
		<SCRIPT language="javascript">
			  var win;
			  var featrue = "dialogWidth=600px;dialogHeight=500px;scroll=yes;status=no;titlebar=no;toolbar=no;maximize=yes;minimize=0;help=0;dialogLeft="+(screen.availWidth-600)/2+";dialogTop="+(screen.availHeight-500)/2;
			  function getTables(e)
			  {
		      	var dsource = document.all.dsource.value;
		        if(dsource !="")
		        {
					var path = "select_tableName.jsp?dsource=" + dsource + "&tablename=" + e.value;
					var win = window.showModalDialog(path,window,featrue);
					
					if(!win)
					{
						e.value = '';
					}
					else
					{
						if(e.value != win)
						{
							e.value=win;
							//�ڻ�ȡ�������ύ��,�Ӷ�ȷ���Ǳ���ֶ�����(ע��:��������)
							document.query.action = "tablesmanager.jsp";
							document.query.target = "";
							document.query.submit();
						}
					}
				}
			}
			
			function getFields(obj,index,targetObject)
			{
				var dsource = query.dsource.value;
				var dname = query.table_name.value;
				if(dsource=='')
				{
					alert('����ѡ�����ݿ�!!!!');
					return ;
				}
				
				if(dname == '')
				{
					alert('��ѡ�����ݿ��!!!');
					return ;
				}
				
				
				var textOrDate = obj.options[obj.selectedIndex].value ;
	
				var arr = textOrDate.split("|");
							
				
				//���������ͺͷ��������͵Ĵ���				
				if(arr[1] == "DATE")
				{
				var strDate = "��ѯ��ֹʱ��:" ;
					
				strDate += "<input type='text' name='startDate"+ index +"' size='10' onclick='showdate(document.all(\"startDate"+ index +"\"))' readonly='true'>";
				
				strDate +="��<input type='text' name='endDate"+ index +"' size='10' onclick='showdate(document.all(\"endDate"+ index +"\"))' readonly='true'>";

					
				document.getElementById("strOrDate" + index).innerHTML = strDate;
				}
				else
				{
					document.getElementById("strOrDate" + index).innerHTML = "�������������:&nbsp;&nbsp;<input type='text' name='advancedvalue"+ index+ "'/>";
				}

			}
			
			var num = 1;
			function changeFlag(nFlag,condition)
			{
				//���num��С����״̬Ϊ0����
				if(num <=1 && nFlag == 0)
				{
					return;
				}
				if(nFlag == 1)
				{
					num ++;
				}else if(nFlag == 0)
				{
					num --;
				}
		
				if(num <1)
				{
					alert('no');
					return ;
				}
				
				
				var str ="<table cellspacing='1' cellpadding='0' border='0' bordercolor='#EEEEEE' width=100% class='thin'>";
					for(var i=1; i<=num; i++)
					{
					
						//�������ֶ�
						str += "<tr><td colspan='2' height='30' valign='middle' align='center' width='255'>���ֶ�:&nbsp;&nbsp;&nbsp;";
						
							str += "<select name=advancedField" + i + " id=select" + i +"  onChange='getFields(this,"+ i +",document.getElementById(\"strOrDate"+ i +"\"))'>";
								str += "<option value=''>--��ѡ����ֶ�--" ;
								
									<%
											for(int i=0; i<columnNameAndTypeList.size(); i++)
											{
												String columnNameAndType = (String) columnNameAndTypeList.get(i);
									%>
										str += "<option value='<%=columnNameAndType%>'><%=columnNameAndType.substring(0,columnNameAndType.indexOf("|")) %>";
									<%
											}
									%>
							str +="</select></td>";
							
							//�����ı���
							if(condition == 1)
							{
								if(i < num)
								{
									var selectObject  = document.getElementById("advancedField" +i);
									var dateAndType = selectObject.options[selectObject.selectedIndex].value ;
									var arr = dateAndType.split("|");
									
									if(arr[1] == 'DATE')
									{
										if(document.all("startDate" + i) != null && document.all("endDate"+i) != null)
										{
											str += "<td colspan='2' height='30' valign='middle' align='center'>";
												str += "<div id='strOrDate"+ i +"'>��ѯ��ֹʱ��:";
													str += "<input type='text' name='startDate"+ i +"' value='"+ document.getElementById('startDate'+ i ).value +"' size='10' onclick='showdate(document.all(\"startDate"+ i +"\"))' readonly='true'>";
													str += "��<input type='text' name='endDate"+ i +"' value='"+ document.getElementById('endDate' +i).value +"' size='10' onclick='showdate(document.all(\"endDate"+ i +"\"))' readonly='true'>";
											str +="</div></td>";
										}
										else
										{
											str += "<td colspan='2' height='30' valign='middle' align='center'>";
												str += "<div id='strOrDate"+ i +"'>��ѯ��ֹʱ��:";
													str += "<input type='text' name='startDate"+ i +"'  size='10' onclick='showdate(document.all(\"startDate"+ i +"\"))' readonly='true'>";
													str += "��<input type='text' name='endDate"+ i +"' size='10' onclick='showdate(document.all(\"endDate"+ i +"\"))' readonly='true'>";
											str +="</div></td>";
										}
									}
									else
									{
										if(document.all("advancedvalue" + i) != null)
										{
											str += "<td colspan='2' height='30' valign='middle' align='center'> ";
												str +="<div id='strOrDate"+ i +"'>�������������:&nbsp;&nbsp;";
													str += "<input type='text' name='advancedvalue"+ i +"' value='"+ document.getElementById('advancedvalue'+i).value +"'/>";
											str += "</div></td>";
										}
										else
										{
											str += "<td colspan='2' height='30' valign='middle' align='center'> ";
												str +="<div id='strOrDate"+ i +"'>�������������:&nbsp;&nbsp;";
													str += "<input type='text' name='advancedvalue"+ i +"'/>";
											str += "</div></td>";
										}
									}
								}
								else if(i == num)
								{
									str += "<td colspan='2' height='30' valign='middle' align='center'> ";
									str +="<div id='strOrDate"+ i +"'>�������������:&nbsp;&nbsp;<input type='text' name='advancedvalue"+ i +"'/></div></td>";
								}
							}
							else if(condition == 0)
							{
									var selectObject  = document.getElementById("advancedField" +i);
									var dateAndType = selectObject.options[selectObject.selectedIndex].value ;
									var arr = dateAndType.split("|");
									
									if(arr[1] == 'DATE')
									{
										if(document.getElementById("startDate" + i) != null && document.getElementById("endDate"+i))
										{
											str += "<td colspan='2' height='30' valign='middle' align='center'>";
												str += "<div id='strOrDate"+ i +"'>��ѯ��ֹʱ��:";
													str += "<input type='text' name='startDate"+ i +"' value='"+ document.getElementById('startDate'+ i ).value +"' size='10' onclick='showdate(document.all(\"startDate"+ i +"\"))' readonly='true'>";
													str += "��<input type='text' name='endDate"+ i +"' value='"+ document.getElementById('endDate' +i).value +"' size='10' onclick='showdate(document.all(\"endDate"+ i +"\"))' readonly='true'>";
											str +="</div></td>";
										}
										else
										{
											str += "<td colspan='2' height='30' valign='middle' align='center'>";
												str += "<div id='strOrDate"+ i +"'>��ѯ��ֹʱ��:";
													str += "<input type='text' name='startDate"+ i +"'  size='10' onclick='showdate(document.all(\"startDate"+ i +"\"))' readonly='true'>";
													str += "��<input type='text' name='endDate"+ i +"' size='10' onclick='showdate(document.all(\"endDate"+ i +"\"))' readonly='true'>";
											str +="</div></td>";
										}
									}
									else
									{
										if(document.getElementById("advancedvalue" + i) != null)
										{
											str += "<td colspan='2' height='30' valign='middle' align='center'> ";
												str +="<div id='strOrDate"+ i +"'>�������������:&nbsp;&nbsp;";
													str += "<input type='text' name='advancedvalue"+ i +"' value='"+ document.getElementById('advancedvalue'+i).value +"'/>";
											str += "</div></td>";
										}
										else
										{
											str += "<td colspan='2' height='30' valign='middle' align='center'> ";
												str +="<div id='strOrDate"+ i +"'>�������������:&nbsp;&nbsp;";
													str += "<input type='text' name='advancedvalue"+ i +"'/>";
											str += "</div></td>";
										}
									}
							}
							
							
							//�����߼���
							if(i !=1)
							{
							
								str +="<td width='16%' height='30' colspan='1' align='center' valign='middle'>";
									str += "<select name=logical"+ i+ "><option value='and' selected>����<option value='or'>����<option value='and not'>������ </option></select>";
								str += "</td></tr>";
							
							}
							else 
							{
								str +="<td width='16%' height='30' colspan='1' align='center' valign='middle'>";
									str += "<input name='add' type='button' class='input' value='����' onClick='changeFlag(1,1)'>&nbsp;&nbsp;"
									str += "<input name='reduce' type='button' class='input' value='����' onClick='changeFlag(0,0)'>";
								str += "</td></tr>";
							}
					}
					
				str += "</table>";
				rememberSelectedField();
				rememberInputLogic();
				div1.innerHTML = str;
				selectField(condition);
				selectLogic();
				
			}
			
			var arrSelectIndex = "";
			function rememberSelectedField()
			{
				arrSelectIndex = "";
				for(var i=1;i<=num;i++)
				{
					var selectID = "select" + i;
					if (document.all( selectID ) != null)
					{
						arrSelectIndex += document.all( selectID ).selectedIndex + "|";
						
					}
				}
				//ȥ�����һ��|�ַ�
				if (arrSelectIndex.length > 1)
				{
					arrSelectIndex = arrSelectIndex.substring(0,arrSelectIndex.length - 1);
				}	
				
			}

			function selectField(condition)
			{
		
			    var arrIndex = arrSelectIndex.split('|');
				for(var i=1;i<= num;i++)
				{
					var selectID = "select" + i;
					//������ĳ���
					var j = document.all( selectID ).length;
		
					if( j > i )
					{
						j = i-1;
					}
					else
					{
						j = j -1;
					}
		

					if(condition == 1)
					{	
						if(i == num)
						{
							document.all( selectID ).options(0).selected = true;
						}
						else
						{
							document.all( selectID ).options(parseInt(arrIndex[i-1])).selected = true;
						}
					}
					else if(condition == 0)
					{
						document.all( selectID ).options(parseInt(arrIndex[i-1])).selected = true;
					}
				}
			}
	
			var arrInputLogic = "";
			function rememberInputLogic()
			{
				arrInputLogic = "";
				for(var i=2;i<= num;i++)
				{
					var selectID = "logical" + i;
					if (document.all( selectID ) != null)
					{
					arrInputLogic += document.all( selectID ).value + "|";
					}
				}
				if (arrInputLogic.length > 1)
				{
					arrInputLogic = arrInputLogic.substring(0,arrInputLogic.length - 1);
				}	
			}

			function selectLogic()
			{
			   if (arrInputLogic=='') return;
				var arrIndex = arrInputLogic.split('|');
				for(var i=2;i<= num;i++)
				{
					if (arrIndex[i-2] != null && arrIndex[i-2] != '')
					{
						var selectID = "logical" + i;
						document.all( selectID ).value=arrIndex[i-2];
					}
				}
			}
			
			function checkData()
			{
				if(query.dsource.value=="" )
				{
					alert('��ѡ������Դ!!!');
					return ;
				}
				if(query.table_name.value=="")
				{
					alert('��ѡ�����ݱ�!!!');
					return ;
				}
				
				if(validate("pageSize") == true)
				{
					document.getElementById("numCount").value = num;
					document.query.action = "selectedtabList.jsp";
					document.query.target = "queryList";
					query.submit();
				}
				else
				{
					return false;
				}
			}
			
			
			function checkSQLData()
			{
				if(sqlQuery.dsource2.value=="" )
				{
					alert('��ѡ������Դ!!!');
					return ;
				}
				if(sqlQuery.sqlContent.value=="" || sqlQuery.sqlContent.value.trim()=="")
				{
					alert('SQL��䲻��Ϊ��!!!');
					sqlQuery.sqlContent.focus();
					return ;
				}
				
				if(validate("pageSize2")==true)
				{
					document.sqlQuery.action = "sqltabList.jsp";
					document.sqlQuery.target = "sqlList";
					sqlQuery.submit();
				}
				else
				{
					return false;
				}
			}	
			
			function validate(objectName)
		  	{
		  		var pageSizeNode = document.getElementById(objectName);
		  		var pageSizeValue = pageSizeNode.value;
		  		 		
		  		if(pageSizeValue =='')
		  		{
		  			alert("ÿҳ��ʾ�ļ�¼��������Ϊ��!!!");
		  			pageSizeNode.value = 10;
		  			return false;
		  		}
		  		else if(pageSizeValue <= 0)
		  		{
		  			alert("ÿҳ��¼���������Ǵ���0!!!");
		  			pageSizeNode.value = 10;
		  			pageSizeNode.focus();
		  			return false;
		  		}
		  		else if(/^\d+$/.test(pageSizeValue) == false)
		  		{
		  			alert("ÿҳ��¼��������������!!!");
		  			pageSizeNode.value = 10;
		  			pageSizeNode.focus();
		  			return  false;
		  		}
		  		return true;
		  	}
		</SCRIPT>
	</head>
	
	<%@ include file="/epp/css/cssControl.jsp"%><body >
		<tab:tabContainer id="foo-menu-container" selectedTabPaneId="query-menu">
			<tab:tabPane id="query-menu" tabTitle="���ٲ�ѯ" lazeload="true">
				<form name="query" action="" method="post">
					<input type="hidden" name="numCount" id="numCount"/>
					<table cellspacing="1" cellpadding="0" border="0"
						bordercolor="#EEEEEE" width=98% class="thin">
						<tr valign='top'>
							<td height='30' valign='middle' colspan="5">
								<img src='../images/edit.gif' width="16" height="16" border=0
									align='middle'>
								&nbsp;
								<strong>���ݿ�����</strong>
							</td>
						</tr>
		
						<tr>
							<td colspan="1" height='30' valign='middle' align="center">
								����Դ��
								<select name="dsource">
									<option>--��ѡ������Դ--
									<%
										DBUtil db = new DBUtil();
										Enumeration dbPoolNameEnum = db.getAllPoolnames();
										
										for (; dbPoolNameEnum.hasMoreElements();) 
										{
											String dbPoolName = (String) dbPoolNameEnum.nextElement();
																
											String selected = dbPoolName.equals(dsource) ? "selected" : "";
											
									%>
									<option value="<%=dbPoolName%>" <%=selected %> >
										<%=dbPoolName%>
										<%
										}
										%>
								</select>
							</td>
		
						  <td colspan="2" height='30' valign='middle' align="center">
								��ѡ�����ݱ�:&nbsp;<input type="text" valign="middle" name="table_name" 
															value="<%=(table_name == null) ? "" : table_name%>" 
															id="table_name" align="center" readonly="readonly" 
															onclick="getTables(this)" size="35" />
						  </td>
						  <td colspan="1" height='30' valign='middle' align="center">
								ÿҳ��ʾ��¼��:<input name="pageSize" type="text" value="6" size="15"/>
						  </td>
						 <td colspan="1" height='30' valign='middle' align="center">
							<input name="search" type="button" class="input" value="��ѯ" onClick="checkData()"/>
						 </td>
						</tr>				
					</table>
					<br/>
					<br/>
					<div id="div1">
						<table cellspacing="1" cellpadding="0" border="0"
						bordercolor="#EEEEEE" width=98% class="thin">
							<tr>
								<td colspan="2" height='30' valign='middle' align="center" width="255">
									���ֶΣ�&nbsp;&nbsp;&nbsp;
									<select name=advancedField1 id="select1" onChange="getFields(this,1,document.getElementById('strOrDate1'))">
										<option value="">--��ѡ����ֶ�--
										<%
											for(int i=0; i<columnNameAndTypeList.size(); i++)
											{
												String columnNameAndType = (String) columnNameAndTypeList.get(i);
										%>
									  <option value="<%=columnNameAndType%>"><%=columnNameAndType.substring(0,columnNameAndType.indexOf("|")) %>
										<% 
											}
										 %>
									</select>
								</td>
								<td colspan="2" height='30' valign='middle' align="center">
									<div id="strOrDate1">
										�������������:&nbsp;&nbsp;<input type="text" name="advancedvalue1"/>
									</div>
									
								</td>
								<td width="16%" height='30' colspan="1" align="center" valign='middle'>
									<input name="add" type="button" class="input" value="����" onClick="changeFlag(1,1)">&nbsp;&nbsp;
									<input name="reduce" type="button" class="input" value="����" onClick="changeFlag(0,0)">
							  </td>
							</tr>
						</table>
					</div>
				</form>
				<tab:iframe id="queryList" name="queryList" src="" frameborder="0" width="99%" height="350px"/>
			</tab:tabPane>
			
			<tab:tabPane id="sql-menu" tabTitle="���ݿ����" lazeload="true">
				<form name="sqlQuery" action="" method="post">
					<input type="hidden" name="numCount" id="numCount"/>
					<table cellspacing="1" cellpadding="0" border="0"
						bordercolor="#EEEEEE" width=98% class="thin">
						<tr valign='top'>
							<td height='30' valign='middle' colspan="5">
								<img src='../images/edit.gif' width="16" height="16" border=0
									align='absmiddle'>
								&nbsp;
								<strong>���ݿ�����</strong>
							</td>
						</tr>
		
						<tr>
							<td colspan="1" height='30' valign='middle' align="center" width="35%" nowrap>
								����Դ��
								<select name="dsource2">
									<option>--��ѡ������Դ--
									<%
										DBUtil db2 = new DBUtil();
										Enumeration dbPoolNameEnum2 = db2.getAllPoolnames();
										
										for (; dbPoolNameEnum2.hasMoreElements();)
										 {
											String dbPoolName2 = (String) dbPoolNameEnum2.nextElement();
																
											String selected2 = dbPoolName2.equals(dsource) ? "selected" : "";
											
									%>
									<option value="<%=dbPoolName2%>" <%=selected2 %> >
										<%=dbPoolName2%>
										<%
										}
										%>
								</select>
							</td>
							<td colspan="1" valign='middle' align="center" width="15%" nowrap>
								ÿҳ��ʾ��¼��:&nbsp;<input name="pageSize2" type="text" value="6" size="8"/>
							</td>
							<td colspan="1" height='30' valign='middle' align="center" width="*" nowrap>
								<input name="search" type="button" class="input" value="ִ��" onClick="checkSQLData()"/>
								&nbsp;&nbsp;&nbsp;
								<input type="reset" class="input" value="����"/>
							</td>
						</tr>
						<tr>
							<td colspan="1"  valign='middle' align="center">
								SQL���:
							</td>
							<td colspan="2" valign='middle'>
								<textarea rows="5" name="sqlContent" cols="85"></textarea>
							</td>
						</tr>
					</table>
					<br/>
				<tab:iframe id="sqlList" name="sqlList" src="" frameborder="0" width="99%" height="350px"/>
			</tab:tabPane>
			
			<tab:tabPane id="tableinfo-menu" tabTitle="�������ɻ��ƹ���" lazeload="true">
				<tab:iframe id="tableinfo" name="tableinfo" src="tableinfo/tableinfoList_tab.jsp" frameborder="0" width="98%" height="550px"/>
			</tab:tabPane>
			
			<tab:tabPane id="poolmen-menu" tabTitle="���ӳ����" lazeload="true">
				<tab:iframe id="poolmen" name="poolmen" src="tableinfo/poolmanList.jsp" frameborder="0" width="100%" height="600px"/>
			</tab:tabPane>	
		</tab:tabContainer>
		<br/>
		<br/>	
	</body>
</html>

				