<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%@ page import="com.chinacreator.syndatemanager.Rtxsyn"%>



<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request,response);	
%>

<%
   
   String selorgid = request.getParameter("selptorgid");
   String seldeptid = request.getParameter("selrtxdeptid");
   
   String type = request.getParameter("type");
   String message = "";
   Rtxsyn rtxsyn = new Rtxsyn();
   
   if(type.equals("egp2rtx")){ message = rtxsyn.EGPtoRTX_org(selorgid);}
   if(type.equals("egp2rtxall")){message = rtxsyn.EGPtoRTX_org(selorgid);}
   if(type.equals("rtx2egp")){message = rtxsyn.RTXtoEGP_org(seldeptid);}
   if(type.equals("rtx2egpall")){message = rtxsyn.RTXtoEGP_org(seldeptid);}
   
%>
<script language="javascript">
   var showresult = '<%=message%>';
   if(showresult!=""){
    alert(showresult);
   
    parent.document.body.disabled = false;
    parent.document.Form1.submit();
    }
    
   parent.document.body.disabled = false;
   parent.document.Form1.submit();
</script>