<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ page import="com.chinacreator.cms.channelmanager.*"%>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%  //Ƶ��ɾ��
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
		
    ChannelManagerImpl smi=new ChannelManagerImpl();
    boolean ret = false;
    String msg = "";
    String str = smi.isUsedByChannel(request.getParameter("channelId"));
    if(str.equals(""))
    {
    	ret = smi.logDeleteChannel(request.getParameter("channelId"),request, response);
    	if(ret==true)
    	{
    		msg = "��ϲ,Ƶ��ɾ���ɹ�!";	
    	}
    	else
    	{
    		msg = "��Ǹ,Ƶ��ɾ��ʧ��!";
    	}
    }
    else
    {
    	msg = "��Ǹ,Ƶ��ɾ��ʧ��!��Ƶ����Ƶ��:"+ str + " ���ó�Ƶ����ҳ";
    }
	//boolean ret=smi.deleteChannel(Integer.parseInt(request.getParameter("channelId")),path+"/");
	
%>
 <%if(ret==true){%>
	<script language="javascript">
		alert("<%=msg%>");	
		parent.window.returnValue = true;
		parent.close(); 
	</script>
  <%}%>
  
  <%if(ret==false){%>
	<script language="javascript">
	   alert("<%=msg%>");
	   parent.close(); 
	 </script>
  <%}%> 