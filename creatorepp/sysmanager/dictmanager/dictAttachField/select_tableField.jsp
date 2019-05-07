<%@ include file="../../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%@ page import="com.frameworkset.common.poolman.sql.*"%>
<%@ page import="com.frameworkset.dictionary.Data" %>
<%@ page import="com.chinacreator.dictionary.DictManager" %>
<%@ page import="com.chinacreator.dictionary.DictManagerImpl" %>
<%@ page import="com.chinacreator.dictionary.input.InputTypeManagerImpl" %>
<%@ page import="com.chinacreator.dictionary.input.InputTypeManager" %>
<%@ page import="com.chinacreator.dictionary.input.InputType" %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	
	String dicttypeId = (String)request.getParameter("dicttypeId");
	
	
    dicttypeId = dicttypeId==null?"":dicttypeId;
    DictManager dictManager = new DictManagerImpl();  
      
    Data dicttype = null;
    String dictName = "";
    String dbname = "";
	String tablename = "";
	String selected_column = (String)request.getParameter("column"); 
	String selected_dicttypeField= request.getParameter("fieldName");
    if(dicttypeId.trim().length()>0){
    	dicttype = dictManager.getDicttypeById(dicttypeId);
    	dictName = dicttype.getName();
    	dbname = dicttype.getDataDBName();
        tablename = dicttype.getDataTableName();
    }

	dbname = dbname==null?"":dbname;
	tablename = tablename==null?"":tablename;
	selected_column = selected_column==null?"":selected_column;
	
	TableMetaData nameObj = DBUtil.getTableMetaData(dbname,tablename);    
    //���
    Set foreignKeys = nameObj.getForeignKeys();
    String foreignPrompt = "";
    Iterator foreignIt =  foreignKeys.iterator();
    boolean hasFK = false;
    if(foreignIt.hasNext()){
        hasFK = true;        
    	foreignPrompt = "<span style='color:red'>(���������,���ܵ���ά��!)</span>";
    }

	Set set = DBUtil.getColumnMetaDatas(dbname,tablename);	
	Iterator it = set.iterator();
	
%>
<html>
    <head>
        <title>ѡ�����ݿ��ֶ�</title>
        <link href="<%=rootpath%>/cms/inc/css/cms.css" rel="stylesheet" type="text/css">		
		<link rel="stylesheet" type="text/css" href="../../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../../css/tab.winclassic.css">
		<script language="JavaScript" src="../../include/pager.js" type="text/javascript"></script>
		<script language="JavaScript" src="../../user/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="../../include/pager.js" type="text/javascript"></script>
    </head>
    <%@ include file="/epp/css/cssControl.jsp"%><body >
		<form name="dictList" method="post" >
			<table cellspacing="1" cellpadding="0" border="0" width=98%  class="thin">
 				<tr valign='top'>
   					<td height='30'valign='middle' colspan="8"><img src='../../images/edit.gif' width="16" height="16" border=0 align='absmiddle'>&nbsp;<strong>ѡ�����ݿ��ֶ�,��ע�������Ƿ�ƥ��<%=foreignPrompt%></strong></td>
 				</tr>
 				<tr>
					<!--���÷�ҳ��ͷ-->
					<td class="headercolor" width="10"></td>
					<td class="headercolor" >�ܷ�Ϊ��</td>
					<td class="headercolor" >�ֶ�����</td>					
					<td class="headercolor" >�ֶ�����</td>
					<td class="headercolor" >�ֶγ���</td>
					<td class="headercolor" >�ֶ�˵��</td>
					<td class="headercolor" >�Ƿ�����</td>
					<td class="headercolor" >�Ƿ����</td>
					
				</tr>
 			<%
 			while(it.hasNext()){
			    ColumnMetaData  metaData = (ColumnMetaData)it.next();		
			    
				int flag = dictManager.advanceColumnUseStatue(dicttype,metaData.getColumnName(),selected_column);
				String checkStr = "";
				if(flag == DictManager.COLUMN_SELECTED){
				    checkStr = "checked=true";
				}else if(flag == DictManager.COLUMN_USED){
				    checkStr = "disabled=true";
				}
				else if(flag == DictManager.COLUMN_ADVANCE_USED)	
				{
					if(selected_dicttypeField != null && selected_dicttypeField.equals("field_parentid"))
					{
					}
					else
					{
						checkStr = "disabled=true";
					}
				}
				String isnullable = "��Ϊ��";
			    if("no".equalsIgnoreCase(metaData.getNullable())){
			        isnullable = "����Ϊ��";
			    }
			    String isunique = "nounique";
			    if(nameObj.getPrimaryKeyMetaData(metaData.getColumnName())!=null){
			    	isunique = "unique";
			    }
 			    
 			%>	
	 			<tr>	
	 				<td class="tablecells" style="text-align:left" nowrap="nowrap">
						<input type="radio" name="columnname" onClick="selectOne('columnname',this)" value="<%=metaData.getColumnName()%>:<%=isnullable%>:<%=isunique%>" <%=checkStr%> width="10">
					</td>
					<td class="tablecells" style="text-align:left" nowrap="nowrap">
						<%if(isnullable.equals("����Ϊ��")){%>
					    	<span style='color:red'><%=isnullable%><span>
					    <%}else{%>
					    	<%=isnullable%>
					    <%}%>
					</td>
					<td class="tablecells" style="text-align:left" nowrap="nowrap">
					    <%=metaData.getColumnName()%>
					</td>
					
					<td class="tablecells" style="text-align:left" nowrap="nowrap">
					    <%=metaData.getTypeName()%>
					</td>
					<td class="tablecells" style="text-align:left" nowrap="nowrap">
					    <%=metaData.getColunmSize()%>
					</td>
					<td class="tablecells" style="text-align:left" nowrap="nowrap">
					    <%=null!=metaData.getRemarks()&&!metaData.getRemarks().trim().equals("")?metaData.getRemarks():""%>
					</td>
					<!--�Ƿ�����-->
					<td class="tablecells" style="text-align:left" nowrap="nowrap">
					    <%
					        if(nameObj.getPrimaryKeyMetaData(metaData.getColumnName())!=null){
					    %>
					    <span style='color:red'>������</span>
					    <%        
					        }
					    %>
					</td>
					<!--�Ƿ����-->
					<td class="tablecells" style="text-align:left" nowrap="nowrap">
					    <%
					        if(nameObj.getForeignKeyMetaData(metaData.getColumnName())!=null){
					    %>
					    <span style='color:red'>�����</span>
					    <%        
					        }
					    %>
					</td>
					
				</tr>
			<%
			    }
			%>
		    </table>
		    
		    <!--�����Ϣ�б�-->
		    <%
		    if(hasFK){
		    %>
		    <table cellspacing="1" cellpadding="0" border="0" width=98%  class="thin">
 				<tr valign='top'>
   					<td height='30'valign='middle' colspan="7"><img src='../../images/edit.gif' width="16" height="16" border=0 align='absmiddle'>&nbsp;<strong>�����Ϣ</strong></td>
 				</tr>
 				<tr>
					<!--���÷�ҳ��ͷ-->
					<td class="headercolor" >�����������</td> 
					<td class="headercolor" >��������ֵ�����</td> 
					<td class="headercolor" >�����������ֶ���</td>
					<td class="headercolor" >��������</td>
					<td class="headercolor" >�����ֶ���</td>					
					<td class="headercolor" >�������</td>
				</tr>
				
				<%
	 			    while(foreignIt.hasNext()){
	 			        ForeignKeyMetaData fmeta = (ForeignKeyMetaData)foreignIt.next(); 			    
 			    %>
 			    <tr>    
 			        <td class="tablecells" nowrap="nowrap">
					    <span style="color:red"><%=fmeta.getPKTABLE_NAME()%></span>
					</td>
					<td class="tablecells" nowrap="nowrap">
					    <span style="color:red"><%=dictManager.getDicttypeNames(fmeta.getPKTABLE_NAME())%></span>
					</td>
					<td class="tablecells" nowrap="nowrap">
					    <span style="color:red"><%=fmeta.getPKCOLUMN_NAME()%></span>
					</td>					
					<td class="tablecells" nowrap="nowrap">
					    <%=fmeta.getFKTABLE_NAME()%>
					</td>
					<td class="tablecells" nowrap="nowrap">
					    <%=fmeta.getFKCOLUMN_NAME()%>
					</td>
					<td class="tablecells" nowrap="nowrap">
					    <%=fmeta.getFK_NAME()%>
					</td>
                </tr>			
 			    <%    
 			       }
 			    %>		    
		    </table>
		    <strong>��ʾ:���ָ��ά���ı�,���������,�����ȱ�֤���������Ҳ�����ó����ֵ�,<br>
		              ͬʱ,���������ڡ��ֵ�߼��ֶ����á�ģ����,���óɸ߼��ֶ�,<br>
		              ����,Ҫ��������������óɡ�ѡ���ֵ䡿<br>
		              ���,��Ҫ����ֵ������ѡ���"���������"���óɵ��ֵ�����!
		    </strong>
		    <%
		    }
		    %>
		    
			<table cellspacing="1" cellpadding="0" border="0" width=98%  >
			    <tr height="18px" class="labeltable_middle_tr_01">
			        <td align='center'></td>
					<td align='right'></td>
			    </tr>
			    <tr height="18px" class="labeltable_middle_tr_01">
					<td align='center'></td>
					<td  align="center" colspan="1" nowrap>
					    <input type="button" value="ȷ��" class="input" onclick="window.close()">
						<input name="new" type="button" class="input" value="���" onclick="removeValue('columnname')">
						<input name="new" type="button" class="input" value="�ر�" onclick="window.close()">
					</td>
				</tr>
		    </table>	
		</form>
 	</body>
 	<script> 	    
 	    window.onunload = function setValue(){
 	        var select_value = "";
 	        var arr = new Array();
 	        arr = document.getElementsByName("columnname");
 	        for(var i=0;i<arr.length;i++){
 	            if(arr[i].checked==true){
 	                select_value = arr[i].value;
 	                break;
 	            }
 	        }
 	        window.returnValue = select_value;
 	    } 
 	    function selectOne(checkbox_name,e){
 	        arr = document.getElementsByName(checkbox_name);
 	        for(var i=0;i<arr.length;i++){
 	            if(arr[i].value==e.value){
 	                arr[i].checked = true;
 	            }else{
 	                arr[i].checked = false;
 	            }
 	        }
 	    }
 	    function removeValue(checkbox_name){
 	        arr = document.getElementsByName(checkbox_name);
 	        for(var i=0;i<arr.length;i++){ 	            
 	            arr[i].checked = false; 	            
 	        }
 	    }	    
 	   
 	</script>
</html>