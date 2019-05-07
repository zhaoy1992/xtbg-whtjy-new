<%@ page contentType="text/html;charset=GBK" import="java.util.*" language="java"%>
<%@ page import="com.chinacreator.cms.documentmanager.*"%>
<%@ page import="com.chinacreator.cms.channelmanager.*"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.cms.docCommentManager.*"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String docId = request.getParameter("docId");
	
	String docComment = request.getParameter("docComment");
	String userName = request.getParameter("userName");
	String subTimeBgin = request.getParameter("subTimeBgin");
	String subTimeEnd = request.getParameter("subTimeEnd");
	String queryFlag = request.getParameter("queryFlag");
	String status = request.getParameter("status");
	String hasImpeach = request.getParameter("hasImpeach");
	
	DocCommentManager ddm = new DocCommentManagerImpl();
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title>�����ĵ��б�</title>
		<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
		<script src="../inc/js/func.js"></script>
		<script language="JavaScript" src="../../sysmanager/include/pager.js" type="text/javascript"></script>
		<script language="javascript">
			function checkAll(totalCheck,checkName){	//��ѡ��ȫ��ѡ��
			   var selectAll = document.getElementsByName(totalCheck);
			   var o = document.getElementsByName(checkName);
			   if(selectAll[0].checked==true){
				   for (var i=0; i<o.length; i++){
			      	  if(!o[i].disabled){
			      	  	o[i].checked=true;
			      	  }
				   }
			   }else{
				   for (var i=0; i<o.length; i++){
			   	  	  o[i].checked=false;
			   	   }
			   }
			}
			//����ѡ�и�ѡ��
			function checkOne(totalCheck,checkName){
			   var selectAll = document.getElementsByName(totalCheck);
			   var o = document.getElementsByName(checkName);
				var cbs = true;
				for (var i=0;i<o.length;i++){
					if(!o[i].disabled){
						if (o[i].checked==false){
							cbs=false;
						}
					}
				}
				if(cbs){
					selectAll[0].checked=true;
				}else{
					selectAll[0].checked=false;
				}
			}
			//�ж��Ƿ���ѡ��
			function haveSelect(elName){
				var isSelect = false;
				var ch = document.getElementsByName(elName);
				for (var i=0;i<ch.length;i++) {
					if (ch[i].checked){
						isSelect=true;
						break;
					}
				}
				return isSelect;
			}	
			function deleteComments(){
				if(haveSelect("ID")){
				  if(confirm("��ȷ��ɾ����ѡ���ۣ�"))
		    		{
					commentDocForm.action = "docCommentHandle.jsp?action=delete";
					commentDocForm.target = "docComIframe";
					commentDocForm.submit();
					}
				}
				else{
					alert("����ѡ��һƪ�����ĵ�");
				}
			}	
			function publishComments(){
				if(haveSelect("ID")){
					commentDocForm.action = "docCommentHandle.jsp?action=publish";
					commentDocForm.target = "docComIframe";
					commentDocForm.submit();
				}
				else{
					alert("����ѡ��һƪ�����ĵ�");
				}
			}	
			function addOneComment(){
				//��ģ̬��������һ������
				var re = openWin("add_one_comment.jsp?docId="+<%=docId%>,400,600);
				if(re=="cf"){
					var str = document.location.href;
					var end = str.indexOf("?");
					var strArray;
					if(end != -1)
						strArray= str.slice(0,end);
					else
						strArray = str;
					document.location.href = strArray+"?"+document.all.queryString.value;
				}
			}	
			function seeDocComment(docTitle,userName,subtime,userIP,commentId){
				var re = openWin("see_doc_comment.jsp?docTitle="+docTitle+"&userName="+userName+"&subtime="+subtime+"&userIP="+userIP+"&commentId="+commentId,400,550);
				if(re=="cf"){
					var str = document.location.href;
					var end = str.indexOf("?");
					var strArray;
					if(end != -1)
						strArray= str.slice(0,end);
					else
						strArray = str;
					document.location.href = strArray+"?"+document.all.queryString.value;
				}
			}
			function withdrawPubComments(){
				if(haveSelect("ID")){
					commentDocForm.action = "docCommentHandle.jsp?action=withdrawPub";
					commentDocForm.target = "docComIframe";
					commentDocForm.submit();
				}
				else{
					alert("����ѡ��һƪ�����ĵ�");
				}
			}	
			function openComments(){
				commentDocForm.action = "docCommentHandle.jsp?action=open&docId=<%=docId%>";
				commentDocForm.target = "docComIframe";
				commentDocForm.submit();
			}
			function closeComments(){
				commentDocForm.action = "docCommentHandle.jsp?action=close&docId=<%=docId%>";
				commentDocForm.target = "docComIframe";
				commentDocForm.submit();
			}
			function seeImpeachInfo(commentId){
				//alert(commentId);
				//alert(comment);
				var re = openWin("parent_comment_impeach.jsp?commentId="+commentId,800,700);
			}
			function allCommentSearch()
			{
				parent.docCommentQueryF.document.getElementById("allComments").value = "1";
				commentDocForm.allComments.value = "1";
				commentDocForm.submit();
			}
		</script>
	</head>
	<body topmargin="2" scroll=no leftmargin="0">
		<form name="commentDocForm" method="post">
			<input type="hidden" name="allComments" value="0"/>
			<table width="99%" border="0" align="center" cellpadding="3" cellspacing="0" class="Datalisttable">
				<tr>
					<td colspan=8  height="25" background="../images/data_list_tHeadbg.jpg" style="text-align:left; background:url(../images/data_list_tHeadbg.jpg) repeat-y center #B7BDD7"><div class="DocumentOperT">������</div>
						<%int comswitch = ddm.getDocCommentSwitch(docId,"doc");
						  if(comswitch == 1){%>
						<a style="cursor:hand" onClick="openComments()"><div class="DocumentOper"><img 
										class="operStyle" src="../../sysmanager/images/plan.gif">��ͨ����</div></a>
						<%}else if(comswitch == 0){%>
						<a style="cursor:hand" onClick="closeComments()"><div class="DocumentOper"><img 
										class="operStyle" src="../../sysmanager/images/plan.gif">�ر�����</div></a>
						<%}%>
						<a style="cursor:hand" onClick="addOneComment()"><div class="DocumentOper"><img
										class="operStyle" src="../images/audity.gif">��������</div></a>
						<a style="cursor:hand" onClick="deleteComments()"><div class="DocumentOper"><img 
										class="operStyle" src="../../sysmanager/images/plan.gif">ɾ������</div></a>
						<a style="cursor:hand" onClick="publishComments()"><div class="DocumentOper"><img 
										class="operStyle" src="../../sysmanager/images/plan.gif">����</div></a>
						<a style="cursor:hand" onClick="withdrawPubComments()"><div class="DocumentOper"><img 
										class="operStyle" src="../../sysmanager/images/plan.gif">����</div></a>
						<a style="cursor:hand" onClick="allCommentSearch()"><div class="DocumentOper"><img 
										class="operStyle" src="../../sysmanager/images/plan.gif">��������</div></a>
					</td>
				</tr>
				<pg:listdata dataInfo="DocCommentList" keyName="DocCommentList" />
				<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
				<pg:pager maxPageItems="12" scope="request" data="DocCommentList" isList="false">
				<tr class="cms_report_tr">
					<td width="4%" height="30" align=center>
						<input   class="checkbox" type="checkBox" hideFocus=true name="checkBoxAll" onClick="checkAll('checkBoxAll','ID')">
					</td>
					<td width="23%">�ĵ�����</td>
					<td width="27%">��������</td>
					<td width="10%">�û���</td>
					<td width="10%">�û�IP</td>
					<td width="5%">����״̬</td>
					<td width="5%">�ٱ�</td>
					<td width="20%">��������</td>
				</tr>
				<pg:param name="docId" />
				<pg:param name="docComment" />
				<pg:param name="userName" />
				<pg:param name="subTimeBgin" />
				<pg:param name="subTimeEnd" />
				<pg:param name="queryFlag" />
				<pg:param name="status" />
				<pg:param name="hasImpeach" />
				<pg:param name="allComments"/>
				<pg:notify>
						<tr  class="labeltable_middle_tr_01">
							<td colspan=100 align='center' height="18px">
								���ĵ���ʱû������
							</td>
						</tr>
				  </pg:notify>

				<!--list��ǩѭ�����ÿ����¼-->
				<pg:list>
				<%
						String docTitle = dataSet.getString("docTitle");
						String oneUserName = dataSet.getString("userName");
						String userIP = dataSet.getString("userIP");
						Date subtime = dataSet.getDate("subTime");
						String oneDocComment = dataSet.getString("comment");
						int commentId = dataSet.getInt("commentId");
						int oneStatus = dataSet.getInt("status");
						int alarm = dataSet.getInt("alarm");
						int impeachFlag = dataSet.getInt("impeachFlag");
						
						String statusDsp = "";
						switch(oneStatus){
							case 0: 
								statusDsp = "δ��";
								break;
							case 1:
								statusDsp = "�ѷ�";
								break;
							case 2:
								statusDsp = "����";
								break;
						}
				%>
				<tr onMouseOver="high(this)" onMouseOut="unhigh(this)">
					<td height="30" align=center>
						<input   class="checkbox" hideFocus onClick="checkOne('checkBoxAll','ID')" type="checkbox" name="ID" value="<%=commentId%>">
					</td>
					<td>
						<pg:cell colName="docTitle" defaultValue="" />
					</td>
					<td onClick="seeDocComment('<%=docTitle%>','<%=oneUserName%>','<%=subtime%>','<%=userIP%>','<%=commentId%>')" style="cursor:hand;<%=alarm==1?"color:red":""%>">
						<%=oneDocComment.length()<18?oneDocComment:oneDocComment.substring(0,16)+"..."%>
					</td>
					<td>
						<pg:cell colName="userName" defaultValue="" />
					</td>
					<td>
						<pg:cell colName="userIP" defaultValue="" />
					</td>
					<td>
						<%=statusDsp%>
					</td>
					<td style="<%=impeachFlag==1?"color:red;":""%>"><%=impeachFlag==1?"<a style=\"cursor:hand\" onclick=\"seeImpeachInfo('" + commentId + "')\">�ٱ�</a>":""%></td>
					<td>
						<pg:cell colName="subTime" dateformat="yyyy/MM/dd HH:mm:ss" defaultValue="" />
					</td>
				</tr>
				</pg:list>
					<tr class="labeltable_middle_tr_01">
						<td colspan=8 align='center' height="18px">
							��
							<pg:rowcount />
							����¼
							<pg:index />
						</td>
					</tr>
					<input id="queryString" name="queryString" value="<pg:querystring/>" type="hidden">
					<tr></tr>
				</pg:pager>
		  </table>
		</form>
		<div height="0" width="0" style="display:none">
			<iframe name="docComIframe"></iframe>
		</div>
	</body>	
</html>