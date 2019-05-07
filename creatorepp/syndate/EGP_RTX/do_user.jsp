<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ page import="com.chinacreator.security.AccessControl"%>


<%@ page import="com.chinacreator.syndatemanager.Rtxsyn"%>


<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request,response);	
%>

<%
   
   String selusername = request.getParameter("selptusername");
   String selrtxusername = request.getParameter("selrtxusername");
   
   String type = request.getParameter("type");
   String message = "";
   Rtxsyn rtxsyn = new Rtxsyn();
   
   if(type.equals("egp2rtx")){ message = rtxsyn.EGPtoRTX_user(selusername);}
   if(type.equals("egp2rtxall")){message = rtxsyn.EGPtoRTX_user(selusername);}
   if(type.equals("rtx2egp")){message = rtxsyn.RTXtoEGP_user(selrtxusername);}
   if(type.equals("rtx2egpall")){message = rtxsyn.RTXtoEGP_user(selrtxusername);}
   
%>
<script language="javascript">
   var showresult = '<%=message%>'; 
   if(showresult!=""){
    alert(showresult);
    
    parent.document.body.disabled = false;
    parent.document.synuser.submit();
    
    }
   
    parent.document.body.disabled = false;
    parent.document.synuser.submit();
   
</script>