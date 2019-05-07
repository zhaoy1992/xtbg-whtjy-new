
<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.cms.sitemanager.*"%>
<%@page import="com.chinacreator.cms.channelmanager.*"%>


<%
			AccessControl accesscontroler = AccessControl.getInstance();
			accesscontroler.checkAccess(request, response);

			response.setHeader("Cache-Control", "no-cache");
			response.setHeader("Pragma", "no-cache");
			response.setDateHeader("Expires", -1);
			response.setDateHeader("max-age", 0);

			String siteId = request.getParameter("siteId");
			String channelId = request.getParameter("channelId");

			String title = "";

			SiteManager sm = new SiteManagerImpl();
			Site site = sm.getSiteInfo(siteId);

			ChannelManager cm = new ChannelManagerImpl();
			Channel channel = null;
			if (channelId == null || "".equals(channelId)) {
				title = "【" + site.getName() + "】站点";
			} else {
				channel = cm.getChannelInfo(channelId);
				title = "【" + channel.getDisplayName() + "】频道";
			}

			%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
	<script src="../inc/js/func.js"></script>
	<style type="text/css">
		<!--
		.STYLE7 {color:#003398; font-size: 12px;}
		#Layer1 
		{
			position:absolute;
			left:0px;
			top:0px;
			width:113px;
			height:127px;
			z-index:1;
		}
		.STYLE8 {color: #0000FF}
		.STYLE1 {color: blue}
		-->
	</style>
	<SCRIPT LANGUAGE="JavaScript">
	   
		function subform()
		{
			//发布范围数组
			publishForm.publishScope.value = "";
			
			if(publishForm.channelId.value=="null")
			{
				if(publishForm.PUBLISH_SITE_INDEX.checked)
				{
					publishForm.publishScope.value += "1" + ",";
				}
			}
			
			if(publishForm.PUBLISH_CHANNEL_INDEX.checked)
			{
				publishForm.publishScope.value += "2" + ",";
				if(publishForm.channelId.value=="null"||publishForm.PUBLISH_CHANNEL_RECINDEX.checked)
				{
					publishForm.publishScope.value += "7" + ",";
				}
			}
			
			if(publishForm.PUBLISH_CHANNEL_CONTENT.checked)
			{
				publishForm.publishScope.value += "3" + ",";
				if(publishForm.channelId.value=="null"||publishForm.PUBLISH_CHANNEL_RECCONTENT.checked)
				{
					publishForm.publishScope.value += "5" + ",";
				}
			}
			
			
			if(publishForm.publishScope.value=="")
			{
				alert("请选择发布内容！");
				return false;
			}
	
			//标识增量发布，还是完全发布  完全发布是: 0 增量发布是: 1
			publishForm.increament.value = "";
			
			if(publishForm.increamentall.checked)
				publishForm.increament.value = "0" ;
				
			if(publishForm.increamentno.checked)
				publishForm.increament.value = "1";
				
	
			publishForm.submit();
				
			
			if(document.getElementById("publishButton"))
				document.getElementById("publishButton").disabled="disabled";
				
			if(document.getElementById("closeButton"))
				document.getElementById("closeButton").disabled="disabled";   
				
			if(document.getElementById("increamentall"))
				document.getElementById("increamentall").disabled="disabled";
				
			if(document.getElementById("increamentno"))
				document.getElementById("increamentno").disabled="disabled";
	               
			if(document.getElementById("PUBLISH_SITE_INDEX"))
				document.getElementById("PUBLISH_SITE_INDEX").disabled="disabled";
				
			if(document.getElementById("PUBLISH_CHANNEL_INDEX"))
				document.getElementById("PUBLISH_CHANNEL_INDEX").disabled="disabled";
				
			if(document.getElementById("PUBLISH_CHANNEL_RECINDEX"))
				document.getElementById("PUBLISH_CHANNEL_RECINDEX").disabled="disabled";  
				
			if(document.getElementById("PUBLISH_CHANNEL_CONTENT"))
				document.getElementById("PUBLISH_CHANNEL_CONTENT").disabled="disabled";
				
			if(document.getElementById("PUBLISH_CHANNEL_RECCONTENT"))
				document.getElementById("PUBLISH_CHANNEL_RECCONTENT").disabled="disabled"; 
				
				
			if(document.getElementById("lever"))
				document.getElementById("lever").disabled="disabled";
				
			if(document.getElementById("day"))
				document.getElementById("day").disabled="disabled";
				
				
			if(document.getElementById("time"))
				document.getElementById("time").disabled="disabled";
		
			if(parent.document.getElementById("waiting_marquee"))
				document.getElementById("waiting_marquee").style.display="block";
			 		
	        
		}    
   
    
		function changeChlIndex()
		{
			if(publishForm.channelId.value=="null")
			{
				if(publishForm.PUBLISH_CHANNEL_INDEX.checked)
					publishForm.PUBLISH_CHANNEL_RECINDEX.checked = true;
				else
					publishForm.PUBLISH_CHANNEL_RECINDEX.checked = false;
			}
			else
			{
				publishForm.PUBLISH_CHANNEL_RECINDEX.checked = false;
			}
		}
	
		function changeChlContent()
		{
			if(publishForm.channelId.value=="null")
			{
				if(publishForm.PUBLISH_CHANNEL_CONTENT.checked)
					publishForm.PUBLISH_CHANNEL_RECCONTENT.checked = true;
				else
					publishForm.PUBLISH_CHANNEL_RECCONTENT.checked = false;
			}
			else
			{
				publishForm.PUBLISH_CHANNEL_RECCONTENT.checked = false;
			}
		}
		
		function changeTime(obj)
		{
			if(obj)
			{
				var value = obj.options[obj.selectedIndex].value ;
				
				if(value == 0)
				{
					document.publishForm.day.options.length=7;
					document.publishForm.day.options[0].value='1';
					document.publishForm.day.options[0].text='星期日';
					
					document.publishForm.day.options[1].value='2';
					document.publishForm.day.options[1].text='星期一';
					
					document.publishForm.day.options[2].value='3';
					document.publishForm.day.options[2].text='星期二';
					
					document.publishForm.day.options[3].value='4';
					document.publishForm.day.options[3].text='星期三';
					
					document.publishForm.day.options[4].value='5';
					document.publishForm.day.options[4].text='星期四';
					
					document.publishForm.day.options[5].value='6';
					document.publishForm.day.options[5].text='星期五';
					
					document.publishForm.day.options[6].value='7';
					document.publishForm.day.options[6].text='星期六';
					
				}
				else if(value == 1)
				{
					document.publishForm.day.options.length=1;
					document.publishForm.day.options[0].value='1';
					document.publishForm.day.options[0].text='每天';
				}
			}
		}
	</SCRIPT>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title><%=title%>定时发布设置</title>
	</head>

	<body background="../images/grayline_bg.jpg">
		<form action="ordersitepublish_do.jsp" method="post" name="publishForm" target="hiddenFrame" id="publishForm">
			<input type="hidden" name="siteId" value="<%=siteId%>" />
			<input type="hidden" name="channelId" value="<%=channelId%>" />
			<input type="hidden" name="publishScope" value="" />
			<input type="hidden" name="increament" value="" />
			<input type="hidden" name="op" value="updateOp" />
			

			<table width="98%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" align="center">
				<tr>
					<td width="4%" height="20" align="right">
						<img src="../images/ico_point.gif" width="25" height="25">
					</td>
					<td height="20" class="cms_title_blue">
						定时发布参数
					</td>
				</tr>
				<tr>
					<td colspan="2" style="height:9px; background-color:#3266B1"></td>
				</tr>
				<tr>
					<td colspan="2">
						<table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#f0f0f0">
							<tr>
								<td width="100" height="24" align="right" nowrap>
									发布内容:
								</td>
								<td height="24">
									<table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#f0f0f0">
										<%
											if (channelId == null || "".equals(channelId)) 
											{

										%>
										<tr>
											<input type="checkbox" id="PUBLISH_SITE_INDEX" name="PUBLISH_SITE_INDEX" value="1" checked hideFocus />
											发布站点首页
										</tr>
										<%
											}

										%>
										
										<tr>
											<input hideFocus type="checkbox" id="PUBLISH_CHANNEL_INDEX" name="PUBLISH_CHANNEL_INDEX" value="2" onClick="changeChlIndex()" 
										<%
											if(channelId!=null&&!"".equals(channelId))
											{
										%> checked 
										<%
											}
										%> />发布频道首页
										
											<input hideFocus type="checkbox" id="PUBLISH_CHANNEL_RECINDEX" name="PUBLISH_CHANNEL_RECINDEX" value="7" onClick="publishForm.PUBLISH_CHANNEL_INDEX.checked=true" 
										<%
											if(channelId==null||"".equals(channelId))
										{
										%>
											 disabled="true" 
										<%
										}
										%> />
											递归发布所有子频道首页
										</tr>
										<tr>
											<input hideFocus type="checkbox" id="PUBLISH_CHANNEL_CONTENT" name="PUBLISH_CHANNEL_CONTENT" value="3" onClick="changeChlContent();" />
											发布频道内容
											<input hideFocus type="checkbox" id="PUBLISH_CHANNEL_RECCONTENT" name="PUBLISH_CHANNEL_RECCONTENT" value="5" onClick="publishForm.PUBLISH_CHANNEL_CONTENT.checked=true"
												<%
									if(channelId==null||"".equals(channelId))
									{
									%> disabled="true" <%
									}
									%> />
											递归发布所有子频道内容
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td width="100" height="24" align="right" nowrap>
									发布方式:
								</td>
								<td height="24">
									<input hideFocus type="checkbox" id="increamentall" name="increamentall" value="0" onClick="publishForm.increamentno.checked=false" checked />
									完全发布
									<input hideFocus type="checkbox" id="increamentno" name="increamentno" onClick="publishForm.increamentall.checked=false" value="1" />
									增量发布
								</td>
							</tr>
							<tr>
								<td width="100" height="24" align="right" nowrap>
									发布频率:
								</td>
								<td height="24">
									<select name="lever" onChange="changeTime(this)" class="cms_select">
										<option value="0"/>每周一次
										<option value="1"/>每天一次
									</select>
								</td>
							</tr>
							<tr>
								<td width="100" height="24" align="right" nowrap>
									发布日期:
								</td>
								<td height="24">
									<select name="day"  class="cms_select">
										<option value="1"/>星期日&nbsp;&nbsp;
										<option value="2"/>星期一&nbsp;&nbsp;
										<option value="3"/>星期二&nbsp;&nbsp;
										<option value="4"/>星期三&nbsp;&nbsp;
										<option value="5"/>星期四&nbsp;&nbsp;
										<option value="6"/>星期五&nbsp;&nbsp;
										<option value="7"/>星期六&nbsp;&nbsp;
									</select>
								</td>
							</tr>
							<tr>
								<td width="100" height="24" align="right" nowrap>
									发布时间:
								</td>
								<td height="24">
									<select name="time" class="cms_select">
										<script languae="javascript">
											for(var i = 0 ; i<24 ; i++)
											{
												document.write("<option value='"+ i +"'/>"+ i +":00&nbsp;&nbsp;&nbsp;") ;
											}
										</script>
									</select>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<br>
			<div style="text-align:center">
				<INPUT name="button" id="publishButton" type="button" class="cms_button" onClick="subform()" value="保存">
				&nbsp;&nbsp;&nbsp;
				<INPUT name="button" id="closeButton" type="button" class="cms_button" onClick="window.close()" value="关闭">
			</div>
			<div id="waiting_marquee" style="position:absolute;width:40%;height:20px;z-index:1;
				background-color:#F0f0f0;layer-background-color:#F0f0f0;left:22%;top:75%;display:none;"  class="font">   
			    <marquee direction="left" width="250" behavior="alternate"><span class=STYLE1>正在处理中，请稍等……</span></marquee>
		    </div>
		</form>
		<iframe id="hiddenFrame" name="hiddenFrame" width="0" height="0"/>
	</body>

</html>
