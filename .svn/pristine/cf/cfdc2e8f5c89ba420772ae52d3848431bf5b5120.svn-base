<%@ page contentType="text/html; charset=gb2312" language="java"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.documentmanager.*"%>
<%@ page import="com.chinacreator.comm.publicInfo.imp.PublicInfoContentImpl"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<%
		AccessControl accesscontroler = AccessControl.getInstance();
		accesscontroler.checkAccess(request, response);
		String curUserId = accesscontroler.getUserID();
		PublicInfoContentImpl impl = new PublicInfoContentImpl();
	%>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<link href="inc/css/cms.css" rel="stylesheet" type="text/css">
		<title>内容管理主框架</title>
		<style type="text/css">
<!--
body {
	background-color: #E0E3EA;
	margin: auto;
}

a:link {
	text-decoration: none
}

a:visited {
	text-decoration: none
}

a:hover {
	font-size: 12px;
	position: relative;
	top: 1px;
}

.outbox {
	height: 626px;
	width: : 810px;
}
-->
</style>
		<script type="text/JavaScript">
<!--
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function showPerson(){
	window.showModalDialog("iframe.jsp", window, "dialogHeight:645px; dialogWidth:810px;");
}

function showAddressBook(){
	window.showModalDialog("addressManage/addressFrame.jsp",window,"dialogHeight:600px; dialogWidth:900px;");
}
//-->
</script>
	</head>

	<body rightmargin="0"
		onLoad="MM_preloadImages('images/Main_menu01.jpg')" scroll="no">
		<table border="0" align="center" cellpadding="0" cellspacing="0"
			bgcolor="#E6E6F0" class="outbox">
			<tr>
				<td height="104" valign=middle>
					<table width="810" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td height="120" background="images/main_banner_all.jpg">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="57%">&nbsp;
											
									  </td>
										<td width="43%">
									  <!-- <div style=" float:left; width:auto;margin:10px; padding:4px;background-color:#7596BF;  font-size:12px;"><a href="#" onClick="window.open('../sysmanager/logmanager/logList.jsp?logModuel=认证管理','','width=950,height=600,resizable=no left=250 top=170');"><font style="color:#FFFFFF;"><strong>个人登录日志</strong></font></a></div> --></td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td valign=top style="background-repeat: no-repeat">
					<table width="100%" border="0" cellpadding="0" cellspacing="0"
						background="images/main_menu_Midd_BG.gif"
						style="text-align: center">
						<tr>
							<td width="22">
								<img src="images/main_menu_left_BG.gif" width="22" height="52">							</td>
						  <td width="150"><a href="../comm/public_info/newdoc_list_frmset.jsp"
									onMouseOut="MM_swapImgRestore()"
									onMouseOver="MM_swapImage('999','','images/Main_menu02.jpg',1)"><img
										src="images/Main_menu02Mouseout.jpg" name="Image16" width="60"
										height="52" border="0"> </a><a href="docManage/newdoc_list_frmset.jsp"></a><font color="red">(<%=impl.getDocCount(0)%>条)</font></td>
						  <td width="156"><a href="../comm/public_info/audit_list_frmset.jsp"
									onMouseOut="MM_swapImgRestore()"
									onMouseOver="MM_swapImage('Image16','','images/Main_menu01.jpg',1)"><img
										src="images/Main_menu01Mouseout.jpg" name="Image16" width="60"
										height="52" border="0"> </a><font color="red">(<%=impl.getDocCount(1)%>条)</font></td>
							<td width="156">
								<a href="../comm/public_info/pre_list_frmset.jsp"
									onMouseOut="MM_swapImgRestore()"
									onMouseOver="MM_swapImage('999','','images/Main_menu03.jpg',1)"><img
										src="images/Main_menu03Mouseout.jpg" name="Image16" width="60"
										height="52" border="0">								</a><a href="docManage/docPublish.jsp"></a><font color="red">(<%=impl.getDocCount(2)%>条)</font>						  </td>
							<td width="162">
								<a href="../comm/public_info/backdoc_list_frmset.jsp"
									onMouseOut="MM_swapImgRestore()"
									onMouseOver="MM_swapImage('999','','images/Main_menu04.jpg',1)"><img
										src="images/Main_menu04Mouseout.jpg" name="Image16" width="60"
										height="52" border="0">								</a><a href="docManage/workAgain.jsp"></a><font color="red">(<%=impl.getDocCount(4)%>条)</font>						  </td>
						  <td width="109">&nbsp;						  </td>
						  <td width="9">&nbsp;						  </td>
							<td width="9">&nbsp;						  </td>
							<td width="9">&nbsp;						  </td>
							<td width="14">&nbsp;						  </td>
							<td width="20">
								<img src="images/main_menu_R_BG.gif" width="20" height="52">							</td>
						</tr>
					</table>

					<table border="0" cellspacing="0" cellpadding="0"
						background="images/main_M_ball.jpg" width="810" height="267">
						<tr>
							<td valign="top" align="left"></td>
						</tr>
					</table>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="22">
								<img src="images/Main_B_left.gif" width="22" height="79">
							</td>
							<td background="images/main_B_bg.gif">
								<table width="auto" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="65">
											<!--<a href="#"><img src="images/Main_B_botton1.gif" width="65" height="79" hspace="5" border="0"></a>-->
										</td>
										<td width="65">
											<!--<a href="#"><img src="images/Main_B_botton2.gif" width="65" height="79" hspace="5" border="0"></a>-->
										</td>
										<td width="65">
											<!--<a href="#"><img src="images/Main_B_botton3.gif" width="65" height="79" hspace="5" border="0"></a>-->
										</td>
										<td width="65">
											<!--<a href="#"><img src="images/Main_B_botton1.gif" width="65" height="79" hspace="5" border="0"></a>-->
										</td>
										<td width="65">
											<!--&nbsp; -->
										</td>
									</tr>
								</table>
							</td>
							<td width="20">
								<img src="images/Main_B_right.gif" width="20" height="79">
							</td>
						</tr>
					</table>
					<img src="images/main_B_bg.jpg" width="810" height="23">
				</td>
			</tr>
		</table>
		<%
			//取频道可发布的状态
			//  List list=null;
			//SiteManagerImpl tmi=new SiteManagerImpl();
			//Site site=new Site();
			//list=tmi.getSupportedSitePublishStatus(String.valueOf(18));
			//out.print("状态数:"+list.size()+"个");
			//for(int i=0;i<list.size();i++){
			//site = (Site)list.get(i);
			//out.print(site.getSingleEnabledPublishStatus()+"<br>");
			// }
		%>
	</body>
</html>