<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.chinacreator.cms.votemanager.*"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ include file="../../sysmanager/include/global1.jsp"%>
<jsp:useBean id="date" scope="page" class="net.fiyu.edit.TimeStamp" />
<%@ page import="com.chinacreator.cms.sitemanager.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<%!/**
	 * 针对HTML的特殊字符转义

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
	}%>

		<%
			String path_ = request.getContextPath();
			String basePath = request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ path_ + "/";

			String todayTime = null;
			String strOutput = null;
			Calendar calendar = Calendar.getInstance();
			strOutput = "" + calendar.get(1); //年

			int n = calendar.get(2) + 1;
			if (n < 10) //月

				strOutput = strOutput + "-0" + n;
			else
				strOutput = strOutput + "-" + n;
			n = calendar.get(5);
			if (n < 10) //日

				strOutput = strOutput + "-0" + n;
			else
				strOutput = strOutput + "-" + n;

			n = calendar.get(11);
			if (n < 10) //时

				strOutput = strOutput + " 0" + n;
			else
				strOutput = strOutput + " " + n;
			n = calendar.get(12);
			if (n < 10) //分

				strOutput = strOutput + ":0" + n;
			else
				strOutput = strOutput + ":" + n;
			n = calendar.get(13);
			if (n < 10) //秒

				strOutput = strOutput + ":0" + n;
			else
				strOutput = strOutput + ":" + n;
			todayTime = strOutput;
		%>

		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<title>编辑<%=request.getParameter("channel")%>信息</title>
		<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
		<META HTTP-EQUIV="pragma" CONTENT="no-cache">
		<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
		<META HTTP-EQUIV="expires" CONTENT="Mon, 23 Jan 1978 20:52:30 GMT">

		<tab:tabConfig />
		<script src="<%=basePath%>public/datetime/calender.js"
			language="javascript"></script>
		<script src="<%=basePath%>public/datetime/calender_date.js"
			language="javascript"></script>
		<link href="<%=basePath%>cms/inc/css/cms.css" rel="stylesheet"
			type="text/css">
		<script src="<%=basePath%>cms/inc/js/func.js"></script>
		
	<SCRIPT src="js/list.js" language="javascript"></SCRIPT>
		<link href="css/wgtm.css" rel="stylesheet" type="text/css" />
	</head>
	<body style="background-color: #F3F4F9" onload="init()">
		<%
			response.setHeader("Cache-Control", "no-cache");
			response.setHeader("Pragma", "no-cache");
			response.setDateHeader("Expires", -1);
			response.setDateHeader("max-age", 0);

			AccessControl accessControl = AccessControl.getInstance();
			accessControl.checkAccess(request, response);
			CMSManager cmsM = new CMSManager();
			cmsM.init(request, session, response, accessControl);
			String siteID = cmsM.getSiteID();
			SiteManager siteManager = new SiteManagerImpl();
			String docPath = siteManager.getSiteInfo(siteID).getSiteDir()
					+ "/_webprj/uploadfiles";
			//String docPath = "site"+siteID+"/_webprj/uploadfiles/" + (String)date.Time_YMD().substring(0,6) ;

			String qid = request.getParameter("qid");
			String id = request.getParameter("id");
			String channel = request.getParameter("channel");
			String docpath = "";
			Title oneTitle = new Title();
			String picPath = "";
			String depart = "";
			String ctime = "";
			String check = "";
			String content = "";
			String disposedept = "";
			if (id == null && qid != null) {
				VoteManager voteMgr = new VoteManagerImpl();
				id = String.valueOf(voteMgr.getTitleIDBy(qid));
			}
			if (id != null) {
				VoteManager voteMgr = new VoteManagerImpl();
				oneTitle = voteMgr.getSurveyBy(Integer.parseInt(id));
				if (oneTitle != null) {
					picPath = oneTitle.getPicpath();
					ctime = oneTitle.getFoundDate();
					if (ctime.length() > 20) {
						ctime = ctime.substring(0, 19);
					}
					depart = oneTitle.getDepart_id();
					disposedept = oneTitle.getDepart_name();
					content = oneTitle.getContent();
					content = filterStr(content);
				}
			}
		%>



		<base target="_self">
		<form name="form1" method="post" action="copyOfQuestionnaire_do.jsp"
			target="biaoge">

			<input name="ipStartString" type="hidden" value="">
			<input name="titleID" type="hidden" value="">
			<input name="ipEndString" type="hidden" value="">
			<input name="timeStartString" type="hidden" value="">
			<input name="timeEndString" type="hidden" value="">
			<input name="questionString" type="hidden" value="">
			<input name="actionType" type="hidden" value="">
			<input name="origQidString" type="hidden" value="">
			<table width="100%">
				<tr>
					<td>
						<div align="right">
							<input type="button" name="保存" value=" 保 存 " onclick="return save('<%=todayTime%>')"  class="button2">
							<% if(request.getParameter("qid")!=null||request.getParameter("id")!=null){
							 %><input type="button" name="删除 " value=" 删 除 " onclick="return del();"    class="button2"><%
							}%>
							<input type="button" name="取消" value=" 取 消 " onclick="javascript:window.close();"  class="button2">
						</div>
					</td>
				</tr>
			</table>
			<tab:tabContainer id="foo-survey-add" selectedTabPaneId="foo-survey">
				<tab:tabPane id="foo-survey" tabTitle="问卷信息">

					<table border="0" cellpadding="0" cellspacing="0" class="table_wgtm02" width="100%">
						<tr>
							<td align="right">
								问卷名称：

							</td>
							<td>
								<input name="titleName" type="text" maxlength="200"
									class="textfield01">
								<font color="red">*问卷标题字数不能超过100字</font>
							</td>
						</tr>
						<input name="channelName" type="hidden"
							value="<%=channel != null ? channel : ""%>">
						<tr>
					<td align="right">
						所属部门：
					</td>
					<td>
							<input type="hidden" name="depart_id" id="depart_id" value='<%=depart %>'>
						<input type="text" name="orgName" readonly="true" class="textfield01" value='<%=disposedept%>' defaultValue=""> <input type=button name="bxlb" class="button2" value="部门选择" onclick="addOrg()">
					<font color="#FF0000">*</font>	</td>
				</tr>
						<tr>
							<td>
								&nbsp;
							</td>
							<td>
								&nbsp;
							</td>
						</tr>
						<tr>
							<td>
								&nbsp;
							</td>
							<td>
								<input type="checkbox" name="can_repeat" value="0"
									onClick="return chkTimeGap();">
								相同IP不可重复投票 时间间隔
								<select name="selectGap" disabled>
									<option value="-1">
										无限
									</option>
									<option value="1">
										1
									</option>
									<option value="2">
										2
									</option>
									<option value="3">
										3
									</option>
									<option value="4">
										4
									</option>
									<option value="5">
										5
									</option>
									<option value="6">
										6
									</option>
									<option value="7">
										7
									</option>
									<option value="8">
										8
									</option>
									<option value="9">
										9
									</option>
									<option value="10">
										10
									</option>
									<option value="11">
										11
									</option>
									<option value="12">
										12
									</option>
									<option value="13">
										13
									</option>
									<option value="14">
										14
									</option>
									<option value="15">
										15
									</option>
									<option value="16">
										16
									</option>
									<option value="17">
										17
									</option>
									<option value="18">
										18
									</option>
									<option value="19">
										19
									</option>
									<option value="20">
										20
									</option>
									<option value="21">
										21
									</option>
									<option value="22">
										22
									</option>
									<option value="23">
										23
									</option>
									<option value="24">
										24
									</option>
								</select>
								小时
							</td>
						</tr>
						<tr>
							<td width="15%" align="right">
								创建时间：

							</td>
							<td>
								<%
									if (ctime.equals("") || (ctime == null)) {
								%>
								<input type="text" name="ctime" id="ctime"
									value="<%=todayTime%>" class="cms_text" readonly size="30" />
								<%
									} else {
								%>
								<input type="text" name="ctime" id="ctime" class="cms_text"
									readonly size="30" />
								<%
									}
								%>
								<input name="button" type="button"
									onClick="showdatetime(document.all('ctime'))" value="..." class="button2"/>
							</td>
						</tr>
						<%
							if (ctime.length() < 10) {
						%>
						  <tr>
					<td width="15%" align="right">
						选择图片：


					</td>
					<td>
					<input type="text" name="picpath"  class="cms_text" readonly size="30"/>
											
					<input type="button" class="button2" name="addpic" onClick="chooseImage()" value="选择图片"/>
						
					</td>
				</tr>
						<%
							} else {
						%>
						<tr>
			    	<td width="15%" align="right">
			    		主题图片：

			    	</td>
			    	<td>
			    		<input type="hidden" name="dispicpath" >
			    		<%if((picPath!=null)&&(!picPath.equals(""))){%>
			    		<img src="/cms/siteResource/<%=picPath%>" height="100" width="100">
			    		<%}else{%>
			    		<img src="/comm_front/images/nullimage1.gif" height="100" width="150">
			    		<%}%>
			    	</td>
			    </tr>

						<tr>
					<td width="15%" align="right">
						更改图片：

					</td>
					<td>
					<input type="text" name="picpath" value="<%=picPath%>"  class="cms_text" readonly size="30"/>
											
					<input type="button" class="button2" name="addpic" onClick="chooseImage()" value="选择图片"/>
						
					</td>
				</tr>
						<%
							}
						%>
						<tr>
							<td align="right">
								可投票时间段：


							</td>
							<td align="left">
								<input type="text" name="timeCtrlStart" id="timeCtrlStart"
									class="cms_text" readonly size="20" />
								<input name="button" type="button"
									onClick="showdate(document.all('timeCtrlStart'))" value="..." class="button2"/>
								&nbsp;到&nbsp;
								<input type="text" name="timeCtrlEnd" id="timeCtrlEnd"
									class="cms_text" readonly size="20" />
								<input name="button" type="button"
									onClick="showdate(document.all('timeCtrlEnd'))" value="..." class="button2"/>
								<font color="red">*</font>
							</td>
						</tr>
						<tr>
							<td width="15%" align="right">
								可投票IP段：
							</td>
							<td align="left">
								<input type="button" name="Submit3" value=" + "
									onclick="return addIpCtrl()" class="button2">
								<input type="button" name="Submit22" value=" - "
									onclick="return delIpCtrl()" class="button2">
							</td>
						</tr>
						<tr>
							<td>
								&nbsp;
							</td>
							<td>
								<table name="ipTable" id="ipTable">
									<tbody>

									</tbody>
								</table>
							</td>
						</tr>
						<tr>
							<td align="right">
								问卷描述：

							</td>
							<td colspan="3"></td>
						</tr>
						<input type="hidden" name="content" value="<%=content%>" />
						<input type="hidden" name="pics" />
						<input type="hidden" name="flashs" />
						<input type="hidden" name="medias" />
						<input type="hidden" name="files" />
						<tr>
							<td colspan="4">
								<iframe id="eWebEditor1"
									src="<%=request.getContextPath()%>/cms/editor/eWebEditor48/ewebeditor.htm?id=content&style=mini500&cusdir=<%=docPath%>"
									frameborder="0" scrolling="no" width="95%" height="460"></iframe>
							</td>
						</tr>

					</table>
				</tab:tabPane>

				<tab:tabPane id="bar-question" tabTitle="题目信息">
					<table width="100%" border="0" id="qstTable" name="qstTable"
						cellpadding="0" cellspacing="0" bgcolor="#F3F4F9">
						<tr>
							<td>
								<input type="button" name="Submit4" value="添加题目"
									onclick="return addQuestion()" class="button2">
							</td>
						</tr>
						<tr>
							<td>
								<table width="100%" name='qstionTbl1' id='qstionTbl1'>
									<tr>
										<td align="right">
											<strong>题目：</strong>

										</td>
										<td>
											<input name="qstionTbl1Qstion" id="qstionTbl1Qstion"
												type="text" size="60">
											<input name="qstionTbl1Qstion_id" id="qstionTbl1Qstion_id"
												type="hidden" size=5>
											<input name="qstionTbl1VoteCount" id="qstionTbl1VoteCount"
												type="hidden" size="5">
											<font color="red">*字数不能超过100</font>
										</td>
									</tr>
									<tr>
										<td align="right">
											回答方式：

										</td>
										<td>
											<input type="radio" name="qstionTbl1Style"
												id="qstionTbl1Style" value="0"
												onClick="return changeStyle('qstionTbl1')">
											单选

											<input type="radio" name="qstionTbl1Style"
												id="qstionTbl1Style" value="1"
												onClick="return changeStyle('qstionTbl1')">
											多选

											<input type="radio" name="qstionTbl1Style"
												id="qstionTbl1Style" value="2"
												onClick="return clearOption('qstionTbl1')">
											自由回答
										</td>
									</tr>
									<tr>
										<td>
											选项：

										</td>
										<td>
											<input type="button" name="qstionTbl1AddBtn" value="添加选项"
												onclick="return addOption('qstionTbl1')" class="button2">
											<input type="button" name="qstionTbl1DelBtn" value="删除选项"
												onclick="return delOption('qstionTbl1')" class="button2">
										</td>
									</tr>
									<tr>
										<td>
											&nbsp;
										</td>
										<td>
											<table id="qstionTbl1OptinTbl" name="qstionTbl1OptinTbl">
												<tbody></tbody>
											</table>
										</td>
								</table>
							</td>
						</tr>
					</table>
					<table cellpadding="0" cellspacing="0" bgcolor="#F3F4F9">
						<tr>
							<td>
								<input type="button" name="Submit4" value="添加题目"
									onclick="return addQuestion()" class="button2">
							</td>
						</tr>
					</table>

				</tab:tabPane>
			</tab:tabContainer>


		</form>
		</base>
		<IFRAME id="biaoge" name="biaoge" width=0 height=0></IFRAME>
	</body>
	<script language="javascript">
	function selectValue(selCtrl,v){
		selCtrl = document.all(selCtrl);
		for(var i=0;i<selCtrl.options.length;i++){
			if (selCtrl.options[i].value == v){
				selCtrl.options[i].selected = true;
				return;
			}
		}
	}
	
	function checkRadiobox(radiobox,v){
		radiobox = document.getElementsByName(radiobox);
		for(var i=0;i<radiobox.length;i++){
			if (radiobox[i].value == v){
				radiobox[i].checked = true;
				return;
			}
		}
	}
	
	function getQstionTblScript(tblName){
		var questionTable = "<table width='100%'  name='"+tblName+"' id='"+tblName+"' ><tr><td ><strong>题目：</strong></td><td ><input name='"+tblName+"Qstion' id='"+tblName+"Qstion' type='text' size='80'><input name='"+tblName+"Qstion_id' id='"+tblName+"Qstion_id' type='hidden' value='0' size='5'><input name='"+tblName+"VoteCount' id='"+tblName+"VoteCount' type='hidden' value='0' size='5'><input type='button' name='Submit42' value='删除' onclick=\"return delQstion('"+tblName+"')\"  class='cms_button'></td></tr><tr><td>回答方式：</td><td><input type='radio' name='"+tblName+"Style' id='"+tblName+"Style' value='0' onClick='return changeStyle(\""+tblName+"\")'>单选<input type='radio' name='"+tblName+"Style' id='"+tblName+"Style' value='1' onClick='return changeStyle(\""+tblName+"\")'>多选 <input type='radio' name='"+tblName+"Style' id='"+tblName+"Style' value='2' onClick='return clearOption(\""+tblName+"\")'>自由回答</td></tr><tr><td>选项：</td><td><input type='button' name='"+tblName+"AddBtn' value='添加选项' onclick='return addOption(\""+tblName+"\")'  class='cms_button'><input type='button'name='"+tblName+"DelBtn' value='删除选项' onclick='return delOption(\""+tblName+"\")'  class='cms_button'></td></tr><tr><td>&nbsp;</td><td><table name='"+tblName+"OptinTbl' id='"+tblName+"OptinTbl'><tbody></tbody></table></td></table></td></tr></table>";
		return questionTable;
	}
	
	function getOptionTblScript(tblName){
		var op = "*<input type='checkbox' name='"+tblName+"Chkbx' id='"+tblName+"Chkbx' value='checkbox'><input name='"+tblName+"Option' id='"+tblName+"Option' type='text' size='50'><input name='"+tblName+"Option_id' id='"+tblName+"Option_id' type='hidden' value='0' size='5'><input name='"+tblName+"Count' id='"+tblName+"Count' type='hidden' value='0' size='5'>";
		return op;
	}
	
	document.all("qstionTbl1AddBtn").disabled = true;
	document.all("qstionTbl1DelBtn").disabled = true;
	<%
		
		if (id!=null){
			%>document.all("titleID").value="<%=id%>";<%
			if (oneTitle != null){
				%>document.all("titleName").value = "<%=oneTitle.getName()%>";
				document.all("ctime").value = "<%=ctime%>";
				<%
				
				if (oneTitle.getIpRepeat()==0){
					%>
					document.all("can_repeat").checked=true;
					chkTimeGap();
					selectValue("selectGap","<%=oneTitle.getTimeGap()%>");
					<%
				}else
				{
				  %>
				  document.all("can_repeat").checked=false;
					chkTimeGap();
					<%
				}
				
				List ipCtrls = oneTitle.getIpCtrls();
				if (ipCtrls!=null&&ipCtrls.size()>0){
					for (int i=0;i<ipCtrls.size();i++){
						IpCtrl ip = (IpCtrl)ipCtrls.get(i);
						%>addIpCtrl();<%
						if (i>0){
							%>document.all("ipCtrlStart")[<%=i%>].value = "<%=ip.getIpStart()%>";
							document.all("ipCtrlEnd")[<%=i%>].value = "<%=ip.getIpEnd()%>";<%
						}
						else{
							%>document.all("ipCtrlStart").value = "<%=ip.getIpStart()%>";
							document.all("ipCtrlEnd").value = "<%=ip.getIpEnd()%>";<%
						}
					}
				}
				
				
				List timeCtrls = oneTitle.getTimeCtrls();
				if (timeCtrls!=null&&timeCtrls.size()>0){
						TimeCtrl time = (TimeCtrl)timeCtrls.get(0);
						%>
							document.all("timeCtrlStart").value = "<%=time.getTimeStart()%>";
							document.all("timeCtrlEnd").value = "<%=time.getTimeEnd()%>";<%
				}
				
				List questions = oneTitle.getQuestions();
				Question  qstion = (Question)questions.get(0);
				%>document.all("qstionTbl1Qstion").value = "<%=qstion.getTitle()%>";
				checkRadiobox("qstionTbl1Style","<%=qstion.getStyle()%>");
				document.all("qstionTbl1VoteCount").value = "<%=qstion.getVotecount()%>";
				document.all("qstionTbl1Qstion_id").value="<%=qstion.getId()%>";<%
				if (qstion.getStyle()!=2 && qstion.getItems().size()>0){
					List items = qstion.getItems();
					Item item = (Item)items.get(0);
					%>document.all("qstionTbl1AddBtn").disabled = false;
					document.all("qstionTbl1DelBtn").disabled = false;
					addOption("qstionTbl1");
					document.all("qstionTbl1Option").value = "<%=item.getOptions()%>";
					document.all("qstionTbl1Count").value = "<%=item.getCount()%>";
					document.all("qstionTbl1Option_id").value = "<%=item.getId()%>";
					<%
					for (int j=1;j<items.size();j++){
						item = (Item)items.get(j);
						%>addOption("qstionTbl1");
						document.all("qstionTbl1Option")[<%=j%>].value = "<%=item.getOptions()%>";
						document.all("qstionTbl1Count")[<%=j%>].value = "<%=item.getCount()%>";
						document.all("qstionTbl1Option_id")[<%=j%>].value = "<%=item.getId()%>";<%
					}
				}
				
				for (int i=1;i<questions.size();i++){
					qstion = (Question)questions.get(i);
					%>addQuestion();
					var tblNm = "qstionTbl"+tableIndex;
					document.all(tblNm+"AddBtn").disabled = true;
					document.all(tblNm+"DelBtn").disabled = true;
					document.all(tblNm+"Qstion").value = "<%=qstion.getTitle()%>";
					checkRadiobox(tblNm+"Style","<%=qstion.getStyle()%>");
					document.all(tblNm+"VoteCount").value="<%=qstion.getVotecount()%>";
					document.all(tblNm+"Qstion_id").value="<%=qstion.getId()%>";<%
					if (qstion.getStyle()!=2 && qstion.getItems().size()>0){
						List items = qstion.getItems();
						Item item = (Item)items.get(0);
						%>document.all(tblNm+"AddBtn").disabled = false;
						document.all(tblNm+"DelBtn").disabled = false;
						addOption(tblNm);
						document.all(tblNm+"Option").value = "<%=item.getOptions()%>";
						document.all(tblNm+"Count").value = "<%=item.getCount()%>";
						document.all(tblNm+"Option_id").value = "<%=item.getId()%>";
						<%
						for (int j=1;j<items.size();j++){
							item = (Item)items.get(j);
							%>addOption(tblNm);
							document.all(tblNm+"Option")[<%=j%>].value = "<%=item.getOptions()%>";
							document.all(tblNm+"Count")[<%=j%>].value = "<%=item.getCount()%>";
							document.all(tblNm+"Option_id")[<%=j%>].value = "<%=item.getId()%>";<%
						}
					}
				}
			}
		}
	%>
	
	</script>
</html>
