<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/sysmanager/base/scripts/panes.jsp"%>
<%@ include file="/sysmanager/include/global1.jsp"%>
<%@ page import="com.chinacreator.cms.sitemanager.*"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	String taskType = request.getParameter("taskType");
	String channelid = request.getParameter("channelid");  //ֻ��Ƶ�����ô���ʱ�Ŵ����˲���
	
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	com.chinacreator.cms.CMSManager cmsManager  = new com.chinacreator.cms.CMSManager();
 	cmsManager.init(request,session,response,accesscontroler);
 	String currentSiteid = cmsManager.getSiteID();
%>
<html>
	<head>
		<title>:::��Ƶ��ѡ��::::::</title>
		<script language="JavaScript" src="changeView.js" type="text/javascript"></script>
  		<link rel="stylesheet" type="text/css" href="<%=rootpath%>/sysmanager/css/treeview.css">
  		<link rel="stylesheet" type="text/css" href="<%=rootpath%>/sysmanager/css/windows.css">
  		<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
  		<script language="javascript">
  			function sub(taskType){
  				var flag = true;
	  			var allChannelInfos = parent.multi_chn_slt_top.document.getElementsByName("channelInfo");
	  				
	  			if(allChannelInfos == null){
	  				alert("��ʱû��Ƶ���ɹ�ѡ��!");
	  				return;
	  			}
	  			var selChannelNames = "";
	  			var selChannelids = "";
	  			var selchnlSiteIds = "";
	  			for(var i=0;i<allChannelInfos.length;i++){
	  				var oneChnlInfo;
	  				if(allChannelInfos[i].checked == true){
	  					oneChnlInfoArray = allChannelInfos[i].value.split(":");
	  					selChannelNames = selChannelNames + oneChnlInfoArray[oneChnlInfoArray.length-2] + ";";
	  					selChannelids = selChannelids + oneChnlInfoArray[oneChnlInfoArray.length-1] + ",";
	  					selchnlSiteIds = selchnlSiteIds + oneChnlInfoArray[oneChnlInfoArray.length-3] + ",";
	  					if(oneChnlInfoArray[oneChnlInfoArray.length-1] == <%=channelid%>)
	  						flag = false;                    //����Ƶ��ʱ����ѡ��ǰƵ��
	  				}
	  			}
	  			if(taskType!="cite"){			//�����ĵ���ѯʱ��Ƶ��ѡ��
	  				window.returnValue = selChannelNames + ":" + selChannelids + ":" + selchnlSiteIds;
	  				window.close();
	  			}else{						//ѡ������Ƶ����������
	  				if(flag){
		  				if(selChannelids == "")
						{
							alert("��ѡ��Ƶ����");
							return false;
						}
						var urls = "<%=rootpath%>/cms/docManage/citeHandle.jsp?flag=3&docsiteid=" + selchnlSiteIds + "&channelid=<%=channelid%>&docidStr=" + selChannelids + "&dstSiteId=<%=currentSiteid%>";
						window.urlstr = urls;
						showModalDialog("../doing_iframe.html",window,"dialogWidth:"+(screen.availWidth-200)+"px;dialogHeight:"+(screen.availHeight-150)+"px;help:no;scroll:auto;status:no");
					}else{
						alert("�Բ��𣬲���ѡ��ǰƵ����");
					}			
	  			}	  			
  			}
  		</script>
	</head>
	<body class="contentbodymargin" scrolling="no">
		<form name="multiqueryForm" method="post">
			<table class="table" width="80%">
				<tr class="tr">
					<td align="center">
						<input type="button" value="ȷ��" class="cms_button" onClick="sub('<%=taskType%>')">
						<input type="button" value="����" class="cms_button" onClick="window.close()">
					</td>
				</tr>
			</table>
		</form>
	</body>
	<div height=0 width=0 style="display:none">
		<iframe name="multiquery"> </iframe>
	</div>
</html>