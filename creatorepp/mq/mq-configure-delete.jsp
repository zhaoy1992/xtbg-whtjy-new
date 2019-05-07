<%@ page language="java" pageEncoding="gb2312"%>

<%@page import="com.chinacreator.kettle.mq.MqNode"%>
<%@page import="com.chinacreator.kettle.mq.MqNodeDo"%>
<%
	String id = request.getParameter("ID");
	MqNodeDo mnd = new MqNodeDo();
	if (mnd.deleteNode(id)) {
%>
<script type="text/javascript">
				alert("操作成功!");
				window.location.href="mq-configure.jsp";
</script>
<%
} else {
%>
<script type="text/javascript">
				alert("很抱谦,操作失败！");
				window.location.href="mq-configure.jsp";
</script>
<%
}
%>


