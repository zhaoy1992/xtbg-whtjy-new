<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.chinacreator.dictionary.DictManager" %>
<%@ page import="com.chinacreator.dictionary.DictManagerImpl" %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
    AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
    
    String orgId = (String)request.getParameter("orgId");
    String dicttypeId = (String)request.getParameter("dicttypeId");
    String datas = (String)request.getParameter("dicttypeValues");        
    String[] dictdataValues = null;
    if(datas!=null){
    	dictdataValues = datas.split(",");
    }
    DictManager dictManager = new DictManagerImpl();    
    if(dictdataValues!=null){
        System.out.println(dictdataValues.length);
    	dictManager.storeUsualOrgTaxcode(orgId,dicttypeId,dictdataValues);
    }
    
%>
	<script language="javascript">		
		parent.win.alert("²Ù×÷³É¹¦!");
		parent.win.close();
	</script>