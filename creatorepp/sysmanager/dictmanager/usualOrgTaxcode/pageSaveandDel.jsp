<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.chinacreator.dictionary.DictManager" %>
<%@ page import="com.chinacreator.dictionary.DictManagerImpl" %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.net.URLDecoder"%>
<%
    //�ɼ���ϵά��-----------------------------------------------    
    AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	DictManager dictManager = new DictManagerImpl();
    
    String dicttypeId = request.getParameter("sendDicttypeId");
    String orgId = request.getParameter("sendOrgId");
    String readOp = request.getParameter("readOp");
    
    String PAGE_QUERY_STRING = (String)request.getParameter("pager.PAGE_QUERY_STRING")==null?"":request.getParameter("pager.PAGE_QUERY_STRING");
    
    if(readOp.equals("save")){
    	String dictdataValues = request.getParameter("selectedNodeValue");
    	dictdataValues = URLDecoder.decode(dictdataValues,"utf-8");
    	String[] dictdataValue = dictdataValues.split(",");
    	dictManager.store_UsualOrgTaxcode(orgId,dicttypeId,dictdataValue);
    }
    if(readOp.equals("del")){
    	String dictdataValues = request.getParameter("selectedNodeValue");
    	dictdataValues = URLDecoder.decode(dictdataValues,"utf-8");
    	String[] dictdataValue = dictdataValues.split(",");
    	dictManager.delete_UsualOrgTaxcode(orgId,dicttypeId,dictdataValue);
    }
%>
<script language="javascript">
<%if(readOp.equals("save")){%>
	parent.document.location.href = "org_dictdataList.jsp?<%=PAGE_QUERY_STRING%>";
	parent.parent.refurbishIframe(); 
<%}%>

<%if(readOp.equals("del")){%>
	parent.document.location.href = "org_dictdataSelectedList.jsp?<%=PAGE_QUERY_STRING%>";
	parent.parent.refurbishIframeSelected(); 
<%}%>

<%if(readOp.equals("")){%>
	var str = parent.document.location.href;
	str = str.substring(0,str.indexOf("?"));
	parent.document.location.href = str+"?<%=PAGE_QUERY_STRING%>";
<%}%>
</script>
