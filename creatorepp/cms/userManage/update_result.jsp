<%@page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="com.chinacreator.cms.documentmanager.*"%>
<%@page import="com.chinacreator.cms.channelmanager.*"%>
<%@page import="com.chinacreator.cms.sitemanager.*"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.cms.documentmanager.bean.*"%>
<%@page import="com.chinacreator.util.RemoteFileHandle"%>
<%@page import="com.chinacreator.cms.customform.*"%>
<%@page import="com.chinacreator.security.authorization.AuthUser"%>
<%@page import="com.chinacreator.cms.driver.htmlconverter.*"%>
<%@page import="com.chinacreator.cms.driver.i18n.*"%>
<%
	//AccessControl accesscontroler = AccessControl.getInstance();
   // accesscontroler.checkAccess(request, response);
   response.setHeader("Cache-Control", "no-cache"); 
   response.setHeader("Pragma", "no-cache"); 
   response.setDateHeader("Expires", -1);  
    response.setDateHeader("max-age", 0); 
    String flag = (String) request.getParameter("flag");
    //从session中得到错误信息
    String errMsg=(String) request.getSession().getAttribute("errMsg");
    if(errMsg==null || errMsg==""){
    	errMsg="操作失败!!!";
    }
    else{
    	errMsg="操作失败!!!因为："+errMsg;
    }
    System.out.println(flag);
    if(flag.equals("1")){%>
            <SCRIPT LANGUAGE="JavaScript">
			alert("操作成功!!!");
			var str = window.dialogArguments.location.href;
			//alert(str);
			//alert(parent.parent.document.location);
			//if(str.indexOf("?")==-1){
			//	window.dialogArguments.location.href = window.dialogArguments.location.href;
			//}else{
			//	var strArray = str.slice(0,str.indexOf("?"));
			//	window.dialogArguments.location.href = strArray+"?"+window.dialogArguments.document.all.queryString.value;
			//}
            //window.dialogArguments.location.href = window.dialogArguments.location.href;
            window.returnValue = "ok";
			window.close();
			</script>
			<%}
	else{
		%>
		<SCRIPT LANGUAGE="JavaScript"> 
			alert("<%=errMsg%>");
			//window.close();
		</script>
	<%
	}
	%>

		
		
		
		
		
		