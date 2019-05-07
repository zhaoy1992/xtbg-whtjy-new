<%     
  response.setHeader("Cache-Control", "no-cache"); 
  response.setHeader("Pragma", "no-cache"); 
  response.setDateHeader("Expires", -1);  
  response.setDateHeader("max-age", 0); 
%>
<%
/**
 * 
 * <p>Title: 关键字设置页面</p>
 *
 * <p>Description: 关键字设置页面</p>
 *
 * <p>Copyright: Copyright (c) 2007</p>
 *
 * <p>Company: chinacreator</p>
 * @Date 2006-9-15
 * @author gao.tang
 * @version 1.0
 */
 %>
 
<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%@ page import="com.frameworkset.common.poolman.sql.*"%>
<%@ page import="com.chinacreator.dictionary.DictManager"%>
<%@ page import="com.chinacreator.dictionary.DictManagerImpl,
				com.frameworkset.dictionary.Data,
 				com.chinacreator.dictionary.DictKeyWordManager,
 				com.chinacreator.dictionary.DictKeyWordManagerImpl,
 				com.chinacreator.dictionary.KeyWord,
 				java.util.Map"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	DictManager dicManager = new DictManagerImpl();

	String dictTypeId = request.getParameter("dictTypeId");//字典类型ID
	String dbname = (String)request.getParameter("dbname");//数据库名称
	String tablename = (String)request.getParameter("tablename");//表名称
	
	TableMetaData nameObj = DBUtil.getTableMetaData(dbname,tablename);
	Set set = DBUtil.getColumnMetaDatas(dbname,tablename);	
	Iterator it = set.iterator();
	
	Data data = dicManager.getDicttypeById(dictTypeId);
	String name = data.getName();//字典名称
	DictKeyWordManager dictKeyWordManager = new DictKeyWordManagerImpl();
	KeyWord keyWord = null;
	Map map = dictKeyWordManager.getAllKeyWords(dictTypeId);
	Map mapAll = dictKeyWordManager.getAllDictFields(dictTypeId);
	//字典换表出现的多余关键字项
	Map mapAllKey = dictKeyWordManager.getInvalidationKeys(dictTypeId,dbname,tablename);
	boolean isAppear = false;
%>
<html>
    <head>
    <base target="_self">
        <title>字典【<%=name%>】关键字段定义</title>
        <link href="<%=rootpath%>/cms/inc/css/cms.css" rel="stylesheet" type="text/css">		
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
		<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
		<script language="JavaScript" src="../user/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
    </head>
    <%@ include file="/epp/css/cssControl.jsp"%><body  onunload="window.returnValue='ok';">
		<form name="dictList" method="post" >
			<table cellspacing="1" cellpadding="0" border="0" width=98%  class="thin">
			<input name="checkValues" type="hidden" value="" />
				<tr>
				<td colspan="9"><img src='../images/edit.gif' width="16" height="16" border=0 align='absmiddle'>&nbsp;<strong>
					关键字段的值不能被修改
				</strong>
				</td>
				</tr>
 				<tr>
					<!--设置分页表头-->
					<td class="headercolor" width="10">
					<P align="left">
					<INPUT type="checkbox" name="checkBoxAll" onclick="checkAll('checkBoxAll','checkBoxOne')" value="on">
					</P>
					</td>
					<td class="headercolor" >能否为空</td>
					<td class="headercolor" >字段名称</td>
					<td class="headercolor" >字段类型</td> 
					<td class="headercolor" >字段长度</td>
					<td class="headercolor" >字段说明</td>
					<td class="headercolor" >是否主键</td>
					<td class="headercolor" >是否外键</td>
					<td class="headercolor" >java属性名称</td>
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
			    String columnName = metaData.getColumnName();
			    if(mapAll.get(columnName) != null){
			    //判断是否为主键 提示信息
			    
			    //判断是否是外键 提示信息
 			%>	
	 			<tr>	
	 				<td class="tablecells" nowrap="nowrap">
 				    	<P align="left">
							<input type="checkbox" name="checkBoxOne" onclick="checkOne('checkBoxAll','checkBoxOne')" value='<%=metaData.getColumnName()%>'
							<%
								if(map.get(columnName) != null){
									keyWord = (KeyWord)map.get(columnName);
							%>
								checked="true"
							<%
								}
							%>
							 />
						</P>
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
					<td class="tablecells" style="text-align:left" >
					    <%=null!=metaData.getRemarks()&&!metaData.getRemarks().trim().equals("")?metaData.getRemarks():""%>
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
					<td class="tablecells" style="text-align:left" nowrap="nowrap">
					    <input type="text" name="javaProperty" value="<%=map.get(columnName)==null?"":keyWord.getJavaProperty()%>">
					</td>
				</tr>
				
			<%
			    }else{
			    	if(map.get(columnName) != null){
			    		isAppear = true;
			    	}
			    }
			    }
			%>
			<tr>
			<td  align="left" colspan="9" nowrap>
					<input type="button" value="确定" class="input" onclick="saveKeyField()">
					<input name="col" type="button" class="input" value="关闭" onclick="window.close();window.returnValue='ok';">
			</td>
			</tr>
		    </table>
		    <%
		    	//换表之后形成的多余关键字段与字典换了已设置好的关键字段的显示
		    	if(isAppear || (mapAllKey.size() > 0 && mapAllKey != null)){
		    %>
		    <table cellspacing="1" cellpadding="0" border="0" width=98% height="100%"  class="thin">
		    <tr>
		    <td>
		    	<iframe src="invalidationKey_iframe.jsp?dictTypeId=<%=dictTypeId%>&dbname=<%=dbname%>&tablename=<%=tablename%>" name="invalidationKey" style="width:100%" height="100%" scrolling="no" frameborder="0" marginwidth="1" marginheight="1"></iframe>
		    </td>
		    </tr>
		    </table>
		    <%
		    	}
		    %>
		</form>
	
 	</body>
 	<iframe name="hiddenFrame" width="0" height="0"></iframe>
 	<script> 	    
 	   function saveKeyField(){
 	   		var obj = document.getElementsByName("checkBoxOne");
 	   		var obj2 = document.getElementsByName("javaProperty");
 	   		var checkValues = "";
 	   		for(var i = 0; i < obj.length; i++){
 	   			if(obj[i].checked){
 	   				if(checkValues == ""){
 	   					checkValues = obj[i].value+"#-#"+obj2[i].value+" ";
 	   				}else{
 	   					checkValues += "-#-" + obj[i].value+"#-#"+obj2[i].value+" ";
 	   				}
 	   			}
 	   		}
 	   		document.dictList.checkValues.value = checkValues;
 	   		document.dictList.target = "hiddenFrame";
 	   		document.dictList.action = "keySave_handle.jsp?dictTypeId=<%=dictTypeId%>";
 	   		document.dictList.submit();		
 	   }
 	   
 	   function winClose(){
 	   		window.close();
 	   		window.returnValue = "ok";
 	   }
 	   
 	   function parentSubmit(){
 	   	document.forms[0].action = document.location.href;
	   	document.forms[0].submit();
	   }
 	</script>
</html>