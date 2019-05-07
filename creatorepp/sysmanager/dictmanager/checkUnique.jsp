<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@ page import="com.chinacreator.dictionary.DictManager" %>
<%@ page import="com.chinacreator.dictionary.DictManagerImpl" %>

<%
	
	String dicttypeId = request.getParameter("dicttypeId");
	String fieldName = request.getParameter("fieldName");
	String fieldValue = request.getParameter("fieldValue");
	DictManager dictManager = new DictManagerImpl();
	out.print(dictManager.checkDictDataPropertyValueUnique(dicttypeId,fieldName,fieldValue));
%>
