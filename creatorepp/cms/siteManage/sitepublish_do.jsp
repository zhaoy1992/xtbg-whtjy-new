<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@page import="com.chinacreator.cms.driver.publish.*,
				com.chinacreator.cms.driver.publish.impl.*,
				com.chinacreator.cms.driver.distribute.DistributeManager,
				com.chinacreator.cms.sitemanager.*,
				com.chinacreator.security.AccessControl"%>
<script language="javascript">
	function hideMarquee(){
		if(parent.document.getElementById("waiting_marquee"))
			parent.document.getElementById("waiting_marquee").style.display="none"; 
		if(parent.document.getElementById("publishButton"))
			parent.document.getElementById("publishButton").disabled="none";
		if(parent.document.getElementById("closeButton"))
			parent.document.getElementById("closeButton").disabled="";   
		if(parent.document.getElementById("increamentall"))
			parent.document.getElementById("increamentall").disabled="";
		if(parent.document.getElementById("increamentno"))
			parent.document.getElementById("increamentno").disabled="";  
		if(parent.document.getElementById("PUBLISH_SITE_INDEX"))
			parent.document.getElementById("PUBLISH_SITE_INDEX").disabled="";
		if(parent.document.getElementById("PUBLISH_CHANNEL_INDEX"))
			parent.document.getElementById("PUBLISH_CHANNEL_INDEX").disabled="";
		if(parent.document.getElementById("PUBLISH_CHANNEL_RECINDEX"))
			parent.document.getElementById("PUBLISH_CHANNEL_RECINDEX").disabled="";  
		if(parent.document.getElementById("PUBLISH_CHANNEL_CONTENT"))
			parent.document.getElementById("PUBLISH_CHANNEL_CONTENT").disabled="";
		if(parent.document.getElementById("PUBLISH_CHANNEL_RECCONTENT"))
			parent.document.getElementById("PUBLISH_CHANNEL_RECCONTENT").disabled="";
        if(parent.document.getElementById("isRecordMsg1"))
            parent.document.getElementById("isRecordMsg1").disabled="";
        if(parent.document.getElementById("isRecordMsg2"))
            parent.document.getElementById("isRecordMsg2").disabled="";
	}
</script>
<%
	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkAccess(request,response);

	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);

	String actionType = request.getParameter("actionType");
	String siteId = request.getParameter("siteId");//վ��id
	String channelId = request.getParameter("channelId");//Ƶ��id

	SiteManager sm = new SiteManagerImpl();

	//������Χ����
	String[] publishScopeStr = request.getParameter("publishScope").split(",");
	int[] publishScope = new int[publishScopeStr.length];
	for(int i=0;i<publishScopeStr.length;i++)
	{
		publishScope[i] = Integer.parseInt(publishScopeStr[i]);
	}
	//���ط�����Զ�̷�����ʶboolean��ά����
	//���巢��Ŀ�ĵ�:0:���� 1:Զ�� 2:Զ�̱���
	boolean[] local2ndRemote = sm.getSitePublishDestination(siteId);
	
	//��ʶ����������������ȫ����
	String increamentStr = request.getParameter("increament");
	boolean increament = false;
	if("true".equals(increamentStr))
			increament = true;
	if("false".equals(increamentStr))
			increament = false;
	//�ַ���ʽ����
	int[] distributeManners = sm.getSiteDistributeManners(siteId);
    String uuid = request.getParameter("uuid");
    String isRecordValue = request.getParameter("isRecordValue");
    
    
	WEBPublish publish = new WEBPublish();
	publish.init(request,response,pageContext,accessControl);
	PublishCallBack callback = new PublishCallBackImpl();
	publish.setPublishCallBack(callback);
    
    //�ⲿע��monitor
    PublishMonitor monitor = (PublishMonitor)session.getAttribute(uuid);
    //�ⲿ�����Ƿ������־
    if("false".equalsIgnoreCase(isRecordValue)){
        monitor.setNotRecordMsg(true);
        //System.out.println("monitor----------------"+monitor.isNotRecordMsg());
    }else{
        monitor.setNotRecordMsg(false);
    }
    publish.setMonitor(monitor);
    
    boolean successFlag = false;
	String pageUrl = "";
	String alertmsg = "";
    String typemsg = "";
	if(actionType == null || actionType.equals("publish"))
	{
		if("null".equals(channelId))
		{
			try
			{
				publish.publishSite(siteId,//վ��id
								    publishScope,//������Χ���飬�����ַ�����Χ�������
								    local2ndRemote, //���ط�����Զ�̷�����ʶboolean��ά���飬boolean[0]��ֵ�����Ƿ񱾵ط�����boolean[1]�����Ƿ�Զ��ftp����
								    increament,//��ʶ����������������ȫ����
								    distributeManners);//��ŷ�������ķַ���ʽ���飬����ͬʱ�ж��ַ�ʽ������DistributeManager.HTML_DISTRIBUTE,DistributeManager.RSS_DISTRIBUTE,DistributeManager.MAIL_DISTRIBUTE
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
			
		    //alertmsg = "�����ɹ���Ҫ�鿴վ����ҳ��";
            alertmsg = "վ�㷢���ɹ���Ҫ�鿴��ҳ��";
            if("false".equalsIgnoreCase(isRecordValue)){
                alertmsg = "�����ɹ���Ҫ�鿴վ����ҳ��";
            }
            typemsg = "վ��";
		}
		else
		{
			publish.publishChannel(siteId,//վ��id 
								   channelId,//Ƶ��id
								   publishScope,//������Χ���飬�����ַ�����Χ�������
								   local2ndRemote,//���ط�����Զ�̷�����ʶboolean��ά���飬boolean[0]��ֵ�����Ƿ񱾵ط�����boolean[1]�����Ƿ�Զ��ftp����
								   increament,//��ʶ�Ƿ���������
								   distributeManners);//��ŷ�������ķַ���ʽ���飬����ͬʱ�ж��ַ�ʽ������DistributeManager.HTML_DISTRIBUTE,DistributeManager.RSS_DISTRIBUTE,DistributeManager.MAIL_DISTRIBUTE
			//alertmsg = "�����ɹ���Ҫ�鿴Ƶ����ҳ��";
            alertmsg = "Ƶ�������ɹ�!";
            if("false".equalsIgnoreCase(isRecordValue)){
                alertmsg = "�����ɹ���Ҫ�鿴Ƶ����ҳ��";
            }
            typemsg = "Ƶ��";
		}
		System.out.println("callback.getPageUrl():" + callback.getPageUrl());
		pageUrl = callback.getPageUrl();
		successFlag = callback.getPublishMonitor().isAllFailed()==true?false:true;
	}
	if(successFlag==true){
        session.setAttribute("pageUrl"+uuid,pageUrl);
	%>
		<script language="javascript">
            hideMarquee();
            if("<%=isRecordValue%>"=="false"){
    			var see=confirm("<%=alertmsg%>");
    			if(see==true){
    			    try
    			    {
    					window.open("<%=pageUrl%>");
    				}
    				catch(e)
    				{
    					alert("�Բ��𣬴�ҳ��[<%=pageUrl%>]��������վ��������Ƿ�������ȷ��");
    				}
    			}
    			parent.window.close();
                
            }else{
                //alert("<%=alertmsg%>");
                var infomsg = "<a href=<%=pageUrl%> onclick='window.close()'><%=typemsg%>��ҳ:<%=pageUrl%></a>"
                parent.document.all("linkInfo").innerHTML = infomsg;
                parent.document.getElementById("closeButton").disabled="";
            }
            
		</script>
	<%
	}
	else
	{
		%>
		<script language="javascript">
			hideMarquee();            
			alert("<%=typemsg%>����ʧ�ܣ�");
		</script>
		<%
	}
	
	
%>