<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="com.chinacreator.cms.addressmanager.*"%>
<%
	String[] addressid = request.getParameterValues("checkBoxOne");
	boolean flag = false;
	if (addressid != null) {
		flag = new AddressManagerImpl().deleteAddress(addressid);
	}
	if(flag){
%>
		<script language="javascript" >
			alert("É¾³ý³É¹¦!");
			top.sreachFrame.document.all.form1.action = "address_list.jsp?isAll=yes";
			top.sreachFrame.document.all.form1.submit();
		</script>
<%
	}else{
%>
		<script language="javascript" >
			alert("É¾³ýÊ§°Ü!");
		</script>
<%
	}
%>	