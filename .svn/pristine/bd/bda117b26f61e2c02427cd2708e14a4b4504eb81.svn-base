<%@page contentType="text/html;charset=GBK"%>
<%@page import="com.chinacreator.epp.egpstyle.EgpStyle"%>
<%
	String csstype = request.getParameter("csstype");
	boolean bl = EgpStyle.setCurrentStyleByCookie(response, csstype);

%>
<script language="JavaScrip" type="text/javascript">
//检测浏览器是否支持cookie 未启用
//if(support_cookie()!="true"){
//	alert("您的浏览器不支持cookie,请打开cookie后再做设置!");
//}

function support_cookie(){
   var cookieEnabled=navigator.cookieEnabled? true : false;
   if(typeof navigator.cookieEnabled && !cookieEnabled){
    document.cookie="test";
    cookieEnabled=(document.cookie=="test")? true : false;
    document.cookie="";
   }
   if(cookieEnabled){
   return "true";
   }
}

//设置cookie
function  setCookie(){
   try{
   		var expiration = new Date((new Date()).getTime() + 60 * 60000 * 24 * 365);
		document.cookie="currentcss ="+"<%=csstype%>"+"; expires ="+ expiration.toGMTString(); 
		return "true";
	}catch(e){
		return "false";
	}
}
//获取cookie 如果返回Null js重新设置cookie
function getCookie(str){
	var tmp,reg=new RegExp("(^| )"+str+"=([^;]*)(;|$)","gi");
	if(tmp=reg.exec(document.cookie))return(tmp[2]);
	return null;
}

//如果java设置js失败 则调用js设置cookie
if(getCookie("currentcss")==null){
	if("true"==setCookie()){
		alert("设置成功！");
		parent.window.close();
		returnValue = "ok";
	}else{
		alert("设置失败！");
	}
}else{
	alert("设置成功！");
	parent.window.close();
	returnValue = "ok";
}

</script>