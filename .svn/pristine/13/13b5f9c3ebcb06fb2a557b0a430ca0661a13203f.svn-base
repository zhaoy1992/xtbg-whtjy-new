<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.chinacreator.security.AccessControl
				,com.chinacreator.message.Config
				,rtx.RTXSvrApi
				,com.chinacreator.message.util.MsgConfig
				,com.chinacreator.message.factory.MsgRMIClientServerFactory" %>
<%
//2009.4.21 minghua.guoadd 解决退出再登录缓存的问题----
response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires",0);
//-------------------------------------------------
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request,response);
    RTXSvrApi rtxApi = null;
    //如果使用远程发送
	boolean useRMISend = ("1".equals(MsgConfig.getProperties("RTX_USER_RMISEND")));
    String account = accesscontroler.getUserAccount();//我是通过一个session类来获得当前用户登陆名称的
    String ip = null;
    String port = null;

    // 如果没有在配置文件中设置server ip，则调用sdk服务器的ip
    //String ip = StringUtils.isEmpty(Message.RTX_SERVER_IP) ? rtxApi.getServerIP() : Message.RTX_SERVER_IP;
    try {
    	if(useRMISend){
    		ip = MsgConfig.getProperties("RMI_IP");
    	}else{
    		rtxApi = new RTXSvrApi();
    		ip = MsgConfig.getProperties("rtxServerIP");
    	}
    } catch(java.util.MissingResourceException e) {
    	//ip = rtxApi.getServerIP();
    	// modify by yaohui.luo	2008-9-3
    	ip = request.getLocalAddr();
    }

    // 如果没有在配置文件中设置server port，则调用8000，此端口对应RTX服务器端ConnServer服务
    //String port = StringUtils.isEmpty(Message.RTX_SERVER_PORT) ? "8000" : Message.RTX_SERVER_PORT;
    try {
    	port = MsgConfig.getProperties("RTX_SERVER_PORT");
    } catch(java.util.MissingResourceException e) {
    	port = "8000";
    }
	String key = null;
	
    try {
    	//if () {
    	//这个GetSessionKey的方法就在RTX SDK下面JAVA例子RTXSvrApi.java里面有
    	//使用远程发送,则调用远程的getSessionKey(userName);
    		if(useRMISend){
    			key = MsgRMIClientServerFactory.getRmiMsgServer().getSessionKey(account);
    		}else{
				if(rtxApi.Init()){
    			key = rtxApi.getSessionKey(account); 
				rtxApi.UnInit();
				}
    		}
    	//	
    	//}
    } catch(Exception e) {
    	e.printStackTrace();
    	return;
    }

%>
<html>
<%@ include file="/epp/css/cssControl.jsp"%><body onload="RtxSycn();">
    <OBJECT classid=clsid:5EEEA87D-160E-4A2D-8427-B6C333FEDA4D id=RTXAX></OBJECT>
</body>
</html>
<script language="javascript">
function RtxSycn() {
	try {
    	var key = "<%=key%>";            //上面取到的sessionkey
		var account = "<%=account%>";    //用户登陆名,当然在RTX里面也要有一个一样的用户名
		var ip = "<%=ip%>";
		var port = <%=port%>;
      	var RTXCRoot = RTXAX.GetObject("KernalRoot");    //客户端SDK
      	RTXCRoot.LoginSessionKey(ip,port,account,key);
	} catch(e) {
		alert("启动RTX出现错误，可能您已经启动了RTX客户端！");
	}
	}
	window.close();
</script>