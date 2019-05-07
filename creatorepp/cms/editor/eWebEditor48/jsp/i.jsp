<%@ page contentType="text/html;charset=gb2312"%>
<%request.setCharacterEncoding("gb2312");%>
<jsp:useBean id="eWebEditor" class="ewebeditor.server.i_jsp" scope="page"/>

<%
eWebEditor.Load(pageContext);
%>