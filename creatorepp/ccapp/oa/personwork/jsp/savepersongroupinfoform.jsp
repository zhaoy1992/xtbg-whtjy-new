<%--  
描述：保存分组信息
作者：戴连春
版本：1.0
日期：2013-06-13
--%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.core.personwork.service.PersonInfoServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.personwork.service.impl.PersonInfoServiceImpl"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript"src="../../resources/plug/ifrom/js/ifrom-ui-tree.1.1.js"charset="utf-8"></script>
<script type="text/javascript"src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript"src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript"src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<title>保存人员分组信息form</title>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
    String personids = request.getParameter("personids");
    String groupids = request.getParameter("groupshowids");
   
    PersonInfoServiceIfc service = new PersonInfoServiceImpl();
    //保存分组信息
    boolean flag = service.savePersonGroupInfo(personids,groupids);
    
%>
</head>
<body>
<script type="text/javascript">
var mes = "";
var bool = true;
if(<%=flag%>){
    mes = "操作成功";       
    bool = true;
}else{
    mes = "操作失败"    ;
    bool = false;

}
var ok=function(){
    window.parent.location.reload();
}
if(window.top.removeAlertWindows('',false,bool,mes,true)){
    if(bool){
        window.top.alert(mes,{headerText:'处理结果',okName:'确认',okFunction:ok})
    }
    else{
        window.top.alert(mes)
    }
}
</script>
</body>
</html>