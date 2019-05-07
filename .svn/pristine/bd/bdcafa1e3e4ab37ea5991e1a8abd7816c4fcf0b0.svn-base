<%@page contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.cms.sitemanager.*" %>
<%@ page import="java.util.List"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request,response);
	
	com.chinacreator.cms.CMSManager cmsManager  = new com.chinacreator.cms.CMSManager();
	cmsManager.init(request,session,response,control);

	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);
	
	String siteId = request.getParameter("siteId");
	if(siteId == null || siteId.trim().length()==0){
	%>
		<script language="javascript" type="text/javascript">
			alert("站点id为空,无法编辑站点.");
			self.location.href = "about:blank";
		</script>
	<%
		return;
	}
	SiteManager sm = new SiteManagerImpl();
	Site site = sm.getSiteInfo(siteId) ;

	String siteName = site.getName();
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
	<script src="../inc/js/func.js"></script>
	<title>复制站点</title>
<style type="text/css">
	.topDIV {
		background-image: url(../images/toolbar_common_func_site.jpg);
		height: 82px;
		padding-top: 7px;
		padding-left: 55px;

	body {
		margin-left: 0px;
		margin-top: 0px;
		margin-right: 0px;
		margin-bottom: 0px;
	}
</style>
<script language="javascript">

//站点窗口输入参数校验
function checkForm(){
	if(confirm("您确定复制此站点信息？（包括模板信息和频道信息）"))
	{
		var siteForm = document.all.siteForm;
		document.getElementById("divProcessing").style.display="block";
		document.all.siteForm.submit();
	}
}
</script>
</head>
<body bgcolor="#F7F8FC" leftmargin="0" topmargin="0" >
<form id="siteForm" name="siteForm"  target="exeman" action="site_copy_do.jsp" method="post">
	<input name="copyBySiteId" type="hidden" id="siteId" value="<%=siteId%>">
	<table width="100%" border="0" cellpadding="3" cellspacing="0" align="center" class="Templateedittable">
		<tr>
			<td colspan="2" class="topDIV"  align="left" valign="top">&nbsp;<div class="siteCTitle">复制站点</div></td>
		</tr>
		<tr>
			<td width="100" height="24" align="right" nowrap bgcolor="#EDEFF6">被复制站点:</td>
			<td height="24">
				<%=(siteName==null?"&nbsp;":siteName)%>
			</td>
		</tr>
		<tr>
			<td height="24" rowspan="2" align="right" nowrap bgcolor="#EDEFF6">复制到站点:</td>
			<td height="24">
				<select name="copyToSiteId" class="cms_select" style="width:200px">
					<%
                      List sitelist = cmsManager.getSiteAllRuningList();
					  request.setAttribute("sitelist",sitelist);

					%>
          			<pg:list requestKey="sitelist">
          			<%if(!dataSet.getString("siteId").equals(siteId)){ %>
          			<option value="<pg:cell colName="siteId"/>"><pg:cell colName="name"/></option>  
          			<%} %>
          			</pg:list>
        	</select>
			</td>
		</tr>
  </table>
	<br>
	<div style="text-align:center">
		<INPUT name="button" type="button" class="cms_button" onClick="checkForm()"  value="保存">
		&nbsp;&nbsp;&nbsp;
		<INPUT name="button" type="button" class="cms_button" onClick="window.close()"  value="关闭">
	</div>
</form>
<div id="divProcessing" style="width:280px;height:50px;position:absolute;left:100px;top:150px;display:none">
        <table border=0 cellpadding=0 cellspacing=1 bgcolor="#000000" width="100%" height="100%">
            <tr>
                <td bgcolor=#3A6EA5>
                    <marquee align="middle" behavior="alternate" scrollamount="5">
                        <font color=#FFFFFF>...站点复制中...请等待...</font>
                    </marquee>
                </td>
            </tr>
        </table>
    </div>
<iframe name="exeman" width="0" height="0" style="display:none"></iframe>
</body>
</html>