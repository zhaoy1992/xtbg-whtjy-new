<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Set"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.chinacreator.dictionary.DictManager"%>
<%@ page import="com.chinacreator.dictionary.DictManagerImpl"%>
<%@ page import="com.frameworkset.dictionary.Data"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%	
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String did = (String)request.getParameter("did");
	String mutiInfo = (String)request.getParameter("infos");
	String queryString = request.getParameter("queryString");
	did = did==null?"":did;
	mutiInfo = mutiInfo==null?"":mutiInfo;
	String[] infos = mutiInfo.split(",");
	DictManager dicManager = new DictManagerImpl();
	//ɾ��������,�����ݹ�ɾ����������
	boolean state = dicManager.deletedictdatas(did,infos);
	
	
%>
	<script language="javascript">		
	<%if(state){%>
		parent.win.alert("�����ɹ�!");		
		//parent.enable();
		//parent.afterDeleteRefresh(<%=queryString%>);
		parent.win.close();
	<%}else{%>
		parent.win.alert("����ʧ��!��������������������߸��������Ѿ�����Ȩ���ã�");	
		//parent.enable();
		parent.win.close();	
	<%}%>
	parent.location.reload();
	</script>

 


 

