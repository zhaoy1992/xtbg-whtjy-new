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
	//域,当是排序字段的时候,只能选number型的 fieldName=="field_order"
	String fieldName = request.getParameter("fieldName")==null?"":request.getParameter("fieldName");
	dbname = dbname==null?"":dbname;
	tablename = tablename==null?"":tablename;
	selected_column = selected_column==null?"":selected_column;
	other_selected = other_selected==null?"":other_selected;
	
	TableMetaData nameObj = DBUtil.getTableMetaData(dbname,tablename);
    
    //外键
    Set foreignKeys = nameObj.getForeignKeys();
    String foreignPrompt = "";
    Iterator foreignIt =  foreignKeys.iterator();
    boolean hasFK = false;
    if(foreignIt.hasNext()){
        hasFK = true;        
    	foreignPrompt = "<span style='color:red'>(有外键关联,维护方式,请查看【提示】!)</span>";
    }
	
	Set set = DBUtil.getColumnMetaDatas(dbname,tablename);	
	Iterator it = set.iterator();
	
	String did = request.getParameter("didcolumn");
	DictManager dicManager = new DictManagerImpl();
	String columnName = dicManager.getColumnName(did);
	
%>
<html>
    <head>
        <title>选择数据库字段</title>
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
   					<td height='30' colspan="8"><img src='../images/edit.gif' width="16" height="16" border=0 align='absmiddle'>&nbsp;<strong>选择数据库字段,请注意类型是否匹配<%=foreignPrompt%></strong></td>
 				</tr>
 				<tr>
					<!--设置分页表头-->
					<td class="headercolor" width="10"></td>
					<td class="headercolor" >能否为空</td>
					<td class="headercolor" >字段名称</td>
					<td class="headercolor" >字段类型</td> 
					<td class="headercolor" >字段长度</td>
					<td class="headercolor" >字段说明</td>
					<td class="headercolor" >是否主键</td>
					<td class="headercolor" >是否外键</td>
				</tr>
 			<%
			String setPKColumnName = "";
		    boolean hasSetPKColumn = false;
		    setPKColumnName = dicManager.getOtherDicttypePKColumnByTable(dbname,tablename);
 			while(it.hasNext()){
			    ColumnMetaData  metaData = (ColumnMetaData)it.next();
			    String isnullable = "可为空";
			    boolean isDateFlag = false;
			    if(metaData.getTypeName().equalsIgnoreCase("date")){
			        isDateFlag = true;
			    }
			    if("no".equalsIgnoreCase(metaData.getNullable())){
			        isnullable = "<span style='color:red'>不能为空<span>";
			    }
			    
			    //判断是否为主键 提示信息
			    
			    //判断是否是外键 提示信息
 			%>	
	 			<tr>	
	 				<td class="tablecells" nowrap="nowrap">
	 				    <%
	 				    //"field_value" 不是选择值(主键)字段
	 				    if(!"field_value".equalsIgnoreCase(fieldName)){
	 				        if(isDateFlag){
	 				        
	 				    %>
	 				        
	 				    <%
	 				        }else{
	 				            //排序字段,并且column不是number,不提供radio.--字典定义时外键也需过滤

	 				            if("field_order".equalsIgnoreCase(fieldName)){
	 				               // if("number".equalsIgnoreCase(metaData.getTypeName()) || "long".equalsIgnoreCase(metaData.getTypeName())
	 				               // 	|| "integer".equalsIgnoreCase(metaData.getTypeName())){
	 				               if(DictFieldTypeConfig.isDictFieldType(metaData.getTypeName(),DictFieldTypeConfig.NUMBER)){
	 				                	//System.out.println("外键吗？ = " + nameObj.getForeignKeyMetaData(metaData.getColumnName()));
	 				                	if(nameObj.getForeignKeyMetaData(metaData.getColumnName())==null){	 				                	
	 				    %>
	 				                    <input type="radio" style="text-align:left" name="columnname" onClick="selectOne('columnname',this)" value="<%=metaData.getColumnName()%>" width="10"> 
	 				    <%            
	 				                    }
	 				                }
	 				            }
	 				            //gao.tang update 20100507  如果为字典类型字段选择字段，并且选择的表为td_sm_dictdata，那么可以选择外键字段
	 				            else if("field_typeid".equalsIgnoreCase(fieldName) 
	 				            		&& "td_sm_dictdata".equalsIgnoreCase(tablename)){
	 				     %>
						            <input type="radio" name="columnname" style="text-align:left" onClick="selectOne('columnname',this)" value="<%=metaData.getColumnName()%>" width="10">
						<%        	
	 				            }else{
	 				            	//modify by ge.tao
	 				                //date 2008-01-24
	 				                //外键不允许配置, 但是field_create_orgId所属机构字段 和 field_parentid父类ID字段 可以选择外键: 
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
						}else{//选择值(主键)字段
						    //判断这个数据库表是否被其他字典类型映射, 如果映射了, 那么其他字典指定的值(主键)字段 是那个字段.
						    
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
					<!--是否主键-->
					<td class="tablecells" style="text-align:left" nowrap="nowrap">
					    <%
					        if(nameObj.getPrimaryKeyMetaData(metaData.getColumnName())!=null){
					    %>
					    <span style='color:red'>是主键</span>
					    <%        
					        }
					    %>
					</td>
					<!--是否外键-->
					<td class="tablecells" style="text-align:left" nowrap="nowrap">
					    <%
					        if(nameObj.getForeignKeyMetaData(metaData.getColumnName())!=null){
					    %>
					    <span style='color:red'>是外键</span>
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
		    	提示：<%=tablename%>表已经被其他字典引用, <br>
		    	&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
		    	并且指定了【值字段】字段为"<%=setPKColumnName%>",【值字段】指定的字段必须保持一致 
		    	</strong></span>		    
		    <%
		        }
		    %>
		    
		    <!--外键信息列表-->
		    <%
		    if(hasFK){
		    %>
		    <table cellspacing="1" cellpadding="0" border="0" width=98%  class="thin">
 				<tr valign='top'>
   					<td height='30'valign='middle' colspan="7"><img src='../images/edit.gif' width="16" height="16" border=0 align='absmiddle'>&nbsp;<strong>外键信息</strong></td>
 				</tr>
 				<tr>
					<!--设置分页表头-->
					<td class="headercolor" >外键关联表名</td> 
					<td class="headercolor" >外键在外键表字段名</td>
					<td class="headercolor" >主表名称</td>
					<td class="headercolor" >主表字段名</td>					
					<td class="headercolor" >外键名称</td>
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
		    <strong>提示:如果指定维护的表,有外键关联,必须先保证外键关联表也被配置成了字典,<br>
		              同时,必须把外键在【字典高级字段配置】模块中,配置成高级字段,<br>
		              而且,要求把输入类型配置成【选择字典】<br>
		              最后,还要求把字典的类型选择成"外键关联表"配置成的字典类型!
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
					    <input type="button" value="确定" class="input" onclick="save();">
						<input name="new" type="button" class="input" value="清除" onclick="removeValue('columnname')">
						<input name="new" type="button" class="input" value="关闭" onclick="winclose();">
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