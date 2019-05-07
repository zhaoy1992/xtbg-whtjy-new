<%@ page contentType="text/html; charset=GBK" language="java"%>

<%@ page import="com.chinacreator.security.AccessControl"%>

<%@page import="com.chinacreator.cms.sitemanager.SiteManager,
				com.chinacreator.cms.sitemanager.SiteManagerImpl,
				com.chinacreator.cms.templatemanager.TemplateManager,
				com.chinacreator.cms.templatemanager.TemplateManagerImpl,
				com.chinacreator.cms.container.Template"%>

<%@ page import="com.chinacreator.cms.documentmanager.crawl.EDocument"%>
<%@ page import="com.chinacreator.cms.documentmanager.crawl.EDocumentManager"%>
<%@ page import="com.chinacreator.cms.documentmanager.crawl.EDocumentManagerImpl"%>

<jsp:useBean id="date" scope="page" class="net.fiyu.edit.TimeStamp" />

<%@ page import="com.chinacreator.cms.channelmanager.ChannelManager"%>
<%@ page import="com.chinacreator.cms.channelmanager.ChannelManagerImpl"%>
<%@ page import="com.chinacreator.cms.channelmanager.Channel"%>

<%@ page import="com.chinacreator.cms.driver.htmlconverter.CmsLinkProcessor"%>
<%@ page import="com.chinacreator.cms.driver.i18n.CmsEncoder"%>

<%@ page import="java.util.List"%>

<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>



<%
			response.setHeader("Cache-Control", "no-cache");
			response.setHeader("Pragma", "no-cache");
			response.setDateHeader("Expires", -1);
			response.setDateHeader("max-age", 0);

			AccessControl accesscontroler = AccessControl.getInstance();
			accesscontroler.checkAccess(request, response);
			

			

			String docid = request.getParameter("docId");

			String channelname = "";
			
			String siteid = "";
			String channelId = "";
			int docsourceid=0;
			String docsourcename="";

			EDocumentManager dmi = new EDocumentManagerImpl();

			EDocument document = dmi.getDocumentById(docid);

			SiteManager siteManager = new SiteManagerImpl();

			channelId = String.valueOf(document.getChannelId());

			ChannelManager cm = new ChannelManagerImpl();

			Channel channel = cm.getChannelInfo(channelId);

			channelname = channel.getName();
			
			
			docsourcename=document.getDocsource_name();

			siteid = String.valueOf(channel.getSiteId());

			String tid = String.valueOf(document.getDetailtemplateId());

			
			String sitedir = siteManager.getSiteInfo(siteid).getSiteDir();//站点相对路径

			String relativePath = channel.getChannelPath();//站点相对路径

			String docpath = sitedir + "/_webprj/uploadfiles/"
					+ (String) date.Time_YMD().substring(0, 6);

			//处理文档内容
			CmsLinkProcessor processor = new CmsLinkProcessor(request,
					relativePath, sitedir);
			processor.setHandletype(CmsLinkProcessor.PROCESS_READCONTENT);
			try
			{
				String content = processor.process(document.getContent(),
						CmsEncoder.ENCODING_US_GBK);
				document.setContent(content);
			} catch (Exception e)
			{
				e.printStackTrace();
			}

			%>
<%!/**
	 * 针对HTML的特殊字符转义
	 * @param value String
	 * @return String
	 */
	String filterStr(String value)
	{
		if (value == null)
		{
			return (null);
		}
		char content[] = new char[value.length()];
		value.getChars(0, value.length(), content, 0);
		StringBuffer result = new StringBuffer(content.length + 50);
		for (int i = 0; i < content.length; i++)
		{
			switch (content[i])
			{
			case '<':
				result.append("&lt;");
				break;
			case '>':
				result.append("&gt;");
				break;
			case '&':
				result.append("&amp;");
				break;
			case '"':
				result.append("&quot;");
				break;
			case '\'':
				result.append("&#39;");
				break;
			case '\\':
				result.append("\\\\");
				break;
			default:
				result.append(content[i]);
			}
		}
		return (result.toString());
	}

	%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<link href="../../inc/css/cms.css" rel="stylesheet" type="text/css">
	<script src="../../inc/js/func.js"></script>
	<script type="text/javascript" src="../../../public/datetime/calender.js" language="javascript"></script>
	<style type="text/css">
<!--
	.STYLE7 {color:#003398; font-size: 12px;}
	#Layer1 {
		position:absolute;
		left:0px;
		top:0px;
		width:113px;
		height:127px;
		z-index:1;
	}
	.STYLE8 {color: #0000FF}
-->
</style>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title>CMS 文档管理</title>
	</head>

	<body bottommargin="0" bgcolor="#F3F4F9" rightmargin="0" leftmargin="0" topmargin="0">

		<form target="updategather" name="myform">

			<tr>
	            <td height="50" colspan="3" valign="top" background="<%=request.getContextPath()%>/cms/images/top_tile_short.jpg">
		            
	            </td>
	        </tr>

			<tr>
				<td height="18" colspan="3">
					<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
						<tr background="../../images/Gather_Content_topbg.gif">
							<td width="4%" height="35" align="right" background="../../images/Gather_Content_topbg.gif">
								<img src="../../images/ico_point.gif" width="25" height="25">
							</td>
							<td colspan="3" background="../../images/Gather_Content_topbg.gif" class="cms_title_blue">
								<table width="100%" border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td height="35" class="cms_title_blue">
											文档信息
										</td>
										<td width="120">
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td height="26">
								&nbsp;
							</td>
							<td height="23" colspan="3">
								<table border="0" cellpadding="3" cellspacing="0">
									<tr>
										<td align="right">
											<strong>文档类型:</strong>
										</td>
										<td>
											<img src="../../images/doc_html.gif" width="20" height="20">
										</td>
										<td>
											普通文档
										</td>
									</tr>
								</table>

							</td>
						</tr>
						<tr>
							<td height="26">
								&nbsp;
							</td>
							<td width="8%" height="23" align="right">
								<strong>文档标题:</strong>
							</td>
							<td width="43%">
								<span class="cms_title_blue"> <label>
										<input name="title" type="text" class="cms_text" size="60" value="<%=document.getTitle()%>" readonly>
									</label> </span> <span class="STYLE7"> <label>
										<span class="red_star"> * </span>
									</label> </span> <span> </span>
							</td>
							<td height="23">
								<span> <strong>标题颜色:</strong> </span> <span> <input name="titlecolor" value="<%=document.getTitleColor()%>" readonly type="text" class="cms_text" size="8" style="color:<%=document.getTitleColor()%>" maxlength="50"> </span>
							</td>
						</tr>
						<tr>
							<td height="26">
								&nbsp;
							</td>
							<td height="23" align="right">
								<strong>显示标题:</strong>
							</td>
							<td height="23">
								<input name="subtitle" type="text" class="cms_text" size="60" value="<%=document.getSubtitle()%>" readonly>
								<span class="STYLE7"> <label>
										<span class="red_star"> * </span>
									</label> </span>
							</td>
							<td height="23">
								<label>
									<strong>文档来源:</strong>
								</label>
								<span class="cms_title_blue"> <input type="text" style="width:100px;height:21px;font-size:10pt;" id="inputdocsource" name="inputdocsource" value="<%=docsourcename%>" readonly>
							</td>
						</tr>

						<tr>
							<td height="26">
								&nbsp;
							</td>
							<td height="23" align="right">
								<strong>编稿时间:</strong>
							</td>
							<td height="23">
								<input name="docwtime" dateformat="yyyy-MM-dd HH:mm:ss" type="text" value="<%=document.getDocwtime()%>" readonly="true">
								<span class="STYLE7"> <label>
										<span class="red_star"> * </span>
									</label> </span>
							</td>
						</tr>

						<tr>
							<td height="26">
								&nbsp;
							</td>
							<td height="23" align="right">
								<strong>发布模板:</strong>
							</td>
							<td height="23">
								<table border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td>
											<table>
												<tr>
													<td>
														<span class="cms_title_blue"> <span class="cms_title_blue"> <select name="detailtemplate_id" class="cms_select" style="width:130px" disabled>
																	<%
																		List list = null;
																		TemplateManager tmi = new TemplateManagerImpl();
																		Template template = new Template();
																		list = tmi.getTemplateInfoListofSite(Integer.parseInt(siteid), 2);
																		request.setAttribute("tpllist", list);
															
																		%>
																	<pg:list requestKey="tpllist">
																		<option value="<pg:cell colName="templateId"/>" <pg:equal colName="templateId" value="<%=tid%>">
																									selected
																								</pg:equal>>
																			<pg:cell colName="name" />
																	</pg:list>
																</select> </span>
													</td>
												</tr>
											</table>
										</td>
										<td>
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td height="26">
								&nbsp;
							</td>
							<td height="23" colspan="3">
								<table width="100%" border="0" cellpadding="3" cellspacing="0">
									<tr>
										<td width="8%" align="right">
											<strong>关键字:</strong>
										</td>
										<td width="92%">
											<textarea name="keywords" cols="70" rows="5" class="cms_textarea" readonly><%=document.getKeywords()%></textarea>
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td height="26">
								&nbsp;
							</td>
							<td height="23" colspan="3">
								<table width="100%" border="0" cellpadding="3" cellspacing="0">
									<tr>
										<td width="8%" align="right">
											<strong>摘要内容:</strong>
										</td>
										<td width="92%">
											<textarea name="docabstract" cols="70" rows="5" class="cms_textarea" readonly><%=document.getDocabstract()%></textarea>
										</td>
									</tr>
								</table>
							</td>
							<td valign="baseline">
								<input type="button" value="返回" class="cms_button" onclick="window.close()">
							</td>
						</tr>
					</table>
				</td>
			</tr>


			<tr>
				<td width="95%" height="22" colspan="3" align="center" valign="top">
					<div>
						<input type="hidden" name="content" value="<%=filterStr(document.getContent())%>">
						<input type="hidden" name="pics">
						<input type="hidden" name="flashs">
						<input type="hidden" name="medias">
						<input type="hidden" name="files">
						<br />
						<iframe id="eWebEditor1" src="<%=request.getContextPath()%>/cms/editor/eWebEditor48/ewebeditor.htm?id=content&style=coolblue&cusdir=<%=docpath%>" frameborder="0" scrolling="no" width="95%" height="460">
						</iframe>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
			</tr>
			</table>
		</form>
	</body>
</html>