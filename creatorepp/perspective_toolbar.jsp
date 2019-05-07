<%@page contentType="text/html;charset=GBK"%>

<%@ include file="sysmanager/include/global1.jsp"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page
	import="com.chinacreator.epp.applymanager.dbmanager.ApplyManager"%>
<%@page
	import="com.chinacreator.epp.shortcutmenu.dbmanager.Shorcut_menuManager"%>
<%@page import="com.chinacreator.framework.Item"%>
<%@page import="com.chinacreator.framework.MenuHelper"%>
<%@page import="java.util.*"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String userId = accesscontroler.getUserID();
	String currentSystemID = accesscontroler.getCurrentSystemID();
	//System.out.println("currentSystemID="+currentSystemID);
	String title = "";
	String background = "epp/eppTemplate/applybackground/banner.jpg";
	String logo = ""; 
	//朱文 
	//平台根据配置修改表头背景
	//if (currentSystemID != null && !currentSystemID.trim().equals("")
	//		&& !currentSystemID.trim().equals("module")) {
		if (currentSystemID != null && !currentSystemID.trim().equals("")) {
		ApplyManager applyManager = new ApplyManager();
		background = applyManager.getApplyBackground(currentSystemID);
		logo = applyManager.getApplyLogo(currentSystemID);
		//System.out.println("background="+background);
		if (background == null || background.trim().equals("")) {
			background = "epp/eppTemplate/applybackground/banner.jpg";
			//title = applyManager.getApplyName(currentSystemID);
		}
	} else {
		//title = "科创应用支撑平台";
		title = "";
		logo = "epp/eppTemplate/applyLogo/future-logo.gif";
	}
%>
<HTML>
	<HEAD>
		<TITLE>科创应用支撑平台</TITLE>
		<link rel="stylesheet" type="text/css"
			href="sysmanager/css/toolbar.css">
		<script language="javascript" src="sysmanager/scripts/toolbar.js"></script>
		<script language="javascript" src="sysmanager/common/CommonFunc.js"></script>

		<META content="MSHTML 6.00.2800.1522" name=GENERATOR>
	</HEAD>
	<%@ include file="/epp/css/cssControl.jsp"%>
	<style type="text/css">
<!--
.menu { background:url(epp/eppTemplate/images/nav01.jpg) no-repeat;color: #fff; width:95px; line-height:26px; text-align:center;margin-right:5px;margin-top:2px;display:inline}
.menu a { color: #fff; text-decoration:none;}
.menu a:visited {color: #fff; text-decoration:none;}
.menu a:hover {color: #000;background:url(epp/eppTemplate/images/nav02.jpg) no-repeat; width:95px; line-height:26px;}
.menu a:active {color: #000;background:url(epp/eppTemplate/images/nav02.jpg) no-repeat; width:95px; line-height:26px;}
.menubg { background:url(epp/eppTemplate/images/bg01.jpg) repeat-x; width:100%; height: 5px;}
-->
    </style>
	<body >

			<table width="100%" height="63px" cellpadding=3 cellspacing=0
				border=0 background="<%=background%>">
				<tr>
					<td class="text" nowrap valign="middle" align="center" width="75"
						height=25>
						<%
						if (currentSystemID.trim().equals("module")) {
						%>
						<!-- <img class="normal" src="<%//=logo%>" width="75" height="25"
										border="0" title="科创应用支撑平台">
									-->
						<%
						}
						%>
					</td>
					<td class="text" nowrap valign="middle" align="left" width="200"
						height=25>
						<br />
						<p style="font-size: 20px;font-weight: bold;">
							<%=title%>
						</p>
					</td>
					<td class="text" nowrap valign="middle" align="center" width="100%"
						height=25></td>
					<td class="text" nowrap valign="middle" align="right" width="260"
						height=25>
						<br />
						<jsp:include page="/accountbox.jsp" flush="true" />
					</td>
					<td class="text" nowrap valign="middle" align="center" width="5"
						height=25></td>
				</tr>
				<tr>
					<!-- <td colspan="4" bgcolor="#93bee2" width="100%" height=1px></td>-->
				</tr>
			</table>
			<%
						List list = new Shorcut_menuManager()
						.getShortcutmenuItemListByUserid(accesscontroler
						.getUserID());
			%>
			<table width="100%" border="0" cellpadding="0" cellspacing="0"
				style="background:url(epp/eppTemplate/images/navbg.jpg) repeat-x;width:100%;font-size:13px;">
				<tr>
					<td nowrap="nowrap">
						&nbsp;&nbsp;&nbsp;&nbsp;
						<span id="currentDate" />
					</td>
					<td nowrap="nowrap" >
					&nbsp;&nbsp;
						<img src="epp/eppTemplate/images/before.gif" onmouseover="scrollw(-1)" onmouseout="scrollw(0)"
							onmousedown="scrollw(-3)" title="向左滚动" style="cursor: hand;" >
					</td>
					<td align="center" nowrap="nowrap">
				<div id="scroller" align="right" style="width:800px;height:26px;overflow:hidden;white-space: nowrap;">
						<%
									for (int i = 0; i < list.size(); i++) {
									Item item = (Item) list.get(i);
									String itemname = item.getName();
									String itemurl = MenuHelper.getMainUrl(
									request.getContextPath(), item.getPath(),
									(Map) null);
						%>
						
						<div class="menu">
							<a href="<%=itemurl%>" target="perspective_main"
								title="<%=itemname%>" ><%=itemname
									.length() > 6 ?itemname.substring(0,5)+"...":itemname%> 
							</a>
						</div>
						<%
						}
						%>
						</div>
			
					</td>
					<td nowrap="nowrap">
					<img src="epp/eppTemplate/images/back.gif" onmouseover="scrollw(1)" onmouseout="scrollw(0)"
							onmousedown="scrollw(3)" title="向右滚动" style="cursor: hand;">&nbsp;&nbsp;
					</td>
				</tr>
			</table>
			<table width="100%" border="0" cellpadding="0" cellspacing="0" background="epp/eppTemplate/images/bg01.jpg">
  <tr>
    <td height="5"></td>
  </tr>
</table>
	</body>
</html>
    <script type="text/Javascript"> 
function scrollw(n)      
{b=n;      
document.getElementById("scroller").scrollLeft=document.getElementById("scroller").scrollLeft+b;      
if (b==0) return;      
setTimeout("scrollw(b)",1);      
}

         //提取年月日
 var now = new Date();
        var year=now.getYear();
        var month=now.getMonth()+1;
        var date=now.getDate();
 var day = now.getDay();
 var dayName="";
 //替换星期为大写
 if(day == 0) dayName = "星期日";
 else if(day == 1) dayName = "星期一";
 else if(day == 2) dayName = "星期二";
 else if(day == 3) dayName = "星期三";
 else if(day == 4) dayName = "星期四";
 else if(day == 5) dayName = "星期五";
 else dayName = "星期六";
 document.getElementById("currentDate").innerHTML =year+"年"+month+"月"+date+"日 "+dayName;
</script>