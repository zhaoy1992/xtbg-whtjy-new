<%
/**
 * 
 * <p>Title: �߼��ֶ�����ҳ��</p>
 *
 * <p>Description: �߼��ֶ�����ҳ��</p>
 *
 * <p>Copyright: Copyright (c) 2007</p>
 *
 * <p>Company: chinacreator</p>
 * @Date 2008-4-6
 * @author gao.tang
 * @version 1.0
 */ 
%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.dictionary.DictManager" %>
<%@ page import="com.chinacreator.dictionary.DictManagerImpl" %>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	DictManager dictManager = new DictManagerImpl();
	
	String dicttypeId = request.getParameter("dicttypeId");
	String docid = request.getParameter("docid");
	boolean state = dictManager.storeAdvanceFieldArr(dicttypeId, docid);
%>

<%
	if(state){
%>
<script language="Javascript">
	alert("��������ɹ���");
	parent.document.location = parent.document.location;
</script>
<% 
	}else{
%>
	alert("����ʧ�ܣ�");
<%
	} 
%>