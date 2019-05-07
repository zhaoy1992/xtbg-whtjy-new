<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%@ page import="com.frameworkset.common.poolman.sql.*"%>
<%@ page import="com.chinacreator.dictionary.DictManager"%>
<%@ page import="com.chinacreator.dictionary.DictManagerImpl"%>
<%@ page import="com.chinacreator.dictionary.DictFieldTypeConfig"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	String dbname = (String)request.getParameter("dbname");
	String tablename = (String)request.getParameter("tablename");
		String selected_column = (String)request.getParameter("column").toUpperCase();
	String other_selected = (String)request.getParameter("otherSelected");
	//��,���������ֶε�ʱ��,ֻ��ѡnumber�͵� fieldName=="field_order"
	String fieldName = request.getParameter("fieldName")==null?"":request.getParameter("fieldName");
	dbname = dbname==null?"":dbname;
	tablename = tablename==null?"":tablename;
	selected_column = selected_column==null?"":selected_column;
	other_selected = other_selected==null?"":other_selected;
	
	TableMetaData nameObj = DBUtil.getTableMetaData(dbname,tablename);
    
    //���
    Set foreignKeys = nameObj.getForeignKeys();
    String foreignPrompt = "";
    Iterator foreignIt =  foreignKeys.iterator();
    boolean hasFK = false;
    if(foreignIt.hasNext()){
        hasFK = true;        
    	foreignPrompt = "<span style='color:red'>(���������,ά����ʽ,��鿴����ʾ��!)</span>";
    }
	
	Set set = DBUtil.getColumnMetaDatas(dbname,tablename);	
	Iterator it = set.iterator();
	
	String did = request.getParameter("didcolumn");
	DictManager dicManager = new DictManagerImpl();
	String columnName = dicManager.getColumnName(did);
	
%>
<html>
    <head>
        <title>ѡ�����ݿ��ֶ�</title>
        <link href="<%=rootpath%>/cms/inc/css/cms.css" rel="stylesheet" type="text/css">		
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
		<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
		<script language="JavaScript" src="../user/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
    </head>
    <%@ include file="/epp/css/cssControl.jsp"%>
    <body>
		<form name="dictList" method="post" >
			<table cellspacing="1" cellpadding="0" border="0" width=98%  class="thin">
 				<tr valign='top'>
   					<td height='30' colspan="8"><img src='../images/edit.gif' width="16" height="16" border=0 align='absmiddle'>&nbsp;<strong>ѡ�����ݿ��ֶ�,��ע�������Ƿ�ƥ��<%=foreignPrompt%></strong></td>
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
			String setPKColumnName = "";
		    boolean hasSetPKColumn = false;
		    setPKColumnName = dicManager.getOtherDicttypePKColumnByTable(dbname,tablename);
 			while(it.hasNext()){
			    ColumnMetaData  metaData = (ColumnMetaData)it.next();
			    String isnullable = "��Ϊ��";
			    boolean isDateFlag = false;
			    if(metaData.getTypeName().equalsIgnoreCase("date")){
			        isDateFlag = true;
			    }
			    if("no".equalsIgnoreCase(metaData.getNullable())){
			        isnullable = "<span style='color:red'>����Ϊ��<span>";
			    }
			    
			    //�ж��Ƿ�Ϊ���� ��ʾ��Ϣ
			    
			    //�ж��Ƿ������ ��ʾ��Ϣ
 			%>	
	 			<tr>	
	 				<td class="tablecells" nowrap="nowrap">
	 				    <%
	 				    //"field_value" ����ѡ��ֵ(����)�ֶ�
	 				    if(!"field_value".equalsIgnoreCase(fieldName)){
	 				        if(isDateFlag){
	 				        
	 				    %>
	 				        
	 				    <%
	 				        }else{
	 				            //�����ֶ�,����column����number,���ṩradio.--�ֵ䶨��ʱ���Ҳ�����

	 				            if("field_order".equalsIgnoreCase(fieldName)){
	 				               // if("number".equalsIgnoreCase(metaData.getTypeName()) || "long".equalsIgnoreCase(metaData.getTypeName())
	 				               // 	|| "integer".equalsIgnoreCase(metaData.getTypeName())){
	 				               if(DictFieldTypeConfig.isDictFieldType(metaData.getTypeName(),DictFieldTypeConfig.NUMBER)){
	 				                	//System.out.println("����� = " + nameObj.getForeignKeyMetaData(metaData.getColumnName()));
	 				                	if(nameObj.getForeignKeyMetaData(metaData.getColumnName())==null){	 				                	
	 				    %>
	 				                    <input type="radio" style="text-align:left" name="columnname" onClick="selectOne('columnname',this)" value="<%=metaData.getColumnName()%>" width="10"> 
	 				    <%            
	 				                    }
	 				                }
	 				            }
	 				            //gao.tang update 20100507  ���Ϊ�ֵ������ֶ�ѡ���ֶΣ�����ѡ��ı�Ϊtd_sm_dictdata����ô����ѡ������ֶ�
	 				            else if("field_typeid".equalsIgnoreCase(fieldName) 
	 				            		&& "td_sm_dictdata".equalsIgnoreCase(tablename)){
	 				     %>
						            <input type="radio" name="columnname" style="text-align:left" onClick="selectOne('columnname',this)" value="<%=metaData.getColumnName()%>" width="10">
						<%        	
	 				            }else{
	 				            	//modify by ge.tao
	 				                //date 2008-01-24
	 				                //�������������, ����field_create_orgId���������ֶ� �� field_parentid����ID�ֶ� ����ѡ�����: 
	 				                //if(nameObj.getForeignKeyMetaData(metaData.getColumnName())==null || "field_parentid".equalsIgnoreCase(fieldName)){	
	 				            	if(nameObj.getForeignKeyMetaData(metaData.getColumnName())==null || "field_parentid".equalsIgnoreCase(fieldName) || "field_create_orgId".equalsIgnoreCase(fieldName)){
	 				            	
	 				            	if("field_data_validate".equalsIgnoreCase(fieldName) && DictFieldTypeConfig.isDictFieldType(metaData.getTypeName(),DictFieldTypeConfig.NUMBER)){
	 				    %>
	 				    		<input type="radio" name="columnname" style="text-align:left" onClick="selectOne('columnname',this)" value="<%=metaData.getColumnName()%>" width="10">
	 				    <%
	 				    	}else if(("field_name".equalsIgnoreCase(fieldName) || "field_typeid".equalsIgnoreCase(fieldName) || "field_create_orgId".equalsIgnoreCase(fieldName) || "field_parentid".equalsIgnoreCase(fieldName)) && DictFieldTypeConfig.isDictFieldType(metaData.getTypeName(),DictFieldTypeConfig.CHARACTER)){
	 				    %>
						            <input type="radio" name="columnname" style="text-align:left" onClick="selectOne('columnname',this)" value="<%=metaData.getColumnName()%>" width="10">
						<%
						            }
						            }
						        }
						    }
						}else{//ѡ��ֵ(����)�ֶ�
						    //�ж�������ݿ���Ƿ������ֵ�����ӳ��, ���ӳ����, ��ô�����ֵ�ָ����ֵ(����)�ֶ� ���Ǹ��ֶ�.
						    
						    if(!"".equals(setPKColumnName.trim()) && metaData.getColumnName().equalsIgnoreCase(setPKColumnName.trim()) && DictFieldTypeConfig.isDictFieldType(metaData.getTypeName(),DictFieldTypeConfig.CHARACTER)){
						        hasSetPKColumn = true;
						%>
						        <input type="radio" name="columnname" style="text-align:left" onClick="selectOne('columnname',this)" value="<%=metaData.getColumnName()%>" width="10">
						<%
						    }else if("".equals(setPKColumnName.trim()) && DictFieldTypeConfig.isDictFieldType(metaData.getTypeName(),DictFieldTypeConfig.CHARACTER)){
						%>
						        <input type="radio" name="columnname" style="text-align:left" onClick="selectOne('columnname',this)" value="<%=metaData.getColumnName()%>" width="10">
						<%    
						    }
						}
						%>
						
					</td>
					<td class="tablecells" style="text-align:left" nowrap="nowrap">
					    <%=isnullable%>
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
					    <%=null!=metaData.getRemarks()&&!metaData.getRemarks().trim().equals("null")?metaData.getRemarks():""%>
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

			<%
		        if(hasSetPKColumn){
		    %>		    
		    	<span style="color:red">
		    	<strong>
		    	��ʾ��<%=tablename%>���Ѿ��������ֵ�����, <br>
		    	&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
		    	����ָ���ˡ�ֵ�ֶΡ��ֶ�Ϊ"<%=setPKColumnName%>",��ֵ�ֶΡ�ָ�����ֶα��뱣��һ�� 
		    	</strong></span>		    
		    <%
		        }
		    %>
		    
		    <!--�����Ϣ�б�-->
		    <%
		    if(hasFK){
		    %>
		    <table cellspacing="1" cellpadding="0" border="0" width=98%  class="thin">
 				<tr valign='top'>
   					<td height='30'valign='middle' colspan="7"><img src='../images/edit.gif' width="16" height="16" border=0 align='absmiddle'>&nbsp;<strong>�����Ϣ</strong></td>
 				</tr>
 				<tr>
					<!--���÷�ҳ��ͷ-->
					<td class="headercolor" >�����������</td> 
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
					    <input type="button" value="ȷ��" class="input" onclick="save();">
						<input name="new" type="button" class="input" value="���" onclick="removeValue('columnname')">
						<input name="new" type="button" class="input" value="�ر�" onclick="winclose();">
					</td>
				</tr>
		    </table>	
		</form>
 	</body>
 	<script>
 		function save(){
 			setValue();
 			window.close();
 		}
 		
 		function winclose(){
 			window.returnValue =  "<%=selected_column%>";
 			window.close();
 		}
 	 	    
 	    function setValue(){
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
 	    window.onload = function autoRun(){
 	        var selected_value = "<%=selected_column%>";
 	        var arr = new Array();
 	        arr = document.getElementsByName("columnname");
 	        for(var i=0;i<arr.length;i++){
 	            if(arr[i].value==selected_value){
 	                arr[i].checked = true;
 	                //arr[i].disabled = true;
 	            }else{
 	                if(arr[i].value==window.dialogArguments.createTypeForm.db_name.value.toUpperCase() ||
				       arr[i].value==window.dialogArguments.createTypeForm.table_name.value.toUpperCase() || 
				       arr[i].value==window.dialogArguments.createTypeForm.field_name.value.toUpperCase() || 
				       arr[i].value==window.dialogArguments.createTypeForm.field_value.value.toUpperCase() || 
				       arr[i].value==window.dialogArguments.createTypeForm.field_order.value.toUpperCase() || 
				       arr[i].value==window.dialogArguments.createTypeForm.field_typeid.value.toUpperCase() ||
				       arr[i].value==window.dialogArguments.createTypeForm.field_data_validate.value.toUpperCase() ||
				       arr[i].value==window.dialogArguments.createTypeForm.field_create_orgId.value.toUpperCase() ||
				       (window.dialogArguments.createTypeForm.field_parentid !=null &&
				       arr[i].value==window.dialogArguments.createTypeForm.field_parentid.value.toUpperCase()) ){
				          arr[i].disabled = true;
				    }
				    var colum = "<%=columnName%>";
				    if(colum!=""){
				    	var colums = colum.split(",");
				    	for(var j=0;j<colums.length;j++){
				            if(arr[i].value==colums[j]){
				                arr[i].disabled = true;
				            }
				        }
				    }
				    var other_selected = "<%=other_selected%>";
				    if(other_selected!=""){
				        var others = other_selected.split(",");
				        for(var j=0;j<others.length;j++){
				            if(arr[i].value==others[j]){
				                arr[i].disabled = true;
				            }
				        }
				    }
				    
 	            }
 	        }
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