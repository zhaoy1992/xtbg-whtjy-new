<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.chinacreator.security.AccessControl
				,com.chinacreator.message.Config
				,rtx.RTXSvrApi
				,com.chinacreator.message.util.MsgConfig
				,com.chinacreator.message.factory.MsgRMIClientServerFactory" %>
<%
//2009.4.21 minghua.guoadd ����˳��ٵ�¼���������----
response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires",0);
//-------------------------------------------------
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request,response);
    RTXSvrApi rtxApi = null;
    //���ʹ��Զ�̷���
	boolean useRMISend = ("1".equals(MsgConfig.getProperties("RTX_USER_RMISEND")));
    String account = accesscontroler.getUserAccount();//����ͨ��һ��session������õ�ǰ�û���½���Ƶ�
    String ip = null;
    String port = null;

    // ���û���������ļ�������server ip�������sdk��������ip
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

    // ���û���������ļ�������server port�������8000���˶˿ڶ�ӦRTX��������ConnServer����
    //String port = StringUtils.isEmpty(Message.RTX_SERVER_PORT) ? "8000" : Message.RTX_SERVER_PORT;
    try {
    	port = MsgConfig.getProperties("RTX_SERVER_PORT");
    } catch(java.util.MissingResourceException e) {
    	port = "8000";
    }
	String key = null;
	
    try {
    	//if () {
    	//���GetSessionKey�ķ�������RTX SDK����JAVA����RTXSvrApi.java������
    	//ʹ��Զ�̷���,�����Զ�̵�getSessionKey(userName);
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
    	var key = "<%=key%>";            //����ȡ����sessionkey
		var account = "<%=account%>";    //�û���½��,��Ȼ��RTX����ҲҪ��һ��һ�����û���
		var ip = "<%=ip%>";
		var port = <%=port%>;
      	var RTXCRoot = RTXAX.GetObject("KernalRoot");    //�ͻ���SDK
      	RTXCRoot.LoginSessionKey(ip,port,account,key);
	} catch(e) {
		alert("����RTX���ִ��󣬿������Ѿ�������RTX�ͻ��ˣ�");
	}
	}
	window.close();
</script>