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
    
    String dicttypeId = request.getParameter("dicttypeId");
    //�û���Ȩ���¼��򱾼�����ID
    String orgId = request.getParameter("orgId");
    String state = request.getParameter("state");
    String data_org = request.getParameter("data_org");
    //�û���������ID
    String curOrg = accesscontroler.getChargeOrgId();
    String hintStr = "";
    if(!data_org.equals("") && data_org != null){//����ֵ������˻����ֶ�
    	if(state.equals("read")){
	    	String dictdataValues = request.getParameter("dictdataValues");
	    	String[] dictdataValue = dictdataValues.split(",");
	    	if(accesscontroler.isAdmin()){
	    		dictManager.storeReadOrgTaxcodeorAdmin(orgId,dicttypeId,dictdataValue);
	    	}else{
	    		dictManager.storeReadOrgTaxcode(curOrg,orgId,dicttypeId,dictdataValue);
	    	}
	    	hintStr = "saveRead";
	    }
	    if(state.equals("allRead")){
	    	String identifier = request.getParameter("identifier");
	    	String[] dictAlldataValue = null;
	    	if(accesscontroler.isAdmin()){
	    		dictAlldataValue = dictManager.getDictdataValues(dicttypeId,orgId,identifier,true,"");
	    		dictManager.storeReadOrgTaxcodeorAdmin(orgId,dicttypeId,dictAlldataValue);
	    	}else{
	    		//�����û�ID�õ�getCurOrgSelfGatherDictDataValues
	    		if(orgId.equals(curOrg)){
	    			dictAlldataValue = dictManager.getCurOrgSelfGatherDictDataValues(curOrg,dicttypeId,identifier);
	    		}else{
	    			dictAlldataValue = dictManager.getDictdataValues(dicttypeId,orgId,identifier,false,accesscontroler.getUserID());
	    		}
	    		dictManager.storeReadOrgTaxcode(curOrg,orgId,dicttypeId,dictAlldataValue);
	    	}
	    	hintStr = "saveAllRead";
	    }
    }else{//�ֵ�û�����û����ֶ�
	    if(state.equals("read")){
	    	String dictdataValues = request.getParameter("dictdataValues");
	    	String[] dictdataValue = dictdataValues.split(",");
	    	dictManager.storeReadOrgTaxcode(orgId,dicttypeId,dictdataValue);
	    	hintStr = "saveRead";
	    }
	    if(state.equals("allRead")){
	    	String identifier = request.getParameter("identifier");
	    	String[] dictAlldataValue = null;
	    	if(accesscontroler.isAdmin()){
	    		dictAlldataValue = dictManager.getDictdataValues(dicttypeId,orgId,identifier,true,"");
	    	}else{
	    		//�����û�ID�õ�
	    		dictAlldataValue = dictManager.getDictdataValues(dicttypeId,orgId,identifier,false,accesscontroler.getUserID());
	    	}
	    	dictManager.storeReadOrgTaxcode(orgId,dicttypeId,dictAlldataValue);
	    	hintStr = "saveAllRead";
	    }
    }
%>
<script language = "javascript">
<%if(hintStr.equals("saveRead")){%>
	alert("����δ������ɹ���");
	parent.document.location.href = parent.document.location.href;
	parent.parent.refurbishIframe();  
<%}%>

<%if(hintStr.equals("saveAllRead")){%>
	alert("����ȫ��δ������ɹ���");
	parent.document.location.href = parent.document.location.href;
	parent.parent.refurbishIframe();  
<%}%>

<%if(hintStr.equals("")){%>
	alert("����ʧ�ܣ�");
<%}%>
</script>