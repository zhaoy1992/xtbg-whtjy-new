<%
	/**
	 *  ����Ƶ�������
	 *
	 */
%>

<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@page import="com.chinacreator.cms.container.ContainerImpl"%>
<%
	String siteid = request.getParameter("siteid");
	String channelid = request.getParameter("channelid");
	//String docid = request.getParameter("docid");

	String urlstr = "";
	
	try
	{
		urlstr = ContainerImpl.getChannelUrl(request,response,siteid,channelid);
	}
	catch(Exception e)
	{
	}
	
%>
<SCRIPT LANGUAGE="JavaScript">
	var urlstr = "<%=urlstr%>";
	function send_request(url){
		http_request = false;
		//��ʼ��ʼ��XMLHttpRequest����
		if(window.XMLHttpRequest){//Mozilla
			http_request = new XMLHttpRequest();
			if(http_request.overrideMimeType){//����MIME���
				http_request.overrideMimeType("text/xml");						
			}
		}
		else if(window.ActiveXObject){//IE
			try{
				http_request = new ActiveXObject("Msxml2.XMLHTTP");
			}catch(e){
				try{
					http_request = new ActiveXObject("Microsoft.XMLHTTP");							
				}catch(e){
				}
			}
		}
		if(!http_request){
			alert("���ܴ���XMLHttpRequest����");
			return false;
		}
		//http_request.onreadystatechange = processRequest;
		http_request.open("GET",url,false);
		http_request.send();
		if(http_request.readyState == 4){
		
			if(http_request.status == 200){
				return true;
			}
			else{
				return false;
			}
		}
	}
	if(urlstr == "" || !send_request(urlstr))
	{
		alert("Ƶ����ҳ��δ���������ȷ������������");
		window.close();
	}
	else
		document.location.href = urlstr;
</SCRIPT>