<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@page import="com.frameworkset.common.poolman.DBUtil"%>
<%@page import="com.chinacreator.cms.sitemanager.*,com.chinacreator.cms.templatemanager.*
,com.chinacreator.cms.container.Template,com.chinacreator.cms.documentmanager.*"%>
<%@page import="com.chinacreator.security.AccessControl,java.util.List"%>
<%@page import="com.chinacreator.cms.channelmanager.*"%>
<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);

	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
    String userid = accesscontroler.getUserID();
    
	String docid = request.getParameter("docid");
	String channelname = "";//request.getParameter("channelName");
	String siteid = "";//request.getParameter("siteid");
	String channelId = "";//request.getParameter("channelId");
	
	DocumentManager dmi = new DocumentManagerImpl();
	ChannelManager cm = new ChannelManagerImpl();
	SiteManager siteManager = new SiteManagerImpl();

	Document document = dmi.getDoc(docid);
	channelId = String.valueOf(document.getChanel_id());
	Channel channel = cm.getChannelInfo(channelId);
	channelname = channel.getName();
	siteid = String.valueOf(channel.getSiteId());
	//��ȡ��ѡƵ����ϸ��ģ��ID
	
	 //�ڷ����ĵ��༭ʱ����rebound�������ʱ����audit����������Ϊ��(�����ĵ���������id��)
   	String flag =  request.getParameter("flag");
   	int taskid = 0;
   	String taskidStr="";
   	if(flag!=null && flag.equals("rebound")){
   		taskid = dmi.hasTask(Integer.parseInt(userid),Integer.parseInt(docid),2);
   	}
   	else if(flag!=null && flag.equals("audit")){
   		taskid = dmi.hasTask(Integer.parseInt(userid),Integer.parseInt(docid),1);
   		taskidStr = request.getParameter("taskidStr");
   	}
	
	String status = String.valueOf(document.getStatus());
	
	String sitename = siteManager.getSiteInfo(siteid).getName();
	String docsource = String.valueOf(document.getDocsource_id());
	String tid = String.valueOf(document.getDetailtemplate_id());
	String doc_level_id = String.valueOf(document.getDoc_level());

	//get�ĵ�������ĵ�����Ϣ
	String partId = "";
	String partName = "";
	String partTitle = "";
	String partChlName = "";//Ƶ������
	String[] doclists =  dmi.getAggrDocList2Str(docid);
	for(int i=0;i<doclists.length;i++)
	{
		String[] tem = doclists[i].split("��");
		partId += tem[0] + "��";
		partName += tem[1] + "��";
		partTitle += tem[2] + "��";
		partChlName += tem[3] + "��";
	}
%>
<%!/**
   * ���HTML�������ַ�ת��
   * @param value String
   * @return String
   */
  String filterStr(String value) {
    if (value == null) {
      return (null);
    }
    char content[] = new char[value.length()];
    value.getChars(0, value.length(), content, 0);
    StringBuffer result = new StringBuffer(content.length + 50);
    for (int i = 0; i < content.length; i++) {
      switch (content[i]) {
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
<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
<script src="../inc/js/func.js"></script>
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
	.STYLE9 {color: #FF6600}

-->
</style>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>CMS �ĵ�����</title>
</head>
<script language="javascript">
		
	//����
	function back() {
		window.close();
	}
	//������ڵ�һ��text
	function init(){
		myform.title.focus();
	}
	//�����ͣ���ı������ֵ����
	function focusend() 
	{ 
		var e = event.srcElement; 
		var r =e.createTextRange(); 
		r.moveStart("character",e.value.length); 
		r.collapse(true); 
		r.select(); 
	}
	//��ʼ������ĵ�table�������
	function initRelatedDoc()
	{
		docxz.document.all("buttons").parentElement.style.display = "none";
		var part_id = "<%=partId%>";
		var part_name = "<%=filterStr(partName)%>";
		var part_title = "<%=filterStr(partTitle)%>";
		var part_chlName = "<%=partChlName%>";
		
		if(part_id!=""&&part_name!="")
		{
			var ids = new Array();
			var names = new Array();
			var titles = new Array();
			var chlNames = new Array();
			ids = part_id.split("��");
			names = part_name.split("��");
			titles = part_title.split("��");
			chlNames = part_chlName.split("��");
			var tableatt = docxz.document.all("chndoclist");
			for(var i=0;i<ids.length-1;i++)
			{
				var row1 = tableatt.insertRow(i+1);
				var td1 = docxz.document.createElement("td");
				var td2 = docxz.document.createElement("td");
				var td3 = docxz.document.createElement("td");
				var td4 = docxz.document.createElement("td");
				var td5 = docxz.document.createElement("td");

				td1.innerHTML="<input type='checkBox' name='id' value="+(i+1)+" hideFocus=true onclick='checkOne(id)'/>";		 
				var docid = "<input type='hidden' name='docid' value='"+ids[i]+"' />";
				//var channelId = "<input type='hidden' name='channelId' value='"+obj[1]+"' />";
				td2.innerHTML = docid + names[i];
				td3.innerHTML = chlNames[i];
				td4.innerHTML = "<input type='text' name=aggrtitle value="+titles[i]+" />";
				var up = "<a href='#' onclick='upRow(this)'><u>����</u></a>&nbsp;";
				var down = "<a href='#' onclick='downRow(this)'><u>����</u></a>";
				td5.innerHTML = "&nbsp;";
				row1.appendChild(td1);
				row1.appendChild(td2);
				row1.appendChild(td3);
				row1.appendChild(td4);
				row1.appendChild(td5);
			}
		}
	}
	//��ʼ�����table
	function document.onreadystatechange()
	{
		if (document.readyState!="complete") 
			return;
		initRelatedDoc();
	}
	function publishPreview(){
		myform.method="post";
		myform.action="previewPubDocHandle.jsp?docId=<%=docid%>";
		myform.submit();
	}
	function seeAdvice(channelId,docid,taskid){
		openWin("<%=rootpath%>/cms/docManage/see_audit_advice.jsp?channelId=<%=channelId%>&docid=<%=docid%>&taskid=<%=taskid%>" ,400,550);
	}
	function delive(){
		saveform("0");
		//flagΪ1��ʾ�¸��ĵ��ĳ���,Ϊ2��ʾ�����ĵ��ĳ���
		openWin("<%=rootpath%>/cms/docManage/doc_AuditorList.jsp?flag=2&channelId=<%=channelId%>&docid=<%=docid%>&taskid=<%=taskid%>");
		var str = window.dialogArguments.location.href;
		var end = str.indexOf("?");
		var strArray;
		if(end != -1)
			strArray= str.slice(0,end);
		else
			strArray = str;
		window.dialogArguments.location.href = strArray+"?"+window.dialogArguments.document.all.queryString.value;
		window.close();
	}
	function agree(){
		var re;
		//����auditFlagΪ��������0��ͬ�⣬1��ͬ��
		re = openWin("<%=rootpath%>/cms/docManage/audit_add_comment.jsp?idStr=<%=taskidStr%>&auditFlag=1",400,550);
		if(re == "cf"){ 
			var str = window.dialogArguments.location.href;
			var end = str.indexOf("?");
				var strArray;
				if(end != -1)
					strArray= str.slice(0,end);
				else
					strArray = str;
			window.dialogArguments.location.href = strArray+"?"+window.dialogArguments.document.all.queryString.value;
			window.close();
		}
	}
	function disagree(){
		var re;
		var addComment = window.confirm("Ҫ������������");
		if(addComment==false){
			re = "cf";
			myform.method="post";
			//����auditFlagΪ��������0��ͬ�⣬1��ͬ��
			myform.action = "<%=rootpath%>/cms/docManage/auditDocHandle.jsp?idStr=<%=taskidStr%>&auditFlag=0";
			myform.submit();
		}
		else{
			re = openWin("<%=rootpath%>/cms/docManage/audit_add_comment.jsp?idStr=<%=taskidStr%>&auditFlag=0",400,550);
		}
		if(re == "cf"){
			var str = window.dialogArguments.location.href;
			var end = str.indexOf("?");
				var strArray;
				if(end != -1)
					strArray= str.slice(0,end);
				else
					strArray = str;
			window.dialogArguments.location.href = strArray+"?"+window.dialogArguments.document.all.queryString.value;
			window.close();	
		}
	}
	function changSelect(o)
	{
	   document.all.inputdocsource.value=document.all.docsource_id.options(document.all.docsource_id.selectedIndex).text;
	   document.all.inputdocsource.focus();
	   document.all.inputdocsource.select();
	}
	//��Ӧrodio�¼�
	function changtpl(type)
	{
		if(type==0)
			document.all.detailtemplate_id.disabled = false;
		else
			document.all.detailtemplate_id.disabled = true;
	}
	//Ԥ��ģ��
	function preview()
	{
		var tplId = document.all.detailtemplate_id.value;
		window.open("../templateManage/template_previewbyid.jsp?tplId=" + tplId + "&siteId=<%=siteid%>");
	}	
</script>
<script type="text/javascript" src="../../public/datetime/calender.js" language="javascript"></script>
<!--����Ĵ��� ʹ�ð� F5��ˢ��modalҳ��-->
<base target="_self">
<body  bottommargin="0"   bgcolor="#F3F4F9"  onkeydown="if(event.keyCode==116){reload.click()}" rightmargin="0" leftmargin="0" topmargin="0" onload="init()">
<script language="javascript">
	document.write("<a id='reload' href='" + document.location.href + "' style='display:none'>reload...</a>");
</script>
<!--����Ĵ��� ʹ�ð� F5��ˢ��modalҳ��-->
<form target="updatelinks" action="update_document.jsp" method="post"  name="myform">
	<input name="doctype" value="3" type=hidden><!--�ۺ��ĵ�-->
   	<input name="docid" value="<%=docid%>" type=hidden>
	<input name="siteid" value="<%=siteid%>" type=hidden>
  	<input name="channelName" value="<%=channelname%>" type=hidden>
  	<input name="channelId" value="<%=channelId%>" type=hidden>
	<input type="hidden" name="titlecolor" value="<%=document.getTitlecolor()%>" /><!--������ɫ-->
	<input name="subtitle" type="hidden" value="<%=document.getSubtitle()%>"/><!--��ʾ����-->
	<input name="author" value="����" type="hidden"/><!--����-->
	<input name="isnewdocsource" value="0" type="hidden"><!--�Ƿ��¸�Դ-->
	<!--input name="detailtemplate_id" type="hidden"/><!--����ģ��-->
	<input name="content" type="hidden"/><!--content-->
	<!--  <input type="hidden" name="parentDetailTpl" value="1"/>-->
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
			            		<tr>
					            	<td height="47" colspan="3" valign="top" background="../images/top_tile_short.jpg">
					            		<table width="100%" border="0" cellpadding="0" cellspacing="0">
					            			<tr>
					                  			<td width="200"><img src="../images/logo.jpg" width="200" height="50" /></td>
					                		    <td>���ݱ༭ [<%=sitename%> վ��  :  <%=channelname%> Ƶ��]</td>
					            			    <td width="53"><img src="../images/Gather_top_LeftDot.jpg" width="174" height="50" /></td>
					            			</tr>
					              		</table>				            	  </td>
					            </tr>
			            		<tr>
					            	<td height="18" colspan="3">
					            		<table width="100%" border="0" cellpadding="0" cellspacing="0">
					                		<tr background="../images/Gather_Content_topbg.gif">
					                  			<td width="4%" height="35" align="right" background="../images/Gather_Content_topbg.gif"><img src="../images/ico_point.gif" width="25" height="25"></td>
					                  			<td class="cms_title_blue">
					                  				<table width="100%" border="0" cellpadding="0" cellspacing="0" background="../images/Gather_Content_topbg.gif">
					                      				<tr>
					                        				<td width="100" height="35" class="cms_title_blue">�ĵ���Ϣ��д</td>
					                        				<td><div style="text-align:right">(<span class="red_star">*</span> 
						                        				Ϊ������
						                        				<img src="../images/tan.gif" width="11" height="11">)</div></td>
					                      				</tr>
				                    			  </table>				                    		  </td>
				                		  </tr>
							                <tr>
							                	<td height="26">&nbsp;</td>
							                  	<td>
							                  		<table border="0" cellpadding="0" cellspacing="0">
									                    <tr>
									                    	<td align="right"><strong>�ĵ�����:</strong></td>
									                      	<td>
										                      	<div align="center">
								                      		<img src="../images/doc_aggr.gif" width="20" height="20">										                      	</div>									                      	</td>
									                      	<td>�ۺ��ĵ�</td>
								                      </tr>
						                  		  </table>							                    </td>
							                </tr>
							                <tr>
							                	<td height="26">&nbsp;</td>
							                  	<td height="23"><strong>���ӱ���:
							                  		<span class="cms_title_blue">
								                    	<label>						                    		</label>
							                  		</span></strong><span class="cms_title_blue"><label>
							                  		<input name="title" type="text" class="cms_text" size="60" value="<%=document.getTitle()%>" onfocus="focusend()">
								                    	</label>
							                  		</span>
						                  		  <span class="STYLE7">
							                  			<label>
							                  				<span class="red_star">*</span>							                  			</label>
						                  		  </span>
							                  		&nbsp;&nbsp;<span><strong>�ĵ���Դ:</strong>
														<span>
						                  					<span class="black">
						                  						<span class="STYLE7">
						                  							<span class="red_star">
						                  								<span class="cms_title_blue">
						                  								<input type="text" style="width:100px;height:21px;font-size:10pt;" id="inputdocsource" name="inputdocsource" readonly><span style="width:18px;border:0px solid red;">
						                  								<select name="docsource_id"  style="margin-left:-100px;width:118px;" onChange="changSelect(this)" id="docsource_id" disabled>
						                										<%
														                          List dslist=null;
																			      DocumentManagerImpl dmimpl=new DocumentManagerImpl();
																			      dslist=dmimpl.getDocSourceList();
																				  request.setAttribute("dslist",dslist);
																				%>
												  								<pg:list requestKey="dslist">
																					<option value="<pg:cell colName="docsource_id"/>"  
																						<pg:equal colName="docsource_id" value="<%=docsource%>">selected</pg:equal>>
																					 	<pg:cell colName="srcname" defaultValue="" />
																				 	</option>
																				</pg:list>
						                    								</select>
						                    								</span>
						                  								</span>						                  							</span>						                  						</span>						                  					</span>						                  				</span>
						                  			</span>											  </td>
							                </tr>
							               
					                		<tr>
							                	<td height="26">&nbsp;</td>
							                  	<td height="23">
							                  		<span class="black">
							                  			<strong>�� �� ��:</strong>						                  			<span class="cms_title_blue"><input name="keywords" type="text" class="cms_text" size="26" value="<%=document.getKeywords()%>">
							                  			</span>
&nbsp;&nbsp;							                  		</span>
													����:
													<span class="cms_title_blue">
														<select name="doc_level" class="cms_select" disabled>
															<%
															  List doclevellist = null;
															  DocumentManager impl = new DocumentManagerImpl();
															  doclevellist = impl.getDocLevelList();
															  request.setAttribute("doclevellist",doclevellist);
															%>
															<pg:list requestKey="doclevellist">
																<option value="<pg:cell colName="id"/>"<pg:equal colName="id" value="<%=doc_level_id%>">selected</pg:equal>>
																<pg:cell colName="name"/> 
															</pg:list>
														</select>
&nbsp;												  </span>
											  		
											  		<label>
											  			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
														&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
														<strong>&nbsp;���ʱ��:</strong>										  			<span class="black">
											  				<span class="cms_title_blue">
																<input name="docwtime" type="text" dateformat="yyyy-MM-dd HH:mm:ss" class="cms_text" value="<%=document.getDocwtime()%>" size="20" readonly="true" >
															</span>
														</span>													</label>						                  	  </td>
							                </tr>
							                <tr height="23">
							                <td>&nbsp;</td>
							                <td colspan="3"><strong>����ģ��:</strong>
							                <span class="cms_title_blue">
																			<input type="radio" name="selecttpl" value="0" checked="true" onClick="changtpl(0)" disabled>
																			<select name="detailtemplate_id" class="cms_select" style="width:130px" disabled>
																				<%
																				  List list=null;
																				  TemplateManager tmi=new TemplateManagerImpl();
																				  Template template=new Template();
																				  list=tmi.getTemplateInfoListofSite(Integer.parseInt(siteid), 2);
																				  request.setAttribute("tpllist",list);
																				%>
																				<pg:list requestKey="tpllist">
																					<option value="<pg:cell colName="templateId"/>"<pg:equal colName="templateId" value="<%=tid%>">selected</pg:equal>>
																					<pg:cell colName="name"/> 
																				</pg:list>
																			</select>
																			
																		</span>		
							               
							                
							                <input type="radio" name="selecttpl" value="1" onClick="changtpl(1)" disabled>
																		<input type="hidden" name="parentDetailTpl"/>
																		<%
																		ChannelManager chnl = new ChannelManagerImpl();
																		Template tp = chnl.getDetailTemplateOfChannel(channelId);
																		String tname = (tp==null?"��û������":tp.getName());
																		%>
																		�̳�����Ƶ����ϸ��ģ��(<span class="red_star"><%=tname%></span>)	  
																		<!--<a href="#" onClick="preview()" ><u>Ԥ��</u></a>-->
							                </td>
							                </tr>
							                <tr>
							                	<td height="26">&nbsp;												</td>
											  <td><strong>ժҪ����:</strong>												  <textarea name="docabstract" cols="70" rows="5" class="cms_textarea"><%=document.getDocabstract()%></textarea></td>
							                </tr>
					                		<tr>
												<td height="26">&nbsp;</td>
												<td height="23" colspan="2">
													<!--<img align=absMiddle border=0 height=12 src="../images/text-correlated.gif" width=14 >
													<a id=tab2 href="#" onclick=tabClick(2) ><u>[����ĵ�]</u></a>-->												</td>
									        </tr>
				              		  </table>					              	</td>
					            </tr>
			            		
								<tr>
									<td  width="95%" height="22" colspan="3"  align="center" valign="top">
										<div>

											<input type="hidden" name="doclist">
											<input type="hidden" name="titles">
											<br/><iframe id="docxz" src="../channelManage/chn_doc_xzlist.jsp?flag=11&siteid=<%=siteid%>" frameborder="0" scrolling="auto" width="95%" height="300">
											</iframe>
										</div>									</td>
								</tr>
								<tr>
									<td  height="23">
										<div align="center">
											<input type="button" value="����" class="cms_button" onclick="back()">
										</div>									</td>
								</tr>
								
			            		<!--��Դ�ڱ����վ���и�վ��-->
  </table> 
   <script type="text/javascript">
  document.all.inputdocsource.value=document.all.docsource_id.options(document.all.docsource_id.selectedIndex).text;
  </script>  
</form>
<div style="display:none">
	<iframe name="updatelinks" width="0" height="0"></iframe>
</div>
</body>
</html>