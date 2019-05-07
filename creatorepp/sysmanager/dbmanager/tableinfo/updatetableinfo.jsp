
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.dbmanager.TableInfoManager"%>
<%@ page import="com.chinacreator.dbmanager.TableInfoManagerImpl"%>
<%@ page import="com.chinacreator.dbmanager.TableInfoEntity"%>
<%@ page import="com.frameworkset.common.poolman.sql.TableMetaData"%>
<%@ page import="com.frameworkset.common.poolman.sql.ColumnMetaData"%>
<%@ page import="com.frameworkset.common.poolman.sql.PrimaryKeyMetaData"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%@ page import="java.util.Set"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>



<%
		AccessControl accesscontroler = AccessControl.getInstance();
	    if(!accesscontroler.checkAdminAccess(request, response)){
			return;	
		}
	    
	    String db = request.getParameter("db");
	    String tableName = request.getParameter("tablename");
	    
	    db = db == null ? "" : db;
		tableName = tableName == null ? "" : tableName;
	    
	    String keyName = "";
		String keyIncrement = "";
	    String currentKeyValue = "";
		String keyGenerator = "";
		String keyPrefix = "";
		String keyType = "";
			
			
	    
	    if(!db.trim().equals("")  && !tableName.trim().equals(""))
	    {
	    	try
	    	{
		    	TableInfoManager tableInfoManager = new TableInfoManagerImpl();
			    TableInfoEntity tableInfoEntity = tableInfoManager.getTableInfoEntity(db,tableName);	    	
			    
			    keyName = tableInfoEntity.getTableKeyName();
			    keyIncrement = tableInfoEntity.getKeyIncrement() +"";
			    currentKeyValue = tableInfoEntity.getCurrentKeyValue() + "";
			    keyGenerator = tableInfoEntity.getKeyGenerator();
			    keyPrefix = tableInfoEntity.getKeyPrefix();
			    keyType = tableInfoEntity.getKeyType();
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
	    }
%>

<html>
	<head>     
    	<title>��������޸Ľ���</title> 
		<script language="JavaScript" src="../../scripts/common.js" type="text/javascript"></script>		
		<script language="javaScript" src="../../scripts/validateForm.js"></script> 
		<link rel="stylesheet" type="text/css" href="../../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../../css/treeview.css">
		<script language="javaScript">
			function addInfo()
			{  
				 
				  var tableName = document.all.tableName.value ;
				  if(tableName =="")
				  {
				    alert("���ݱ�����Ʋ��ܿգ�");
				    return false ;
				  }
				  
				   var keyName = document.all.keyName.value ;
				  if(keyName == "")
				  {
				  	alert('�������Ʋ��ܿ�!');
				  	return false ;
				  }
				  
				  
				  var keyType = document.all.keyType.value ;
				  if(keyType == "")
				  {
				  	alert("�������Ͳ���Ϊ��!");
				  	return false ;
				  }
				  
				  //����������ΪsequenceΪʱ,�Զ����������ܿ�
				  var keyGenerator = document.all.keyGenerator.value ;
				  if(keyType == "sequence")
				  {
				  	if(keyGenerator.replace(/\s/g,"") == "" || keyGenerator.length < 1)
				  	{
				  		alert("����������Ϊsequenceʱ,�Զ����������ܿ�!");
				  		return false ;
				  	}
				  }
				  
				  
				  
				  document.all("save").disabled = true ;
				  document.all("reset").disabled = true ;
				  document.all("back").disabled = true ;
				  
				  document.tableForm.action = "updatetableinfo_do.jsp";
				  document.tableForm.target = "hiddenFrame";
				  document.tableForm.submit();
			}
		</script>
	</head>

	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin">
		<div id="contentborder">
			<form name="tableForm" action="" method="post"  >	
				<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
					<tr >    
					    <td align="center" class="detailtitle" width="15%" nowrap>����Դ����</td>
					    <td class="detailcontent" width="20%" nowrap>
					  		<input type="text" name="db" value="<%=db%>" size="35" readOnly="readOnly"/>  	
					    </td>	
					    
						<td align="center" class="detailtitle" width="15%" nowrap>���ݱ�����</td>
					    <td class="detailcontent" width="*" nowrap>
					    	<input type="text" name="tableName" value="<%=tableName%>" size="45" readOnly="readOnly"/>  	
					    </td>	   
					  </tr>
					  
					   <tr>
					  	<td align="center" class="detailtitle" width="15%" nowrap>��������</td>
					    <td class="detailcontent" width="20%" nowrap>
					    	<select name="keyName" id="keyName">
								<option value="">--��ѡ������������--
								<%
									//��ȡ����ֶ���Ϣ
									DBUtil dbUtil = new DBUtil();
									Set keyMetaDataSet = dbUtil.getPrimaryKeyMetaDatas(db,tableName);
									for (Iterator iter = keyMetaDataSet.iterator(); iter.hasNext();) 
									{
										PrimaryKeyMetaData primaryKeyMetaData = (PrimaryKeyMetaData) iter.next();
										String columnName =primaryKeyMetaData.getColumnName();
								%>
     							<option value="<%=columnName%>" <%=keyName.equalsIgnoreCase(columnName) ? "selected" : ""%> ><%=columnName%>
								<%
									}		
												
								%>
							</select>
					    </td>
						<td class="detailcontent" width="15%" nowrap>��������</td>	   
						<td class="detailcontent" width="*" nowrap>
							<select name="keyType">
								<option value="">----��ѡ������������----
								<option value="string" <%=keyType.equals("string") ? "selected" : ""%> >�ı���
								<option value="int" <%=keyType.equals("int") ? "selected" : ""%> >������
								<option value="sequence" <%=keyType.equals("sequence") ? "selected" : ""%> >sequence
							</select>
						</td>
					  </tr> 
					  
					  <tr>
					    <td align="center" class="detailtitle" width="15%" nowrap>����������</td>
					    <td class="detailcontent" width="20%" nowrap>
					    	<input name="keyIncrement" type="text" size="35" value="<%=keyIncrement%>"/>
					    </td>	
						<td align="center" class="detailtitle" width="15%" nowrap>������ǰֵ</td>
					    <td class="detailcontent" width="*" nowrap>
					    	<input name="currentKeyValue" type="text" size="45" value="<%=currentKeyValue%>"/>
						</td>
					  </tr>
					  
					  <tr>
					    <td align="center" class="detailtitle" width="15%" nowrap>�Զ�������</td>
					    <td class="detailcontent" width="20%" nowrap>
					    	<input name="keyGenerator" type="text" size="35" value="<%=keyGenerator%>"/>
					    </td>	
						<td align="center" class="detailtitle" width="15%" nowrap>�ؼ���ǰ׺</td>
					    <td class="detailcontent" width="*" nowrap>
					    	<input name="keyPrefix" type="text" size="45" value="<%=keyPrefix%>"/>
					    </td>	
					  </tr>
					    
					  <tr>
					  	<td colspan="4" class="detailcontent" align="center" height="30">
					  		<input type="button" name="save" value="����" class="input" onclick="addInfo()"/>&nbsp;&nbsp;
					  		<input type="reset" name="reset" value="����" class="input"/>&nbsp;&nbsp;
					  		<input type="button" name="back" value="����" class="input" onclick="window.close();"/>	
					  	</td>
					  </tr>
				</table>	
			</form>
		</div>
		<iframe src="" width="0" height="0" name="hiddenFrame"></iframe>
	</body>
</html>