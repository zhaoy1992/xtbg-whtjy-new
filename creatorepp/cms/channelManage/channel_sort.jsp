<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="java.util.List"%>
<%@ page import="com.chinacreator.cms.CMSManager"%>
<%@ page import="com.chinacreator.cms.channelmanager.ChannelCacheManager"%>
<%@ page import="com.chinacreator.cms.sitemanager.SiteCacheManager"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%
	String channelId = request.getParameter("channelId");//机构id
	String className = request.getParameter("treeName");//机构orgName
	
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
	
	CMSManager cmsmanager = new CMSManager();
	cmsmanager.init(request, session, response,accesscontroler);
	String siteId = cmsmanager.getSiteID();
	ChannelCacheManager cm = (ChannelCacheManager)(SiteCacheManager.getInstance().getChannelCacheManager(siteId));
	List channels = cm.getSubChannels(channelId);
%>
<html>
<head>    
  	<title>频道排序</title>
	<SCRIPT LANGUAGE="JavaScript">
	//排序
	function sortOrg()
	{
		var len = document.all("id").options.length;
		var channelIds = "";
		for (var i=0;i<len;i++)
		{
			channelIds += document.all("id").options[i].value + ",";
		}
		if(channelIds == "")
		{
			return false;
		}
		document.forms[0].action = "channel_sort_do.jsp?channelIds=" + channelIds;
		document.forms[0].target = "sortOrgiframe";
		document.forms[0].submit();
	}

	function up1() {
		var len=document.all("id").options.length;
		var isselected = 0;
		for (var i=0;i<len;i++){
			var op=document.all("id").options[i];
	   		if(op.selected){   			
	   			isselected += 1;
	   		}
	   	}
	   	if(isselected != 1){
	   		alert("请先选择一个频道再进行此操作");
	   		return;
	   	}
		for (var i=0;i<len;i++){
			var op=document.all("id").options[i];
	   		if(op.selected){   			
	   			var tmp = new Option(op.text,op.value);
	   			if(i>0){
	   				var dest = document.all("id").options[i-1];
	   				document.all("id").options[i-1] = tmp;
	   				document.all("id").options[i] = dest;
	   				document.all("id").options[i-1].selected=true;
					var num = i - 1;
					//document.all("orgId").selectedIndex = num;
					setTimeout("indexChange(" + num +");",100);
	   			}
	   		}
	    }
	}
	function upall() {
		var len=document.all("id").options.length;	
		var isselected = 0;
		for (var i=0;i<len;i++){
			var op=document.all("id").options[i];
	   		if(op.selected){   			
	   			isselected += 1;
	   		}
	   	}
	   	if(isselected != 1){
	   		alert("请先选择一个频道再进行此操作");
	   		return;
	   	}
		for (var i=0;i<len;i++){
			var op=document.all("id").options[i];
	   		if(op.selected){   			
	   			var tmp = new Option(op.text,op.value);
	   			op.selected = false;   			
	   			var j=i;   			
	   			for(;j>=1;j--){     				
	   				var atmp =  document.all("id").options[j-1];   				
	   				var btmp = new Option(atmp.text,atmp.value);   				
	   				document.all("id").options[j] = btmp;
	   			}   			
	   			document.all("id").options[0] = tmp;
	   			break;	
	   		}
	    }  
	    document.all("id").options[0].selected=true;
		document.all("id").selectedIndex = 0;
	}
	
	function down1() {
		var len=document.all("id").options.length;
		var isselected = 0;
		for (var i=0;i<len;i++){
			var op=document.all("id").options[i];
	   		if(op.selected){   			
	   			isselected += 1;
	   		}
	   	}
	   	if(isselected != 1){
	   		alert("请先选择一个频道再进行此操作");
	   		return;
	   	}
		var flag = 0;
		for (var i=0;i<len;i++){
			var op=document.all("id").options[i];
	   		if(op.selected){   			
	   			var tmp = new Option(op.text,op.value);   			
	   			op.selected=false;
	   			if(i == len-1){
	   				flag = len-2;
	   			}
	   			else {
	   				flag = i;
	   			}
	   			if(i<len-1){
	   				var dest = document.all("id").options[i+1];
	   				var orgId2 = tmp.value;	   				
	   				var orgId = document.all("id").value;
	   				var orgId1 = dest.value;
	   				var jobSn = i;
	   				document.all("id").options[i+1] = tmp;
	   				document.all("id").options[i] = dest;
	   			}
	   		}
	    }
	    document.all("id").options[flag+1].selected=true;
		var num = flag + 1;
		setTimeout("indexChange(" + num +");",100);
		//document.all("orgId").selectedIndex = num;
	}

	
	function downall() {
		var len=document.all("id").options.length;
		var isselected = 0;
		for (var i=0;i<len;i++){
			var op=document.all("id").options[i];
	   		if(op.selected){   			
	   			isselected += 1;
	   		}
	   	}
	   	if(isselected != 1){
	   		alert("请先选择一个频道再进行此操作");
	   		return;
	   	}	
		for (var i=0;i<len;i++){
			var op=document.all("id").options[i];
	   		if(op.selected){   			
	   			var tmp = new Option(op.text,op.value);
	   			op.selected = false;   			
	   			var j=i;   			
	   			for(;j<len-1;j++){     				
	   				var atmp =  document.all("id").options[j+1];   				
	   				var btmp = new Option(atmp.text,atmp.value);   				
	   				document.all("id").options[j] = btmp;   				
	   			}   			
	   			document.all("id").options[len-1] = tmp;	
				break;
	   		}
	    }
	    document.all("id").options[len-1].selected=true;
		var num = len-1;
		setTimeout("indexChange(" + num +");",100);
		//document.all("orgId").selectedIndex = num;
	}
	function indexChange(num)
	{
		document.OrgJobForm.id.selectedIndex = num;
	}
	</SCRIPT>
   <link rel="stylesheet" type="text/css" href="../css/windows.css">
   <link rel="stylesheet" type="text/css" href="../css/contentpage.css">
   <link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
   <link rel="stylesheet" type="text/css" href="../../sysmanager/css/windows.css">
   <link rel="stylesheet" type="text/css" href="../../sysmanager/css/contentpage.css">
   <link rel="stylesheet" type="text/css" href="../../sysmanager/css/tab.winclassic.css">
	
<body >
<form name="OrgJobForm" action="" method="post" >

<table width="100%" border="0" cellpadding="1" cellspacing="1">
  <tr>
	<td align="center" colspan="4">
	频道  <%=className%>
	</td>
  </tr>
  <tr >
	<td width="20%"> &nbsp;</td>
    <td class="detailcontent" align="center" width="50%">
     <select name="id"  multiple style="width:100%" size="18">
	  <%
	  request.setAttribute("orglist",channels);
	  %>
	  <pg:list requestKey="orglist">
		<option value="<pg:cell colName="channelId"/>"><pg:cell colName="name"/></option>
	  </pg:list>			
	 </select>				
					
	</td>
	<td>
	<table align="center" width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td align="center" class="detailcontent"><input name="button1" type="button" class="input" value="到顶部" onClick="upall()"></td>
      </tr>
      <tr>
        <td align="center" class="detailcontent">&nbsp;</td>
      </tr>
      <tr>
        <td align="center"><input name="button2" type="button" class="input" value="向上移" onClick="up1()"></td>
      </tr>
      <tr>
        <td align="center" class="detailcontent">&nbsp;</td>
      </tr>
      <tr>
        <td align="center" class="detailcontent"><input name="button3" type="button" class="input" value="向下移" onClick="down1()"></td>
      </tr>
      <tr>
        <td align="center" class="detailcontent">&nbsp;</td>
      </tr>
      <tr>
        <td align="center" class="detailcontent"><input name="button4" type="button" class="input" value="到底部" onClick="downall()"></td>
      </tr>
      <tr>
        <td align="center" class="detailcontent">&nbsp;</td>
      </tr>
    </table>
	
	</td>
  <tr>
  	<td>&nbsp;</td>
  </tr>	
  <tr>
    <td align="center" colspan="4">
	<input name="butn" type="button" class="input" value="确定" onClick="sortOrg();">
	<input name="butn" type="button" class="input" value="关闭" onClick="window.close();">
	</td>
  </tr>	
  </table>
</form>
<iframe name="sortOrgiframe" width="0" height="0">
</iframe>
</body>
</html>
