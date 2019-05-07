<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.chinacreator.dictionary.DictManager" %>
<%@ page import="com.chinacreator.dictionary.DictManagerImpl" %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.net.URLDecoder"%>
<%
    //�ɼ���ϵά��-----------------------------------------------    
    AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
    //ֱ�ӱ��� ���Ƿ�ҳ���� op=direct ֱ�ӱ���
    String op = (String)request.getParameter("op")==null?"":(String)request.getParameter("op");
    String orgId = (String)request.getParameter("sendOrgId")==null?"":(String)request.getParameter("sendOrgId");
    String dicttypeId = (String)request.getParameter("sendDicttypeId")==null?"":(String)request.getParameter("sendDicttypeId");
    String datas = (String)request.getParameter("selectedNodeValue")==null?"":(String)request.getParameter("selectedNodeValue");
    String un_datas = (String)request.getParameter("un_selectedNodeValue")==null?"":(String)request.getParameter("un_selectedNodeValue");
    String PAGE_QUERY_STRING = (String)request.getParameter("pager.PAGE_QUERY_STRING")==null?"":request.getParameter("pager.PAGE_QUERY_STRING");
        
    //����--����  utf-8
    if(!"direct".equals(op)){//��ҳ��ʱ��,����Ҫ������, ֱ�ӱ���, ����Ҫ������
	    datas = URLDecoder.decode(datas,"utf-8");
	    un_datas = URLDecoder.decode(un_datas,"utf-8");
    }
    
    String[] dictdataValues = null;
    String[] un_dictdataValues = null;
    if(datas!=null){
    	dictdataValues = datas.split(",");
    }
    if(un_datas!=null){
    	un_dictdataValues = un_datas.split(",");
    }
    DictManager dictManager = new DictManagerImpl();        
    dictManager.init(request, response);
    String errorMsg = "";
    if(dictdataValues!=null && un_dictdataValues!=null){
        //dictManager.storeOrgTaxcode(orgId,dicttypeId,dictdataValues);
        try{
    		dictManager.storeOrgTaxcode(orgId,dicttypeId,dictdataValues,un_dictdataValues);
    	}catch(Exception e){
    		errorMsg = accesscontroler.formatErrorMsg(e.getMessage());
    		e.printStackTrace();
    	}
    }
%>
<script language = "javascript">
<%    
    if(!"".equals(PAGE_QUERY_STRING)){
%>
        parent.location.href = "org_dictdataList.jsp?<%=PAGE_QUERY_STRING%>";      
<%
    }else{    
%> 
		var errorMsg = "<%=errorMsg%>";
		if(errorMsg == ""){
			parent.win.alert("�����ɹ�!");
		}else{
			parent.win.alert("����ʧ��!ԭ�����£�\n"+errorMsg);
		}
		parent.win.close();
	    
<%
    }
%>
</script>