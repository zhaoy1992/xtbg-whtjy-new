<%     
  response.setHeader("Cache-Control", "no-cache"); 
  response.setHeader("Pragma", "no-cache"); 
  response.setDateHeader("Expires", -1);  
  response.setDateHeader("max-age", 0); 
%>
<%
/**
 * 
 * <p>Title: �ؼ�������ҳ��</p>
 *
 * <p>Description: �ؼ�������ҳ��</p>
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

	String dictTypeId = request.getParameter("dictTypeId");//�ֵ�����ID
	String dbname = (String)request.getParameter("dbname");//���ݿ�����
	String tablename = (String)request.getParameter("tablename");//������
	
	TableMetaData nameObj = DBUtil.getTableMetaData(dbname,tablename);
	Set set = DBUtil.getColumnMetaDatas(dbname,tablename);	
	Iterator it = set.iterator();
	
	Data data = dicManager.getDicttypeById(dictTypeId);
	String name = data.getName();//�ֵ�����
	DictKeyWordManager dictKeyWordManager = new DictKeyWordManagerImpl();
	KeyWord keyWord = null;
	Map map = dictKeyWordManager.getAllKeyWords(dictTypeId);
	Map mapAll = dictKeyWordManager.getAllDictFields(dictTypeId);
	//�ֵ任����ֵĶ���ؼ�����
	Map mapAllKey = dictKeyWordManager.getInvalidationKeys(dictTypeId,dbname,tablename);
	boolean isAppear = false;
%>
<html>
    <head>
    <base target="_self">
        <title>�ֵ䡾<%=name%>���ؼ��ֶζ���</title>
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
					�ؼ��ֶε�ֵ���ܱ��޸�
				</strong>
				</td>
				</tr>
 				<tr>
					<!--���÷�ҳ��ͷ-->
					<td class="headercolor" width="10">
					<P align="left">
					<INPUT type="checkbox" name="checkBoxAll" onclick="checkAll('checkBoxAll','checkBoxOne')" value="on">
					</P>
					</td>
					<td class="headercolor" >�ܷ�Ϊ��</td>
					<td class="headercolor" >�ֶ�����</td>
					<td class="headercolor" >�ֶ�����</td> 
					<td class="headercolor" >�ֶγ���</td>
					<td class="headercolor" >�ֶ�˵��</td>
					<td class="headercolor" >�Ƿ�����</td>
					<td class="headercolor" >�Ƿ����</td>
					<td class="headercolor" >java��������</td>
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
			    String columnName = metaData.getColumnName();
			    if(mapAll.get(columnName) != null){
			    //�ж��Ƿ�Ϊ���� ��ʾ��Ϣ
			    
			    //�ж��Ƿ������ ��ʾ��Ϣ
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
					<input type="button" value="ȷ��" class="input" onclick="saveKeyField()">
					<input name="col" type="button" class="input" value="�ر�" onclick="window.close();window.returnValue='ok';">
			</td>
			</tr>
		    </table>
		    <%
		    	//����֮���γɵĶ���ؼ��ֶ����ֵ任�������úõĹؼ��ֶε���ʾ
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