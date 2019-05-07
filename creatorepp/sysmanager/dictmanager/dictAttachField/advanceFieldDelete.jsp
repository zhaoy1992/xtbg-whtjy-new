<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../include/global1.jsp"%>
<%@ page import="com.frameworkset.dictionary.Data" %>
<%@ page import="com.chinacreator.dictionary.DictManager" %>
<%@ page import="com.chinacreator.dictionary.DictManagerImpl" %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.dictionary.DictAttachField"%>
<%  
    AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkManagerAccess(request,response);
    DictManager dictManager = new DictManagerImpl();
    
    String dicttypeId = (String)request.getParameter("dicttypeId");
    String tableColumn = (String)request.getParameter("tableColumn");
    String[] tableColumns = null;
    int deleteFlag = 0;
    tableColumn = tableColumn==null?"":tableColumn;
    if(!"".equals(tableColumn)){
        tableColumns = tableColumn.split(",");
        deleteFlag = dictManager.deleteDictdataAttachField(dicttypeId,tableColumns);
    }
%>  
    <script language="javascript">      
        //parent.win.close();
        <%
            if(deleteFlag==DictManager.ALL_DELETE_SUCCESS){
        %>
        	parent.win.alert("删除成功!") 
        	parent.win.close();	          	        	
        	parent.afterDeleteRefresh();
        <%
            }else if(deleteFlag==DictManager.ALL_DELETE_FAILD){
        %>
        	alert("字段已经有数据,删除失败!")
        <%
            }else{
        %>
            alert("部分附加字段已经有数据,删除失败!")
        <%
            }
        %>
    </script>
    