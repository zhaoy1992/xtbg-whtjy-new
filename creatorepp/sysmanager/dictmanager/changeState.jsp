<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@ page import="com.chinacreator.dictionary.DictManager" %>
<%@ page import="com.chinacreator.dictionary.DictManagerImpl" %>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%
	/**
	 * ���νṹ��ͣ�����ô���ҳ��
	 */
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);	
	String did = request.getParameter("did");
	String dictdataValue = request.getParameter("dictdata");
	String flag = request.getParameter("flag");
	String docid = request.getParameter("docid");
	String isRescure = request.getParameter("isRescure")==null?"0":request.getParameter("isRescure");
	String[] doc = docid.split(",");
	DictManager dictManager = new DictManagerImpl();
	//modify by ge.tao
	//�������Ƿ�ݹ�����/ͣ�õĲ���
	boolean state = dictManager.changeState(did, dictdataValue, doc, flag,isRescure);
%>

<script>
	if(<%=state%>){
		alert("�����ɹ���");

  		parent.parent.newDictdata.document.location.href = parent.parent.newDictdata.document.location.href ;
	}else{
		alert("����ʧ�ܣ�");
	}
</script>